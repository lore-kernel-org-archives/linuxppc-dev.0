Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 80F3D140338
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 09:26:23 +1000 (EST)
Message-ID: <1399332359.15726.154.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/6] powerpc/corenet: Create the dts components for the
 DPAA FMan
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Mon, 5 May 2014 18:25:59 -0500
In-Reply-To: <5364BEB3.6000904@Freescale.com>
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
 <1397823693-27977-4-git-send-email-Shruti@Freescale.com>
 <1398118262.1694.188.camel__8135.6513932862$1398128944$gmane$org@snotra.buserror.net>
 <5364BEB3.6000904@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Shruti Kanetkar <Shruti@Freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-05-03 at 05:02 -0500, Emil Medve wrote:
> Hello Scott,
> 
> 
> On 04/21/2014 05:11 PM, Scott Wood wrote:
> > On Fri, 2014-04-18 at 07:21 -0500, Shruti Kanetkar wrote:
> >> +fman@400000 {
> >> +	mdio@f1000 {
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +		compatible = "fsl,fman-xmdio";
> >> +		reg = <0xf1000 0x1000>;
> >> +	};
> >> +};
> > 
> > I'd like to see a complete fman binding before we start adding pieces.
> 
> The driver for the FMan 10 Gb/s MDIO has upstreamed a couple of years
> ago: '9f35a73 net/fsl: introduce Freescale 10G MDIO driver', granted
> without a binding writeup.

Pushing driver code through the netdev tree does not establish device
tree ABI.  Binding documents and dts files do.

> This patch series should probably include a
> binding blurb. However, let's not gate this patchset on a complete
> binding for the FMan

I at least want to see enough of the FMan binding to have confidence
that what we're adding now is correct.

> As you know we don't own the FMan work and the FMan work is... not ready
> for upstreaming.

I'm not asking for a driver, just a binding that describes hardware.  Is
there any reason why the fman node needs to be anywhere near as
complicated as it is in the SDK, if we're limiting it to actual hardware
description?  Do we really need to have nodes for all the sub-blocks?

> In an attempt to make some sort of progress we've
> decided to upstream the pieces that are less controversial and MDIO is
> an obvious candidate
> 
> >> +fman@400000 {
> >> +	mdio0: mdio@e1120 {
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +		compatible = "fsl,fman-mdio";
> >> +		reg = <0xe1120 0xee0>;
> >> +	};
> >> +};
> > 
> > What is the difference between "fsl,fman-mdio" and "fsl,fman-xmdio"?  I
> > don't see the latter on the list of compatibles in patch 3/6.
> 
> 'fsl,fman-mdio' is the 1 Gb/s MDIO (Clause 22 only). 'fsl,fman-xmdio' is
> the 10 Gb/s MDIO (Clause 45 only). We can respin this patch wi
> 

"respin this patch wi..."?

> I believe 'fsl,fman-mdio' (and others on that list) was added
> gratuitously as the FMan MDIO is completely compatible with the
> eTSEC/gianfar MDIO driver, but we can deal with that later

It's still good to identify the specific device, even if it's believed
to be 100% compatible.  Plus, IIRC there's been enough badness in the
eTSEC MDIO binding that it'd be good to steer clear of it.

> > Within each category, is the exact fman version discoverable from the
> > mdio registers?
> 
> No, but that's irrelevant as that's not the difference between the two
> compatibles

It's relevant because it means the compatible string should have a block
version number in it, or at least some other way in the MDIO node to
indicate the block version.

> >> +fman@500000 {
> >> +	#address-cells = <1>;
> >> +	#size-cells = <1>;
> >> +	compatible = "simple-bus";
> > 
> > Why is this simple-bus?
> 
> Because that's the translation type for the FMan sub-nodes.

What do you mean by "translation type"?

> We need it now to get the MDIO nodes probed

No.  "simple-bus" is stating an attribute of the hardware, that the
child nodes represent simple memory-mapped devices that can be used
without special bus knowledge.  I don't think that applies here.

You can get the MDIO node probed without misusing simple-bus by adding
the fman node's compatible to the probe list in the kernel code.

This sort of thing is why I want to see what the rest of the fman
binding will look like.

>  and we'll needed later to probe other nodes/devices that will have
> standalone drivers: MAC, MURAM. etc. 

How are they truly standalone?  The exist in service to the greater
entity that is fman.  They presumably work together in some fashion.

> >> +	/* mdio nodes for fman v3 @ 0x500000 */
> >> +	mdio@fc000 {
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +		reg = <0xfc000 0x1000>;
> >> +	};
> >> +
> >> +	mdio@fd000 {
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +		reg = <0xfd000 0x1000>;
> >> +	};
> >> +};
> > 
> > Where's the compatible?  Why is this file different from all the others?
> 
> The FMan v3 MDIO block (supports both Clause 22/45) is compatible with
> the FMan v2 10 Gb/s MDIO (the xgmac-mdio driver). However, the driver
> needs a small clean-up patch (still in internal review) that will get it
> working for FMan v3 MDIO.

This suggests that it is not 100% backwards compatible.

>  With that patch will add the compatible to these nodes. However, we
> need these nodes now for the board level MDIO bus muxing support
> (included in this patchset)

If you need these nodes now then add the compatible property now.

-Scott
