Return-Path: <torsten.demke@motorola.com>
Received: from motgate7.mot.com (motgate7.mot.com [129.188.136.7])
	by ozlabs.org (Postfix) with ESMTP id 106DE6883B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Nov 2005 01:21:51 +1100 (EST)
Received: from az33exr01.mot.com ([10.64.251.231])
	by motgate7.mot.com (8.12.11/Motgate7) with ESMTP id jAPEkCQc012945
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Nov 2005 07:46:12 -0700 (MST)
Received: from zuk35exm60.ds.mot.com (zuk35exm60.ea.mot.com [10.178.1.39])
	by az33exr01.mot.com (8.13.1/8.13.0) with ESMTP id jAPEZp60004208
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Nov 2005 08:35:52 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 25 Nov 2005 14:21:45 -0000
Message-ID: <67194FEE6056B947B4EF756C9E497A2E2FE6DC@zuk35exm60.ds.mot.com>
From: "Demke Torsten-atd012" <torsten.demke@motorola.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: Badness in 2.6.15-rc1 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Joakim Tjernlund
> Sent: Freitag, 25. November 2005 14:28
> To: linuxppc-embedded@ozlabs.org
> Subject: Badness in 2.6.15-rc1 on 8xx
>=20
> Anyone seen this when booting 2.6.15-rc1 on 8xx?
>   Mount-cache hash table entries: 512
>   Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:346
>   Call trace:
>    [c00039e8] check_bug_trap+0x80/0xa8
>    [c0003c1c] program_check_exception+0x20c/0x480
>    [c00031e0] ret_from_except_full+0x0/0x4c
>    [c01b86b8] dma_alloc_init+0x40/0xcc
>    [c000225c] init+0x8c/0x288
>    [c00050ac] kernel_thread+0x44/0x60
>   NET: Registered protocol family 16
> The kernel boots just fine into user space so it seems=20
> harmless, but I suspect it will bite me later.
>=20
> Something anoying:
> Why did the new cpm_uart driver change major and minor number=20
> for the tty?
> As it is now I can't boot my 2.4 rootfs as init think it=20
> should find the console on ttyS0.
> Would be great if major and minor could be configurable.
Because it's a new driver...with a new name (ttyCPM0) and a new
device number. It shared the device number and name in 2.4=20
with the "standard" device driver (8250/16550), and that made
it very difficult to use both in 2.4.=20
Maybe you should use console=3DttyCPM0 in your boot parameters for 2.6.

Regards,
Torsten
>=20
>   Jocke
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
