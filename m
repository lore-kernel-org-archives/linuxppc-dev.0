Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0146.outbound.protection.outlook.com [157.56.111.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D67E71A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 04:38:13 +1100 (AEDT)
Message-ID: <1415727479.15957.29.camel@freescale.com>
Subject: Re: [PATCH] DT: add MDIO node for FMan node
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
Date: Tue, 11 Nov 2014 11:37:59 -0600
In-Reply-To: <fb6dc6131da04e89bfc31bd8278030a0@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1415102196-9238-1-git-send-email-shh.xie@gmail.com>
 <1415665384.15957.16.camel@freescale.com>
 <fb6dc6131da04e89bfc31bd8278030a0@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Liberman Igal-B31950 <Igal.Liberman@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Medve
 Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-11-11 at 04:32 -0600, Xie Shaohui-B21989 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, November 11, 2014 8:23 AM
> > To: shh.xie@gmail.com
> > Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; Medve
> > Emilian-EMMEDVE1; Xie Shaohui-B21989
> > Subject: Re: [PATCH] DT: add MDIO node for FMan node
> > 
> > On Tue, 2014-11-04 at 19:56 +0800, shh.xie@gmail.com wrote:
> > > From: Shaohui Xie <Shaohui.Xie@freescale.com>
> > >
> > > This binding is for FMan MDIO, it covers FMan v2 & FMan v3.
> > >
> > > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > > ---
> > > based on http://patchwork.ozlabs.org/patch/390351/
> > > for 'next' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> > 
> > Are there any other FMan pieces that are missing from the above patch?
> [S.H] I'm adding Igal for this comment.
> 
> > 
> > >  .../devicetree/bindings/powerpc/fsl/fman.txt       | 69
> > ++++++++++++++++++++++
> > >  1 file changed, 69 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > > b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > > index da8e5f2..83c2f14 100644
> > > --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > > +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > > @@ -7,6 +7,7 @@ CONTENTS
> > >    - FMan MURAM Node
> > >    - FMan dTSEC/XGEC/mEMAC Node
> > >    - FMan IEEE 1588 Node
> > > +  - FMan MDIO Node
> > >    - Example
> > >
> > >
> > > ======================================================================
> > > ======= @@ -352,6 +353,67 @@ ptp-timer@fe000 {  };
> > >
> > >
> > > ======================================================================
> > > =======
> > > +FMan MDIO Node
> > > +
> > > +DESCRIPTION
> > > +
> > > +The MDIO is a bus to which the PHY devices are connected.
> > > +
> > > +PROPERTIES
> > > +
> > > +- compatible
> > > +		Usage: required
> > > +		Value type: <stringlist>
> > > +		Definition: A standard property.
> > > +		Must include "fsl,fman-mdio" for 1 Gb/s MDIO from FMan v2.
> > > +		Must include "fsl,fman-xmdio" for 10 Gb/s MDIO from FMan v2.
> > > +		Must include "fsl,fman-memac-mdio" for 1/10 Gb/s MDIO from
> > > +		FMan v3.
> > > +
> > > +- reg
> > > +		Usage: required
> > > +		Value type: <prop-encoded-array>
> > > +		Definition: A standard property.
> > > +
> > > +- bus-frequency
> > > +		Usage: optional
> > > +		Value type: <u32>
> > > +		Definition: Default MDIO bus clock speed.
> > 
> > Use clocks/clock-names
> [S.H] The MDIO uses Fman clock and divides it to a proper value which is specified by this property.

Use clocks/clock-names to describe that relationship.

> > 
> > > +- interrupts
> > > +		Usage: optional
> > > +		Value type: <prop-encoded-array>
> > > +		Definition: MDIO controller event interrupts.
> > 
> > One interrupt or multiple?
> [S.H] One for 1 Gb/s, one for 10 Gb/s.

Then the binding needs to say that there are two (except for
"fsl,fman-mdio", right?) and which is which.

> > 
> > > +
> > > +- type
> > > +		Usage: required for FMan v3
> > > +		Value type: <stringlist>
> > > +		Definition: A standard property.
> > 
> > What standard is "type" defined in?
>
> [S.H] It's to differentiate between the internal and external MDIO, I'm
> not quite sure about naming it, or what could be better way to
> differentiate the MDIOs?

I'm not questioning the need to convey this information.  I'm saying
it's not "A standard property".  I'd also like to see a better name.

> > 
> > > +		FMan v3 has internal MDIO for internal PCS(Physical Coding
> > > +		Sublayer) PHYs and external MDIO for external PHYs.
> > > +		The settings and programming routines for internal/external
> > > +		MDIO are different. Must include "internal" for internal MDIO,
> > > +		must include "external" for external MDIO.
> > 
> > I assume fman v2 is always internal?  How about a boolean "fsl,fman-
> > internal-phy" property instead?
> [S.H] Both Fman v2 & v3 have internal/external MDIO, Fman v2 uses internal MDIO for TBI operations to set the SGMII PHY, 
>
> The TBI implements transmit/receive portions of PCS, it's not used in
> Linux. The PCS on Fman V3 are not just for SGMII, it has more
> implementations, it's used in Linux.

The device tree is about the hardware, not what's used in Linux.

-Scott
