Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A22A6679E0
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Mar 2006 09:07:58 +1100 (EST)
Subject: snd-aoa & rates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 09:06:36 +1100
Message-Id: <1143324396.6318.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Johannes

Current snd-aoa blew up on me at module load btw ... anyway, that's not
my point here :)

I wonder if you may be doing something a bit too complicated and maybe
not perfectly wanted for your bitrates thingy... you basically end up
with min/max limits and bit size limits, sort-of
assuming that on analog, any rates you have in your list that fits those
limits will be available on a given codec. That may not be the case for
all codecs no ? Then you end up with a similar list for digital but
since you need discrete bitrates, you end up with a list with min==max.

Why not do something much simpler which is to define the known bitrates
as a bitmask and have the codec expose a bitmask of supported analog and
digital rates ?

In fact, I would have been even nastier and only exposed the
intersection of the above so I don't have to bother about rates that
digital won't support :) But I suppose that if you really want to
support 8k or 96k it might make sense to support others.

Also, for the sample sizes, same comment. Number of bits are not that
useful. I'd rather have a bitmask of formats: 8 bits, 16 bits msb, 24
bits msb, maybe lsb versions if supported, ac3, floating point if
supported, etc... That or an array. I'm sure Alsa already have constants
defined for those no ? I would then have the codec have a function
returning the required clocks for a given bitrate/format combination...

That is all suggestions of course, if you feel that what you do is
better, then stick to it :)

Another thing I wouldn't have bothered with is again with whatever
digital supports or doesn't ... rather that trying to prevent some rates
from being useable by alsa based on a control that users will typically
not have means to set at the right time (what about a sound server
running all the time keeping the drier running, you want to block the
digital switch ?) what I would do is just "mute" the digital output if a
format is selected that isn't supported for digital. I would let the
user chose the formats they want at all time, and only clamp the digital
enable/disable switch. On this switch, btw, you should then remember the
user setting: if the user switches it off, remember off. If the user
switches it on, remember on, If the user sets it on but you have to mute
it, remember that so that when the sample size/format changes again,
unmute.

Sames goes for things that may be supported by the digital output and
not analog (ac3 ?). In this case, mute the analog outputs. The mutes of
these are controlled externally via the amps so it may be a bit
complicated, unless you define specific messages to the core for that,
or maybe just clamp the master volume down in the codec driver.

Ben.
 
