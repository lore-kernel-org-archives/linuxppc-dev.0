Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0140.outbound.protection.outlook.com [65.55.169.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11BE51A01DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 10:21:55 +1100 (AEDT)
Message-ID: <1414538500.23458.125.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/3] powerpc/dts: Factorize the clock control node
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Tue, 28 Oct 2014 18:21:40 -0500
In-Reply-To: <1413988937-27885-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1413988937-27885-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: yuantian.tang@Freescale.com, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-22 at 09:42 -0500, Emil Medve wrote:
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> Change-Id: I25ce24a25862b4ca460164159867abefe00ccdd1

Please remove gerrit stuff prior to submitting.

> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
> new file mode 100644
> index 0000000..4871048
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
> @@ -0,0 +1,78 @@
> +/*
> + * QorIQ clock control device tree stub [ controller @ offset 0xe1000 ]
> + *
> + * Copyright 2014 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *	 notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *	 notice, this list of conditions and the following disclaimer in the
> + *	 documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *	 names of its contributors may be used to endorse or promote products
> + *	 derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +global-utilities@e1000 {
> +	compatible = "fsl,qoriq-clockgen-1.0";
> +	ranges = <0x0 0xe1000 0x1000>;
> +	reg = <0xe1000 0x1000>;
> +	clock-frequency = <0>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	sysclk: sysclk {
> +		#clock-cells = <0>;
> +		compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
> +		clock-output-names = "sysclk";
> +	};
> +	pll0: pll0@800 {
> +		#clock-cells = <1>;
> +		reg = <0x800 0x4>;
> +		compatible = "fsl,qoriq-core-pll-1.0";
> +		clocks = <&sysclk>;
> +		clock-output-names = "pll0", "pll0-div2";
> +	};
> +	pll1: pll1@820 {
> +		#clock-cells = <1>;
> +		reg = <0x820 0x4>;
> +		compatible = "fsl,qoriq-core-pll-1.0";
> +		clocks = <&sysclk>;
> +		clock-output-names = "pll1", "pll1-div2";
> +	};
> +	mux0: mux0@0 {
> +		#clock-cells = <0>;
> +		reg = <0x0 0x4>;
> +		compatible = "fsl,qoriq-core-mux-1.0";
> +		clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +		clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
> +		clock-output-names = "cmux0";
> +	};
> +	mux1: mux1@20 {
> +		#clock-cells = <0>;
> +		reg = <0x20 0x4>;
> +		compatible = "fsl,qoriq-core-mux-1.0";
> +		clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +		clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
> +		clock-output-names = "cmux1";
> +	};
> +};

I don't think the mux stuff belongs here, given that clockgen2.dtsi
doesn't have it, and I saw at least one clockgen1 user needing to
supplement this with more muxes.

> @@ -1068,7 +1043,6 @@
>  			clocks = <&sysclk>;
>  			clock-output-names = "pll2", "pll2-div2", "pll2-div4";
>  		};
> -
>  		pll3: pll3@860 {
>  			#clock-cells = <1>;
>  			reg = <0x860 0x4>;
> @@ -1076,7 +1050,6 @@
>  			clocks = <&sysclk>;
>  			clock-output-names = "pll3", "pll3-div2", "pll3-div4";
>  		};
> -
>  		pll4: pll4@880 {
>  			#clock-cells = <1>;
>  			reg = <0x880 0x4>;

Why?

-Scott
