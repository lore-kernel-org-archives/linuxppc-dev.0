Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id A572867A75
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Feb 2005 07:25:48 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 16 Feb 2005 14:13:40 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592B9@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
Subject: RE: sched while atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2.6.11rc2 and rc4 gives roughly the same message on an MPC8266

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
scheduling while atomic: swapper/0x00000002/0
Call trace:
 [c0006c30] dump_stack+0x18/0x28
 [c01ba970] schedule+0x670/0x674
 [c0003f20] syscall_exit_work+0x108/0x10c
 [c0244fc4] proc_root_init+0x144/0x150
 [00000000] 0x0
 [c023a5fc] start_kernel+0x138/0x164
 [000035fc] 0x35fc
NET: Registered protocol family 16

Kernel boots normally after this, and everything seems to work

> -----Original Message-----
> From: linuxppc-dev-bounces@ozlabs.org=20
> [mailto:linuxppc-dev-bounces@ozlabs.org] On Behalf Of=20
> danny@mailmij.org
> Sent: Thursday, February 03, 2005 17:15
> To: linuxppc-dev@ozlabs.org
> Subject: sched while atomic
>=20
>=20
> Latest 2.6.11rc* give me this interesting message at boot:
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> scheduling while atomic: swapper/0x00000002/0
> Call trace:
>  [c01c7580] schedule+0x640/0x6bc
>  [c0004698] syscall_exit_work+0x120/0x124
>  [c00a5414] proc_device_tree_init+0x7c/0x98
>  [c02be9b4] proc_root_init+0x14c/0x158
>  [c02a660c] start_kernel+0x178/0x1b0
>  [00003a5c] 0x3a5c
>=20
> Since it doesn't happen on x86, I first thought it was=20
> because of the ppc=20
> specific init of the device_tree, but commenting this out=20
> just lets it=20
> happen somewhere else. It seems schedule is called when it=20
> returns from a=20
> syscall, which seems normal behaviour to me, but the recent=20
> preempt_disable() in start_kernel makes the scheduler give=20
> these warnings.
> So what's happening?=20
>=20
> Also, I think this is already know for a while:
> /lib/modules/2.6.11-rc3/kernel/drivers/video/vga16fb.ko needs unknown=20
> symbol vgacon_remap_base
>=20
> regards,
>=20
> danny
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
