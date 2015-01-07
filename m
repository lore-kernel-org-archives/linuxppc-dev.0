Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0103.outbound.protection.outlook.com [207.46.100.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 633D31A07C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 11:28:54 +1100 (AEDT)
Message-ID: <1420590520.4961.38.camel@freescale.com>
Subject: Re: [PATCH] [v3] power/fsl: add MDIO dt binding for FMan
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
Date: Tue, 6 Jan 2015 18:28:40 -0600
In-Reply-To: <DM2PR0301MB08640979E5088618D1395CFAE2580@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1419321466-5575-1-git-send-email-shh.xie@gmail.com>
 <DM2PR0301MB08640979E5088618D1395CFAE2580@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Medve
 Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-05 at 05:21 -0600, Xie Shaohui-B21989 wrote:
> Hello Scott,
> 
> Is this v3 OK?
> 
> Best Regards, 
> Shaohui Xie
> > -----Original Message-----
> > From: shh.xie@gmail.com [mailto:shh.xie@gmail.com]
> > Sent: Tuesday, December 23, 2014 3:58 PM
> > To: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; Wood Scott-B07421
> > Cc: Medve Emilian-EMMEDVE1; Xie Shaohui-B21989
> > Subject: [PATCH] [v3] power/fsl: add MDIO dt binding for FMan
> > 
> > From: Shaohui Xie <Shaohui.Xie@freescale.com>
> > 
> > This binding is for FMan MDIO, it covers FMan v2 & FMan v3.
> > 
> > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > ---
> > changes in v3:
> > rephrase the 'Definition' of property 'bus-frequency', don't include the
> > property in example.
> > 
> > changes in v2:
> > addressed comments from Scott in V1.
> > 
> >  .../devicetree/bindings/powerpc/fsl/fman.txt       | 69 ++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > index edeea16..737aa4c 100644
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> > @@ -7,6 +7,7 @@ CONTENTS
> >    - FMan MURAM Node
> >    - FMan dTSEC/XGEC/mEMAC Node
> >    - FMan IEEE 1588 Node
> > +  - FMan MDIO Node
> >    - Example
> > 
> >  =============================================================================
> > @@ -357,6 +358,69 @@ ptp-timer@fe000 {
> >  };
> > 
> >  =============================================================================
> > +FMan MDIO Node
> > +
> > +DESCRIPTION
> > +
> > +The MDIO is a bus to which the PHY devices are connected.
> > +
> > +PROPERTIES
> > +
> > +- compatible
> > +		Usage: required
> > +		Value type: <stringlist>
> > +		Definition: A standard property.
> > +		Must include "fsl,fman-mdio" for 1 Gb/s MDIO from FMan v2.
> > +		Must include "fsl,fman-xmdio" for 10 Gb/s MDIO from FMan v2.
> > +		Must include "fsl,fman-memac-mdio" for 1/10 Gb/s MDIO from
> > +		FMan v3.
> > +
> > +- reg
> > +		Usage: required
> > +		Value type: <prop-encoded-array>
> > +		Definition: A standard property.
> > +
> > +- bus-frequency
> > +		Usage: optional
> > +		Value type: <u32>
> > +		Definition: Specifies the external MDIO bus clock speed to
> > +		be used, if different from the standard 2.5 MHz.
> > +		This may be due to the standard speed being unsupported (e.g.
> > +		due to a hardware problem), or to advertise that all relevant
> > +		components in the system support a faster speed.
> > +
> > +- interrupts
> > +		Usage: optional
> > +		Value type: <prop-encoded-array>
> > +		Definition: Event interrupt of external MDIO controller.
> > +		1 Gb/s MDIO and 10 Gb/s MDIO has one interrupt respectively.

I'm confused by "respectively" here.  Does fsl,fman-memac-mdio have two
interrupts (one for 1 Gb/s and one for 10 Gb/s)?  If there's only (at
most) one interrupt per MDIO controller then just delete this line.

What interrupt is used for internal MDIO?  Does "optional" mean it's
used if and only if external MDIO is used, or is it optional even with
external MDIO?  I see it's not present in the example -- do we not have
a real example that has the interrupt?

-Scott
