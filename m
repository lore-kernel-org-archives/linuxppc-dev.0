Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0102.outbound.protection.outlook.com [207.46.100.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05B9C1A06B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 03:10:27 +1100 (AEDT)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: Scott Wood <scottwood@freescale.com>, Shaohui Xie
 <Shaohui.Xie@freescale.com>, Madalin-Cristian Bucur
 <madalin.bucur@freescale.com>
Subject: RE: [PATCH] powerpc/fsl: Update fman dt binding with pcs-phy and
 tbi-phy
Date: Tue, 22 Dec 2015 16:10:20 +0000
Message-ID: <DM2PR03MB509A7437BA4A9A28DDE77CFE6E50@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1450757888-14216-1-git-send-email-igal.liberman@freescale.com>
 <1450799843.28718.56.camel@infinera.com>
In-Reply-To: <1450799843.28718.56.camel@infinera.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Regards,
Igal Liberman

> -----Original Message-----
> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@infinera.com]
> Sent: Tuesday, December 22, 2015 5:57 PM
> To: linuxppc-dev@lists.ozlabs.org; Liberman Igal-B31950
> <Igal.Liberman@freescale.com>; devicetree@vger.kernel.org
> Cc: Wood Scott-B07421 <scottwood@freescale.com>; Xie Shaohui-B21989
> <Shaohui.Xie@freescale.com>; Bucur Madalin-Cristian-B32716
> <madalin.bucur@freescale.com>
> Subject: Re: [PATCH] powerpc/fsl: Update fman dt binding with pcs-phy and
> tbi-phy
>=20
> On Tue, 2015-12-22 at 06:18 +0200, igal.liberman@freescale.com wrote:
> > From: Igal Liberman <igal.liberman@freescale.com>
> >
> > Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> > ---
> > =A0.../devicetree/bindings/powerpc/fsl/fman.txt=A0=A0=A0=A0=A0=A0=A0|=
=A0=A0=A039
> > ++++++++++++++++++++
> > =A01 file changed, 39 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > index 1fc5328..7a6d7c3 100644
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > @@ -315,6 +315,16 @@ PROPERTIES
> > =A0		Value type: <phandle>
> > =A0		Definition: A phandle for 1EEE1588 timer.
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
> > =A0EXAMPLE
> >
> > =A0fman1_tx28: port@a8000 {
> > @@ -340,6 +350,7 @@ ethernet@e0000 {
> > =A0	reg =3D <0xe0000 0x1000>;
> > =A0	fsl,fman-ports =3D <&fman1_rx8 &fman1_tx28>;
> > =A0	ptp-timer =3D <&ptp-timer>;
> > +	tbi-handle =3D <&tbi0>;
> > =A0};
> >
> >
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D
> > @@ -415,6 +426,13 @@ PROPERTIES
> > =A0		The settings and programming routines for internal/external
> > =A0		MDIO are different. Must be included for internal MDIO.
> >
> > +For internal PHY device on internal mdio bus, a PHY node should be
> created.
> > +See the definition of the PHY node in booting-without-of.txt for an
> > +example of how to define a PHY (Internal PHY has no interrupt line).
> > +- For "fsl,fman-mdio" compatible internal mdio bus, the PHY is TBI PHY=
.
> > +- For "fsl,fman-memac-mdio" compatible internal mdio bus, the PHY is
> > +PCS PHY,
> > +=A0=A0PCS PHY addr must be '0'.
>=20
> Will this replace the need for fixed PHYs ?
>=20

Hi Jocke,

No, this is internal PCS configuration which required for both types of lin=
ks.
The configuration for fixed links is different, but we use the same method.

Igal

> =A0 =A0Jocke
