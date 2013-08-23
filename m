Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8CB5F2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 06:08:39 +1000 (EST)
Date: Fri, 23 Aug 2013 15:08:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: tang yuantian <Yuantian.Tang@freescale.com>
Subject: Re: [v3] powerpc/mpc85xx: Update the clock device tree nodes
Message-ID: <20130823200827.GA29737@home.buserror.net>
References: <1370480811-13700-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1370480811-13700-1-git-send-email-Yuantian.Tang@freescale.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 06, 2013 at 09:06:51AM +0800, tang yuantian wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> The following SoCs will be affected: p2041, p3041, p4080,
> p5020, p5040, b4420, b4860, t4240
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> 
> ---
> v3:
> 	- fix typo
> v2:
> 	- add t4240, b4420, b4860 support
> 	- remove pll/4 clock from p2041, p3041 and p5020 board
> 
>  arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |  32 ++++++++-
>  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   2 +
>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  32 ++++++++-
>  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   4 ++
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |  54 ++++++++++++++-
>  arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi  |   4 ++
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  54 ++++++++++++++-
>  arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi  |   4 ++
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 100 +++++++++++++++++++++++++++-
>  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi  |   8 +++
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |  38 ++++++++++-
>  arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi  |   2 +
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |  54 ++++++++++++++-
>  arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi  |   4 ++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  77 ++++++++++++++++++++-
>  arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  |  12 ++++
>  16 files changed, 473 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> index 5a6615d..b69d6e5 100644
> --- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> @@ -85,7 +85,37 @@
>  	};
>  
>  	clockgen: global-utilities@e1000 {
> -		compatible = "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0";
> +		compatible = "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0",
> +				   "fixed-clock";
> +		clock-output-names = "sysclk";
> +		#clock-cells = <0>;

Does U-Boot fill in clock-frequency here?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800>;
> +			compatible = "fsl,core-pll-clock";
> +			clocks = <&clockgen>;
> +			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> +		};
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820>;
> +			compatible = "fsl,core-pll-clock";
> +			clocks = <&clockgen>;
> +			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
> +		};

Please leave a blank line between properties and nodes, and between
nodes.

What does reg represent?  Where is the binding for this?

The compatible is too vague.

> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0>;
> +			compatible = "fsl,core-mux-clock";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
> +				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
> +			clock-names = "pll0_0", "pll0_1", "pll0_2",
> +				"pll1_0", "pll1_1", "pll1_2";
> +			clock-output-names = "cmux0";
> +		};

What does reg represent?  Where is the binding for this?

The compatible is too vague.

-Scott
