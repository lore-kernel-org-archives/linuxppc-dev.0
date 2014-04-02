Return-Path: <shawn.guo@linaro.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1A00114010F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 00:03:30 +1100 (EST)
Date: Wed, 2 Apr 2014 21:03:04 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Message-ID: <20140402130302.GC8558@dragon>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
 <d09da3eb629143abd3f61ae037af4ddaf7286a83.1396432924.git.Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <d09da3eb629143abd3f61ae037af4ddaf7286a83.1396432924.git.Guangyu.Chen@freescale.com>
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

On Wed, Apr 02, 2014 at 06:10:20PM +0800, Nicolin Chen wrote:
> Since we added fours clock to the DT binding, we should update the current
> SAI dts/dtsi so as not to break their functions.
> 
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index d31ce1b..9fd0007 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -139,8 +139,10 @@
>  				compatible = "fsl,vf610-sai";
>  				reg = <0x40031000 0x1000>;
>  				interrupts = <0 86 0x04>;
> -				clocks = <&clks VF610_CLK_SAI2>;
> -				clock-names = "sai";
> +				clocks = <&clks VF610_CLK_SAI2>,
> +				       <&clks VF610_CLK_SAI2>,
> +				       <&clks 0>, <&clks 0>;

So it seems that SAI on vf610 does work with only one clock.  So the
driver change will break old DTB for vf610?  If that's case, we will
have to need a new compatible for cases where 4 clocks are needed.

Shawn

> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
>  				status = "disabled";
>  			};
>  
> -- 
> 1.8.4
> 
> 
