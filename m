Return-Path: <Yuantian.Tang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B06212C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 13:01:03 +1100 (EST)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>, "mike.turquette@linaro.org"
 <mike.turquette@linaro.org>
Subject: RE: [PATCH v6] clk: corenet: Adds the clock binding
Date: Tue, 12 Nov 2013 02:00:54 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B150CB933@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1384162906-30730-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131111115202.GD21201@e106331-lin.cambridge.arm.com>
In-Reply-To: <20131111115202.GD21201@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +++ b/Documentation/devicetree/bindings/clock/corenet-clock.txt
> > @@ -0,0 +1,123 @@
> > +* Clock Block on Freescale CoreNet Platforms
> > +
> > +Freescale CoreNet chips take primary clocking input from the external
> > +SYSCLK signal. The SYSCLK input (frequency) is multiplied using
> > +multiple phase locked loops (PLL) to create a variety of frequencies
> > +which can then be passed to a variety of internal logic, including
> > +cores and peripheral IP blocks.
> > +Please refer to the Reference Manual for details.
> > +
> > +1. Clock Block Binding
> > +
> > +Required properties:
> > +- compatible: Should include one or more of the following:
>=20
> When you say "one or more", I assume you mean of the specific clock block
> strings, and then a chassis string?
>=20
> If so, it might be better to say smoething like:
>=20
> - compatible: Should contain a specific clock block compatible string
>   and a single chassis clock compatible string.
>=20
>   Clock block strings include:
>   * "fsl,p2041-clockgen"
>   * "fsl,p3041-clockgen"
>=20
>   Chassis clock strings include:
>   * "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
>   * "fsl,qoriq-clockgen-2.0": for chassis 2.0 clock
>=20
Sounds better.

> > +	* "fsl,<chip>-clockgen": for chip specific clock block, here chip
> > +		could be but not limited to one of the: p2041, p3041, p4080,
> > +		p5020, p5040, t4240, b4420, b4860
> > +	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
> > +	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
> > +	Notes that "fsl,qoriq-clockgen-1.0" and "fsl,qoriq-clockgen-2.0"
> > +	cannot be included simultaneously.
> > +- reg: Offset and length of the clock register set
> > +
> > +Recommended properties:
> > +- ranges: Allows valid translation between child's address space and
> > +	parent's. Must be present if the device has sub-nodes.
> > +- #address-cells: Specifies the number of cells used to represent
> > +	physical base addresses.  Must be present if the device has
> > +	sub-nodes and set to 1 if present
> > +- #size-cells: Specifies the number of cells used to represent
> > +	the size of an address. Must be present if the device has
> > +	sub-nodes and set to 1 if present
>=20
> Is there any particular reason these _must_ be 1?
>=20
They are one u32 variable long and no other options, so, they should be set=
 to 1.

> > +
> > +2. Clock Provider/Consumer Binding
> > +
> > +Most of the bindings are from the common clock binding[1].
> > + [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +Required properties:
> > +- compatible : Should include one of the following:
> > +	* "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
> > +    * "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
> > +    * "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
> > +    * "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
> > +	* "fsl,qoriq-sysclk-1.0": for input system clock (v1.0)
> > +	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0)
> > +- #clock-cells: From common clock binding; indicates the number of
> > +	output clock. 0 is for "fsl,qoriq-sysclk-[1,2].0" and
> > +	"fsl,qoriq-core-mux-[1,2].0"; 1 for "fsl,qoriq-core-pll-[1,2].0".
>=20
> Nit: #clock-cells defines the number of cells in a clock-specifier, not
> the number of output clocks. How about:
>=20
> - #clock-cells: The number of cells in a clock-specifier. Should be <0>
>   for "fsl,qoriq-sysclk-[1,2].0" clocks, or <1> for
>   "fsl,qoriq-core-pll-[1,2].0" clocks.
>=20
> > +	If #clock-cells has a value of 1, its clock consumer should specify
> > +	the desired clock by having the clock ID in its "clocks" phandle
> > +	cell. The following is a full list IDs:
>=20
> The ID is in the clock-specifier, not the phandle. How about the
> following instead:
>=20
> For "fsl,qoriq-core-pll-[1,2].0" clocks, the single clock-specifier cell
> may take the following values:
>=20
OK, thanks.

> > +	* 0 - equal to the PLL frequency
> > +	* 1 - equal to the PLL frequency divided by 2
> > +	* 2 - equal to the PLL frequency divided by 4
> > +
> > +Recommended properties:
> > +- clocks: Should be the phandle of input parent clock
> > +- clock-names: From common clock binding, indicates the clock name
>=20
> Is this not well defined and common across all of the clocks? The set of
> inputs they have must be well known, and if it isn't then this property
> isn't all that useful.
>=20
> > +- clock-output-names: From common clock binding, indicates the names
> of
> > +	output clocks
>=20
> Similarly, I'd expect that there might be well defined output names.
>=20
The clock-output-names and clock-names vary both from nodes to nodes and
from platforms to platforms. There is no general rules to define it.
I think the *-names properties should be added easily by following the exam=
ple below.

> > +- reg: Should be the offset and length of clock block base address.
> > +	The length should be 4.
> > +
> > +Example for clock block and clock provider:
> > +/ {
> > +	clockgen: global-utilities@e1000 {
> > +		compatible =3D "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> > +		ranges =3D <0x0 0xe1000 0x1000>;
> > +		reg =3D <0xe1000 0x1000>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +
> > +		sysclk: sysclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fsl,qoriq-sysclk-1.0";
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
>=20
> The binding documentation for clock-output-names describes clock-output-
> names as the name of the clock output signals. I understand this as
> meaning name of the output with respect to the clock, rather than a
> global namespace, but I may be mistaken there. Mike?
>=20
> Given that I'd expect pll0 and pll1 to have the same set of clock-output-
> names, (perhaps "pll", "pll-div2") as they seem to be instances of the
> same HW block. As far as I am aware the precise instance shouldn't affect
> the name (unless the documentation for the HW have these logical output
> names?).
>=20
These names will be used to register clock in driver, so it should be uniqu=
e globally.
So...

> > +
> > +		mux0: mux0@0 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x0 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0", "pll0-div2", "pll1", "pll1-div2";
> > +			clock-output-names =3D "cmux0";
> > +		};
>=20
> I have a similar worry here with regards to the clock-names, but I guess
> it doesn't really matter here if the documentation doesn't provide any
> better names for the inputs to the mux.
>=20
> However for the output name I'd expect just "cmux".
>=20
Same as above, cmux is not unique if we have multiple MUXes.

Thanks,
Yuantian

> Thanks,
> Mark,
>=20
> > +
> > +		mux1: mux1@20 {
> > +			#clock-cells =3D <0>;
> > +			reg =3D <0x20 0x4>;
> > +			compatible =3D "fsl,qoriq-core-mux-1.0";
> > +			clocks =3D <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
> > +			clock-names =3D "pll0", "pll0-div2", "pll1", "pll1-div2";
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
> > --
> > 1.8.0
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
