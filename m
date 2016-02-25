Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9682D1A035A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 16:56:50 +1100 (AEDT)
Message-ID: <1456379804.5360.43.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Qiang Zhao <qiang.zhao@nxp.com>, Rob Herring <robh@kernel.org>
Cc: Yang-Leo Li <leoyang.li@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 24 Feb 2016 23:56:44 -0600
In-Reply-To: <AM3PR04MB118518B07AE928823BE73B8491A60@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
 <20160223201520.GA3354@rob-hp-laptop>
 <1456258812.5360.22.camel@buserror.net>
 <AM3PR04MB1185D9D56F72F7AD64AC92E291A60@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <1456369908.5360.28.camel@buserror.net>
 <AM3PR04MB118518B07AE928823BE73B8491A60@AM3PR04MB1185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/7] QE: Add IC, SI and SIRAM document to device tree
 bindings.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-25 at 05:55 +0000, Qiang Zhao wrote:
> On Thu, 2016-02-25 at 11:12  AM, Scott Wood wrote:
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Thursday, February 25, 2016 11:12 AM
> > To: Qiang Zhao <qiang.zhao@nxp.com>; Rob Herring <robh@kernel.org>
> > Cc: Yang-Leo Li <leoyang.li@nxp.com>; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH v2 1/7] QE: Add IC, SI and SIRAM document to device
> > tree
> > bindings.
> > 
> > On Thu, 2016-02-25 at 03:10 +0000, Qiang Zhao wrote:
> > > On Wed, 2016-02-24 at 04:20  AM, Scott Wood wrote:
> > > > -----Original Message-----
> > > > From: Scott Wood [mailto:oss@buserror.net]
> > > > Sent: Wednesday, February 24, 2016 4:20 AM
> > > > To: Rob Herring <robh@kernel.org>; Qiang Zhao <qiang.zhao@nxp.com>
> > > > Cc: Yang-Leo Li <leoyang.li@nxp.com>; linux-kernel@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > > > Subject: Re: [PATCH v2 1/7] QE: Add IC, SI and SIRAM document to
> > > > device tree bindings.
> > > > 
> > > > On Tue, 2016-02-23 at 14:15 -0600, Rob Herring wrote:
> > > > > On Thu, Feb 18, 2016 at 09:06:06AM +0800, Zhao Qiang wrote:
> > > > > > Add IC, SI and SIRAM document of QE to
> > > > > > Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> > > > > > 
> > > > > > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > > > > > ---
> > > > > > Changes for v2
> > > > > > 	- Add interrupt-controller in Required properties
> > > > > > 	- delete address-cells and size-cells for qe-si and qe-siram
> > > > > > 
> > > > > >  .../devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt  | 50
> > > > > > ++++++++++++++++++++++
> > > > > >  1 file changed, 50 insertions(+)
> > > > > > 
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> > > > > > b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> > > > > > index 4f89302..84052a7 100644
> > > > > > ---
> > > > > > a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> > > > > > +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.tx
> > > > > > +++ t
> > > > > > @@ -69,6 +69,56 @@ Example:
> > > > > >  	};
> > > > > >       };
> > > > > > 
> > > > > > +* Interrupt Controller (IC)
> > > > > > +
> > > > > > +Required properties:
> > > > > > +- compatible : should be "fsl,qe-ic".
> > > > > 
> > > > > > +- compatible : should be "fsl,qe-si".
> > > > > 
> > > > > > +- compatible : should be "fsl,qe-siram".
> > > > > 
> > > > > These compatible strings are all a bit generic and should have SoC
> > > > > specific compatible strings.
> > > > 
> > > > I don't know about si/siram, but "fsl,qe-ic" has been around since
> > > > 2008, so it should be documented even if a more specific compatible
> > > > is also added.
> > > 
> > > Agree, and si/siram are also has been around since 2008.
> > 
> > Where?  I couldn't find them when grepping.
> 
> Sorry, I make a mistake, they have not been in upstream.
> 
> > 
> > > In addition, I don’t think it is needed to add specific compatible,
> > > because they are the same in qe-supported soc.
> > 
> > How do we know that they are 100% the same?
> 
> You mean it will be changed in later version?

That's always a possibility, but even on current chips, what bit of
documentation are you referring to that confirms it's the exact same logic?

-Scott
