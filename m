Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel oops with MPC5200 UDMA. How to debug?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 24 Jun 2004 11:06:05 +0200
Message-ID: <42A622EB18325843894BB8E1040E3DF5022764@sinaexchf>
From: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.
We get this kernel oops when using UDMA on a Lite5200 board even if the FEC support is not in the kernel.
At this moment, we're using a Lite5200 with a Realtek 8139 instead of the 5200's FEC for ethernet. To test this problem we do an infinite loop with 'hdparm -t /dev/hda' with DMA on. This provokes a kernel oops (see end of mail) if eth0 is up, but if we shut down the eth0 before the test, it works with no problems.
Also, we get the kernel oops when using heavily the ethernet and the IDE DMA is activated (for example, doing 'find /' on a telnet console, will give an oops with different values for TASK, like swapper, or in.telnetd), but not if the IDE DMA is off.
Seems that the DMA is still broken even if the FEC support is disabled.
Is there a way to find where the problem is without using a BDI? We don't have any of those tools yet, but a Metrowerks wiretap which seems to be not supported on linux.
This is one of the several oops we see:

Caused by (from SRR1=41000): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C00C91B4 XER: 00000000 LR: C0004F3C SP: C3047D10 REGS: c3047c60 TRAP: 0200    Not tainted
MSR: 00041000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c3046000[616] 'hdparm' Last syscall: 3
last math c3046000 last altivec 00000000
GPR00: C0004F3C C3047D10 C3046000 00000000 C3FF3C00 C3047DA0 300A14BC 00000000
GPR08: F0001200 C01C0000 F0000500 C000C154 24002842 1001F27C 00000000 00000000
GPR16: 00000004 00000001 C0025B84 C3002100 00001032 03047D90 00000000 C0003E40
GPR24: 00000000 40000074 C3FF3D60 00000014 C3FF3C00 4000003E 40000000 00000000
Call backtrace:
C00D5710 C0004F3C C0005000 C0003E40 00000000 C00255C4 C0025CF4
C0035154 C0003BFC 00000000 10001A78 1000270C 100037BC 0FEBCF6C
00000000
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..

Thanks.

Iñigo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
