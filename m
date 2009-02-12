Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 82B26DDDAA
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 13:36:23 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1C2aJ3K029613
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 19:36:20 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1C2aIGm025776
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 20:36:19 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/83xx: Revive Marvell PHY option on MPC8313E-RDB
	rev. C boards
Date: Thu, 12 Feb 2009 10:36:18 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED1D2D22@zch01exm26.fsl.freescale.net>
In-Reply-To: <6413661A-2719-46F5-AC06-C83C088DCCA1@kernel.crashing.org>
References: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
	<2a27d3730902082347n7f0eb48dq8c4ecccda290f9c8@mail.gmail.com>
	<ED186496-3882-4E87-9BEC-B56FE09C5827@kernel.crashing.org>
	<20090210151047.GA25086@oksana.dev.rtsoft.ru>
	<6413661A-2719-46F5-AC06-C83C088DCCA1@kernel.crashing.org>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Tuesday, February 10, 2009 11:31 PM
> To: avorontsov@ru.mvista.com
> Cc: Li Yang-R58472; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] powerpc/83xx: Revive Marvell PHY option=20
> on MPC8313E-RDB rev. C boards
>=20
>=20
> On Feb 10, 2009, at 9:10 AM, Anton Vorontsov wrote:
>=20
> > commit e85477f516c2de7ed515fcf94ceab5282eba7fa4 ("powerpc/83xx: Fix=20
> > TSEC0 workability on MPC8313E-RDB boards") fixed TSEC0=20
> workability for=20
> > rev. A and rev. B boards by using fixed-link property for VSC 7385=20
> > 5-port switch. But rev. C boards have an option where TSEC0=20
> connected=20
> > to a Marvell PHY, which is a normal PHY on MDIO bus.
> >
> > So far U-Boot does not fix up TSEC0 nodes for MPC8313E-RDB=20
> boards, so=20
> > we'd better include two device-tree files: one that specify Vitesse=20
> > PHY and another for boards with Marvell PHY option.
> >
> > Reported-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >
> > Li, thanks for heads-up!
> >
> > One thing though: documentation says that Marvell PHY=20
> address is 0x3,=20
> > while old device tree and this patch:
> >
> >=20
> http://www.bitshrine.org/gpp/linux-fsl-2.6.23-MPC8313ERDB-add-default-
> > dts.patch
> >
> > says "0x1"... I don't have any rev. C boards, so it would=20
> be great if=20
> > somebody could confirm that 0x1 is the actual address.
> >
> > arch/powerpc/boot/dts/mpc8313erdb_marvell_phy.dts |  401=20
> ++++++++++++
> > +++++++++
> > arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |    2 +-
> > 2 files changed, 402 insertions(+), 1 deletions(-) create=20
> mode 100644=20
> > arch/powerpc/boot/dts/mpc8313erdb_marvell_phy.dts
>=20
> did we decide that we don't have any bcsr or something that=20
> convey board rev or this setting?

Nope for now.  The board do have two revision bits readable to the core,
one bit set by resisters and the other set by a switch.  We don't
currently have a convention for using these two bits.  And apperently
they can't cover the information of both the board revision and setup.

- Leo
