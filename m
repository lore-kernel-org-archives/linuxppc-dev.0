Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 7 Feb 2003 11:19:43 +0100 (MET)
From: Andreas Plaickner <apxx@gmx.net>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Subject: PCMCIA Card, RTAI on PowerPC
Message-ID: <13881.1044613183@www65.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

thanks a lot for the last help and advice to create a new
linux kernel, I appreciate it very much.

Now I have downloaded from DENX via anonymous ftp
the linux-2.4 kernel sources for PowerPC. I have created
a new kernel and tried to bring my PCMCIA interface to up
and it seems to work.

Now I wanted to patch this kernel to run RTAI on the Board.
Testing if the pach works with --dry-run I received the following:

patch --dry-run -b -z.PRE_RTAI -p1 < ../patch-denx-linux-2.4-D2002-09-26

patching file arch/ppc/8xx_io/commproc.c
patching file arch/ppc/8xx_io/Config.in
patching file arch/ppc/8xx_io/enet.c
patching file arch/ppc/8xx_io/lwmon_spi.c
Hunk #1 FAILED at 79.
Hunk #2 succeeded at 133 (offset 21 lines).
Hunk #3 FAILED at 587.
Hunk #4 FAILED at 681.
3 out of 4 hunks FAILED -- saving rejects to file
arch/ppc/8xx_io/lwmon_spi.c.rej
patching file arch/ppc/8xx_io/spiclk.c
patching file arch/ppc/8xx_io/uart.c
patching file arch/ppc/config.in
Hunk #1 succeeded at 140 (offset 6 lines).
patching file arch/ppc/kernel/entry.S
patching file arch/ppc/kernel/irq.c
patching file arch/ppc/kernel/m8xx_setup.c
Hunk #1 succeeded at 385 (offset 12 lines).
patching file arch/ppc/kernel/ppc8xx_pic.c
patching file arch/ppc/kernel/ppc8xx_pic.h
patching file arch/ppc/kernel/ppc_ksyms.c
patching file arch/ppc/kernel/traps.c
patching file arch/ppc/mm/init.c
patching file Documentation/Configure.help
patching file drivers/i2c/i2c-algo-8xx.c
Hunk #1 succeeded at 46 with fuzz 1 (offset 7 lines).
patching file drivers/i2c/i2c-lwmon.c
patching file drivers/i2c/i2c-r360.c
patching file drivers/i2c/i2c-rpx.c
patching file drivers/i2c/i2c-simple.c
Hunk #1 succeeded at 43 (offset 11 lines).
Hunk #2 FAILED at 115.
Hunk #3 succeeded at 202 with fuzz 1 (offset 54 lines).
Hunk #4 succeeded at 312 (offset 40 lines).
Hunk #5 FAILED at 990.
2 out of 5 hunks FAILED -- saving rejects to file
drivers/i2c/i2c-simple.c.rej
patching file include/asm-ppc/irq.h
patching file include/asm-ppc/system.h
patching file include/linux/i2c-algo-8xx.h
patching file include/linux/sched.h
patching file kernel/exit.c
patching file kernel/fork.c
patching file kernel/ksyms.c
patching file kernel/sched.c
patching file kernel/signal.c
patching file Makefile
Then I read that it is necessary to download the tree with revision date
2002-09-26. I did this one and created a kernel-image without rtai
like before, and I copied it to the board and this time the following
happened:


Serial driver version 5.05a (2001-03-20) with no serial options enabled
Oops: kernel access of bad area, sig: 11
NIP: C00B91CC XER: 8000007F LR: C00BD810 SP: C0209DC0 REGS: c0209d10 TRAP:
0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000003F9, DSISR: 00018469^[[1;47r^[[47;1H
TASK = c0208000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C0209DC0 C0208000 C0209DC8 00000001 10000000 C020B538
000003F8
GPR08: 00000000 000003F8 00000000 00000000 C01A0000 1004B640 C00BCEB4
C00BC71C
GPR16: C00BB2B4 C00BBF5C C00BC830 C00B9368 C00B92DC C00BC3AC C00BB384
C00BB2FC
GPR24: C00BBFE4 C00BB234 C00BB21C C016A1CC C016A1CC 00000000 00000000
C0209DC8
Call backtrace:
1004B640 C0179474 C017278C C0172830 C00023CC C0004D28 0000007D
Kernel panic: Attempted to kill init!
Rebooting in 1 seconds..

What I would need is a combination of the source trees. The ideal would be
if i could patch the
kernel linux-2.4 from anonymous ftp on DENX as my PCMCIA card works with it.
Does
anyone have any suggestions what I could do to be able to patch this kernel?

Thanks a lot in advance for any suggestions.

Andreas


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
