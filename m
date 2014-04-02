Return-Path: <guangyu.chen@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 699A8140102
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 00:52:08 +1100 (EST)
Date: Wed, 2 Apr 2014 21:39:56 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Message-ID: <20140402133955.GB29440@MrMyself>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
 <d09da3eb629143abd3f61ae037af4ddaf7286a83.1396432924.git.Guangyu.Chen@freescale.com>
 <20140402130302.GC8558@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140402130302.GC8558@dragon>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 broonie@kernel.org, ijc+devicetree@hellion.org.uk,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org,
 Li.Xiubo@freescale.com, rob@landley.net, galak@codeaurora.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shawn,

   Thanks for the comments, but...

On Wed, Apr 02, 2014 at 09:03:04PM +0800, Shawn Guo wrote:
> On Wed, Apr 02, 2014 at 06:10:20PM +0800, Nicolin Chen wrote:
> > Since we added fours clock to the DT binding, we should update the current
> > SAI dts/dtsi so as not to break their functions.
> > 
> > Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> > ---
> >  arch/arm/boot/dts/vf610.dtsi | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> > index d31ce1b..9fd0007 100644
> > --- a/arch/arm/boot/dts/vf610.dtsi
> > +++ b/arch/arm/boot/dts/vf610.dtsi
> > @@ -139,8 +139,10 @@
> >  				compatible = "fsl,vf610-sai";
> >  				reg = <0x40031000 0x1000>;
> >  				interrupts = <0 86 0x04>;
> > -				clocks = <&clks VF610_CLK_SAI2>;
> > -				clock-names = "sai";
> > +				clocks = <&clks VF610_CLK_SAI2>,
> > +				       <&clks VF610_CLK_SAI2>,
> > +				       <&clks 0>, <&clks 0>;
> 
> So it seems that SAI on vf610 does work with only one clock.  So the
> driver change will break old DTB for vf610?  If that's case, we will
> have to need a new compatible for cases where 4 clocks are needed.

According to Vybrid's RM Chapter 9.11.12 SAI clocking, the SoC actually
connects SAI with two clocks: SAI_CLK and Platform Bus Clock. So the DT
binding here still needs to be corrected even if ignoring driver change.

Besides, I've checked both SAI on imx and vf610 and found that they are
seemly identical, especially for the clock part -- "The transmitter and
receiver can independently select between the bus clock and up to three
audio master clocks to generate the bit clock." And the driver that was
designed for vf610 already contains the code to switch the clock between
Bus Clock and Three MCLKs. What I want to say is, even if SAI on vf610
does work with only one clock, it still doesn't have the full function
on vf610 -- driving clock from Platform Bus Clock unless we make this
improvement to the DT binding.

So I think it's fair to complete the code here for both platforms, even
though we might take the risk of merging conflict. And I understand
your point to avoid function break on those platform both of us aren't
convenient to test. But I've already involved Xiubo in the list. And
we can wait for his test result.

Hope you can understand the circumstance,
Nicolin
