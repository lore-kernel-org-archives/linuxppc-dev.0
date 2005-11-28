Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id 4108868800
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Nov 2005 21:52:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 28 Nov 2005 11:52:33 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9393FE1C7@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Chris Down" <chris@alcor.co.uk>,
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
> From: Chris Down [mailto:chris@alcor.co.uk]=20
> Sent: 28 November 2005 11:01
> To: Joakim Tjernlund; linuxppc-embedded@ozlabs.org
> Subject: RE: Badness in 2.6.15-rc1 on 8xx
>=20
> From: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Joakim Tjernlund
> Sent: 25 November 2005 13:28
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
> The kernel boots just fine into user space so it seems harmless, but I
> suspect it will bite me later.
>=20
>=20
> I am currently working with 2.6.15-rc1 on MPC852 and I am=20
> seeing a similar
> problem.
>=20
> Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:346
> Call trace:
>  [c00036f8] check_bug_trap+0xa4/0xb8
>  [c0003f9c] program_check_exception+0x2f0/0x4c4
>  [c0003320] ret_from_except_full+0x0/0x4c
>  [c024c530] dma_alloc_init+0x3c/0xbc
>  [c0002280] init+0xbc/0x25c
>  [c000538c] kernel_thread+0x44/0x60
>=20
> Have not had time to look at it yet, however I was not getting this on
> 2.6.11.
>=20
> Chris

Let me guess you have IMAP_ADDR set to 0xff000000? Then you need to
change
CONSISTENT_START to something else(like 0xffa00000). Its somwhere in the
Advanced setup.

 Jocke
