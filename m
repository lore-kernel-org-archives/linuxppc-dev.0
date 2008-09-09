Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F1244DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 16:30:56 +1000 (EST)
Message-ID: <48C618B1.1020306@denx.de>
Date: Tue, 09 Sep 2008 08:33:21 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: =?ISO-8859-15?Q?=22Rog=E9rio_Brito=22?= <rbrito@ime.usp.br>
Subject: Re: Call Trace and scary messages on kernel 2.6.27-rc5
References: <20080909004727.GA6239@ime.usp.br>
In-Reply-To: <20080909004727.GA6239@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Rogerio,

Rogério Brito wrote onTue Sep 9 10:47:29 EST 2008:
> I just compiled a new 2.6.27-rc5 kernel for my standard Kurobox (an
> embedded NAS that has an MPC8241 CPU, if I'm not mistaken) and upon
> booting, I get these scary messages and Call Traces:
>
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> Linux version 2.6.27-rc5.try03 (rbrito at chagas) (gcc version 4.2.0) #4 Mon Sep 8 21:12:13 BRT 2008
> (...)
> physmap platform flash device: 00400000 at ffc00000
> physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank
[...]
> 0x00300000-0x00370000 : "mtd_bootcode"
> kobject (c395b278): tried to init an initialized object, something is seriously wrong.
> Call Trace:
> [c381dc80] [c000806c] show_stack+0x4c/0x16c (unreliable)
> [c381dcc0] [c013a308] kobject_init+0x64/0xa4
> [c381dcd0] [c013a920] kobject_init_and_add+0x30/0x78
> [c381dd10] [c0135574] blk_register_filter+0x4c/0x70
> [c381dd20] [c01340a4] add_disk+0x68/0xbc
> [c381dd40] [c01b1210] add_mtd_blktrans_dev+0x17c/0x2b4
> [c381dd60] [c01b1490] mtdblock_add_mtd+0x60/0x80
> [c381dd70] [c01b08d8] blktrans_notify_add+0x44/0x84
> [c381dd90] [c01ac118] add_mtd_device+0xa8/0x140
> [c381ddb0] [c01ad860] add_mtd_partitions+0x55c/0x6b0
> [c381de10] [c01b5cc4] physmap_flash_probe+0x2d8/0x318
> [c381de50] [c0175864] platform_drv_probe+0x20/0x30
> [c381de60] [c0174748] driver_probe_device+0xb8/0x1e8
> [c381de80] [c01738ec] bus_for_each_drv+0x70/0xac
> [c381deb0] [c01749c8] device_attach+0x84/0xa8
> [c381ded0] [c01736e0] bus_attach_device+0x6c/0x78
> [c381dee0] [c01720bc] device_add+0x47c/0x5c8
> [c381df30] [c0175d30] platform_device_add+0x14c/0x1b4
> [c381df50] [c03245fc] physmap_init+0x30/0x48
> [c381df60] [c0003874] do_one_initcall+0x38/0x1a0
> [c381dfd0] [c030a17c] kernel_init+0x88/0xf4
> [c381dff0] [c000fd4c] kernel_thread+0x44/0x60
> 0x00370000-0x00380000 : "mtd_status"
> kobject (c395b278): tried to init an initialized object, something is seriously wrong.

Try this patch:

http://lists.infradead.org/pipermail/linux-mtd/2008-August/022874.html

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
