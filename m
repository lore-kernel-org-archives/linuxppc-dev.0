Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 258CE140115
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 18:57:29 +1000 (EST)
Date: Wed, 9 Apr 2014 16:39:26 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Message-ID: <20140409083925.GB12559@MrMyself>
References: <cover.1396605772.git.Guangyu.Chen@freescale.com>
 <08ba57a2fdce1a404a6bcb61e21e25509fcd6b30.1396605772.git.Guangyu.Chen@freescale.com>
 <20140409081137.GD28420@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140409081137.GD28420@dragon>
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

On Wed, Apr 09, 2014 at 04:11:38PM +0800, Shawn Guo wrote:
> On Fri, Apr 04, 2014 at 06:08:13PM +0800, Nicolin Chen wrote:
> > Since we added fours clock to the DT binding, we should update the current
> > SAI dts/dtsi so as not to break their functions.
> 
> For the record, you're asking my ACK to have the dts change go via sound
> tree for not breaking vf610 function on the sound branch,  while
> ignoring the fact that the existing DTB will break with the new kernel
> anyway.
> 
> I'm not completely happy with the approach, but considering that the
> existing binding is incorrect, I'm fine with it as long as people agree
> to go this way.

Although I'm not a big fan of explaining, yet, I still want to say that
actually I've balanced this way and your last suggestion against the v1.

It'd be surely better to distinguish two platforms as you suggested if
we are looking at this change alone since the change is nearly tiny and
the code to specify them wouldn't be quite a lot. However, there's more
work to do based on this patch, an auto-selecting clock source mechanism
for SAI as a DAI master for example, which would need to drop the existing
code and to add the new one. If vf610 is still using the old one, it would
not benefit from the further feature and the code would be definitely ugly
as we would have to add too many platform checks. So personally I prefer
this reasonable change than the little sacrifice we're going to make here.

Right now I feel grateful for what Sascha suggested to the DT bindings of
fsl-spdif. It was a painstaking experience when getting it upstream last
year but what's done at that moment makes the driver more flexible. So I
think we should do the strict and comprehensive review for the clock part
to every module from now on since an once-defined-DT-binding would be so
painful to improved for us.

Thank you,
Nicolin

> 
> Shawn
> 
> > 
> > Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> > Tested-by: Xiubo Li <Li.Xiubo@freescale.com>
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
> > +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> >  				status = "disabled";
> >  			};
> >  
> > -- 
> > 1.8.4
> > 
> > 
> 
