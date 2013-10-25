Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B91242C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 09:51:08 +1100 (EST)
Received: by mail-wg0-f41.google.com with SMTP id b13so1467273wgh.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 15:51:05 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
To: Yuantian.Tang@freescale.com, galak@kernel.crashing.org
In-Reply-To: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Fri, 25 Oct 2013 21:11:08 +0100
Message-Id: <20131025201108.B06B8C405AE@trevor.secretlab.ca>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Oct 2013 14:38:24 +0800, <Yuantian.Tang@freescale.com> wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> The following SoCs will be affected: p2041, p3041, p4080,
> p5020, p5040, b4420, b4860, t4240
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> v5:
> 	- refine the binding document
> 	- update the compatible string
> v4:
> 	- add binding document
> 	- update compatible string
> 	- update the reg property
> v3:
> 	- fix typo
> v2:
> 	- add t4240, b4420, b4860 support
> 	- remove pll/4 clock from p2041, p3041 and p5020 board
> 
>  .../devicetree/bindings/clock/corenet-clock.txt    | 111 ++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |  35 +++++++
>  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   2 +
>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |  35 +++++++
>  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  60 +++++++++++
>  arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  60 +++++++++++
>  arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        | 112 +++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   8 ++
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |  42 ++++++++
>  arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   2 +
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  60 +++++++++++
>  arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  85 ++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  12 +++
>  17 files changed, 640 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/corenet-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/corenet-clock.txt b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> new file mode 100644
> index 0000000..8efc62d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> @@ -0,0 +1,111 @@
> +* Clock Block on Freescale CoreNet Platforms
> +
> +Freescale CoreNet chips take primary clocking input from the external
> +SYSCLK signal. The SYSCLK input (frequency) is multiplied using
> +multiple phase locked loops (PLL) to create a variety of frequencies
> +which can then be passed to a variety of internal logic, including
> +cores and peripheral IP blocks.
> +Please refer to the Reference Manual for details.
> +
> +1. Clock Block Binding
> +
> +Required properties:
> +- compatible: Should include one or more of the following:
> +	- "fsl,<chip>-clockgen": for chip specific clock block
> +	- "fsl,qoriq-clockgen-[1,2].x": for chassis 1.x and 2.x clock
> +- reg: Offset and length of the clock register set
> +- clock-frequency: Indicates input clock frequency of clock block.
> +	Will be set by u-boot
> +
> +Recommended properties:
> +- #ddress-cells: Specifies the number of cells used to represent

typo

> +	physical base addresses.  Must be present if the device has
> +	sub-nodes and set to 1 if present
> +- #size-cells: Specifies the number of cells used to represent
> +	the size of an address. Must be present if the device has
> +	sub-nodes and set to 1 if present
> +
> +2. Clock Provider/Consumer Binding
> +
> +Most of the binding are from the common clock binding[1].
> + [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : Should include one or more of the following:
> +	- "fsl,qoriq-core-pll-[1,2].x": Indicates a core PLL clock device
> +	- "fsl,qoriq-core-mux-[1,2].x": Indicates a core multiplexer clock
> +		device; divided from the core PLL clock
> +	- "fixed-clock": From common clock binding; indicates output clock
> +		of oscillator
> +	- "fsl,qoriq-sysclk-[1,2].x": Indicates input system clock
> +- #clock-cells: From common clock binding; indicates the number of
> +	output clock. 0 is for one output clock; 1 for more than one clock
> +
> +Recommended properties:
> +- clocks: Should be the phandle of input parent clock
> +- clock-names: From common clock binding, indicates the clock name
> +- clock-output-names: From common clock binding, indicates the names of
> +	output clocks
> +- reg: Should be the offset and length of clock block base address.
> +	The length should be 4.

Binding looks reasonable to me.

g.

> +
> +Example for clock block and clock provider:
> +/ {
> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> +		reg = <0xe1000 0x1000>;
> +		clock-frequency = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll1", "pll1-div2";
> +		};
> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux0";
> +		};
> +
> +		mux1: mux1@20 {
> +			#clock-cells = <0>;
> +			reg = <0x20 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux1";
> +		};
> +	};
> +  }
> +
> +Example for clock consumer:
> +
> +/ {
> +	cpu0: PowerPC,e5500@0 {
> +		...
> +		clocks = <&mux0>;
> +		...
> +	};
> +  }
> diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> index 5a6615d..e910e82 100644
> --- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> @@ -86,6 +86,41 @@
>  
>  	clockgen: global-utilities@e1000 {
>  		compatible = "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-2.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 0x4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
> +		};
> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-2.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
> +				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
> +			clock-names = "pll0_0", "pll0_1", "pll0_2",
> +				"pll1_0", "pll1_1", "pll1_2";
> +			clock-output-names = "cmux0";
> +		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> index 7b4426e..a11126b 100644
> --- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> @@ -62,11 +62,13 @@
>  		cpu0: PowerPC,e6500@0 {
>  			device_type = "cpu";
>  			reg = <0 1>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2>;
>  		};
>  		cpu1: PowerPC,e6500@2 {
>  			device_type = "cpu";
>  			reg = <2 3>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2>;
>  		};
>  	};
> diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> index e5cf6c8..5cfcfe4 100644
> --- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> @@ -130,6 +130,41 @@
>  
>  	clockgen: global-utilities@e1000 {
>  		compatible = "fsl,b4860-clockgen", "fsl,qoriq-clockgen-2.0";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-2.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 0x4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
> +		};
> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-2.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
> +				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
> +			clock-names = "pll0_0", "pll0_1", "pll0_2",
> +				"pll1_0", "pll1_1", "pll1_2";
> +			clock-output-names = "cmux0";
> +		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> index 5263fa4..185a231 100644
> --- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> @@ -62,21 +62,25 @@
>  		cpu0: PowerPC,e6500@0 {
>  			device_type = "cpu";
>  			reg = <0 1>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2>;
>  		};
>  		cpu1: PowerPC,e6500@2 {
>  			device_type = "cpu";
>  			reg = <2 3>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2>;
>  		};
>  		cpu2: PowerPC,e6500@4 {
>  			device_type = "cpu";
>  			reg = <4 5>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2>;
>  		};
>  		cpu3: PowerPC,e6500@6 {
>  			device_type = "cpu";
>  			reg = <6 7>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2>;
>  		};
>  	};
> diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> index dc6cc5a..f3f7f65 100644
> --- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> @@ -308,6 +308,66 @@
>  		compatible = "fsl,p2041-clockgen", "fsl,qoriq-clockgen-1.0";
>  		reg = <0xe1000 0x1000>;
>  		clock-frequency = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll1", "pll1-div2";
> +		};
> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux0";
> +		};
> +
> +		mux1: mux1@20 {
> +			#clock-cells = <0>;
> +			reg = <0x20 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux1";
> +		};
> +
> +		mux2: mux2@40 {
> +			#clock-cells = <0>;
> +			reg = <0x40 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux2";
> +		};
> +
> +		mux3: mux3@60 {
> +			#clock-cells = <0>;
> +			reg = <0x60 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux3";
> +		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> index 7a2697d..22f3b14 100644
> --- a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> @@ -81,6 +81,7 @@
>  		cpu0: PowerPC,e500mc@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -89,6 +90,7 @@
>  		cpu1: PowerPC,e500mc@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> +			clocks = <&mux1>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -97,6 +99,7 @@
>  		cpu2: PowerPC,e500mc@2 {
>  			device_type = "cpu";
>  			reg = <2>;
> +			clocks = <&mux2>;
>  			next-level-cache = <&L2_2>;
>  			L2_2: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -105,6 +108,7 @@
>  		cpu3: PowerPC,e500mc@3 {
>  			device_type = "cpu";
>  			reg = <3>;
> +			clocks = <&mux3>;
>  			next-level-cache = <&L2_3>;
>  			L2_3: l2-cache {
>  				next-level-cache = <&cpc>;
> diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> index 3fa1e22..9bab9c9 100644
> --- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> @@ -335,6 +335,66 @@
>  		compatible = "fsl,p3041-clockgen", "fsl,qoriq-clockgen-1.0";
>  		reg = <0xe1000 0x1000>;
>  		clock-frequency = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll1", "pll1-div2";
> +		};
> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux0";
> +		};
> +
> +		mux1: mux1@20 {
> +			#clock-cells = <0>;
> +			reg = <0x20 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux1";
> +		};
> +
> +		mux2: mux2@40 {
> +			#clock-cells = <0>;
> +			reg = <0x40 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux2";
> +		};
> +
> +		mux3: mux3@60 {
> +			#clock-cells = <0>;
> +			reg = <0x60 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux3";
> +		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> index c9ca2c3..468e8be 100644
> --- a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> @@ -82,6 +82,7 @@
>  		cpu0: PowerPC,e500mc@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -90,6 +91,7 @@
>  		cpu1: PowerPC,e500mc@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> +			clocks = <&mux1>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -98,6 +100,7 @@
>  		cpu2: PowerPC,e500mc@2 {
>  			device_type = "cpu";
>  			reg = <2>;
> +			clocks = <&mux2>;
>  			next-level-cache = <&L2_2>;
>  			L2_2: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -106,6 +109,7 @@
>  		cpu3: PowerPC,e500mc@3 {
>  			device_type = "cpu";
>  			reg = <3>;
> +			clocks = <&mux3>;
>  			next-level-cache = <&L2_3>;
>  			L2_3: l2-cache {
>  				next-level-cache = <&cpc>;
> diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> index 34769a7..2108269 100644
> --- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> @@ -355,6 +355,118 @@
>  		compatible = "fsl,p4080-clockgen", "fsl,qoriq-clockgen-1.0";
>  		reg = <0xe1000 0x1000>;
>  		clock-frequency = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll1", "pll1-div2";
> +		};
> +
> +		pll2: pll2@840 {
> +			#clock-cells = <1>;
> +			reg = <0x840 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll2", "pll2-div2";
> +		};
> +
> +		pll3: pll3@860 {
> +			#clock-cells = <1>;
> +			reg = <0x860 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll3", "pll3-div2";
> +		};
> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux0";
> +		};
> +
> +		mux1: mux1@20 {
> +			#clock-cells = <0>;
> +			reg = <0x20 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux1";
> +		};
> +
> +		mux2: mux2@40 {
> +			#clock-cells = <0>;
> +			reg = <0x40 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux2";
> +		};
> +
> +		mux3: mux3@60 {
> +			#clock-cells = <0>;
> +			reg = <0x60 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux3";
> +		};
> +
> +		mux4: mux4@80 {
> +			#clock-cells = <0>;
> +			reg = <0x80 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> +			clock-names = "pll2_0", "pll2_1", "pll3_0", "pll3_1";
> +			clock-output-names = "cmux4";
> +		};
> +
> +		mux5: mux5@a0 {
> +			#clock-cells = <0>;
> +			reg = <0xa0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> +			clock-names = "pll2_0", "pll2_1", "pll3_0", "pll3_1";
> +			clock-output-names = "cmux5";
> +		};
> +
> +		mux6: mux6@c0 {
> +			#clock-cells = <0>;
> +			reg = <0xc0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> +			clock-names = "pll2_0", "pll2_1", "pll3_0", "pll3_1";
> +			clock-output-names = "cmux6";
> +		};
> +
> +		mux7: mux7@e0 {
> +			#clock-cells = <0>;
> +			reg = <0xe0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> +			clock-names = "pll2_0", "pll2_1", "pll3_0", "pll3_1";
> +			clock-output-names = "cmux7";
> +		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> index 493d9a0..0040b5a 100644
> --- a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> @@ -81,6 +81,7 @@
>  		cpu0: PowerPC,e500mc@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -89,6 +90,7 @@
>  		cpu1: PowerPC,e500mc@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> +			clocks = <&mux1>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -97,6 +99,7 @@
>  		cpu2: PowerPC,e500mc@2 {
>  			device_type = "cpu";
>  			reg = <2>;
> +			clocks = <&mux2>;
>  			next-level-cache = <&L2_2>;
>  			L2_2: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -105,6 +108,7 @@
>  		cpu3: PowerPC,e500mc@3 {
>  			device_type = "cpu";
>  			reg = <3>;
> +			clocks = <&mux3>;
>  			next-level-cache = <&L2_3>;
>  			L2_3: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -113,6 +117,7 @@
>  		cpu4: PowerPC,e500mc@4 {
>  			device_type = "cpu";
>  			reg = <4>;
> +			clocks = <&mux4>;
>  			next-level-cache = <&L2_4>;
>  			L2_4: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -121,6 +126,7 @@
>  		cpu5: PowerPC,e500mc@5 {
>  			device_type = "cpu";
>  			reg = <5>;
> +			clocks = <&mux5>;
>  			next-level-cache = <&L2_5>;
>  			L2_5: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -129,6 +135,7 @@
>  		cpu6: PowerPC,e500mc@6 {
>  			device_type = "cpu";
>  			reg = <6>;
> +			clocks = <&mux6>;
>  			next-level-cache = <&L2_6>;
>  			L2_6: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -137,6 +144,7 @@
>  		cpu7: PowerPC,e500mc@7 {
>  			device_type = "cpu";
>  			reg = <7>;
> +			clocks = <&mux7>;
>  			next-level-cache = <&L2_7>;
>  			L2_7: l2-cache {
>  				next-level-cache = <&cpc>;
> diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
> index bc3ae5a..e09f8cd 100644
> --- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
> @@ -340,6 +340,48 @@
>  		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
>  		reg = <0xe1000 0x1000>;
>  		clock-frequency = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll1", "pll1-div2";
> +		};
> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux0";
> +		};
> +
> +		mux1: mux1@20 {
> +			#clock-cells = <0>;
> +			reg = <0x20 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux1";
> +		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> index 8df47fc..fe1a2e6 100644
> --- a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> @@ -88,6 +88,7 @@
>  		cpu0: PowerPC,e5500@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -96,6 +97,7 @@
>  		cpu1: PowerPC,e5500@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> +			clocks = <&mux1>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  				next-level-cache = <&cpc>;
> diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> index a91897f..109f132 100644
> --- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> @@ -300,6 +300,66 @@
>  		compatible = "fsl,p5040-clockgen", "fsl,qoriq-clockgen-1.0";
>  		reg = <0xe1000 0x1000>;
>  		clock-frequency = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll1", "pll1-div2";
> +		};
> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux0";
> +		};
> +
> +		mux1: mux1@20 {
> +			#clock-cells = <0>;
> +			reg = <0x20 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux1";
> +		};
> +
> +		mux2: mux2@40 {
> +			#clock-cells = <0>;
> +			reg = <0x40 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux2";
> +		};
> +
> +		mux3: mux3@60 {
> +			#clock-cells = <0>;
> +			reg = <0x60 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +			clock-output-names = "cmux3";
> +		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> index 40ca943..3674686 100644
> --- a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> @@ -81,6 +81,7 @@
>  		cpu0: PowerPC,e5500@0 {
>  			device_type = "cpu";
>  			reg = <0>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -89,6 +90,7 @@
>  		cpu1: PowerPC,e5500@1 {
>  			device_type = "cpu";
>  			reg = <1>;
> +			clocks = <&mux1>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -97,6 +99,7 @@
>  		cpu2: PowerPC,e5500@2 {
>  			device_type = "cpu";
>  			reg = <2>;
> +			clocks = <&mux2>;
>  			next-level-cache = <&L2_2>;
>  			L2_2: l2-cache {
>  				next-level-cache = <&cpc>;
> @@ -105,6 +108,7 @@
>  		cpu3: PowerPC,e5500@3 {
>  			device_type = "cpu";
>  			reg = <3>;
> +			clocks = <&mux3>;
>  			next-level-cache = <&L2_3>;
>  			L2_3: l2-cache {
>  				next-level-cache = <&cpc>;
> diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> index 510afa3..d45434f 100644
> --- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> @@ -370,6 +370,91 @@
>  	clockgen: global-utilities@e1000 {
>  		compatible = "fsl,t4240-clockgen", "fsl,qoriq-clockgen-2.0";
>  		reg = <0xe1000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-2.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2", "pll0-div4";
> +		};
> +
> +		pll1: pll1@820 {
> +			#clock-cells = <1>;
> +			reg = <0x820 0x4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll1", "pll1-div2", "pll1-div4";
> +		};
> +
> +		pll2: pll2@840 {
> +			#clock-cells = <1>;
> +			reg = <0x840 0x4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll2", "pll2-div2", "pll2-div4";
> +		};
> +
> +		pll3: pll3@860 {
> +			#clock-cells = <1>;
> +			reg = <0x860 0x4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll3", "pll3-div2", "pll3-div4";
> +		};
> +
> +		pll4: pll4@880 {
> +			#clock-cells = <1>;
> +			reg = <0x880 0x4>;
> +			compatible = "fsl,qoriq-core-pll-2.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll4", "pll4-div2", "pll4-div4";
> +		};
> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-2.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
> +				 <&pll1 0>, <&pll1 1>, <&pll1 2>,
> +				 <&pll2 0>, <&pll2 1>, <&pll2 2>;
> +			clock-names = "pll0_0", "pll0_1", "pll0_2",
> +				"pll1_0", "pll1_1", "pll1_2",
> +				"pll2_0", "pll2_1", "pll2_2";
> +			clock-output-names = "cmux0";
> +		};
> +
> +		mux1: mux1@20 {
> +			#clock-cells = <0>;
> +			reg = <0x20 0x4>;
> +			compatible = "fsl,qoriq-core-mux-2.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
> +				 <&pll1 0>, <&pll1 1>, <&pll1 2>,
> +				 <&pll2 0>, <&pll2 1>, <&pll2 2>;
> +			clock-names = "pll0_0", "pll0_1", "pll0_2",
> +				"pll1_0", "pll1_1", "pll1_2",
> +				"pll2_0", "pll2_1", "pll2_2";
> +			clock-output-names = "cmux1";
> +		};
> +
> +		mux2: mux2@40 {
> +			#clock-cells = <0>;
> +			reg = <0x40 0x4>;
> +			compatible = "fsl,qoriq-core-mux-2.0";
> +			clocks = <&pll3 0>, <&pll3 1>, <&pll3 2>,
> +				 <&pll4 0>, <&pll4 1>, <&pll4 2>;
> +			clock-names = "pll3_0", "pll3_1", "pll3_2",
> +				"pll4_0", "pll4_1", "pll4_2";
> +			clock-output-names = "cmux2";
> +		};
>  	};
>  
>  	rcpm: global-utilities@e2000 {
> diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
> index a93c55a..0b8ccc5 100644
> --- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
> @@ -67,61 +67,73 @@
>  		cpu0: PowerPC,e6500@0 {
>  			device_type = "cpu";
>  			reg = <0 1>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2_1>;
>  		};
>  		cpu1: PowerPC,e6500@2 {
>  			device_type = "cpu";
>  			reg = <2 3>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2_1>;
>  		};
>  		cpu2: PowerPC,e6500@4 {
>  			device_type = "cpu";
>  			reg = <4 5>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2_1>;
>  		};
>  		cpu3: PowerPC,e6500@6 {
>  			device_type = "cpu";
>  			reg = <6 7>;
> +			clocks = <&mux0>;
>  			next-level-cache = <&L2_1>;
>  		};
>  		cpu4: PowerPC,e6500@8 {
>  			device_type = "cpu";
>  			reg = <8 9>;
> +			clocks = <&mux1>;
>  			next-level-cache = <&L2_2>;
>  		};
>  		cpu5: PowerPC,e6500@10 {
>  			device_type = "cpu";
>  			reg = <10 11>;
> +			clocks = <&mux1>;
>  			next-level-cache = <&L2_2>;
>  		};
>  		cpu6: PowerPC,e6500@12 {
>  			device_type = "cpu";
>  			reg = <12 13>;
> +			clocks = <&mux1>;
>  			next-level-cache = <&L2_2>;
>  		};
>  		cpu7: PowerPC,e6500@14 {
>  			device_type = "cpu";
>  			reg = <14 15>;
> +			clocks = <&mux1>;
>  			next-level-cache = <&L2_2>;
>  		};
>  		cpu8: PowerPC,e6500@16 {
>  			device_type = "cpu";
>  			reg = <16 17>;
> +			clocks = <&mux2>;
>  			next-level-cache = <&L2_3>;
>  		};
>  		cpu9: PowerPC,e6500@18 {
>  			device_type = "cpu";
>  			reg = <18 19>;
> +			clocks = <&mux2>;
>  			next-level-cache = <&L2_3>;
>  		};
>  		cpu10: PowerPC,e6500@20 {
>  			device_type = "cpu";
>  			reg = <20 21>;
> +			clocks = <&mux2>;
>  			next-level-cache = <&L2_3>;
>  		};
>  		cpu11: PowerPC,e6500@22 {
>  			device_type = "cpu";
>  			reg = <22 23>;
> +			clocks = <&mux2>;
>  			next-level-cache = <&L2_3>;
>  		};
>  	};
> -- 
> 1.8.0
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
