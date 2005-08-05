Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id E642667F04
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Aug 2005 02:00:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 5 Aug 2005 18:00:46 +0200
Message-ID: <8E342283C2100540AAC5D103097054776F87A9@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: "linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC885ADS and 2.6.13-rc5 - nogo ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello!=20

Replying to myself: I'm able to see bootup messages on ttyCPM0 now=20
after i applied the "Made non-console uart work"-patch that i skipped
until now because, well, it was "non-console" ...

However, output on ttyCPM0 stops soon:

 Linux version 2.6.13-rc5 (ashaepe@rcf02) (gcc version 3.3.2) #20 Fri
Aug 5 17:48:42 CEST 2005
 Built 1 zonelists
 Kernel command line: console=3DttyCPM0,38400n8 root=3D/dev/nfs
nfsroot=3D/home/ashaepe/nfs rw ip=3D10.135.2.133:10.135.0.22:1
 0.135.0.1:255.255.252.0::eth0:off
 PID hash table entries: 64 (order: 6, 1024 bytes)
 Decrementer Frequency =3D 375000000/60
 Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
 Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
 Memory: 6272k available (1352k kernel code, 404k data, 68k init, 0k
highmem)
 Mount-cache hash table entries: 512
 Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:348
 Call trace:
  [c0005b10] dump_stack+0x18/0x28
  [c0003c60] check_bug_trap+0x84/0xac
  [c0003de8] ProgramCheckException+0x160/0x1a0
  [c0003260] ret_from_except_full+0x0/0x4c
  [c01a9f84] dma_alloc_init+0x44/0xa0
  [c01a66a4] do_initcalls+0x54/0xfc
  [c0002260] init+0x2c/0xf4
  [c000533c] kernel_thread+0x44/0x60
 NET: Registered protocol family 16
 JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
 Serial: CPM driver $Revision: 0.01 $
 ttyCPM0 at MMIO 0xff000a80 (irq =3D 20) is a CPM UART
 ttyCPM1 at MMIO 0xff000a90 (irq =3D 19) is a CPM UART
 io scheduler noop registered

And that's all output for now...

Can anybody explain the "dma_alloc_init"-error ?

 Best regards,

 Peter

-----Original Message-----

Hello!

I gave the MPC885ADS support recently added by Andrei Konovalov=20
a try - but no luck: booting 2.6.13-rc5 with u-boot 1.1.2=20
(tftpboot & bootm) hangs after uncompressing.

Did anybody succeed with this?

Applied were the following patches from patchwork.ozlabs.org:

 * 8xx_cpm_hostalloc
 * all fixes to fec.c

The board boots an 2.4-Kernel just fine. Did i miss some patches=20
for U-Boot?

Best regards,

 Peter
