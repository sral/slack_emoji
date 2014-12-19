# slack_emoji.pl
#   This script converts slack emoji to smileys.

use strict;
use warnings;
use vars qw($VERSION %IRSSI);

use Irssi;
$VERSION = '0.02';
%IRSSI = (
    authors=> 'Lars Djerf',
    contact=> 'lars.djerf@gmail.com',
    name=> 'slack_emoji',
    description=> 'This script convers Slack emoji to smileys.',
    license=> 'GPL',
    );

my %emoji = ('smile' => ':)',
	     'simple_smile' => ':)',
	     'smiley' => ':-)',
	     'grin' => ':D',
	     'wink' => ';)',
	     'smirk' => ';)',
	     'blush' => ':$',
	     'stuck_out_tounge' => ':P',
	     'stuck_out_tounge_winking_eye' => ';P',
	     'stuck_out_tounge_closed_eyes' => '',
	     'disappointed' => ':(',
	     'astonished' => ':O',
	     'open_mouth' => ':O',
	     'heart' => '<3',
	     'broken_heart' => '</3',
	     'thumb' => '*thumbs-up*');

sub event_message_public ($$$) {
    my ($server, $msg, @rest) = @_;
    my @matches = ($msg =~ /\:(\w+)\:/g);
    foreach (@matches) {
	my $smiley = $emoji{$_};
	$msg =~ s/\:$_\:/$smiley/;
    }
    Irssi::signal_continue($server, $msg, @rest);
}

Irssi::signal_add_first('message public', 'event_message_public');
