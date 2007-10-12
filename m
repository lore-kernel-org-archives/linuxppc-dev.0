Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27E7BDDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 21:39:11 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9CBd5vJ016990
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 04:39:06 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9CBd43r010768
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:39:05 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/9 v2] add Freescale SerDes PHY support
Date: Fri, 12 Oct 2007 19:39:03 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5820@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071011200938.GC4247@loki.buserror.net>
References: <1192096425-30192-1-git-send-email-leoli@freescale.com>
	<20071011200938.GC4247@loki.buserror.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Wood Scott-B07421=20
> Sent: Friday, October 12, 2007 4:10 AM
> To: Li Yang-r58472
> Cc: galak@kernel.crashing.org; paulus@samba.org;=20
> linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 3/9 v2] add Freescale SerDes PHY support
>=20
> On Thu, Oct 11, 2007 at 05:53:45PM +0800, Li Yang wrote:
> > diff --git a/arch/powerpc/platforms/Kconfig=20
> > b/arch/powerpc/platforms/Kconfig index 19d4628..e89f803 100644
> > --- a/arch/powerpc/platforms/Kconfig
> > +++ b/arch/powerpc/platforms/Kconfig
> > @@ -291,4 +291,8 @@ config FSL_ULI1575
> >  	  Freescale reference boards. The boards all use the=20
> ULI in pretty
> >  	  much the same way.
> > =20
> > +config FSL_SERDES
> > +	bool
> > +	default n
>=20
> "default n" is the default -- no need to specify it explicitly.
>=20
> > +		/* Configure SRDSCR1 */
> > +		tmp =3D in_be32(regs + FSL_SRDSCR1_OFFS);
> > +		tmp &=3D ~FSL_SRDSCR1_PLLBW;
> > +		out_be32(regs + FSL_SRDSCR1_OFFS, tmp);
>=20
> clrbits32?
>=20
> > +		/* Configure SRDSCR2 */
> > +		tmp =3D in_be32(regs + FSL_SRDSCR2_OFFS);
> > +		tmp &=3D ~FSL_SRDSCR2_SEIC_MASK;
> > +		tmp |=3D FSL_SRDSCR2_SEIC_SATA;
> > +		out_be32(regs + FSL_SRDSCR2_OFFS, tmp);
>=20
> clrsetbits_be32?

Ok, I will try the up-to-the-minute arsenal. :)

- Leo
