Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0907@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Muhammad Sarwar'" <msarwar@mangrovesystems.com>,
	nbasker@india.tejasnetworks.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Problems in booting kernel from bootloader.
Date: Thu, 3 Jul 2003 08:38:32 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Also, make sure the SYPCR is disabled.

-----Original Message-----
From: Muhammad Sarwar [mailto:msarwar@mangrovesystems.com]
Sent: Thursday, July 03, 2003 8:14 AM
To: nbasker@india.tejasnetworks.com;
linuxppc-embedded@lists.linuxppc.org
Subject: RE: Problems in booting kernel from bootloader.



If you are using EP8260 version 1.3, you need to enable PIPELINE in the
planet core boot loader.
In planet core:
PIPELINE=1
STO

Regards,

Muhammad Sarwar
Mangrove Systems Inc.

-----Original Message-----
From: nbasker@india.tejasnetworks.com
[mailto:nbasker@india.tejasnetworks.com]
Sent: Wednesday, July 02, 2003 11:18 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Fwd: Problems in booting kernel from bootloader.


Hi,


 I am having an EP8260 board. And I got a zImage binary from TimeSys
linux(2.4.7). The board comes with a bootloader and diagnostics.

 The TimeSys linux gives me a binary called
zImage.initrd.bin-2.4.7-timesys-3.1.180-ep8260.


 I am trying to boot the kernel using the bootloader given by the
PlanetCore guys. The kernel was the one which I got from TimeSys. But
this
kernel doesn't come up(It hangs).


Then I tried modifying a few lines of
assembly code(arch/ppc/boot/mbx/head_8260.S) to find the problem. The
board always goes for a reset when I run my code. I get the initial
prints
regarding the



loaded at:     00800000 0080C27C
relocated to:  00400000 0040C27C
board data at: F0003000 F0003034
relocated to:  0040C148 0040C17C
zimage at:     0080C27C 008C6253
avail ram:     008C7000 04000000

And then the "Uncompress kernel"and "Now booting kernel" prints are seen
and then the board goes for a reset.


 The embed_config, decompress_kernel functions are run correctly. I
could
come to this conclusion from the dump of the first few bytes of
memory. These were exactly identical to the "disassembled code of
vmlinux".

The head_8260.S is followed by the head.S code in arch/ppc/kernel. What
I
found is that I am able to jump to the diagnostics of the PlanetCore
just
before entering the "_start" of arch/ppc/kernel. But I am not able to
jump
to the diagnostics just after entering the "_start" of the kernel
head.S.



How do I debug this problem, I know that the first few bytes of SDRAM
are
exactly what was expected. These values I dumped. Then what is the
problem
in jumping to that location. With my binary, the board goes for a reset.

Please help.
Nicholas

-------------------------------------------------
This mail sent through Tejasnetworks Webclient


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
