Return-Path: <dgibson@ozlabs.org>
Date: Wed, 12 Sep 2007 13:11:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070912031132.GC20218@localhost.localdomain>
References: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 02:37:56PM -0500, Kumar Gala wrote:
> Added basic board port for MPC8572 DS reference platform that is
> similiar to the MPC8544/33 DS reference platform in uniprocessor mode.
> 
> ---
> 
> Rev 3 -- updates to the device tree based on discussion on how we want
> to handle memory busses going forward.

[snip]
> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";

I don't think we actually have an mdio device_type binding defined.


> +			compatible = "gianfar";

This needs to be more specific.  And it certainly shouldn't be the
same compatible string as the ethernet MACs have.

> +			reg = <24520 20>;
> +			phy0: ethernet-phy@0 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <a 1>;
> +				reg = <0>;
> +				device_type = "ethernet-phy";

Do we actually have an ethernet-phy device_type binding?  If not, we
should kill this.  'compatible' properties for phys would probably be
a good idea, though (giving the actual phy model).

> +			};
> +			phy1: ethernet-phy@1 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <a 1>;
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy2: ethernet-phy@2 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <a 1>;
> +				reg = <2>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy3: ethernet-phy@3 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <a 1>;
> +				reg = <3>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <24000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <1d 2 1e 2 22 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy0>;
> +			phy-connection-type = "rgmii-id";
> +		};
> +
> +		ethernet@25000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <25000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <23 2 24 2 28 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy1>;
> +			phy-connection-type = "rgmii-id";
> +		};
> +
> +		ethernet@26000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <26000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <1f 2 20 2 21 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy2>;
> +			phy-connection-type = "rgmii-id";
> +		};
> +
> +		ethernet@27000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <27000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <25 2 26 2 27 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy3>;
> +			phy-connection-type = "rgmii-id";
> +		};


> +
> +		serial@4500 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4500 100>;
> +			clock-frequency = <0>;
> +			interrupts = <2a 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		serial@4600 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4600 100>;
> +			clock-frequency = <0>;
> +			interrupts = <2a 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		global-utilities@e0000 {	//global utilities block
> +			compatible = "fsl,mpc8548-guts";

Hrm... this should have "fsp,mpc8572-guts" in addition to the older
model with which it is compatible.

> +			reg = <e0000 1000>;
> +			fsl,has-rstcr;
> +		};
> +
> +		mpic: pic@40000 {
> +			clock-frequency = <0>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <40000 40000>;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +			big-endian;
> +		};
> +	};
> +
> +	pcie@ffe08000 {
> +		compatible = "fsl,mpc8548-pcie";

And again, "fsl,mpc8572-pcie", "fsl,mpc8548-pcie".

> +		device_type = "pci";
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		reg = <ffe08000 1000>;
> +		bus-range = <0 ff>;
> +		ranges = <02000000 0 80000000 80000000 0 20000000
> +			  01000000 0 00000000 ffc00000 0 00010000>;
> +		clock-frequency = <1fca055>;
> +		interrupt-parent = <&mpic>;
> +		interrupts = <18 2>;
> +		interrupt-map-mask = <fb00 0 0 0>;
> +		interrupt-map = <
> +			/* IDSEL 0x11 - PCI slot 1 */
> +			8800 0 0 1 &mpic 2 1
> +			8800 0 0 2 &mpic 3 1
> +			8800 0 0 3 &mpic 4 1
> +			8800 0 0 4 &mpic 1 1
> +
> +			/* IDSEL 0x12 - PCI slot 2 */
> +			9000 0 0 1 &mpic 3 1
> +			9000 0 0 2 &mpic 4 1
> +			9000 0 0 3 &mpic 1 1
> +			9000 0 0 4 &mpic 2 1
> +
> +			// IDSEL 0x1c  USB
> +			e000 0 0 0 &i8259 c 2
> +			e100 0 0 0 &i8259 9 2
> +			e200 0 0 0 &i8259 a 2
> +			e300 0 0 0 &i8259 b 2
> +
> +			// IDSEL 0x1d  Audio
> +			e800 0 0 0 &i8259 6 2
> +
> +			// IDSEL 0x1e Legacy
> +			f000 0 0 0 &i8259 7 2
> +			f100 0 0 0 &i8259 7 2
> +
> +			// IDSEL 0x1f IDE/SATA
> +			f800 0 0 0 &i8259 e 2
> +			f900 0 0 0 &i8259 5 2
> +
> +			>;
> +		uli1575@0 {
> +			reg = <0 0 0 0 0>;

This looks kind of bogus...

> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			ranges = <02000000 0 80000000
> +				  02000000 0 80000000
> +				  0 20000000
> +				  01000000 0 00000000
> +				  01000000 0 00000000
> +				  0 00100000>;
> +
> +			pci_bridge@0 {

Ok.. why is pci_bridge nested within uli1575 - with the matching reg
and ranges, it looks like they ought to be one device.  Also if this
is a PCI<->PCI bridge, I believe it shold have device_type = "pci".

> +				reg = <0 0 0 0 0>;
> +				#size-cells = <2>;
> +				#address-cells = <3>;
> +				ranges = <02000000 0 80000000
> +					  02000000 0 80000000
> +					  0 20000000
> +					  01000000 0 00000000
> +					  01000000 0 00000000
> +					  0 00100000>;
> +
> +				isa@1e {
> +					device_type = "isa";
> +					#interrupt-cells = <2>;
> +					#size-cells = <1>;
> +					#address-cells = <2>;
> +					reg = <f000 0 0 0 0>;
> +					ranges = <1 0 01000000 0 0
> +						  00001000>;
> +					interrupt-parent = <&i8259>;
> +
> +					i8259: interrupt-controller@20 {
> +						reg = <1 20 2
> +						       1 a0 2
> +						       1 4d0 2>;
> +						clock-frequency = <0>;

Hrm.. what is clock-frequency for on an i8259?  I see that other 8259
descriptions have this as well, so it's not a problem with this patch
specifically.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
