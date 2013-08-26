Return-Path: <B29983@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9EC62C0079
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 12:42:39 +1000 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [v3] powerpc/mpc85xx: Update the clock device tree nodes
Date: Mon, 26 Aug 2013 02:42:30 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B1503BE58@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1370480811-13700-1-git-send-email-Yuantian.Tang@freescale.com>
 <20130823200827.GA29737@home.buserror.net>
In-Reply-To: <20130823200827.GA29737@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >
> >  	clockgen: global-utilities@e1000 {
> > -		compatible =3D "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0";
> > +		compatible =3D "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0",
> > +				   "fixed-clock";
> > +		clock-output-names =3D "sysclk";
> > +		#clock-cells =3D <0>;
>=20
> Does U-Boot fill in clock-frequency here?
>=20
Yes, clock-frequency will be filled by uboot.
You suggested we'd better not add it here.

> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800>;
> > +			compatible =3D "fsl,core-pll-clock";
> > +			clocks =3D <&clockgen>;
> > +			clock-output-names =3D "pll0", "pll0-div2", "pll0-div4";
> > +		};
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820>;
> > +			compatible =3D "fsl,core-pll-clock";
> > +			clocks =3D <&clockgen>;
> > +			clock-output-names =3D "pll1", "pll1-div2", "pll1-div4";
> > +		};
>=20
> Please leave a blank line between properties and nodes, and between nodes=
.
>=20
OK, will add.

> What does reg represent?  Where is the binding for this?
>=20
> The compatible is too vague.
Reg is register offset. I should have had a binding document.
About the compatible, you should pointed it out earlier in SDK review.
It is too later to change since the clock driver is merged for months altho=
ugh=20
I sent this patch first.
Besides, it is not too bad because other arch use the similar name.

Regards,
Yuantian

>=20
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0>;
> > +			compatible =3D "fsl,core-mux-clock";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll0 2>,
> > +				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll0_2",
> > +				"pll1_0", "pll1_1", "pll1_2";
> > +			clock-output-names =3D "cmux0";
> > +		};
>=20
> What does reg represent?  Where is the binding for this?
>=20
> The compatible is too vague.
>=20
> -Scott
