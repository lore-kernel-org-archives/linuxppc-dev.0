From: nbasker@india.tejasnetworks.com
Message-ID: <1057225657.3f03fbb9e09cf@pop-mail.india.tejasnetworks.com>
Date: Thu, Thu 03 Jul 2003 03:17:37 PM IST, Jul 2003 15:17:37 +0530
To: linuxppc-embedded@lists.linuxppc.org
Subject: Fwd: Problems in booting kernel from bootloader.
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,


 I am having an EP8260 board. And I got a zImage binary from TimeSys
linux(2.4.7). The board comes with a bootloader and diagnostics.

 The TimeSys linux gives me a binary called
zImage.initrd.bin-2.4.7-timesys-3.1.180-ep8260.


 I am trying to boot the kernel using the bootloader given by the
PlanetCore guys. The kernel was the one which I got from TimeSys. But this
kernel doesn't come up(It hangs).


Then I tried modifying a few lines of
assembly code(arch/ppc/boot/mbx/head_8260.S) to find the problem. The
board always goes for a reset when I run my code. I get the initial prints
regarding the



loaded at:     00800000 0080C27C
relocated to:  00400000 0040C27C
board data at: F0003000 F0003034
relocated to:  0040C148 0040C17C
zimage at:     0080C27C 008C6253
avail ram:     008C7000 04000000

And then the "Uncompress kernel"and "Now booting kernel" prints are seen
and then the board goes for a reset.


 The embed_config, decompress_kernel functions are run correctly. I could
come to this conclusion from the dump of the first few bytes of
memory. These were exactly identical to the "disassembled code of
vmlinux".

The head_8260.S is followed by the head.S code in arch/ppc/kernel. What I
found is that I am able to jump to the diagnostics of the PlanetCore just
before entering the "_start" of arch/ppc/kernel. But I am not able to jump
to the diagnostics just after entering the "_start" of the kernel head.S.



How do I debug this problem, I know that the first few bytes of SDRAM are
exactly what was expected. These values I dumped. Then what is the problem
in jumping to that location. With my binary, the board goes for a reset.

Please help.
Nicholas

-------------------------------------------------
This mail sent through Tejasnetworks Webclient


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
