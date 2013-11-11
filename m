Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 1E3202C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 22:52:14 +1100 (EST)
Date: Mon, 11 Nov 2013 11:52:02 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Yuantian.Tang@freescale.com" <Yuantian.Tang@freescale.com>,
 mike.turquette@linaro.org
Subject: Re: [PATCH v6] clk: corenet: Adds the clock binding
Message-ID: <20131111115202.GD21201@e106331-lin.cambridge.arm.com>
References: <1384162906-30730-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384162906-30730-1-git-send-email-Yuantian.Tang@freescale.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 11, 2013 at 09:41:46AM +0000, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> Adds the clock bindings for Freescale PowerPC CoreNet platforms
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> v6:
> 	- splited the previous patch into 2 parts, one is for binding(this one),
> 	  the other is for DTS modification(will submit once this gets accepted)
> 	- fixed typo
> 	- refined #clock-cells and clock-output-names properties
> 	- removed fixed-clock compatible string
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
>  .../devicetree/bindings/clock/corenet-clock.txt    | 123 +++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/corenet-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/corenet-clock.txt b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> new file mode 100644
> index 0000000..6a4e15d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> @@ -0,0 +1,123 @@
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

When you say "one or more", I assume you mean of the specific clock
block strings, and then a chassis string?

If so, it might be better to say smoething like:

- compatible: Should contain a specific clock block compatible string
  and a single chassis clock compatible string.

  Clock block strings include:
  * "fsl,p2041-clockgen"
  * "fsl,p3041-clockgen"
 
  Chassis clock strings include:
  * "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
  * "fsl,qoriq-clockgen-2.0": for chassis 2.0 clock

> +	* "fsl,<chip>-clockgen": for chip specific clock block, here chip
> +		could be but not limited to one of the: p2041, p3041, p4080,
> +		p5020, p5040, t4240, b4420, b4860
> +	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
> +	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
> +	Notes that "fsl,qoriq-clockgen-1.0" and "fsl,qoriq-clockgen-2.0"
> +	cannot be included simultaneously.
> +- reg: Offset and length of the clock register set
> +
> +Recommended properties:
> +- ranges: Allows valid translation between child's address space and
> +	parent's. Must be present if the device has sub-nodes.
> +- #address-cells: Specifies the number of cells used to represent
> +	physical base addresses.  Must be present if the device has
> +	sub-nodes and set to 1 if present
> +- #size-cells: Specifies the number of cells used to represent
> +	the size of an address. Must be present if the device has
> +	sub-nodes and set to 1 if present

Is there any particular reason these _must_ be 1?

> +
> +2. Clock Provider/Consumer Binding
> +
> +Most of the bindings are from the common clock binding[1].
> + [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : Should include one of the following:
> +	* "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
> +    * "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
> +    * "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
> +    * "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
> +	* "fsl,qoriq-sysclk-1.0": for input system clock (v1.0)
> +	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0)
> +- #clock-cells: From common clock binding; indicates the number of
> +	output clock. 0 is for "fsl,qoriq-sysclk-[1,2].0" and
> +	"fsl,qoriq-core-mux-[1,2].0"; 1 for "fsl,qoriq-core-pll-[1,2].0".

Nit: #clock-cells defines the number of cells in a clock-specifier, not
the number of output clocks. How about:

- #clock-cells: The number of cells in a clock-specifier. Should be <0>
  for "fsl,qoriq-sysclk-[1,2].0" clocks, or <1> for
  "fsl,qoriq-core-pll-[1,2].0" clocks.

> +	If #clock-cells has a value of 1, its clock consumer should specify
> +	the desired clock by having the clock ID in its "clocks" phandle
> +	cell. The following is a full list IDs:

The ID is in the clock-specifier, not the phandle. How about the
following instead:

For "fsl,qoriq-core-pll-[1,2].0" clocks, the single clock-specifier cell
may take the following values:

> +	* 0 - equal to the PLL frequency
> +	* 1 - equal to the PLL frequency divided by 2
> +	* 2 - equal to the PLL frequency divided by 4
> +
> +Recommended properties:
> +- clocks: Should be the phandle of input parent clock
> +- clock-names: From common clock binding, indicates the clock name

Is this not well defined and common across all of the clocks? The set of
inputs they have must be well known, and if it isn't then this property
isn't all that useful.

> +- clock-output-names: From common clock binding, indicates the names of
> +	output clocks

Similarly, I'd expect that there might be well defined output names. 

> +- reg: Should be the offset and length of clock block base address.
> +	The length should be 4.
> +
> +Example for clock block and clock provider:
> +/ {
> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> +		ranges = <0x0 0xe1000 0x1000>;
> +		reg = <0xe1000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-1.0";
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

The binding documentation for clock-output-names describes
clock-output-names as the name of the clock output signals. I understand
this as meaning name of the output with respect to the clock, rather
than a global namespace, but I may be mistaken there. Mike?

Given that I'd expect pll0 and pll1 to have the same set of
clock-output-names, (perhaps "pll", "pll-div2") as they seem to be
instances of the same HW block. As far as I am aware the precise
instance shouldn't affect the name (unless the documentation for the HW
have these logical output names?).

> +
> +		mux0: mux0@0 {
> +			#clock-cells = <0>;
> +			reg = <0x0 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
> +			clock-output-names = "cmux0";
> +		};

I have a similar worry here with regards to the clock-names, but I guess
it doesn't really matter here if the documentation doesn't provide any
better names for the inputs to the mux.

However for the output name I'd expect just "cmux".

Thanks,
Mark,

> +
> +		mux1: mux1@20 {
> +			#clock-cells = <0>;
> +			reg = <0x20 0x4>;
> +			compatible = "fsl,qoriq-core-mux-1.0";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
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
> -- 
> 1.8.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
