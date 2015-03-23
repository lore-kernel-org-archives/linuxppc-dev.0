Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0119.outbound.protection.outlook.com [207.46.100.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A657A1A2AA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 10:31:05 +1100 (AEDT)
Message-ID: <1427153449.22867.19.camel@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: Add FMan clock nodes
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Mon, 23 Mar 2015 18:30:49 -0500
In-Reply-To: <1424964417-13760-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1424964417-13760-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, afleming@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Igal Liberman <Igal.Liberman@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-26 at 09:26 -0600, Emil Medve wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 11 +++++++++++
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |  8 ++++++++
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  8 ++++++++
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 16 ++++++++++++++++
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 13 +++++++++++++
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 26 ++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  8 ++++++++
>  arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 11 +++++++++++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 20 ++++++++++++++++++++
>  9 files changed, 121 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> index f8c325e..38621ef 100644
> --- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> @@ -395,6 +395,17 @@
>  		reg = <0xe0000 0xe00>;
>  		fsl,has-rstcr;
>  		fsl,liodn-bits = <12>;
> +
> +		fm0clk: fm0-clk-mux {
> +			#clock-cells = <0>;
> +			compatible = "fsl,fman-clk-mux";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>, <&pll0 3>,
> +				 <&platform_pll 0>, <&pll1 1>, <&pll1 2>;
> +			clock-names = "pll0", "pll0-div2", "pll0-div3",
> +				      "pll0-div4", "platform-pll", "pll1-div2",
> +				      "pll1-div3";
> +			clock-output-names = "fm0-clk";
> +		};

Where's the binding for fsl,fman-clk-mux?

-Scott
