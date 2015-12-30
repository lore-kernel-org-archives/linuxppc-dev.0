Return-Path: <shaohui.xie@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0060.outbound.protection.outlook.com [157.56.112.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBAB51A0021
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 14:41:25 +1100 (AEDT)
From: Shaohui Xie <shaohui.xie@nxp.com>
To: Rob Herring <robh@kernel.org>, "shh.xie@gmail.com" <shh.xie@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Scott Wood
 <scottwood@freescale.com>, Igal Liberman <Igal.Liberman@freescale.com>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: RE: [PATCH] powerpc: fsl: update fman dt binding for PCS PHY
Date: Wed, 30 Dec 2015 03:41:16 +0000
Message-ID: <VI1PR04MB1664E34FC9467506BEC5D815E8FD0@VI1PR04MB1664.eurprd04.prod.outlook.com>
References: <1451274454-26091-1-git-send-email-shh.xie@gmail.com>
 <20151229183436.GB12450@rob-hp-laptop>
In-Reply-To: <20151229183436.GB12450@rob-hp-laptop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Subject: Re: [PATCH] powerpc: fsl: update fman dt binding for PCS PHY
>=20
> On Mon, Dec 28, 2015 at 11:47:34AM +0800, shh.xie@gmail.com wrote:
> > From: Shaohui Xie <Shaohui.Xie@freescale.com>
> >
> > PCS PHY can support backplane (1000BASE-KX and 10GBASE-KR), this needs
> > to change corresponding serdes lane settings, so a reference is needed
> > for serdes lane. This patch describes properties needed for PCS PHY to
> > support backplane.
> >
> > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > ---
> > based on: http://patchwork.ozlabs.org/patch/560936/
> >
> >  Documentation/devicetree/bindings/powerpc/fsl/fman.txt | 14
> > ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > index 55c2c03..b38e727 100644
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > @@ -432,6 +432,16 @@ example of how to define a PHY (Internal PHY has n=
o
> interrupt line).
> >  - For "fsl,fman-mdio" compatible internal mdio bus, the PHY is TBI PHY=
.
> >  - For "fsl,fman-memac-mdio" compatible internal mdio bus, the PHY is P=
CS PHY,
> >    PCS PHY addr must be '0'.
> > +  PCS PHY can support backplane (1000BASE-KX and 10GBASE-KR), this
> > + needs to  change the corresponding serdes lane settings.
> > +
> > +  PCS PHY node properties required for backplane:
> > +
> > +  - compatible: must be "ethernet-phy-ieee802.3-c45".
> > +  - phy-mode: string, operation mode of the PHY interface; must be "10=
00base-
> kx"
> > +    for 1000BASE-KX, or "10gbase-kr" for 10GBASE-KR.
>=20
> Seems like these should be in common ethernet phy binding.
[S.H] 'compatible' and 'phy-mode' are standard properties already in common=
 Ethernet
phy binding, I can update 'phy-mode' with "1000base-kx" and "10gbase-kr", h=
ow
about I still list the two properties here for the requirement of PCS PHY t=
o support
backplane?

>=20
> > +  - lane-handle: phandle, specifies a reference to a node representing=
 a
> Serdes.
> > +  - lane-range: offset and length of the register set for the serdes l=
ane.
>=20
> These seem pretty FSL specific, so add vendor prefix.
[S.H] OK. will add fsl prefix.

Thank you for reviewing the patch!

Shaohui
