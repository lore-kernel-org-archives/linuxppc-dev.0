Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id A2D7067E53
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 19:37:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 8 Aug 2005 11:37:51 +0200
Message-ID: <8E342283C2100540AAC5D103097054776F8849@rcexc.racoms.loc>
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

Hello!

> From: aris@cathedrallabs.org [mailto:aris@cathedrallabs.org]=20
> Sent: Friday, August 05, 2005 6:26 PM
>
> >  Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:348
> >  Call trace:
> >   [c0005b10] dump_stack+0x18/0x28
> >   [c0003c60] check_bug_trap+0x84/0xac
> >   [c0003de8] ProgramCheckException+0x160/0x1a0
> >   [c0003260] ret_from_except_full+0x0/0x4c
> >   [c01a9f84] dma_alloc_init+0x44/0xa0
> >   [c01a66a4] do_initcalls+0x54/0xfc
> >   [c0002260] init+0x2c/0xf4
> >   [c000533c] kernel_thread+0x44/0x60
> >  NET: Registered protocol family 16
> >  JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> >  Serial: CPM driver $Revision: 0.01 $
> >  ttyCPM0 at MMIO 0xff000a80 (irq =3D 20) is a CPM UART
> >  ttyCPM1 at MMIO 0xff000a90 (irq =3D 19) is a CPM UART
> just out of curiosity, try changing CONSISTENT_START to 0xe0000000

Well, then the error in dma_alloc_init goes away.

However, i'm still not able to run 2.6.x on the MPC885ADS.
I'm now using 2.6.13-rc6 with the latest cpm-uart-fixes=20
applied. I made the defconfig, set CONSISTENT_START to 0xe0000000
an got:

 Linux version 2.6.13-rc6 (root@rcf02) (gcc version 3.3.2) #5 Mon Aug 8
11:22:18 CEST 2005
 Built 1 zonelists
 Kernel command line: console=3DttyCPM0,38400n8 root=3D/dev/nfs
nfsroot=3D/home/test/nfs rw
ip=3D192.168.1.10:192.168.1.1:192.168.1.1:255.255.255.0::eth0:off
 PID hash table entries: 64 (order: 6, 1024 bytes)
 Decrementer Frequency =3D 450000000/60
 Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
 Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
 Memory: 6244k available (1432k kernel code, 332k data, 72k init, 0k
highmem)
 Mount-cache hash table entries: 512
 NET: Registered protocol family 16
 Serial: CPM driver $Revision: 0.01 $
 ttyCPM0 at MMIO 0xff000a80 (irq =3D 20) is a CPM UART
 ttyCPM1 at MMIO 0xff000a90 (irq =3D 19) is a CPM UART
 io scheduler noop registered
 PPP generic driver version 2.4.2
 PPP Deflate Compression module registere

Looks like the console does not start (maybe still UART-issues)...=20

As some people on this list reported success on MPC885ADS - can somebody

please hit me with the cluebat ?

Best regards,=20

  Peter
