Return-Path: <david.hagood@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id CA74AB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 08:16:49 +1100 (EST)
Received: by gwaa20 with SMTP id a20so1461557gwa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 14:16:47 -0700 (PDT)
Message-ID: <4ddfb6fd369f4ed76304f237b466328b.squirrel@localhost>
In-Reply-To: <20101013145647.0f066959@udp111988uds.am.freescale.net>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<8636b70ea34330679bebdaad187ccd68.squirrel@localhost>
	<4CB2DEFB.90204@windriver.com>
	<20101011121745.2e471fc0@udp111988uds.am.freescale.net>
	<942ea2f3464025464521511c32355782.squirrel@localhost>
	<20101012162152.5246744a@udp111988uds.am.freescale.net>
	<4CB5088D.4090201@windriver.com>
	<20101013102815.2959fcb6@udp111988uds.am.freescale.net>
	<1c6d107b01e69a0466fd4e4eb4aaf26e.squirrel@localhost>
	<20101013145647.0f066959@udp111988uds.am.freescale.net>
Date: Wed, 13 Oct 2010 16:16:43 -0500
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: "tiejun.chen" <tiejun.chen@windriver.com>, david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Wed, 13 Oct 2010 12:08:16 -0500
> I'd just rip the whole thing out of the board code, and pass zero in
> isu_size to mpic_alloc(), if you can undo whatever is depending on the
> remapping.

OK, what I did was to change

mpic1 = mpic_alloc(np, res.start,
			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
			16, 256,
			" MPIC     ");

to
mpic1 = mpic_alloc(np, res.start,
	MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
	0, 256,
	" MPIC     ");

and remove all the calls to mpic_assign_isu.

When I did this, the board booted, but when I then tried to map my
interrupt, I got a segfault:

unsigned mpic_vector = mpic_reg_to_irq(MSIVPR0);

      printk(KERN_INFO "Endpoint %s: got MPIC IRQ %d\n",name,mpic_vector);

      dis->irq = irq_create_mapping(0,mpic_vector);

Led to:
Using EP8641A machine description
Total memory = 1024MB; using 2048kB for hash table (at cfa00000)
<snip>
mpic: Setting up MPIC " MPIC     " version 1.2 at e0040000, max 2 CPUs
mpic: ISU size: 88, shift: 7, mask: 7f
mpic: Initializing for 88 sources
<snip>
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 164k init
mpic_enable_irq timeout
PCI endpoint driver. Ver. 0.01
Copyright (C) 2010, Aeroflex, Inc
compiled Oct 12 2010 15:26:57
Endpoint: PORBMSR 8F300001, PORDEVSR 0AA58740
Endpoint: PORPLLSR 0020000A
Endpoint: PORDEVSR 0AA58740
Endpoint: PORDBGMSR 0E000000
Endpoint: PORIMPCR 0000007F
Endpoint: PORCIR 2CFFFFFF
SerDes1 PEX, SerDes2 sRIO 3.125Gbps
EP: from 00000000 to 1FFFFFFF is DDR1
EP: from F0000000 to FFFFFFFF is LBC
EP: from C0000000 to DFFFFFFF is sRIO
EP: from A0000000 to BFFFFFFF is PEX1
EP: from E2000000 to E2FFFFFF is PEX1
EP: from 20000000 to 3FFFFFFF is DDR2
Endpoint PEX1 eedb1800: PEX_CONFIG 00000028
Endpoint PEX1: alloc LAW space A0000000 - A0000FFF
Endpoint PEX1: got MPIC IRQ 224
Unable to handle kernel paging request for data at address 0x00000c00
Faulting instruction address: 0xc0016540
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT SMP NR_CPUS=2 EP8641A
Modules linked in: Endpoint_driver(+)
NIP: c0016540 LR: c0050b38 CTR: c00163b8
REGS: eed41ab0 TRAP: 0300   Not tainted  (2.6.26.2-ep1.10)
MSR: 00001032 <ME,IR,DR>  CR: 24024482  XER: 00000000
DAR: 00000c00, DSISR: 40000000
TASK = eed82050[59] 'insmod' THREAD: eed40000 CPU: 0
GPR00: 00000c00 eed41b60 eed82050 ffffffea 00000000 00000000 c035c17c
000000e0
GPR08: 00400000 00000000 c035c020 00000c00 24024422 100a7264 00000000
00000095
GPR16: 00000095 00000000 0000000d 00000124 f102fdb8 00000000 c004a4fc
f102c000
GPR24: 0000001a f1038428 00000000 c031e610 fffffffa 00009032 c031e5e0
000000e0
NIP [c0016540] mpic_set_irq_type+0x188/0x1c4
LR [c0050b38] set_irq_type+0x84/0xc8
Call Trace:
[eed41b60] [c0050b1c] set_irq_type+0x68/0xc8 (unreliable)
[eed41b80] [c001572c] mpic_host_map+0xec/0xf4
[eed41b90] [c00064a0] irq_setup_virq+0x60/0x98
[eed41bb0] [c00065dc] irq_create_mapping+0x104/0x114
[eed41bd0] [f1034798] Endpoint_device_ctor+0x258/0x3b4 [Endpoint_driver]
[eed41c10] [f1034d3c] Endpoint_device_find+0x448/0x63c [Endpoint_driver]
[eed41e40] [f103a028] Endpoint_init_module+0x28/0x60 [Endpoint_driver]
[eed41e60] [c004bcb4] sys_init_module+0xd4/0x1c1c
[eed41f40] [c0011278] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff787ec
    LR = 0x10010e2c
Instruction dump:
90080018 41bdff34 4bffffd4 7c0938ae 2f800000 540b073e 5400073a 40befef8
4bfffeec 7d26482e 7c095a14 7c0004ac <7d29582e> 0c090000 4c00012c 5520028e
---[ end trace a3d033ca1998c9f0 ]---
note: insmod[59] exited with preempt_count 1

>
> Otherwise, I'm guessing from the lines that you posted that you want to
> add:
>
> mpic_assign_isu(mpic1, 14, res.start + 0x11c00);
>
Actually, I tried this first. So I guess the second parameter is interrupt
vector #>>16, and the third is the address base of the registers to
generate that interrupt.

When I did this, the kernel wouldn't even boot - it seg'ed on that line.
