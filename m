Return-Path: <igal.liberman@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0066.outbound.protection.outlook.com [157.56.112.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BF311A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 20:39:25 +1100 (AEDT)
From: Igal Liberman <igal.liberman@nxp.com>
To: Rob Herring <robh@kernel.org>, Igal Liberman <Igal.Liberman@freescale.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Scott Wood
 <scottwood@freescale.com>, Madalin-Cristian Bucur
 <madalin.bucur@freescale.com>, "shaohui.xie@freescale.com"
 <shaohui.xie@freescale.com>
Subject: RE: [v2] powerpc/fsl: Update fman dt binding with pcs-phy and tbi-phy
Date: Mon, 11 Jan 2016 09:23:59 +0000
Message-ID: <AMXPR04MB248CB84E0F389149CA964BBECC90@AMXPR04MB248.eurprd04.prod.outlook.com>
References: <1450921331-25309-1-git-send-email-igal.liberman@freescale.com>
 <20151230162733.GA2518@rob-hp-laptop>
In-Reply-To: <20151230162733.GA2518@rob-hp-laptop>
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

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, December 30, 2015 6:28 PM
> To: Igal Liberman <Igal.Liberman@freescale.com>
> Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Scott Wood
> <scottwood@freescale.com>; Madalin-Cristian Bucur
> <madalin.bucur@freescale.com>; shaohui.xie@freescale.com
> Subject: Re: [v2] powerpc/fsl: Update fman dt binding with pcs-phy and tb=
i-
> phy
>=20
> On Thu, Dec 24, 2015 at 03:42:11AM +0200, igal.liberman@freescale.com
> wrote:
> > From: Igal Liberman <igal.liberman@freescale.com>
> >
> > The FMan contains internal PHY devices used for SGMII connections to
> > external PHYs. When these PHYs are in use a reference is needed for
> > both the external PHY and the internal one. For the external PHY
> > phy-handle provides the reference. For the internal PHY a new handle
> > is required.
> > In dTSEC, the internal PHY is a TBI (Ten Bit Interface) PHY, the
> > handle used will be tbi-handle.
> > In mEMAC, the internal PHY is a PCS (Physical Coding Sublayer) PHY,
> > the handle used will be pcsphy-handle.
>=20
> This is fairly commom for 10G eth I think. Can't you use the common PHY
> binding here in the case without internal MDIO bus? Just because you use =
it
> that doesn't mean you have to use the generic phy subsystem in the kernel=
.
>=20

mEMAC and dTSEC always have internal MDIO bus.
I was requested to use generic PHY API for internal PHY configuration by ne=
tdev, this part was accepted.=20

> Perhaps phy-handle should be deprecated in favor of doing something like
> this if you need a phandle to both:
>=20
> phys =3D <&internal-phy>, <&external-phy>;
>=20

I think that pcsphy-handle and tbi-handle represent the hardware in a good =
way.
This is the actual name of the hardware.

> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > index 1fc5328..55c2c03 100644
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > @@ -315,6 +315,16 @@ PROPERTIES
> >  		Value type: <phandle>
> >  		Definition: A phandle for 1EEE1588 timer.
> >
> > +- pcsphy-handle
> > +		Usage required for "fsl,fman-memac" MACs
> > +		Value type: <phandle>
> > +		Definition: A phandle for pcsphy.
> > +
> > +- tbi-handle
> > +		Usage required for "fsl,fman-dtsec" MACs
> > +		Value type: <phandle>
> > +		Definition: A phandle for tbiphy.
> > +
> >  EXAMPLE
> >
> >  fman1_tx28: port@a8000 {
> > @@ -340,6 +350,7 @@ ethernet@e0000 {
> >  	reg =3D <0xe0000 0x1000>;
> >  	fsl,fman-ports =3D <&fman1_rx8 &fman1_tx28>;
> >  	ptp-timer =3D <&ptp-timer>;
> > +	tbi-handle =3D <&tbi0>;
>=20
> What does the tbi0 node contain? It should be present in the example.
>=20

There is an example in under MDIO section:

mdio@e3120 {
	compatible =3D "fsl,fman-mdio";
	reg =3D <0xe3120 0xee0>;
	fsl,fman-internal-mdio;

	tbi1: tbi-phy@8 {
		reg =3D <0x8>;
		device_type =3D "tbi-phy";
	};
};

I used different indexes to make sure that it's aligned to the other exampl=
es in the binding document.

> Rob

Thank you for your feedback,=20
Igal
