Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id B36A5679E7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 02:24:14 +1000 (EST)
Subject: PCI driver
From: Lee Revell <rlrevell@joe-job.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Sun, 27 Aug 2006 12:24:09 -0400
Message-Id: <1156695850.6010.70.camel@mindpipe>
Mime-Version: 1.0
Cc: Leonid <Leonid@a-k-a.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

We have implemented a driver for a PCI sound card and are attempting to
use it on a PPC400 Yosemite board.  However, as soon as any port I/O is
attempted, we get a machine check error:

dream/mem/mpu 9 0 1 "w" 10
MIDI message chip 9 mpu_port 0 offset 1 direction 1 16bit 0 data 0x10
outb 0x331
Data machine check in kernel mode.
PLB0: BEAR=0x0000000000000000 ACR=  0x00000000 BESR= 0xffffffff
POB0: BEAR=0xc27e3194ffffffff BESR0=0x00000000 BESR1=0x00000000
OPB0: BEAR=0x0000000000000151 BSTAT=0x00000000
Oops: machine check, sig: 7 [#1]
PREEMPT
NIP: 00000000 LR: C02022B0 SP: CFA7FDC0 REGS: c0343f50 TRAP: 0202    Not
tainted
MSR: 00000000 EE: 0 PR: 0 FP: 0 ME: 0 IR/DR: 00
TASK = cffe80d0[43] 'akadiag' THREAD: cfa7e000
Last syscall: 54
GP

Are we doing something wrong?  We use pci_resource_start(pci,0) to get
the BAR which returns 0xFFF0.  This also matches what is
in /proc/ioports, but outb/outw/outl all cause the machine check crash.

Lee
