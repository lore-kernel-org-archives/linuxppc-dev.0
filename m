Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0139.outbound.protection.outlook.com [207.46.100.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C0AE1A004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 11:07:08 +1000 (AEST)
Date: Thu, 28 May 2015 20:06:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: Madalin Bucur <madalin.bucur@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <Igal.Liberman@freescale.com>,
 <roy.pledge@freescale.com>
Subject: Re: [2/4] powerpc/fsl-booke: Add T1023RDB FMan device tree
Message-ID: <20150529010656.GA9447@home.buserror.net>
References: <1432125700-7024-3-git-send-email-madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1432125700-7024-3-git-send-email-madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 20, 2015 at 03:41:38PM +0300, Madalin Bucur wrote:
> diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
> index 48c1690..a6eb7ae 100644
> --- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
> @@ -344,6 +344,14 @@
>  		reg = <0xe0000 0xe00>;
>  		fsl,has-rstcr;
>  		fsl,liodn-bits = <12>;
> +
> +		fm0clk: fm0-clk-mux {
> +			#clock-cells = <0>;
> +			compatible = "fsl,fman-clk-mux";
> +			clocks = <&pll0 1>;
> +			clock-names = "pll0-div2";
> +			clock-output-names = "fm0-clk";
> +		};
>  	};

NACK as previously discussed.

> diff --git a/arch/powerpc/boot/dts/t1023rdb.dts b/arch/powerpc/boot/dts/t1023rdb.dts
> index 571e070..146d30d 100644
> --- a/arch/powerpc/boot/dts/t1023rdb.dts
> +++ b/arch/powerpc/boot/dts/t1023rdb.dts
> @@ -128,6 +128,46 @@
>  		i2c@118100 {
>  		};
>  
> +		fman@400000 {
> +			fm1mac1: ethernet@e0000 {
> +				phy-handle = <&sgmii_rtk_phy2>;
> +				phy-connection-type = "sgmii";
> +				sleep = <&rcpm 0x80000000>;
> +			};

Get rid of this sleep stuff.  It's an unfinished thing that nothing uses
but people have copied all over the place.  The binding for it only
covers pmc nodes compatible with mpc8349, mpc8536, and mpc8548.  The
right way to handle this is with a "clocks" property.

-Scott
