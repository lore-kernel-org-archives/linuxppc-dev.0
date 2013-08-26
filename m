Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A466F2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 03:00:27 +1000 (EST)
Message-ID: <1377536416.3033.18.camel@snotra.buserror.net>
Subject: Re: [v3] powerpc/mpc85xx: Update the clock device tree nodes
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Mon, 26 Aug 2013 12:00:16 -0500
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B1503BE58@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1370480811-13700-1-git-send-email-Yuantian.Tang@freescale.com>
 <20130823200827.GA29737@home.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B1503BE58@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Mike Turquette <mturquette@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-08-25 at 21:42 -0500, Tang Yuantian-B29983 wrote:
> > >
> > >  	clockgen: global-utilities@e1000 {
> > > -		compatible = "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0";
> > > +		compatible = "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0",
> > > +				   "fixed-clock";
> > > +		clock-output-names = "sysclk";
> > > +		#clock-cells = <0>;
> > 
> > Does U-Boot fill in clock-frequency here?
> > 
> Yes, clock-frequency will be filled by uboot.
> You suggested we'd better not add it here.

Right -- I was just making sure.

> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +		pll0: pll0@800 {
> > > +			#clock-cells = <1>;
> > > +			reg = <0x800>;
> > > +			compatible = "fsl,core-pll-clock";
> > > +			clocks = <&clockgen>;
> > > +			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> > > +		};
> > > +		pll1: pll1@820 {
> > > +			#clock-cells = <1>;
> > > +			reg = <0x820>;
> > > +			compatible = "fsl,core-pll-clock";
> > > +			clocks = <&clockgen>;
> > > +			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
> > > +		};
> > 
> > Please leave a blank line between properties and nodes, and between nodes.
> > 
> OK, will add.
> 
> > What does reg represent?  Where is the binding for this?
> > 
> > The compatible is too vague.
> Reg is register offset.

With no size?

> I should have had a binding document.
> About the compatible, you should pointed it out earlier in SDK review.

Sorry, it doesn't work that way.  I don't know why I didn't notice this
stuff there -- the SDK review was probably rushed, with someone shouting
"urgent".  The SDK does not dictate what goes upstream.  Device tree
bindings should go upstream first.

> It is too later to change since the clock driver is merged for months although 
> I sent this patch first.

It should not have gone in without an approved binding.  It seems it
went in via Mike Turquette (why is a non-ARM-specific tree using
linux-arm-kernel as its list, BTW?).  No ack from Ben, Kumar, or me is
shown in the commit.

In any case, you can preserve compatibility with existing trees without
using this compatible in new trees.  The driver can check for both
compatibles, with a comment indicating that "fsl,core-mux-clock" is
deprecated and for compatibility only.

> Besides, it is not too bad because other arch use the similar name.

I don't follow.  This is a specific Freescale register interface, not a
general concept.

In any case, which "similar names" are you referring to?  A search in
arch/arm/boot/dts for "mux" with "clk" or "clock" turns up
"allwinner,sun4i-apb1-mux-clk" which is much more specific than
"fsl,core-mux-clock".

-Scott
