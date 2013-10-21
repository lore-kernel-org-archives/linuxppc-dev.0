Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id B62DC2C0196
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 20:14:59 +1100 (EST)
Date: Mon, 21 Oct 2013 10:14:49 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
Message-ID: <20131021091448.GA6435@kartoffel>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150C24FA@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B150C24FA@039-SN2MPN1-013.039d.mgd.msft.net>
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

On Sat, Oct 12, 2013 at 04:40:06AM +0100, Tang Yuantian-B29983 wrote:
> Thanks for your review.
> 
> >
> > >
> > > > > +- reg: Offset and length of the clock register set
> > > > > +- clock-frequency: Indicates input clock frequency of clock block.
> > > > > +       Will be set by u-boot
> > > >
> > > > Why does the fact this is set by u-boot matter to the binding?
> > > >
> > > OK, I will remove it.
> > >
> > > > > +
> > > > > +Recommended properties:
> > > > > +- #ddress-cells: Specifies the number of cells used to represent
> > > > > +       physical base addresses.  Must be present if the device has
> > > > > +       sub-nodes and set to 1 if present
> > > >
> > > > Typo: #address-cells
> > > >
> > > > In the example it looks like the address cells of child nodes are
> > > > offsets within the unit, rather than absolute physical addresses.
> > > > Could the code not treat them as absolute addresses? Then we'd only
> > > > need to document that #address-cells, #size-cells and ranges must be
> > > > present and have values suitable for mapping child nodes into the
> > > > address space of the parent.
> > > >
> > > OK, thanks.
> > >
> > > > > +- #size-cells: Specifies the number of cells used to represent
> > > > > +       the size of an address. Must be present if the device has
> > > > > +       sub-nodes and set to 1 if present
> > > >
> > > > It's not really the size of an address, it's the size of a region
> > > > identified by a reg entry.
> > > >
> > > > I think this can be simplified by my suggestion above.
> > > >
> > > Yes
> >
> > Aah, I see that this is already in use, so it's a bit late to change
> > this...
> >
> I will modify the driver anyway once the binding gets done.

Won't this break existing users DTBs?

> 
> > >
> > > > > +
> > > > > +2. Clock Provider/Consumer Binding
> > > > > +
> > > > > +Most of the binding are from the common clock binding[1].
> > > > > + [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > > +
> > > > > +Required properties:
> > > > > +- compatible : Should include one or more of the following:
> >
> > I didn't spot this earlier, but why "one or more"? are the 2.0 variants
> > backwards compatible with the 1.0 variants.
> >
> One or more for fixed-clock which is compatible with qoriq-sysclk-*.

This may be somewhat pedantic, but an element from the list plus fixed-clock
isn't one or more of the following. It's one of the following plus fixed-clock.

It may be better to explicitly state that the compatible list must include one
of the following, plus fixed-clock.

> 
> > > > > +       - "fsl,qoriq-core-pll-[1,2].x": Indicates a core PLL clock
> > > > device
> > > > > +       - "fsl,qoriq-core-mux-[1,2].x": Indicates a core
> > > > > + multiplexer
> > > > clock
> > > > > +               device; divided from the core PLL clock
> > > >
> > > > As above, I'd prefer a complete list of the basic strings we expect.
> > > >
> > > There is no list here, just *-mux-1.x and *-mux-2.x What kind of list
> > > do you prefer?
> >
> > Something like:
> >
> > - compatible: Should include at least one of:
> >     * "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
> >     * "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
> >     * "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
> >     * "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
> >   The *-2.0 variants are backwards compatible with the *-1.0 variants,
> >   so for compatiblity a *-1.0 variant string should be in the list.
> >
> See the comment by Scott wood.

OK. The note at the bottom cna go, but I'd still prefer an explicit list with a
description of each entry.

> 
> > >
> > > > > +       - "fixed-clock": From common clock binding; indicates
> > > > > + output
> > > > clock
> > > > > +               of oscillator
> > > > > +       - "fsl,qoriq-sysclk-[1,2].x": Indicates input system clock
> > > >
> > > > Here too.
> > > >
> > > > > +- #clock-cells: From common clock binding; indicates the number of
> > > > > +       output clock. 0 is for one output clock; 1 for more than
> > > > > +one clock
> > > >
> > > > If a clock source has multiple outputs, what those outputs are and
> > > > what values in clock-cells they correspond to should be described
> > here.
> > > >
> > > There is no way to describe the values of multiple outputs here.
> > > This property is the type of BOOL. See the clock-bindings.txt.
> >
> > Sorry? #clock-cells is most definitely _not_ a bool:
> >
> ACTs like bool.

No it does not act like boo, a nd only appears to if you do not consider the
general casel. In general #clock-cells could be any arbitrarily large number,
not just <0> or <1>. It represents the number of cells in a clock-specifier,
not simply that there is a clock-specifier.

It's perfectly possible to have #clock-cells = <2>, or more. It' perfectly
possible to have a DT like the below (with some properties omitted for
brevity):

  clk_2: some-clock {
          compatible = "vendor,banked-clock";
          #clock-cells = <2>;
  };

  clk_5: other-clock {
          #clock-cells = <5>;
  };

  clk_0: another-clock {
          #clock-cells = <0>;
  };

  consumer {
          clocks = <&clk5 0 17 53 91 0>,
                   <&clk_0>,
                   <&clk2 3 17>;
  };

In all of these cases, the cells in the clock-specifier must mean something.
They uniquely identify a clock output of the clock provider, and there must be
a way of mapping them to a particular clock.

The meaning of the cells in the clock specifier should be specified. Consider
"vendor,banked-clock". It's binding could look something like:

  - compatible: should contain
      * "vendor,banked-clock" for v1 banked clock designs
  - #clock-cells: Should be <2>
      * The first cell selects the internal clock bank, indexed [1,3]
      * The second cell selects a clock within the bank, indexed [0,25]

A clock might have a set of named outputs:

  - #clock-cells: should be <1>, a single cell which may be one of the following:
      * 0 - REFCLKOUT
      * 1 - PLLCLKOUT
      * 5 - LOWPWRCLKOUT

A clock provider might have a contiguous (or discontiguous) set of clock indexes:

  - #clock-cells: should be <1>. The clock index as per the documentation, in the range [0,15].

I hope this clears up the confusion on what I am asking for.

> 
> > 17: #clock-cells:      Number of cells in a clock specifier; Typically 0
> > for nodes
> > 18:                    with a single clock output and 1 for nodes with
> > multiple
> > 19:                    clock outputs.
> >
> > And neither are the clock-specifiers encoded with those cells. Consider:
> >
> >   pll0: pll0@800 {
> >           #clock-cells = <1>;
> >           reg = <0x800 0x4>;
> >           compatible = "fsl,qoriq-core-pll-1.0";
> >           clocks = <&sysclk>;
> >           clock-output-names = "pll0", "pll0-div2";
> >   };
> >
> > Here the value of the cells in a clock-specifier seem to be:
> > 0: pll0
> > 1: pll0-div2
> >
> > So in a consumer, the valid values of the cells in a clock-specifier
> > are:
> >
> >   consumer: device {
> >           compatible = "vendor,some-device";
> >           clocks = <&pll0 0>, /* pll0 */
> >                    <&pll0 1>; /* pll0-div2 */
> >   };
> >
> > There must be some meaning assigned to the values of the cells in the
> > clock-specifier (e.g. linear index of the clock output in the hardware).
> > It would be good to describe this, other clock bindings do.
> >
> Sorry, I still get what you mean. There is no INDEX at all.
> 0 is for one output, 1 for multiple output. Just like that.
> What the " other clock bindings" did you refer to?

Take a look at Documentation/devicetree/bindings/clock/imx23-clock.txt, which
specifies each clock output by name. You can also take a look at the tegra
clock bindings, which define the set of clocks by reference to a device tree
header file.

> 
> > >
> > > > > +
> > > > > +Recommended properties:
> > > > > +- clocks: Should be the phandle of input parent clock
> > > > > +- clock-names: From common clock binding, indicates the clock
> > > > > +name
> > > >
> > > > That description's a bit opaque.
> > > >
> > > > What's the name of the clock input on these units? That's what
> > > > clock- names should contain, and that should be documented.
> > > >
> > > Is it necessary to document these names since they are totally used by
> > > clock provider and clock consumer has no idea about them?
> >
> > I'm not sure I follow -- clocks and clock-names are used by consumers.
> > They define which clocks are inputs to a consumer, and the names of the
> > clock inputs on the consumer:
> >
> >   consumer@0xffff0000 {
> >           reg = <0xffff0000 0x1000>;
> >           compatible = "vendor,some-consumer";
> >           clocks = <&pl011 0>,
> >                    <&otherclock 43 22>,
> >                    <&pl011 1>;
> >           clock-names = "apb_pclk",
> >                         "pixel_clk",
> >                         "scanout_clk";
> >   };
> >
> > Here the set of clock-names would be defined in the binding of the
> > consumer, based on the clock input names in the IP documentation -- they
> > tell the consumer which clock inputs on the consumer the clocks described
> > in clocks are wired in to, and describe nothing about output of the
> > provider. Using clock-names allows the set of clocks on an IP to change
> > over revisions and for some clock inputs to be optional.
> >
> OK, I get it. Will name the clock-names better, and add it if missed.
> Thanks,

Cheers.

[...]

> > > > > +               #address-cells = <1>;
> > > > > +               #size-cells = <1>;
> > > > > +
> > > > > +               sysclk: sysclk {
> > > > > +                       #clock-cells = <0>;
> > > > > +                       compatible = "fsl,qoriq-sysclk-1.0",
> > > > > + "fixed-clock";
> > > >
> > > > We didn't mention in the binding that "fsl,qoriq-sysclk-1.0" was
> > > > compatible with "fixed-clock" and should have "fixed-clock" in the
> > > > compatible list...
> > > >
> > > OK, will fix it.
> >
> > Cheers. Also, doesn't a fixed-clock require a clock-frequency?
> >
> Yes, it should be. But we got the clock-frequency from parent node because
> There is a clock-frequency already there before this patch.

OK. Should we not place it there for future? We're not compatible with
fixed-clock if we don't fulfil the minimum requirements of the fixed-clock
binding...

> 
> > >
> > > > > +                       clock-output-names = "sysclk";
> > > > > +               }
> > > > > +
> > > > > +               pll0: pll0@800 {
> > > > > +                       #clock-cells = <1>;
> > > > > +                       reg = <0x800 0x4>;
> > > > > +                       compatible = "fsl,qoriq-core-pll-1.0";
> > > > > +                       clocks = <&sysclk>;
> > > > > +                       clock-output-names = "pll0", "pll0-div2";
> > > > > +               };
> > > > > +
> > > > > +               pll1: pll1@820 {
> > > > > +                       #clock-cells = <1>;
> > > > > +                       reg = <0x820 0x4>;
> > > > > +                       compatible = "fsl,qoriq-core-pll-1.0";
> > > > > +                       clocks = <&sysclk>;
> > > > > +                       clock-output-names = "pll1", "pll1-div2";
> > > > > +               };
> > > > > +
> > > > > +               mux0: mux0@0 {
> > > > > +                       #clock-cells = <0>;
> > > > > +                       reg = <0x0 0x4>;
> > > > > +                       compatible = "fsl,qoriq-core-mux-1.0";
> > > > > +                       clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>,
> > > > <&pll1 1>;
> > > > > +                       clock-names = "pll0_0", "pll0_1",
> > > > > + "pll1_0",
> > > > "pll1_1";
> > > > > +                       clock-output-names = "cmux0";
> > > > > +               };
> > > > > +
> > > > > +               mux1: mux1@20 {
> > > > > +                       #clock-cells = <0>;
> > > > > +                       reg = <0x20 0x4>;
> > > > > +                       compatible = "fsl,qoriq-core-mux-1.0";
> > > > > +                       clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>,
> > > > <&pll1 1>;
> > > > > +                       clock-names = "pll0_0", "pll0_1",
> > > > > + "pll1_0",
> > > > "pll1_1";
> >
> > I didn't spot this last time, but the clock-names here seem to be the
> > names of the outputs from the provider, rather than the input names of
> > the consumer. This goes against the intended purpose of clock-names.
> >
> I am confused here with provider/consumer because some nodes can both be consumer and provider.
> The clock-names are corresponding to clocks one by one, what's wrong with it?

We have clock-names for a consumer's names of its inputs, and
clock-output-names for a provider's names of it's outputs.

Consider a PLL device which takes a clock input (REFCLK) and outputs a higher
frequency clock (OUTCLK). The PLL's specification only talks in terms of REFCLK
and OUTCLK, but these are not the names of the clocks as they are output from
the original clock, or provided to the final consumer.

Consider a sequence of these PLLs plugged together. The OUTCLK of one feeds
into the REFCLK of the next:

fixed: fixed-clock {
        compatible = "fixed-clock";
        clock-frequency = <50>;
};

pll_0: pll {
        compatible = "vendor,pll";
        clocks = <&fixed>;
        clock-names = "refclk";
        clock-output-names = "outclk";
};

pll_1: another-pll {
        compatible = "vendor,pll";
        clocks = <&pll_0>;
        clock-names = "refclk";
        clock-output-names = "outclk";
};

consumer {
        compatible = "vendor,clock-consumer";
        clocks = <&pll_1>,
                 <&pll_0>;
        clock-names = "halfclk", "fullclk";
};

In each case, clock-names describes the clock inputs from the view of the PLL
they are input to, not from the provider they came from, or the consumer some
outputs are going to. Giving the inputs names in this way makes it possible to
describe situations where onlya subset of clock inputs are wired up -- we could
just have "fullclk" on the final consumer, with only pll_0 as an input, and the
driver could figure out what to do.

Does that help?

Thanks,
Mark.
