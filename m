Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id EAD8A2C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 20:25:34 +1100 (EST)
Date: Fri, 11 Oct 2013 10:25:26 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
Message-ID: <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-Leo-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 11, 2013 at 04:18:18AM +0100, Tang Yuantian-B29983 wrote:
> Thanks for your review.
> See my reply inline
>
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland@arm.com]
> > Sent: 2013年10月10日 星期四 18:04
> > To: Tang Yuantian-B29983
> > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org;
> > devicetree@vger.kernel.org; Li Yang-Leo-R58472
> > Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device
> > tree
> >
> > On Wed, Oct 09, 2013 at 07:38:24AM +0100, Yuantian.Tang@freescale.com
> > wrote:
> > > From: Tang Yuantian <yuantian.tang@freescale.com>
> > >
> > > The following SoCs will be affected: p2041, p3041, p4080, p5020,
> > > p5040, b4420, b4860, t4240
> > >
> > > Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> > > Signed-off-by: Li Yang <leoli@freescale.com>
> > > ---
> > > v5:
> > >         - refine the binding document
> > >         - update the compatible string
> > > v4:
> > >         - add binding document
> > >         - update compatible string
> > >         - update the reg property
> > > v3:
> > >         - fix typo
> > > v2:
> > >         - add t4240, b4420, b4860 support
> > >         - remove pll/4 clock from p2041, p3041 and p5020 board
> > >
> > >  .../devicetree/bindings/clock/corenet-clock.txt    | 111
> > ++++++++++++++++++++
> > >  arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |  35 +++++++
> > >  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   2 +
> > >  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |  35 +++++++
> > >  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   4 +
> > >  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  60 +++++++++++
> > >  arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   4 +
> > >  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  60 +++++++++++
> > >  arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   4 +
> > >  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        | 112
> > +++++++++++++++++++++
> > >  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   8 ++
> > >  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |  42 ++++++++
> > >  arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   2 +
> > >  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  60 +++++++++++
> > >  arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   4 +
> > >  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  85
> > ++++++++++++++++
> > >  arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  12 +++
> > >  17 files changed, 640 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/clock/corenet-clock.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/corenet-clock.txt
> > > b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> > > new file mode 100644
> > > index 0000000..8efc62d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> > > @@ -0,0 +1,111 @@
> > > +* Clock Block on Freescale CoreNet Platforms
> > > +
> > > +Freescale CoreNet chips take primary clocking input from the external
> > > +SYSCLK signal. The SYSCLK input (frequency) is multiplied using
> > > +multiple phase locked loops (PLL) to create a variety of frequencies
> > > +which can then be passed to a variety of internal logic, including
> > > +cores and peripheral IP blocks.
> > > +Please refer to the Reference Manual for details.
> > > +
> > > +1. Clock Block Binding
> > > +
> > > +Required properties:
> > > +- compatible: Should include one or more of the following:
> > > +       - "fsl,<chip>-clockgen": for chip specific clock block
> > > +       - "fsl,qoriq-clockgen-[1,2].x": for chassis 1.x and 2.x clock
> >
> > While I can see that "fsl,<chip>-clockgen" might have a large set of
> > strings that we may never deal with in th kernel, I'd prefer that the
> > basic strings (i.e. all the "fsl,qoriq-clockgen-[1,2].x" variants) were
> > listed explicitly here.
> >
> > Given they only seem to be "fsl,qoriq-clockgen-1.0" and "fsl,qoriq-
> > clockgen-2.0" this shouldn't be too difficult to list and describe.
> >
> OK, I will list them all.

Thanks.

>
> > > +- reg: Offset and length of the clock register set
> > > +- clock-frequency: Indicates input clock frequency of clock block.
> > > +       Will be set by u-boot
> >
> > Why does the fact this is set by u-boot matter to the binding?
> >
> OK, I will remove it.
>
> > > +
> > > +Recommended properties:
> > > +- #ddress-cells: Specifies the number of cells used to represent
> > > +       physical base addresses.  Must be present if the device has
> > > +       sub-nodes and set to 1 if present
> >
> > Typo: #address-cells
> >
> > In the example it looks like the address cells of child nodes are offsets
> > within the unit, rather than absolute physical addresses. Could the code
> > not treat them as absolute addresses? Then we'd only need to document
> > that #address-cells, #size-cells and ranges must be present and have
> > values suitable for mapping child nodes into the address space of the
> > parent.
> >
> OK, thanks.
>
> > > +- #size-cells: Specifies the number of cells used to represent
> > > +       the size of an address. Must be present if the device has
> > > +       sub-nodes and set to 1 if present
> >
> > It's not really the size of an address, it's the size of a region
> > identified by a reg entry.
> >
> > I think this can be simplified by my suggestion above.
> >
> Yes

Aah, I see that this is already in use, so it's a bit late to change
this...

>
> > > +
> > > +2. Clock Provider/Consumer Binding
> > > +
> > > +Most of the binding are from the common clock binding[1].
> > > + [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > +
> > > +Required properties:
> > > +- compatible : Should include one or more of the following:

I didn't spot this earlier, but why "one or more"? are the 2.0 variants
backwards compatible with the 1.0 variants.

> > > +       - "fsl,qoriq-core-pll-[1,2].x": Indicates a core PLL clock
> > device
> > > +       - "fsl,qoriq-core-mux-[1,2].x": Indicates a core multiplexer
> > clock
> > > +               device; divided from the core PLL clock
> >
> > As above, I'd prefer a complete list of the basic strings we expect.
> >
> There is no list here, just *-mux-1.x and *-mux-2.x
> What kind of list do you prefer?

Something like:

- compatible: Should include at least one of:
    * "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
    * "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
    * "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
    * "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
  The *-2.0 variants are backwards compatible with the *-1.0 variants,
  so for compatiblity a *-1.0 variant string should be in the list.

>
> > > +       - "fixed-clock": From common clock binding; indicates output
> > clock
> > > +               of oscillator
> > > +       - "fsl,qoriq-sysclk-[1,2].x": Indicates input system clock
> >
> > Here too.
> >
> > > +- #clock-cells: From common clock binding; indicates the number of
> > > +       output clock. 0 is for one output clock; 1 for more than one
> > > +clock
> >
> > If a clock source has multiple outputs, what those outputs are and what
> > values in clock-cells they correspond to should be described here.
> >
> There is no way to describe the values of multiple outputs here.
> This property is the type of BOOL. See the clock-bindings.txt.

Sorry? #clock-cells is most definitely _not_ a bool:

17: #clock-cells:      Number of cells in a clock specifier; Typically 0 for nodes
18:                    with a single clock output and 1 for nodes with multiple
19:                    clock outputs.

And neither are the clock-specifiers encoded with those cells. Consider:

  pll0: pll0@800 {
          #clock-cells = <1>;
          reg = <0x800 0x4>;
          compatible = "fsl,qoriq-core-pll-1.0";
          clocks = <&sysclk>;
          clock-output-names = "pll0", "pll0-div2";
  };

Here the value of the cells in a clock-specifier seem to be:
0: pll0
1: pll0-div2

So in a consumer, the valid values of the cells in a clock-specifier
are:

  consumer: device {
          compatible = "vendor,some-device";
          clocks = <&pll0 0>, /* pll0 */
                   <&pll0 1>; /* pll0-div2 */
  };

There must be some meaning assigned to the values of the cells in the
clock-specifier (e.g. linear index of the clock output in the hardware).
It would be good to describe this, other clock bindings do.

>
> > > +
> > > +Recommended properties:
> > > +- clocks: Should be the phandle of input parent clock
> > > +- clock-names: From common clock binding, indicates the clock name
> >
> > That description's a bit opaque.
> >
> > What's the name of the clock input on these units? That's what clock-
> > names should contain, and that should be documented.
> >
> Is it necessary to document these names since they are totally used
> by clock provider and clock consumer has no idea about them?

I'm not sure I follow -- clocks and clock-names are used by consumers.
They define which clocks are inputs to a consumer, and the names of the
clock inputs on the consumer:

  consumer@0xffff0000 {
          reg = <0xffff0000 0x1000>;
          compatible = "vendor,some-consumer";
          clocks = <&pl011 0>,
                   <&otherclock 43 22>,
                   <&pl011 1>;
          clock-names = "apb_pclk",
                        "pixel_clk",
                        "scanout_clk";
  };

Here the set of clock-names would be defined in the binding of the
consumer, based on the clock input names in the IP documentation -- they
tell the consumer which clock inputs on the consumer the clocks
described in clocks are wired in to, and describe nothing about output
of the provider. Using clock-names allows the set of clocks on an IP to
change over revisions and for some clock inputs to be optional.

>
> > Do we not _always_ need the parent clock?
> >
> Not for fixed-clock that its parent clock is oscillator :)

Certainly fixed-clock doesn't need any parent clock, but I guess PLLs
and muxes always do.

>
> > If we have a clock do we need a clock-names entry for it?
> >
> Technically yes, but I don't bother to add it if the clock node has
> only one clocks.

Ok. Where we only have one input clock, this doesn't need to be
described.

Do the mux clocks always take 3 input clocks (judging by the examples
they do)?

>
> > > +- clock-output-names: From common clock binding, indicates the names
> > of
> > > +       output clocks
> > > +- reg: Should be the offset and length of clock block base address.
> > > +       The length should be 4.
> > > +
> > > +Example for clock block and clock provider:
> > > +/ {
> > > +       clockgen: global-utilities@e1000 {
> > > +               compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-
> > 1.0";
> > > +               reg = <0xe1000 0x1000>;
> > > +               clock-frequency = <0>;
> >
> > That looks odd.
> >
> Yes, but it has already existed here before this patch.
> Can I move it to sysclk clock node since it is not used yet?

I hadn't realised there were DTS with this already. Why is there a clock
with clock-frequency = <0> at all? Surely that isn't useful...

>
> > > +               #address-cells = <1>;
> > > +               #size-cells = <1>;
> > > +
> > > +               sysclk: sysclk {
> > > +                       #clock-cells = <0>;
> > > +                       compatible = "fsl,qoriq-sysclk-1.0",
> > > + "fixed-clock";
> >
> > We didn't mention in the binding that "fsl,qoriq-sysclk-1.0" was
> > compatible with "fixed-clock" and should have "fixed-clock" in the
> > compatible list...
> >
> OK, will fix it.

Cheers. Also, doesn't a fixed-clock require a clock-frequency?

>
> > > +                       clock-output-names = "sysclk";
> > > +               }
> > > +
> > > +               pll0: pll0@800 {
> > > +                       #clock-cells = <1>;
> > > +                       reg = <0x800 0x4>;
> > > +                       compatible = "fsl,qoriq-core-pll-1.0";
> > > +                       clocks = <&sysclk>;
> > > +                       clock-output-names = "pll0", "pll0-div2";
> > > +               };
> > > +
> > > +               pll1: pll1@820 {
> > > +                       #clock-cells = <1>;
> > > +                       reg = <0x820 0x4>;
> > > +                       compatible = "fsl,qoriq-core-pll-1.0";
> > > +                       clocks = <&sysclk>;
> > > +                       clock-output-names = "pll1", "pll1-div2";
> > > +               };
> > > +
> > > +               mux0: mux0@0 {
> > > +                       #clock-cells = <0>;
> > > +                       reg = <0x0 0x4>;
> > > +                       compatible = "fsl,qoriq-core-mux-1.0";
> > > +                       clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>,
> > <&pll1 1>;
> > > +                       clock-names = "pll0_0", "pll0_1", "pll1_0",
> > "pll1_1";
> > > +                       clock-output-names = "cmux0";
> > > +               };
> > > +
> > > +               mux1: mux1@20 {
> > > +                       #clock-cells = <0>;
> > > +                       reg = <0x20 0x4>;
> > > +                       compatible = "fsl,qoriq-core-mux-1.0";
> > > +                       clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>,
> > <&pll1 1>;
> > > +                       clock-names = "pll0_0", "pll0_1", "pll1_0",
> > "pll1_1";

I didn't spot this last time, but the clock-names here seem to be the
names of the outputs from the provider, rather than the input names of
the consumer. This goes against the intended purpose of clock-names.

> > > +                       clock-output-names = "cmux1";
> >
> > How does the mux choose which input clock to use at a point in time?
> >
> That is decided at runtime. Different input clock will lead to the different
> Clock frequency that the CPUs work on.

Ok.

Cheers,
Mark.
