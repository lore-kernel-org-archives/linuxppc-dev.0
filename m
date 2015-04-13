Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0134.outbound.protection.outlook.com [157.56.110.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B16631A074A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 06:21:11 +1000 (AEST)
Message-ID: <1428956457.22867.629.camel@freescale.com>
Subject: Re: [v2] dt/bindings: qoriq-clock: Add binding for FMan clock mux
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
Date: Mon, 13 Apr 2015 15:20:57 -0500
In-Reply-To: <DM2PR03MB3835E1F5A269C969994FDA0E6F80@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1428479031-26597-1-git-send-email-igal.liberman@freescale.com>
 <1428527516.22867.509.camel@freescale.com>
 <DM2PR03MB383D9FD2888970950261FB2E6FB0@DM2PR03MB383.namprd03.prod.outlook.com>
 <1428598976.22867.535.camel@freescale.com>
 <DM2PR03MB3835E1F5A269C969994FDA0E6F80@DM2PR03MB383.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 2015-04-12 at 10:54 -0500, Liberman Igal-B31950 wrote:
> 
> 
> Regards,
> Igal Liberman.
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, April 09, 2015 8:03 PM
> > To: Liberman Igal-B31950
> > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [v2] dt/bindings: qoriq-clock: Add binding for FMan clock mux
> > 
> > On Thu, 2015-04-09 at 02:18 -0500, Liberman Igal-B31950 wrote:
> > >
> > >
> > > Regards,
> > > Igal Liberman.
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Thursday, April 09, 2015 12:12 AM
> > > > To: Liberman Igal-B31950
> > > > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > > > Subject: Re: [v2] dt/bindings: qoriq-clock: Add binding for FMan
> > > > clock mux
> > > >
> > > > On Wed, 2015-04-08 at 10:43 +0300, Igal.Liberman wrote:
> > > > > @@ -76,6 +77,52 @@ Required properties:
> > > > >
> > > > >  Recommended properties:
> > > > >  - clocks: Should be the phandle of input parent clock
> > > > > +	For "fsl,fman-clk-mux" clock there are several options for parent
> > > > > +	clock (clock provider), the parent is determined according to the
> > > > > +	Reset Configuration Word of the specific device:
> > > > > +		* P2041, P3041:
> > > > > +			* 0 - equal to platform PLL divided by 2
> > > > > +			* 1 - equal to PLL2 divided by 2
> > > > > +		* P4080 (Both FMans):
> > > > > +			* 0 - equal to platform PLL divided by 2
> > > > > +			* 1 - equal to PLL3 divided by 2
> > > > ...
> > > >
> > > >
> > > > Again, the clock specifier format is determined by the clock
> > > > provider, not the clock consumer.
> > > >
> > >
> > > Scott,
> > > The "clocks" property contains all possible clock providers, right?
> > > In the text above I'm trying to explain how the FMan clock provider is
> > determined and what are the options for each SoC.
> > > Do you think that we shouldn't have this explanation? Can you please
> > elaborate?
> > 
> > I'm saying that the clock specifiers must be the same regardless of the node
> > that is consuming the clock.  You can't define certain values as only being "for
> > fsl,fman-clk-mux".
> > 
> 
> Just to make things clear,
> In "fm0clk/fm1clk" node, "clocks" holds a list of clock specifiers.
> This list reflects all optional clock providers for a specific hardware, this list varies between different SoCs.
> All those possible providers described by other nodes, as clock providers.
> Please notice that this bindings describes the possible source clock for FMan mux, not the providers themselves.
> 
> You mentioned the following: "You can't define certain values as only being "for fsl,fman-clk-mux"."
> I'm defining those values in the clock provider nodes and using those values as clock providers for FMan mux, it can be used be other HW blocks too.

My point is that the encoding of the clock specifier is not
fman-specific and thus fman should not appear in the description.

-Scott
