Return-Path: <B13201@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BBF051007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jan 2010 13:49:46 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0F2ngnT011286 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 19:49:42 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o0F2u4rc021627
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 20:56:05 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/4] phy: add RTBI mode for m88e1111
Date: Fri, 15 Jan 2010 10:49:37 +0800
Message-ID: <0A1FE637C2C7E148B9573BB60CC630E5711B54@zch01exm26.fsl.freescale.net>
In-Reply-To: <BC00E67D-5906-4740-A961-84FC1C524A4F@kernel.crashing.org>
References: <1263456799-3306-1-git-send-email-yu.liu@freescale.com>
	<1263456799-3306-2-git-send-email-yu.liu@freescale.com>
	<1263456799-3306-3-git-send-email-yu.liu@freescale.com>
	<1263456799-3306-4-git-send-email-yu.liu@freescale.com>
	<BC00E67D-5906-4740-A961-84FC1C524A4F@kernel.crashing.org>
From: "Liu Yu-B13201" <B13201@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Friday, January 15, 2010 12:20 AM
> To: Liu Yu-B13201
> Cc: davem@davemloft.net; linuxppc-dev@lists.ozlabs.org;=20
> netdev@vger.kernel.org
> Subject: Re: [PATCH 4/4] phy: add RTBI mode for m88e1111
>=20
>=20
> On Jan 14, 2010, at 2:13 AM, Liu Yu wrote:
>=20
> > Signed-off-by: Liu Yu <yu.liu@freescale.com>
> > ---
> > drivers/net/phy/marvell.c |   38=20
> ++++++++++++++++++++++++++++++++++++++
> > 1 files changed, 38 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> > index 6f69b9b..65ed385 100644
> > --- a/drivers/net/phy/marvell.c
> > +++ b/drivers/net/phy/marvell.c
> > @@ -63,6 +63,7 @@
> > #define MII_M1111_HWCFG_MODE_COPPER_RGMII	0xb
> > #define MII_M1111_HWCFG_MODE_FIBER_RGMII	0x3
> > #define MII_M1111_HWCFG_MODE_SGMII_NO_CLK	0x4
> > +#define MII_M1111_HWCFG_MODE_COPPER_RTBI	0x9
> > #define MII_M1111_HWCFG_FIBER_COPPER_AUTO	0x8000
> > #define MII_M1111_HWCFG_FIBER_COPPER_RES	0x2000
> >=20
> > @@ -269,6 +270,43 @@ static int m88e1111_config_init(struct=20
> phy_device *phydev)
> > 			return err;
> > 	}
> >=20
> > +	if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RTBI) {
> > +		temp =3D phy_read(phydev, MII_M1111_PHY_EXT_CR);
> > +		if (temp < 0)
> > +			return temp;
> > +		temp |=3D (MII_M1111_RX_DELAY | MII_M1111_TX_DELAY);
> > +		err =3D phy_write(phydev, MII_M1111_PHY_EXT_CR, temp);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		temp =3D phy_read(phydev, MII_M1111_PHY_EXT_SR);
> > +		if (temp < 0)
> > +			return temp;
> > +		temp &=3D ~(MII_M1111_HWCFG_MODE_MASK |=20
> MII_M1111_HWCFG_FIBER_COPPER_RES);
> > +		temp |=3D 0x7 | MII_M1111_HWCFG_FIBER_COPPER_AUTO;
>=20
> Does this magic 0x7 have some meaning?
>=20

Hrr...  it's GMII to fibre mode.
Document 88E1111_erata_RevB2  chapter 4.35 describ the reason.
Without this sometimes phys couldnot work.
