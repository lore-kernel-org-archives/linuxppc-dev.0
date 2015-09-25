Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7604D1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 12:24:28 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Shawn Guo <shawnguo@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Zhao C.H.
 <chenhui.zhao@freescale.com>, Huan Wang <alison.wang@freescale.com>,
 "Yuantian Tang" <Yuantian.Tang@freescale.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, Jin Jason <Jason.Jin@freescale.com>, Scott Wood
 <scottwood@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] fsl: Add binding for RCPM
Date: Fri, 25 Sep 2015 02:24:22 +0000
Message-ID: <SN1PR0301MB161689CBB87F80716219B6F79D420@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
 <20150924122917.GQ3529@tiger>
In-Reply-To: <20150924122917.GQ3529@tiger>
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

Hi Shawn,

Thanks for your review.

> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > RCPM is the Run Control and Power Management module performs all
> > device-level tasks associated with device run control and power
> > management.
> >
> > Add this for freescale powerpc platform and layerscape platform.
> >
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> > *v3*
> > - Add "fsl,#rcpm-wakeup-cells" for rcpm node. The number of cells
> >   correspond rcpm-wakeup property.
> > - Modify rcpm-wakeup property description.
> >
> > *v2*
> > - Remove P4080 example.
> > - Modify rcpm-wakeup property description.
> >
> > diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > new file mode 100644
> > index 0000000..52110ec
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > @@ -0,0 +1,63 @@
> > +* Run Control and Power Management
> > +-------------------------------------------
> > +The RCPM performs all device-level tasks associated with device run
> > +control and power management.
> > +
> > +Required properites:
> > +  - reg : Offset and length of the register set of RCPM block.
> > +  - fsl,#rcpm-wakeup-cells : The number of cells in rcpm-wakeup proper=
ty.
> > +  - compatible : Sould contain a chip-specific RCPM block compatible s=
tring
> > +	and (if applicable) may contain a chassis-version RCPM compatible
> > +	string. Chip-specific strings are of the form "fsl,<chip>-rcpm",
> > +	such as:
> > +	* "fsl,p2041-rcpm"
> > +	* "fsl,p3041-rcpm"
> > +	* "fsl,p4080-rcpm"
> > +	* "fsl,p5020-rcpm"
> > +	* "fsl,p5040-rcpm"
> > +	* "fsl,t4240-rcpm"
> > +	* "fsl,b4420-rcpm"
> > +	* "fsl,b4860-rcpm"
> > +
> > +	Chassis-version strings are of the form "fsl,qoriq-rcpm-<version>",
> > +	such as:
> > +	* "fsl,qoriq-rcpm-1.0": for chassis 1.0 rcpm
> > +	* "fsl,qoriq-rcpm-2.0": for chassis 2.0 rcpm
> > +	* "fsl,qoriq-rcpm-2.1": for chassis 2.1 rcpm
> > +
> > +All references to "1.0" and "2.0" refer to the QorIQ chassis version
> > +to which the chip complies.
> > +Chassis Version		Example Chips
> > +---------------		-------------------------------
> > +1.0				p4080, p5020, p5040, p2041, p3041
> > +2.0				t4240, b4860, b4420
> > +2.1				t1040, ls1021
> > +
> > +Example:
> > +The RCPM node for T4240:
> > +	rcpm: global-utilities@e2000 {
> > +		compatible =3D "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
> > +		reg =3D <0xe2000 0x1000>;
> > +		fsl,#rcpm-wakeup-cells =3D <2>;
> > +	};
> > +
> > +* Freescale RCPM Wakeup Source Device Tree Bindings
> > +-------------------------------------------
> > +Required rcpm-wakeup property should be added to a device node if the
> > +device can be used as a wakeup source.
> > +
> > +  - rcpm-wakeup: The value of the property consists of cells, the
> > + number of
>=20
> Shouldn't this vendor specific property be prefixed with 'fsl,' as well?
>=20

Okay.

> > +	cells defined in "fsl,#rcpm-wakeup-cells". The first cell is a pointe=
r
> > +	to the rcpm node, the second cell is the bit mask that should be set
> > +	in IPPDEXPCR0, and the third cell is for IPPDEXPCR1, and so on.
>=20
> I guess that IPPDEXPCR0 and IPPDEXPCR1 need some documentation too, or a =
pointer
> to hardware documents containing more detailed info about them.
>=20

Following the "rcpm-wakeup" documents put a "Note" to describe IPPDEXPCRx r=
egisters?

Regards,
-Dongsheng=20
