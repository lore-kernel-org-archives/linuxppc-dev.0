Message-ID: <XFMail.991024203926.kburtch@bellsouth.net>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Date: Sun, 24 Oct 1999 20:39:26 -0400 (EDT)
From: Kevin Burtch <kburtch@bellsouth.net>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Cache on PowerStack disabled & ethernet problems (& sound & PCI question)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Well, I finally dug out my PowerStack (604-100 w/256k cache) and loaded R5
on it.

After the installation, I found I could not use my ethernet... so I grabbed
a spare SCSI drive, made a filesystem (on my x86 box) and dumped the current
source tree to it (2.2.13 - stock... they did merge, right?) and moved the
drive to the PPC. I configured and built an appropriate kernel, slapped it on
a floppy, and tried it out.

I noticed that it is slower than my overclocked 486, which is quite sad.
I checked /proc/cpuinfo and sure enough, cache is "none".

I also found that my ethernet still wouldn't work... at least not well
enough to use. I tried the tulip module for the heck of it (hey, it _is_
a tulip chip), then went back to the de4x5 module. I get about 60-85%
packet loss with this... is anyone using this board with the onboard
ethernet?

It is possible that my hub is not working as advertised... it's a D-Link
DH5P, dual-speed hub. It's supposed to work like a switch, in the sense
that the 100Mb and 10Mb connections can talk to each-other, but I don't
have any other 10Mb equipment to test this out on. I might have to dig
out my old DX50 and slap some boards into it...

Anyways...
I grepped through all the old emails from the list (since Feb. '98) and
only found a couple referring to the PowerStack and cache problems
(couldn't find anything about e'net problems, 'cept that you have to use
 the de4x5 module).

I went to the Motorola site and searched the online manual, and it appears
as though you can enable the cache in ppcbug1 (whatever that means) using
the "cf" (configure) command. I tried it out, and sure enough, it asked
about enabling the instruction cache twice(?), both times defaulted to yes.

I booted Linux again, no change.

Has anyone found a way to enable the cache on the PowerStack/Blackhawk
systems? This is quite frustrating to have such a nice machine with such
poor performance.


Also, do the PCI or ISA boards have to be PPC specific, or can you use
generic boards? I thought non-bootable network cards should work, since
they don't have any ROM (x86 code) to get confused about. I also hoped
I could use my generic Bt848 board in it (no ROM, unless it's in the
Bt848), but the system would lock up before it even got to the self-tests
with either board installed (it would start to print it's ID screen).
The ethernet board I tried was a generic PCI/NE2000 clone.


As long as I'm babbling... what selection do you make for the on-board
sound? I grepped through the sources, and the CS4231 chip is supported,
but only as a subset of other drivers. I didn't see anything else on
the board that indicated what other driver I should be looking into.
If I ever get the cache enabled, and ethernet working, I'm going to want
sound too.   ( boy, aren't _I_ demanding? )     ;^)


Thank you very much,
Kevin Burtch


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
