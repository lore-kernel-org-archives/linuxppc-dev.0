Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0105.outbound.protection.outlook.com [157.56.110.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3CB71A0D05
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 09:43:14 +1000 (AEST)
Message-ID: <1430523775.16357.177.camel@freescale.com>
Subject: Re: [v3] dt/bindings: qoriq-clock: Add binding for FMan clock mux
From: Scott Wood <scottwood@freescale.com>
To: Liberman Igal-B31950 <Igal.Liberman@freescale.com>
Date: Fri, 1 May 2015 18:42:55 -0500
In-Reply-To: <DM2PR03MB3839C9D3FDFD7978C1A3497E6D60@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1429008968-24707-1-git-send-email-igal.liberman@freescale.com>
 <1429119357.22867.724.camel@freescale.com>
 <DM2PR03MB38330DBBFFD1BC45D58F447E6E40@DM2PR03MB383.namprd03.prod.outlook.com>
 <1429249281.32545.52.camel@freescale.com>
 <DM2PR03MB383E5F67C358CCE2E38EA71E6E00@DM2PR03MB383.namprd03.prod.outlook.com>
 <1429577504.4352.67.camel@freescale.com>
 <DM2PR03MB383C35FA5959662DD48D00BE6EE0@DM2PR03MB383.namprd03.prod.outlook.com>
 <1430353832.16357.138.camel@freescale.com>
 <DM2PR03MB3839C9D3FDFD7978C1A3497E6D60@DM2PR03MB383.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Tang
 Yuantian-B29983 <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-30 at 09:28 -0500, Liberman Igal-B31950 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, April 30, 2015 3:31 AM
> > To: Liberman Igal-B31950
> > Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Tang
> > Yuantian-B29983
> > Subject: Re: [v3] dt/bindings: qoriq-clock: Add binding for FMan clock mux
> > 
> > On Wed, 2015-04-22 at 05:47 -0500, Liberman Igal-B31950 wrote:
> > > We have 2 cases:
> > > 	- Devices (T2/T4/B4) with CLKCG1HWACSR register.
> > > 	- Devices (Pxxxx, T1) without CLKCG1HWACSR register (Pxxxx
> > devices
> > > have many options, T1 has only one option)
> > >
> > > For the first group, we can have " qoriq-hwacsr" property in the clock node.
> > 
> > No, we're not going to describe every register with its own property.
> > Describe the chip and let the driver be the place with the knowledge of what
> > each chip is like.
> > 
> 
> I think that FMan clock mux (as we defined it) is similar to other muxes available in our SoC.

I realize that.  I'm saying the way we described existing muxes seems to
be a mistake.  We're putting too much complexity in the device tree.
Better to put the complexity in a place that isn't stable ABI.

> If we take T4 as example, it has 3 muxes defined in the device tree (mux0, mux1 and mux2).
> Each mux has its own reg property (and clock providers).
> 	mux2: mux2@40 {
> 		#clock-cells = <0>;
> 		reg = <0x40 0x4>;
> 		compatible = "fsl,qoriq-core-mux-2.0";
> 		clocks = <&pll3 0>, <&pll3 1>, <&pll3 2>,
> 			<&pll4 0>, <&pll4 1>, <&pll4 2>;
> 		clock-names = "pll3", "pll3-div2", "pll3-div4",
> 			"pll4", "pll4-div2", "pll4-div4";
> 		clock-output-names = "cmux2";
> 	};
> 
> I agree that "fm1-clk-mux" need to be moved from the "guts" node to "clockgen" node.

That's not what I was saying.  I'm saying get rid of the node entirely,
in favor of having the clockgen node itself be a clock source with
multiple post-mux outputs.

> However, I'm not sure which changes you want to perform in the node (beside adding reg property for SoC which has it for FMan clock).

Again, the clockgen node already has a reg property.

-Scott
