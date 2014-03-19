Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85F2B2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:33:50 +1100 (EST)
Date: Wed, 19 Mar 2014 17:33:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: Re: [1/2, v9] powerpc/mpc85xx:Add initial device tree support of T104x
Message-ID: <20140319223334.GA28875@home.buserror.net>
References: <1390650059-19437-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1390650059-19437-1-git-send-email-prabhakar@freescale.com>
Cc: Varun Sethi <Varun.Sethi@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 25, 2014 at 05:10:59PM +0530, Prabhakar Kushwaha wrote:
> +	corenet-cf@18000 {
> +		compatible = "fsl,corenet-cf";
> +		reg = <0x18000 0x1000>;
> +		interrupts = <16 2 1 31>;
> +		fsl,ccf-num-csdids = <32>;
> +		fsl,ccf-num-snoopids = <32>;
> +	};

I know this isn't a new problem, but this needs a binding -- and a
different compatible from p4080-era CCF.  AFAICT it's a completely
different programming model, and even the block version registers weren't
present in the original version.

> +/include/ "qoriq-mpic.dtsi"
> +
> +	guts: global-utilities@e0000 {
> +		compatible = "fsl,t1040-device-config", "fsl,qoriq-device-config-2.0";
> +		reg = <0xe0000 0xe00>;
> +		fsl,has-rstcr;
> +		fsl,liodn-bits = <12>;
> +	};
> +
> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,t1040-clockgen", "fsl,qoriq-clockgen-2.0",
> +				   "fixed-clock";
> +		ranges = <0x0 0xe1000 0x1000>;
> +		clock-frequency = <100000000>;

Why is clock-frequency hardcoded here rather than supplied by U-Boot? 
Especially since this is an SoC file, not a board file.

> +		reg = <0xe1000 0x1000>;
> +		clock-output-names = "sysclk";
> +		#address-cells = <1>;
> +		#size-cells = <1>;

clock-output-names and fixed-clock doesn't belong on this node.

> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-2.0";
> +			clock-output-names = "sysclk";
> +		};
> +
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&clockgen>;
> +			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&clockgen>;
> +			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
> +		};

clocks should point to sysclk.

> +	display@180000 {
> +		compatible = "fsl,t1040-diu", "fsl,diu";
> +		reg = <0x180000 1000>;
> +		interrupts = <74 2 0 0>;
> +	};
> +
> +/include/ "qoriq-sata2-0.dtsi"
> +sata@220000 {
> +			fsl,iommu-parent = <&pamu0>;
> +			fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
> +};
> +/include/ "qoriq-sata2-1.dtsi"
> +sata@221000 {
> +			fsl,iommu-parent = <&pamu0>;
> +			fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
> +};
> +/include/ "qoriq-sec5.0-0.dtsi"
> +};

Whitespace

-Scott
