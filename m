Return-Path: <Emilian.Medve@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DB02CDDEA3
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:39:18 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9JDdD8e009098
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 06:39:13 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9JDdDbd005419
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 08:39:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] ucc_geth: Eliminate compile warnings
Date: Fri, 19 Oct 2007 06:39:12 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E270168520B@az33exm24.fsl.freescale.net>
In-Reply-To: <20071018.173032.48505868.davem@davemloft.net>
References: <1192745713-20829-1-git-send-email-Emilian.Medve@Freescale.com>
	<20071018.173032.48505868.davem@davemloft.net>
From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
To: "David Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello David


> It only kills the warning on 32-bit systems, the cast is wrong
> either way.

I'm not aware of the QE being present on any 64-bit PowerPC. However,
porting the entire driver to a 64-bit platform is an exercise in itself
as many other things would need tweaking the QE hardware itself. But
that's an orthogonal issue. For now I just want to fix that warning.

>=20
> >  			ugeth->tx_bd_ring_offset[j] =3D
> > -				kmalloc((u32) (length + align),=20
> GFP_KERNEL);
> > +				(u32)kmalloc(length + align,=20
> GFP_KERNEL);
> > =20
> >  			if (ugeth->tx_bd_ring_offset[j] !=3D 0)
> >  				ugeth->p_tx_bd_ring[j] =3D
>=20
> Pointers can be up to "unsigned long" in size, therefore that
> is the minimal amount of storage you need to store them into
> if they are needed in integer form for some reason.
>=20
> Any cast from pointer to integer like this is a huge red flag.

Agreed, but again, I'm not trying to fix the entire driver or to port it
to a different architecture.

For the current situation, 32-bit QE, 32-bit PowerPC, do you find the
patch acceptable?


Cheers,
Emil.
