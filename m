Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id DF228DDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 04:28:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Kernel crash on mem= argument
Date: Thu, 19 Apr 2007 14:29:27 -0400
Message-ID: <3C02138692C13C4BB675FE7EA2409529328755@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

So, I am able to get my system to autoboot with a ramdisk out of flash
if I leave the mem=3D argument out of my u-boot bootargs, however since =
I
need to define the range of real memory for my kernel to address,
leaving that argument out is not an option for me.=20

When I add it in, this is the error I get.

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 3938k freed
Oops: kernel access of bad area, sig: 11
NIP: C002EB90 XER: 20000000 LR: C0030120 SP: C0419DB0 REGS: c0419d00
TRAP: 0800    Not tainted
MSR: 00009000 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 00
DEAR: 8048486C, ESR: 00800000
TASK =3D c0418000[1] 'swapper' Last syscall: 6
last math 00000000 last altivec 00000000 last spe 00000000
GPR00: 00000000 C0419DB0 C0418000 C0584820 FFFFFFFF 00000001 C058483C
00000080
GPR08: C0584838 80484868 C0291000 C0584808 00000000 00000000 10001000
00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 00009002 C0419EA0 00000000
C0003DEC
GPR24: C0003B40 007FFEB0 00000000 C0240000 C0240000 CFFAEB6B C0584820
CFBD7000
Call backtrace:
00000000 C0030120 C000D94C C00F86E0 C003A388 C0038D24 C0003B9C
C020019C C0001E98 C0001ACC C00064B8
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..
=20
Suddenly, the kernel goes from finding, mounting and loading it's
ramdisk RFS, to not being able to find it at all. I have not moved the
ramdisk in flash, so i'm unsure why adding a mem=3D argument on the =
kernel
bootargs would do this. Any ideas?


Clinton Thomas
