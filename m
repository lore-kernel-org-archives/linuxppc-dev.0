Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 95003DDE08
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 13:09:17 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l28297VJ027372
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 19:09:08 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l28296Ub010610
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 20:09:07 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Thu, 8 Mar 2007 10:09:05 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C0DBE18@zch01exm26.fsl.freescale.net>
In-Reply-To: <150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Loeliger Jon-LOELIGER" <jdl@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Kumar,

> >  	/* Alloc mpic structure and per isu has 16 INT entries. */
> >  	mpic1 =3D mpic_alloc(np, res.start,
> >  			MPIC_PRIMARY | MPIC_WANTS_RESET |=20
> MPIC_BIG_ENDIAN,
> > -			16, NR_IRQS - 4,
> > +			16, NR_IRQS - 10,
> >  			" MPIC     ");
>=20
> Why is the number of interrupts reduced by 10?

There's IRQs reserved for mpic using in mpic.c around line 962:

	mpic->timer_vecs[0] =3D intvec_top - 8;
	mpic->timer_vecs[1] =3D intvec_top - 7;
	mpic->timer_vecs[2] =3D intvec_top - 6;
	mpic->timer_vecs[3] =3D intvec_top - 5;
	mpic->ipi_vecs[0]   =3D intvec_top - 4;
	mpic->ipi_vecs[1]   =3D intvec_top - 3;
	mpic->ipi_vecs[2]   =3D intvec_top - 2;
	mpic->ipi_vecs[3]   =3D intvec_top - 1;
	mpic->spurious_vec  =3D intvec_top;

So I reduces it by 10 for IRQs reserved (leave 1 more space for
further).

Thanks!

Best Regards,
Zhang Wei
