Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 68F56B6FBA
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 15:02:55 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Date: Fri, 24 Feb 2012 04:02:47 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F0578D5BD@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02C5E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <4F463006.7060507@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C02E4A8@039-SN1MPN1-002.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F0578CD9A@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F46F9CF.6040600@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F0578CFD9@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F46FE3E.1050605@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F0578D305@039-SN2MPN1-023.039d.mgd.msft.net>
 <4F470910.9080008@freescale.com>
In-Reply-To: <4F470910.9080008@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Huang Changming-R66093 <r66093@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Subject: Re: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be
> selectable
>=20
> Li Yang-R58472 wrote:
>=20
> > The mpc85xx_defconfig does include silicons with e500v1 core which
> > doesn't have the 36-bit support.  Won't enabling 36-bit support by
> > default break the support for them?
>=20
> No.  The kernel will detect at runtime that that it's an e500v1 core and
> it won't try to create 36-bit TLBs. (e.g. it won't write to MAS7).

It's a good point.  Why can't we decide to use 32-bit/36-bit TLB at runtime=
 even for e500v2?

>=20
> Please remember that the Kconfig for the P1022DS already forced
> PHYS_64BIT for all mpc85xx platforms.  All we're doing is making it
> possible to deselect PHYS_64BIT.

I think it's a side-effect introduced by P1022DS support and need to be fix=
ed.  There was no mentioning of enforcing 36-bit for all mpc85xx platforms.

- Leo
