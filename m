Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 28CC52C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 21:03:41 +1100 (EST)
Date: Thu, 10 Oct 2013 11:03:31 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Yuantian.Tang@freescale.com" <Yuantian.Tang@freescale.com>
Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
Message-ID: <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
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

On Wed, Oct 09, 2013 at 07:38:24AM +0100, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
>
> The following SoCs will be affected: p2041, p3041, p4080,
> p5020, p5040, b4420, b4860, t4240
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> v5:
>         - refine the binding document
>         - update the compatible string
> v4:
>         - add binding document
>         - update compatible string
>         - update the reg property
> v3:
>         - fix typo
> v2:
>         - add t4240, b4420, b4860 support
>         - remove pll/4 clock from p2041, p3041 and p5020 board
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
> +       - "fsl,<chip>-clockgen": for chip specific clock block
> +       - "fsl,qoriq-clockgen-[1,2].x": for chassis 1.x and 2.x clock

While I can see that "fsl,<chip>-clockgen" might have a large set of
strings that we may never deal with in th kernel, I'd prefer that the
basic strings (i.e. all the "fsl,qoriq-clockgen-[1,2].x" variants) were
listed explicitly here.

Given they only seem to be "fsl,qoriq-clockgen-1.0" and
"fsl,qoriq-clockgen-2.0" this shouldn't be too difficult to list and
describe.

> +- reg: Offset and length of the clock register set
> +- clock-frequency: Indicates input clock frequency of clock block.
> +       Will be set by u-boot

Why does the fact this is set by u-boot matter to the binding?

> +
> +Recommended properties:
> +- #ddress-cells: Specifies the number of cells used to represent
> +       physical base addresses.  Must be present if the device has
> +       sub-nodes and set to 1 if present

Typo: #address-cells

In the example it looks like the address cells of child nodes are
offsets within the unit, rather than absolute physical addresses. Could
the code not treat them as absolute addresses? Then we'd only need to
document that #address-cells, #size-cells and ranges must be present and
have values suitable for mapping child nodes into the address space of
the parent.

> +- #size-cells: Specifies the number of cells used to represent
> +       the size of an address. Must be present if the device has
> +       sub-nodes and set to 1 if present

It's not really the size of an address, it's the size of a region
identified by a reg entry.

I think this can be simplified by my suggestion above.

> +
> +2. Clock Provider/Consumer Binding
> +
> +Most of the binding are from the common clock binding[1].
> + [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : Should include one or more of the following:
> +       - "fsl,qoriq-core-pll-[1,2].x": Indicates a core PLL clock device
> +       - "fsl,qoriq-core-mux-[1,2].x": Indicates a core multiplexer clock
> +               device; divided from the core PLL clock

As above, I'd prefer a complete list of the basic strings we expect.

> +       - "fixed-clock": From common clock binding; indicates output clock
> +               of oscillator
> +       - "fsl,qoriq-sysclk-[1,2].x": Indicates input system clock

Here too.

> +- #clock-cells: From common clock binding; indicates the number of
> +       output clock. 0 is for one output clock; 1 for more than one clock

If a clock source has multiple outputs, what those outputs are and what
values in clock-cells they correspond to should be described here.

> +
> +Recommended properties:
> +- clocks: Should be the phandle of input parent clock
> +- clock-names: From common clock binding, indicates the clock name

That description's a bit opaque.

What's the name of the clock input on these units? That's what
clock-names should contain, and that should be documented.

Do we not _always_ need the parent clock?

If we have a clock do we need a clock-names entry for it?

> +- clock-output-names: From common clock binding, indicates the names of
> +       output clocks
> +- reg: Should be the offset and length of clock block base address.
> +       The length should be 4.
> +
> +Example for clock block and clock provider:
> +/ {
> +       clockgen: global-utilities@e1000 {
> +               compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> +               reg = <0xe1000 0x1000>;
> +               clock-frequency = <0>;

That looks odd.

> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               sysclk: sysclk {
> +                       #clock-cells = <0>;
> +                       compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";

We didn't mention in the binding that "fsl,qoriq-sysclk-1.0" was
compatible with "fixed-clock" and should have "fixed-clock" in the
compatible list...

> +                       clock-output-names = "sysclk";
> +               }
> +
> +               pll0: pll0@800 {
> +                       #clock-cells = <1>;
> +                       reg = <0x800 0x4>;
> +                       compatible = "fsl,qoriq-core-pll-1.0";
> +                       clocks = <&sysclk>;
> +                       clock-output-names = "pll0", "pll0-div2";
> +               };
> +
> +               pll1: pll1@820 {
> +                       #clock-cells = <1>;
> +                       reg = <0x820 0x4>;
> +                       compatible = "fsl,qoriq-core-pll-1.0";
> +                       clocks = <&sysclk>;
> +                       clock-output-names = "pll1", "pll1-div2";
> +               };
> +
> +               mux0: mux0@0 {
> +                       #clock-cells = <0>;
> +                       reg = <0x0 0x4>;
> +                       compatible = "fsl,qoriq-core-mux-1.0";
> +                       clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +                       clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +                       clock-output-names = "cmux0";
> +               };
> +
> +               mux1: mux1@20 {
> +                       #clock-cells = <0>;
> +                       reg = <0x20 0x4>;
> +                       compatible = "fsl,qoriq-core-mux-1.0";
> +                       clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> +                       clock-names = "pll0_0", "pll0_1", "pll1_0", "pll1_1";
> +                       clock-output-names = "cmux1";

How does the mux choose which input clock to use at a point in time?

Cheers,
Mark.
