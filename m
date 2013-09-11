Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 65F702C0178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 09:24:25 +1000 (EST)
Message-ID: <1378941854.12204.439.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/mpc85xx:Add initial device tree support of T104x
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Wed, 11 Sep 2013 18:24:14 -0500
In-Reply-To: <1378882686-19454-1-git-send-email-prabhakar@freescale.com>
References: <1378882686-19454-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

On Wed, 2013-09-11 at 12:28 +0530, Prabhakar Kushwaha wrote:
> The QorIQ T1040/T1042 processor support four integrated 64-bit e5500 PA
> processor cores with high-performance data path acceleration architecture
> and network peripheral interfaces required for networking & telecommunications.
> 
> T1042 personality is a reduced personality of T1040 without Integrated 8-port
> Gigabit Ethernet switch.
> 
> The T1040/T1042 SoC includes the following function and features:
> 
>  - Four e5500 cores, each with a private 256 KB L2 cache
>  - 256 KB shared L3 CoreNet platform cache (CPC)
>  - Interconnect CoreNet platform
>  - 32-/64-bit DDR3L/DDR4 SDRAM memory controller with ECC and interleaving
>    support
>  - Data Path Acceleration Architecture (DPAA) incorporating acceleration
>  for the following functions:
>     -  Packet parsing, classification, and distribution
>     -  Queue management for scheduling, packet sequencing, and congestion
>     	management
>     -  Cryptography Acceleration (SEC 5.0)
>     - RegEx Pattern Matching Acceleration (PME 2.2)
>     - IEEE Std 1588 support
>     - Hardware buffer management for buffer allocation and deallocation
>  - Ethernet interfaces
>     - Integrated 8-port Gigabit Ethernet switch (T1040 only)
>     - Four 1 Gbps Ethernet controllers
>  - Two RGMII interfaces or one RGMII and one MII interfaces
>  - High speed peripheral interfaces
>    - Four PCI Express 2.0 controllers running at up to 5 GHz
>    - Two SATA controllers supporting 1.5 and 3.0 Gb/s operation
>    - Upto two QSGMII interface
>    - Upto six SGMII interface supporting 1000 Mbps
>    - One SGMII interface supporting upto 2500 Mbps
>  - Additional peripheral interfaces
>    - Two USB 2.0 controllers with integrated PHY
>    - SD/eSDHC/eMMC
>    -  eSPI controller
>    - Four I2C controllers
>    - Four UARTs
>    - Four GPIO controllers
>    - Integrated flash controller (IFC)
>    - Change this to  LCD/ HDMI interface (DIU) with 12 bit dual data rate
>    - TDM interface
>  - Multicore programmable interrupt controller (PIC)
>  - Two 8-channel DMA engines
>  - Single source clocking implementation
>  - Deep Sleep power implementaion (wakeup from GPIO/Timer/Ethernet/USB)
> 
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git

Everything in there has already been pulled by Linus, so there's no
reason to use that tree as a base right now.

> +/include/ "t1042si-post.dtsi"
[snip]
> +	serdes: serdes@ea000 {
> +		compatible = "fsl,t1040-serdes";
> +		reg	   = <0xea000 0x4000>;
> +	};
> +
> +	sdhc@114000 {
> +		compatible = "fsl,t1040-esdhc", "fsl,esdhc";
> +		sdhci,auto-cmd12;
> +	};

Why does sdhci,auto-cmd12 need to be specified here?  It's already in
t1042si-post.dtsi which you've included.  Likewise with reg on the
serdes node.

I also question the need to define separate t1040 compatible values for
all of these, if the only difference is whether the onboard switch is
enabled or not.

> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,t1042-clockgen", "fsl,qoriq-clockgen-2.0",
> +				   "fixed-clock";
> +		reg = <0xe1000 0x1000>;
> +		clock-output-names = "sysclk";
> +		#clock-cells = <0>;
> +
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
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0>;
> +			compatible = "fsl,core-mux-clock";

Please update the clock stuff based on
http://patchwork.ozlabs.org/patch/274134/

> +/include/ "qoriq-dma-0.dtsi"
> +	dma@100300 {
> +		fsl,iommu-parent = <&pamu0>;
> +		fsl,liodn-reg = <&guts 0x580>; /* DMA1LIODNR */
> +	};
> +
> +/include/ "qoriq-dma-1.dtsi"
> +	dma@101300 {
> +		fsl,iommu-parent = <&pamu0>;
> +		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
> +	};

These are elo3:
http://patchwork.ozlabs.org/patch/271238/

> +	display@180000 {
> +                compatible = "fsl,diu", "fsl,t1042-diu";
> +                reg = <0x180000 1000>;
> +                interrupts = <74 2 0 0>;
> +        };

More specific compatibles come first.

-Scott
