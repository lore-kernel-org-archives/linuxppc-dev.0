Message-ID: <6B546A602AD2D211BFF00008C7A428890584405B@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Steve Rossi'" <srossi@labs.mot.com>,
	Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: strange crashes
Date: Mon, 15 Apr 2002 14:49:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Yes I have seen this occasionaly. I am using HHL20 (2.4.2) on an Embedded
Planet CLLF board (a board that MV supports). The oops always mentions
kswapd.
I do not have the experience that it either works or always crashes. I had
the impression that this only happens (lets say once every 20 boots) when I
use NFS as root-fs, not when I use an intrd from flash.
The problems looks like timing-related to me, a race-condition...

Fred

-----Original Message-----
From: Steve Rossi [mailto:srossi@labs.mot.com]
Sent: maandag 15 april 2002 14:35
To: Embedded Linux PPC List
Subject: strange crashes



Hi All,
Wondering if anyone has seen this ... I've been periodically fighting
some pseudo-random crashes. These occur always during kernel boot, and
occur consistenly (i.e. at the same address) for a given kernel build.
The crash usually occurs right after kswapd starts or somewhere in the
following inittasks where I get a kernel oops with access to bad area.
I say these are pseudo random, because they depend on how the kernel is
built. A given build will either work always or work never. Some of the
things that I've observed that causes it to not work are things like
adding config options that make the kernel bigger, compiling with
debugging symbols - and (don't laugh) changing the path to the kernel.
Thats right, an identical kernel placed at two different paths, compiled
clean from both locations - one will boot and run fine, the other will
crash during boot.
I'm using the MontaVista tools from the 2.0 Journeyman and the 2.4.16
kernel with some modifications on custom hardware. I'm certain its not a
hardware problem, because once I get a kernel that boots, it runs
solidly. In my latest encounter with this problem, it happened when
I added one file to my initial ramdisk - thereby increasing its size by
a few K - absolutely nothing else changed. Before that the same exact
kernel booted and ran solidly, now it does not. I'm fairly certain that
the problem is not just size related, though that seems to play some
role. I suspect some kind of a compiler or linker problem but I wanted
to ask around before spending too much time digging into it. Any similar
experiences or ideas of what might be going on?

Thanks,
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@labs.mot.com
Senior Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
