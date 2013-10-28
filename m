Return-Path: <B29983@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 160AB2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 13:20:28 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
Date: Mon, 28 Oct 2013 02:20:18 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B150C7756@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131025201108.B06B8C405AE@trevor.secretlab.ca>
In-Reply-To: <20131025201108.B06B8C405AE@trevor.secretlab.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +1. Clock Block Binding
> > +
> > +Required properties:
> > +- compatible: Should include one or more of the following:
> > +	- "fsl,<chip>-clockgen": for chip specific clock block
> > +	- "fsl,qoriq-clockgen-[1,2].x": for chassis 1.x and 2.x clock
> > +- reg: Offset and length of the clock register set
> > +- clock-frequency: Indicates input clock frequency of clock block.
> > +	Will be set by u-boot
> > +
> > +Recommended properties:
> > +- #ddress-cells: Specifies the number of cells used to represent
>=20
> typo
Thanks, someone else already pointed out it. Will fix in next patch.

Regards,
Yuantian

>=20
> > +	physical base addresses.  Must be present if the device has
> > +	sub-nodes and set to 1 if present
> > +- #size-cells: Specifies the number of cells used to represent
> > +	the size of an address. Must be present if the device has
> > +	sub-nodes and set to 1 if present
> > +
> > +2. Clock Provider/Consumer Binding
> > +
> > +Most of the binding are from the common clock binding[1].
> > + [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +Required properties:
> > +- compatible : Should include one or more of the following:
> > +	- "fsl,qoriq-core-pll-[1,2].x": Indicates a core PLL clock device
> > +	- "fsl,qoriq-core-mux-[1,2].x": Indicates a core multiplexer clock
> > +		device; divided from the core PLL clock
> > +	- "fixed-clock": From common clock binding; indicates output clock
> > +		of oscillator
> > +	- "fsl,qoriq-sysclk-[1,2].x": Indicates input system clock
> > +- #clock-cells: From common clock binding; indicates the number of
> > +	output clock. 0 is for one output clock; 1 for more than one clock
> > +
> > +Recommended properties:
> > +- clocks: Should be the phandle of input parent clock
> > +- clock-names: From common clock binding, indicates the clock name
> > +- clock-output-names: From common clock binding, indicates the names
> of
> > +	output clocks
> > +- reg: Should be the offset and length of clock block base address.
> > +	The length should be 4.
>=20
> Binding looks reasonable to me.
>=20
> g.
>=20
> > +
> > +Example for clock block and clock provider:
> > +/ {
> > +	clockgen: global-utilities@e1000 {
> > +		compatible =3D "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> > +		reg =3D <0xe1000 0x1000>;
> > +		clock-frequency =3D <0>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-1.0", "fixed-clock";
> > +			clock-output-names =3D "sysclk";
> > +		}
> > +
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll0", "pll0-div2";
> > +		};
> > +
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll1", "pll1-div2";
> > +		};
> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux0";
> > +		};
> > +
> > +		mux1: mux1@20 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x20 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux1";
> > +		};
> > +	};
> > +  }
> > +
> > +Example for clock consumer:
> > +
> > +/ {
> > +	cpu0: PowerPC,e5500@0 {
> > +		...
> > +		clocks =3D <&mux0>;
> > +		...
> > +	};
> > +  }
> > diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> > index 5a6615d..e910e82 100644
> > --- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> > @@ -86,6 +86,41 @@
> >
> >  	clockgen: global-utilities@e1000 {
> >  		compatible =3D "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2.0";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-2.0", "fixed-clock";
> > +			clock-output-names =3D "sysclk";
> > +		}
> > +
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-2.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll0", "pll0-div2", "pll0-div4";
> > +		};
> > +
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-2.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll1", "pll1-div2", "pll1-div4";
> > +		};
> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-2.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll0 2>,
> > +				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll0_2",
> > +				"pll1_0", "pll1_1", "pll1_2";
> > +			clock-output-names =3D "cmux0";
> > +		};
> >  	};
> >
> >  	rcpm: global-utilities@e2000 {
> > diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> > b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> > index 7b4426e..a11126b 100644
> > --- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> > @@ -62,11 +62,13 @@
> >  		cpu0: PowerPC,e6500@0 {
> >  			device_type =3D "cpu";
> >  			reg =3D <0 1>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2>;
> >  		};
> >  		cpu1: PowerPC,e6500@2 {
> >  			device_type =3D "cpu";
> >  			reg =3D <2 3>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2>;
> >  		};
> >  	};
> > diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> > index e5cf6c8..5cfcfe4 100644
> > --- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> > @@ -130,6 +130,41 @@
> >
> >  	clockgen: global-utilities@e1000 {
> >  		compatible =3D "fsl,b4860-clockgen", "fsl,qoriq-clockgen-2.0";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-2.0", "fixed-clock";
> > +			clock-output-names =3D "sysclk";
> > +		}
> > +
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-2.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll0", "pll0-div2", "pll0-div4";
> > +		};
> > +
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-2.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll1", "pll1-div2", "pll1-div4";
> > +		};
> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-2.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll0 2>,
> > +				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll0_2",
> > +				"pll1_0", "pll1_1", "pll1_2";
> > +			clock-output-names =3D "cmux0";
> > +		};
> >  	};
> >
> >  	rcpm: global-utilities@e2000 {
> > diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> > b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> > index 5263fa4..185a231 100644
> > --- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> > @@ -62,21 +62,25 @@
> >  		cpu0: PowerPC,e6500@0 {
> >  			device_type =3D "cpu";
> >  			reg =3D <0 1>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2>;
> >  		};
> >  		cpu1: PowerPC,e6500@2 {
> >  			device_type =3D "cpu";
> >  			reg =3D <2 3>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2>;
> >  		};
> >  		cpu2: PowerPC,e6500@4 {
> >  			device_type =3D "cpu";
> >  			reg =3D <4 5>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2>;
> >  		};
> >  		cpu3: PowerPC,e6500@6 {
> >  			device_type =3D "cpu";
> >  			reg =3D <6 7>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2>;
> >  		};
> >  	};
> > diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> > index dc6cc5a..f3f7f65 100644
> > --- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> > @@ -308,6 +308,66 @@
> >  		compatible =3D "fsl,p2041-clockgen", "fsl,qoriq-clockgen-1.0";
> >  		reg =3D <0xe1000 0x1000>;
> >  		clock-frequency =3D <0>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-1.0", "fixed-clock";
> > +			clock-output-names =3D "sysclk";
> > +		}
> > +
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll0", "pll0-div2";
> > +		};
> > +
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll1", "pll1-div2";
> > +		};
> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux0";
> > +		};
> > +
> > +		mux1: mux1@20 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x20 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux1";
> > +		};
> > +
> > +		mux2: mux2@40 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x40 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux2";
> > +		};
> > +
> > +		mux3: mux3@60 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x60 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux3";
> > +		};
> >  	};
> >
> >  	rcpm: global-utilities@e2000 {
> > diff --git a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> > b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> > index 7a2697d..22f3b14 100644
> > --- a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
> > @@ -81,6 +81,7 @@
> >  		cpu0: PowerPC,e500mc@0 {
> >  			device_type =3D "cpu";
> >  			reg =3D <0>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2_0>;
> >  			L2_0: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -89,6 +90,7 @@
> >  		cpu1: PowerPC,e500mc@1 {
> >  			device_type =3D "cpu";
> >  			reg =3D <1>;
> > +			clocks =3D <&mux1>;
> >  			next-level-cache =3D <&L2_1>;
> >  			L2_1: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -97,6 +99,7 @@
> >  		cpu2: PowerPC,e500mc@2 {
> >  			device_type =3D "cpu";
> >  			reg =3D <2>;
> > +			clocks =3D <&mux2>;
> >  			next-level-cache =3D <&L2_2>;
> >  			L2_2: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -105,6 +108,7 @@
> >  		cpu3: PowerPC,e500mc@3 {
> >  			device_type =3D "cpu";
> >  			reg =3D <3>;
> > +			clocks =3D <&mux3>;
> >  			next-level-cache =3D <&L2_3>;
> >  			L2_3: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> > index 3fa1e22..9bab9c9 100644
> > --- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> > @@ -335,6 +335,66 @@
> >  		compatible =3D "fsl,p3041-clockgen", "fsl,qoriq-clockgen-1.0";
> >  		reg =3D <0xe1000 0x1000>;
> >  		clock-frequency =3D <0>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-1.0", "fixed-clock";
> > +			clock-output-names =3D "sysclk";
> > +		}
> > +
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll0", "pll0-div2";
> > +		};
> > +
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll1", "pll1-div2";
> > +		};
> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux0";
> > +		};
> > +
> > +		mux1: mux1@20 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x20 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux1";
> > +		};
> > +
> > +		mux2: mux2@40 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x40 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux2";
> > +		};
> > +
> > +		mux3: mux3@60 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x60 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux3";
> > +		};
> >  	};
> >
> >  	rcpm: global-utilities@e2000 {
> > diff --git a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> > b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> > index c9ca2c3..468e8be 100644
> > --- a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
> > @@ -82,6 +82,7 @@
> >  		cpu0: PowerPC,e500mc@0 {
> >  			device_type =3D "cpu";
> >  			reg =3D <0>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2_0>;
> >  			L2_0: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -90,6 +91,7 @@
> >  		cpu1: PowerPC,e500mc@1 {
> >  			device_type =3D "cpu";
> >  			reg =3D <1>;
> > +			clocks =3D <&mux1>;
> >  			next-level-cache =3D <&L2_1>;
> >  			L2_1: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -98,6 +100,7 @@
> >  		cpu2: PowerPC,e500mc@2 {
> >  			device_type =3D "cpu";
> >  			reg =3D <2>;
> > +			clocks =3D <&mux2>;
> >  			next-level-cache =3D <&L2_2>;
> >  			L2_2: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -106,6 +109,7 @@
> >  		cpu3: PowerPC,e500mc@3 {
> >  			device_type =3D "cpu";
> >  			reg =3D <3>;
> > +			clocks =3D <&mux3>;
> >  			next-level-cache =3D <&L2_3>;
> >  			L2_3: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> > index 34769a7..2108269 100644
> > --- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> > @@ -355,6 +355,118 @@
> >  		compatible =3D "fsl,p4080-clockgen", "fsl,qoriq-clockgen-1.0";
> >  		reg =3D <0xe1000 0x1000>;
> >  		clock-frequency =3D <0>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-1.0", "fixed-clock";
> > +			clock-output-names =3D "sysclk";
> > +		}
> > +
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll0", "pll0-div2";
> > +		};
> > +
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll1", "pll1-div2";
> > +		};
> > +
> > +		pll2: pll2@840 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x840 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll2", "pll2-div2";
> > +		};
> > +
> > +		pll3: pll3@860 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x860 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll3", "pll3-div2";
> > +		};
> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux0";
> > +		};
> > +
> > +		mux1: mux1@20 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x20 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux1";
> > +		};
> > +
> > +		mux2: mux2@40 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x40 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux2";
> > +		};
> > +
> > +		mux3: mux3@60 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x60 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux3";
> > +		};
> > +
> > +		mux4: mux4@80 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x80 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> > +			clock-names =3D "pll2_0", "pll2_1", "pll3_0", "pll3_1";
> > +			clock-output-names =3D "cmux4";
> > +		};
> > +
> > +		mux5: mux5@a0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0xa0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> > +			clock-names =3D "pll2_0", "pll2_1", "pll3_0", "pll3_1";
> > +			clock-output-names =3D "cmux5";
> > +		};
> > +
> > +		mux6: mux6@c0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0xc0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> > +			clock-names =3D "pll2_0", "pll2_1", "pll3_0", "pll3_1";
> > +			clock-output-names =3D "cmux6";
> > +		};
> > +
> > +		mux7: mux7@e0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0xe0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll2 0>, <&pll2 1>, <&pll3 0>, <&pll3 1>;
> > +			clock-names =3D "pll2_0", "pll2_1", "pll3_0", "pll3_1";
> > +			clock-output-names =3D "cmux7";
> > +		};
> >  	};
> >
> >  	rcpm: global-utilities@e2000 {
> > diff --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> > b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> > index 493d9a0..0040b5a 100644
> > --- a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> > @@ -81,6 +81,7 @@
> >  		cpu0: PowerPC,e500mc@0 {
> >  			device_type =3D "cpu";
> >  			reg =3D <0>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2_0>;
> >  			L2_0: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -89,6 +90,7 @@
> >  		cpu1: PowerPC,e500mc@1 {
> >  			device_type =3D "cpu";
> >  			reg =3D <1>;
> > +			clocks =3D <&mux1>;
> >  			next-level-cache =3D <&L2_1>;
> >  			L2_1: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -97,6 +99,7 @@
> >  		cpu2: PowerPC,e500mc@2 {
> >  			device_type =3D "cpu";
> >  			reg =3D <2>;
> > +			clocks =3D <&mux2>;
> >  			next-level-cache =3D <&L2_2>;
> >  			L2_2: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -105,6 +108,7 @@
> >  		cpu3: PowerPC,e500mc@3 {
> >  			device_type =3D "cpu";
> >  			reg =3D <3>;
> > +			clocks =3D <&mux3>;
> >  			next-level-cache =3D <&L2_3>;
> >  			L2_3: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -113,6 +117,7 @@
> >  		cpu4: PowerPC,e500mc@4 {
> >  			device_type =3D "cpu";
> >  			reg =3D <4>;
> > +			clocks =3D <&mux4>;
> >  			next-level-cache =3D <&L2_4>;
> >  			L2_4: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -121,6 +126,7 @@
> >  		cpu5: PowerPC,e500mc@5 {
> >  			device_type =3D "cpu";
> >  			reg =3D <5>;
> > +			clocks =3D <&mux5>;
> >  			next-level-cache =3D <&L2_5>;
> >  			L2_5: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -129,6 +135,7 @@
> >  		cpu6: PowerPC,e500mc@6 {
> >  			device_type =3D "cpu";
> >  			reg =3D <6>;
> > +			clocks =3D <&mux6>;
> >  			next-level-cache =3D <&L2_6>;
> >  			L2_6: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -137,6 +144,7 @@
> >  		cpu7: PowerPC,e500mc@7 {
> >  			device_type =3D "cpu";
> >  			reg =3D <7>;
> > +			clocks =3D <&mux7>;
> >  			next-level-cache =3D <&L2_7>;
> >  			L2_7: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
> > index bc3ae5a..e09f8cd 100644
> > --- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
> > @@ -340,6 +340,48 @@
> >  		compatible =3D "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> >  		reg =3D <0xe1000 0x1000>;
> >  		clock-frequency =3D <0>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-1.0", "fixed-clock";
> > +			clock-output-names =3D "sysclk";
> > +		}
> > +
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll0", "pll0-div2";
> > +		};
> > +
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll1", "pll1-div2";
> > +		};
> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux0";
> > +		};
> > +
> > +		mux1: mux1@20 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x20 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux1";
> > +		};
> >  	};
> >
> >  	rcpm: global-utilities@e2000 {
> > diff --git a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> > b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> > index 8df47fc..fe1a2e6 100644
> > --- a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
> > @@ -88,6 +88,7 @@
> >  		cpu0: PowerPC,e5500@0 {
> >  			device_type =3D "cpu";
> >  			reg =3D <0>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2_0>;
> >  			L2_0: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -96,6 +97,7 @@
> >  		cpu1: PowerPC,e5500@1 {
> >  			device_type =3D "cpu";
> >  			reg =3D <1>;
> > +			clocks =3D <&mux1>;
> >  			next-level-cache =3D <&L2_1>;
> >  			L2_1: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> > index a91897f..109f132 100644
> > --- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> > @@ -300,6 +300,66 @@
> >  		compatible =3D "fsl,p5040-clockgen", "fsl,qoriq-clockgen-1.0";
> >  		reg =3D <0xe1000 0x1000>;
> >  		clock-frequency =3D <0>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-1.0", "fixed-clock";
> > +			clock-output-names =3D "sysclk";
> > +		}
> > +
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll0", "pll0-div2";
> > +		};
> > +
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-1.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll1", "pll1-div2";
> > +		};
> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux0";
> > +		};
> > +
> > +		mux1: mux1@20 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x20 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux1";
> > +		};
> > +
> > +		mux2: mux2@40 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x40 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux2";
> > +		};
> > +
> > +		mux3: mux3@60 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x60 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> > +			clock-output-names =3D "cmux3";
> > +		};
> >  	};
> >
> >  	rcpm: global-utilities@e2000 {
> > diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> > b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> > index 40ca943..3674686 100644
> > --- a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
> > @@ -81,6 +81,7 @@
> >  		cpu0: PowerPC,e5500@0 {
> >  			device_type =3D "cpu";
> >  			reg =3D <0>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2_0>;
> >  			L2_0: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -89,6 +90,7 @@
> >  		cpu1: PowerPC,e5500@1 {
> >  			device_type =3D "cpu";
> >  			reg =3D <1>;
> > +			clocks =3D <&mux1>;
> >  			next-level-cache =3D <&L2_1>;
> >  			L2_1: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -97,6 +99,7 @@
> >  		cpu2: PowerPC,e5500@2 {
> >  			device_type =3D "cpu";
> >  			reg =3D <2>;
> > +			clocks =3D <&mux2>;
> >  			next-level-cache =3D <&L2_2>;
> >  			L2_2: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > @@ -105,6 +108,7 @@
> >  		cpu3: PowerPC,e5500@3 {
> >  			device_type =3D "cpu";
> >  			reg =3D <3>;
> > +			clocks =3D <&mux3>;
> >  			next-level-cache =3D <&L2_3>;
> >  			L2_3: l2-cache {
> >  				next-level-cache =3D <&cpc>;
> > diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > index 510afa3..d45434f 100644
> > --- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > @@ -370,6 +370,91 @@
> >  	clockgen: global-utilities@e1000 {
> >  		compatible =3D "fsl,t4240-clockgen", "fsl,qoriq-clockgen-2.0";
> >  		reg =3D <0xe1000 0x1000>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-2.0", "fixed-clock";
> > +			clock-output-names =3D "sysclk";
> > +		}
> > +
> > +		pll0: pll0@800 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x800 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-2.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll0", "pll0-div2", "pll0-div4";
> > +		};
> > +
> > +		pll1: pll1@820 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x820 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-2.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll1", "pll1-div2", "pll1-div4";
> > +		};
> > +
> > +		pll2: pll2@840 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x840 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-2.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll2", "pll2-div2", "pll2-div4";
> > +		};
> > +
> > +		pll3: pll3@860 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x860 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-2.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll3", "pll3-div2", "pll3-div4";
> > +		};
> > +
> > +		pll4: pll4@880 {
> > +			#clock-cells =3D <1>;
> > +			reg =3D <0x880 0x4>;
> > +			compatible =3D "fsl,qoriq-core-pll-2.0";
> > +			clocks =3D <&sysclk>;
> > +			clock-output-names =3D "pll4", "pll4-div2", "pll4-div4";
> > +		};
> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-2.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll0 2>,
> > +				 <&pll1 0>, <&pll1 1>, <&pll1 2>,
> > +				 <&pll2 0>, <&pll2 1>, <&pll2 2>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll0_2",
> > +				"pll1_0", "pll1_1", "pll1_2",
> > +				"pll2_0", "pll2_1", "pll2_2";
> > +			clock-output-names =3D "cmux0";
> > +		};
> > +
> > +		mux1: mux1@20 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x20 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-2.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll0 2>,
> > +				 <&pll1 0>, <&pll1 1>, <&pll1 2>,
> > +				 <&pll2 0>, <&pll2 1>, <&pll2 2>;
> > +			clock-names =3D "pll0_0", "pll0_1", "pll0_2",
> > +				"pll1_0", "pll1_1", "pll1_2",
> > +				"pll2_0", "pll2_1", "pll2_2";
> > +			clock-output-names =3D "cmux1";
> > +		};
> > +
> > +		mux2: mux2@40 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x40 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-2.0";
> > +			clocks =3D <&pll3 0>, <&pll3 1>, <&pll3 2>,
> > +				 <&pll4 0>, <&pll4 1>, <&pll4 2>;
> > +			clock-names =3D "pll3_0", "pll3_1", "pll3_2",
> > +				"pll4_0", "pll4_1", "pll4_2";
> > +			clock-output-names =3D "cmux2";
> > +		};
> >  	};
> >
> >  	rcpm: global-utilities@e2000 {
> > diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
> > b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
> > index a93c55a..0b8ccc5 100644
> > --- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
> > @@ -67,61 +67,73 @@
> >  		cpu0: PowerPC,e6500@0 {
> >  			device_type =3D "cpu";
> >  			reg =3D <0 1>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2_1>;
> >  		};
> >  		cpu1: PowerPC,e6500@2 {
> >  			device_type =3D "cpu";
> >  			reg =3D <2 3>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2_1>;
> >  		};
> >  		cpu2: PowerPC,e6500@4 {
> >  			device_type =3D "cpu";
> >  			reg =3D <4 5>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2_1>;
> >  		};
> >  		cpu3: PowerPC,e6500@6 {
> >  			device_type =3D "cpu";
> >  			reg =3D <6 7>;
> > +			clocks =3D <&mux0>;
> >  			next-level-cache =3D <&L2_1>;
> >  		};
> >  		cpu4: PowerPC,e6500@8 {
> >  			device_type =3D "cpu";
> >  			reg =3D <8 9>;
> > +			clocks =3D <&mux1>;
> >  			next-level-cache =3D <&L2_2>;
> >  		};
> >  		cpu5: PowerPC,e6500@10 {
> >  			device_type =3D "cpu";
> >  			reg =3D <10 11>;
> > +			clocks =3D <&mux1>;
> >  			next-level-cache =3D <&L2_2>;
> >  		};
> >  		cpu6: PowerPC,e6500@12 {
> >  			device_type =3D "cpu";
> >  			reg =3D <12 13>;
> > +			clocks =3D <&mux1>;
> >  			next-level-cache =3D <&L2_2>;
> >  		};
> >  		cpu7: PowerPC,e6500@14 {
> >  			device_type =3D "cpu";
> >  			reg =3D <14 15>;
> > +			clocks =3D <&mux1>;
> >  			next-level-cache =3D <&L2_2>;
> >  		};
> >  		cpu8: PowerPC,e6500@16 {
> >  			device_type =3D "cpu";
> >  			reg =3D <16 17>;
> > +			clocks =3D <&mux2>;
> >  			next-level-cache =3D <&L2_3>;
> >  		};
> >  		cpu9: PowerPC,e6500@18 {
> >  			device_type =3D "cpu";
> >  			reg =3D <18 19>;
> > +			clocks =3D <&mux2>;
> >  			next-level-cache =3D <&L2_3>;
> >  		};
> >  		cpu10: PowerPC,e6500@20 {
> >  			device_type =3D "cpu";
> >  			reg =3D <20 21>;
> > +			clocks =3D <&mux2>;
> >  			next-level-cache =3D <&L2_3>;
> >  		};
> >  		cpu11: PowerPC,e6500@22 {
> >  			device_type =3D "cpu";
> >  			reg =3D <22 23>;
> > +			clocks =3D <&mux2>;
> >  			next-level-cache =3D <&L2_3>;
> >  		};
> >  	};
> > --
> > 1.8.0
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
