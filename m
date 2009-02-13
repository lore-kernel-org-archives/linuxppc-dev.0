Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3BD4ADDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 13:24:59 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1D2OtPh016615
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 19:24:55 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n1D2Ora9007048
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 20:24:54 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc/83xx: Revive Marvell PHY option onMPC8313E-RDB
	rev. C boards
Date: Fri, 13 Feb 2009 10:24:51 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED1D2E69@zch01exm26.fsl.freescale.net>
In-Reply-To: <20090213011801.GA28509@oksana.dev.rtsoft.ru>
References: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
	<2a27d3730902082347n7f0eb48dq8c4ecccda290f9c8@mail.gmail.com>
	<ED186496-3882-4E87-9BEC-B56FE09C5827@kernel.crashing.org>
	<20090210151047.GA25086@oksana.dev.rtsoft.ru>
	<60C07231-C830-440E-8425-D3069AB3620B@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9ED1D2D8B@zch01exm26.fsl.freescale.net>
	<F0245D03-4191-4482-B007-603C3DAC8A1A@kernel.crashing.org>
	<20090213011801.GA28509@oksana.dev.rtsoft.ru>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: <avorontsov@ru.mvista.com>, "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
> Sent: Friday, February 13, 2009 9:18 AM
> To: Kumar Gala
> Cc: linuxppc-dev list; Li Yang-R58472
> Subject: Re: [PATCH] powerpc/83xx: Revive Marvell PHY option=20
> onMPC8313E-RDB rev. C boards
>=20
> On Thu, Feb 12, 2009 at 05:51:57PM -0600, Kumar Gala wrote:
> > On Feb 11, 2009, at 11:40 PM, Li Yang-R58472 wrote:
> >>>> Li, thanks for heads-up!
> >>>>
> >>>> One thing though: documentation says that Marvell PHY
> >>> address is 0x3,
> >>>> while old device tree and this patch:
> >>>>
> >>>>
> >>> http://www.bitshrine.org/gpp/linux-fsl-2.6.23-MPC8313ERDB-add-
> >>> default-
> >>>> dts.patch
> >>>>
> >>>> says "0x1"... I don't have any rev. C boards, so it would
> >>> be great if
> >>>> somebody could confirm that 0x1 is the actual address.
> >>
> >> The correct address is 0x3.  The previous patch in revB BSP used a=20
> >> guess value before the revC documentation is available. =20
> The latest=20
> >> BSP has been updated to use the correct address.
> >
> > Anton, will you spin a new patch with this change?
>=20
> Since the correct address is 0x3, that means that the old=20
> device tree never worked on rev. C boards, thus there is no=20
> regression.
> And furthermore, it appears that U-Boot doesn't support=20
> Marvell PHY option either.

No regression but to be more updated.  RevC boards are newly introduced.

>=20
> So, I don't think that adding the new device tree makes any sense now.
>=20
> I think the better option would be to implement Marvell PHY=20
> support in U-Boot, and at the same time teach U-Boot to fixup=20
> 8313rdb's device tree depending on the environment variable=20
> (something like setenv marvell_phy_option yes/no), i.e. like=20
> I did for MPC8315E-RDB's ULPI/TSEC1 options:
>=20
> http://lists.denx.de/pipermail/u-boot/2008-July/036553.html

This approach is surely more user friendly.

- Leo
