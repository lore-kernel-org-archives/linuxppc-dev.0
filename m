Return-Path: <dgibson@ozlabs.org>
Date: Mon, 3 Dec 2007 12:50:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrei Dolnikov <adolnikov@ru.mvista.com>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
Message-ID: <20071203015018.GC26919@localhost.localdomain>
References: <20071129150726.GA13751@ru.mvista.com>
	<20071129152836.GB13751@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071129152836.GB13751@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 29, 2007 at 06:28:36PM +0300, Andrei Dolnikov wrote:
> Device tree source file for the Emerson Katana Qp board
> 
> Signed-off-by: Andrei Dolnikov <adolnikov@ru.mvisa.com>
> 
> ---
>  katanaqp.dts |  360 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 360 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/katanaqp.dts b/arch/powerpc/boot/dts/katanaqp.dts
> new file mode 100644
> index 0000000..98257a2
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/katanaqp.dts
> @@ -0,0 +1,360 @@
> +/* Device Tree Source for Emerson Katana Qp
> + *
> + * Authors: Vladislav Buzov <vbuzov@ru.mvista.com>
> + *	    Andrei Dolnikov <adolnikov@ru.mvista.com>
> + * 
> + * Based on prpmc8200.dts by Mark A. Greer <mgreer@mvista.com>
> + *
> + * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
> + * the terms of the GNU General Public License version 2.  This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + *
> + */
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	model = "Katana-Qp"; /* Default */
> +	compatible = "emerson,Katana-Qp";
> +	coherency-off;

What is this property for?

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,7448@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <0>;		/* From U-boot */
> +			bus-frequency = <0>;		/* From U-boot */
> +			timebase-frequency = <0>;	/* From U-boot */
> +			i-cache-line-size = <20>;
> +			d-cache-line-size = <20>;
> +			i-cache-size = <8000>;
> +			d-cache-size = <8000>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 00000000>;	/* Filled in by bootwrapper */
> +	};
> +
> +	mv64x60@f8100000 { /* Marvell Discovery */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		model = "mv64460";			/* Default */
> +		compatible = "marvell,mv64x60";

Compatible properties should not have "x" asn in 64x60 here.  If
there's a suitable name for the general register interface use that,
otherwise use the specific model number of the earliest device to
implement this register interface.  Later models should have a
compatible property which lists their specific model, followed by the
earlier model number with which they're compatible.

> +		clock-frequency = <7f28155>;		/* 133.333333 MHz */

You can use <d# 133333333> to avoid the ugly hex.

> +		reg = <f8100000 00010000>;
> +		virtual-reg = <f8100000>;
> +		ranges = <c1000000 c1000000 01000000	/* PCI 1 I/O Space */
> +			  90000000 90000000 30000000	/* PCI 1 MEM Space */
> +			  e8000000 e8000000 04000000	/* User FLASH: Up to 64Mb */
> +			  00000000 f8100000 00010000	/* Bridge's regs */
> +			  f8500000 f8500000 00040000>;	/* Integrated SRAM */

These ranges look kind of weird, but I'd have to think about them
harder to say something more specific.

> +		flash@e8000000 {
> +			compatible = "cfi-flash";
> +			reg = <e8000000 1000000>; /* Default (16MB) */
> +			probe-type = "CFI";

You're using the new-style binding (compatible == "cfi-flash"), so the
obsolete probe-tyope property should not be included.

> +			bank-width = <4>;
> +			
> +			partition@0 {
> +				label = "Primary Monitor";
> +				reg = <0 100000>; /* 1Mb */
> +				read-only;
> +			};
> +
> +			partition@100000 {
> +				label = "Primary Kernel";
> +				reg = <100000 200000>; /* 2 Mb */
> +			};
> +
> +			partition@300000 {
> +				label = "Primary FS";
> +				reg = <300000 d00000>; /* 13 Mb */
> +			};
> +
> +		};
> +
> +		mdio {

There must be some way of actuall accessing the mdio bus, so this node
ought to have a 'reg' property and unit address.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "marvell,mv64x60-mdio";
> +			ethernet-phy@0 {
> +				block-index = <0>;
> +				compatible = "marvell,mv88e1111";
> +				reg = <a>;
> +			};
> +			ethernet-phy@1 {
> +				compatible = "marvell,mv88e1111";
> +				block-index = <1>;
> +				reg = <d>;
> +			};
> +			ethernet-phy@2 {
> +				compatible = "marvell,mv88e1111";
> +				block-index = <2>;
> +				reg = <6>;
> +			};
> +		};
> +
> +		ethernet@2000 {
> +			reg = <2000 2000>;

Are the registers for the 3 ethernets really all together?  This bank
can't be subdivided into seperate register blocks for each MAC?

> +			eth0 {
> +				device_type = "network";
> +				compatible = "marvell,mv64x60-eth";
> +				block-index = <0>;

This block-index thing is crap.  If you really need to subindex nodes
like this, use "reg", with an appropriate #address-cells in the
parent, then the nodes will also get sensible unit addresses.

> +				interrupts = <20>;
> +				interrupt-parent = <&/mv64x60/pic>;

You should use a label for the PIC to make things more readable.

> +				phy = <&/mv64x60/mdio/ethernet-phy@0>;
> +				speed = <3e8>; 
> +				duplex = <1>; 
> +				tx_queue_size = <320>;
> +				rx_queue_size = <190>;
> +				local-mac-address = [ 00 00 00 00 00 00 ];
> +				/* Mac address filled in by bootwrapper */
> +			};
> +			eth1 {
> +				device_type = "network";
> +				compatible = "marvell,mv64x60-eth";
> +				block-index = <1>;
> +				interrupts = <21>;
> +				interrupt-parent = <&/mv64x60/pic>;
> +				phy = <&/mv64x60/mdio/ethernet-phy@1>;
> +				speed = <3e8>; 
> +				duplex = <1>; 
> +				tx_queue_size = <320>;
> +				rx_queue_size = <190>;
> +				local-mac-address = [ 00 00 00 00 00 00 ];
> +				/* Mac address filled in by bootwrapper */
> +			};
> +			eth2 {
> +				device_type = "network";
> +				compatible = "marvell,mv64x60-eth";
> +				block-index = <2>;
> +				interrupts = <22>;
> +				interrupt-parent = <&/mv64x60/pic>;
> +				phy = <&/mv64x60/mdio/ethernet-phy@2>;
> +				speed = <3e8>; 
> +				duplex = <1>; 
> +				tx_queue_size = <320>;
> +				rx_queue_size = <190>;
> +				local-mac-address = [ 00 00 00 00 00 00 ];
> +				/* Mac address filled in by bootwrapper */
> +			};
> +		};
> +
> +		sdma@4000 {
> +			compatible = "marvell,mv64x60-sdma";
> +			reg = <4000 c18>;
> +			virtual-reg = <f8104000>;

Why does this node have virtual-reg?

> +			interrupt-base = <0>;
> +			interrupts = <24>;
> +			interrupt-parent = <&/mv64x60/pic>;
> +		};
> +
> +		sdma@6000 {
> +			compatible = "marvell,mv64x60-sdma";
> +			reg = <6000 c18>;
> +			virtual-reg = <f8106000>;

And again.

> +			interrupt-base = <0>;
> +			interrupts = <26>;
> +			interrupt-parent = <&/mv64x60/pic>;
> +		};
> +
> +		brg@b200 {
> +			compatible = "marvell,mv64x60-brg";
> +			reg = <b200 8>;
> +			clock-src = <8>;
> +			clock-frequency = <7ed6b40>;
> +			current-speed = <2580>;
> +			bcr = <0>;
> +		};
> +
> +		brg@b208 {
> +			compatible = "marvell,mv64x60-brg";
> +			reg = <b208 8>;
> +			clock-src = <8>;
> +			clock-frequency = <7ed6b40>;
> +			current-speed = <2580>;
> +			bcr = <0>;
> +		};
> +
> +		cunit@f200 {
> +			reg = <f200 200>;
> +		};
> +
> +		mpscrouting@b400 {
> +			reg = <b400 c>;
> +		};
> +
> +		mpscintr@b800 {
> +			reg = <b800 100>;
> +			virtual-reg = <f810b800>;
> +		};
> +
> +		mpsc@8000 {
> +			device_type = "serial";
> +			compatible = "marvell,mpsc";
> +			reg = <8000 38>;
> +			virtual-reg = <f8108000>;
> +			sdma = <&/mv64x60/sdma@4000>;
> +			brg = <&/mv64x60/brg@b200>;
> +			cunit = <&/mv64x60/cunit@f200>;
> +			mpscrouting = <&/mv64x60/mpscrouting@b400>;
> +			mpscintr = <&/mv64x60/mpscintr@b800>;
> +			block-index = <0>;

What is this block-index thing about here?  Since the devices are
disambiguated by their register address, why do you need it?

> +			max_idle = <28>;
> +			chr_1 = <0>;
> +			chr_2 = <0>;
> +			chr_10 = <3>;
> +			mpcr = <0>;
> +			interrupts = <28>;
> +			interrupt-parent = <&/mv64x60/pic>;
> +		};
> +
> +		mpsc@9000 {
> +			device_type = "serial";
> +			compatible = "marvell,mpsc";
> +			reg = <9000 38>;
> +			virtual-reg = <f8109000>;
> +			sdma = <&/mv64x60/sdma@6000>;
> +			brg = <&/mv64x60/brg@b208>;
> +			cunit = <&/mv64x60/cunit@f200>;
> +			mpscrouting = <&/mv64x60/mpscrouting@b400>;
> +			mpscintr = <&/mv64x60/mpscintr@b800>;
> +			block-index = <1>;
> +			max_idle = <28>;
> +			chr_1 = <0>;
> +			chr_2 = <0>;
> +			chr_10 = <3>;
> +			mpcr = <0>;
> +			interrupts = <29>; 
> +			interrupt-parent = <&/mv64x60/pic>;
> +		};
> +
> +		wdt@b410 {			/* watchdog timer */
> +			compatible = "marvell,mv64x60-wdt";
> +			reg = <b410 8>;
> +			timeout = <a>;		/* wdt timeout in seconds */

Uh... that looks like it should be a configuration parameter, not a
device tree property.

> +		};
> +
> +		i2c@c000 {
> +			compatible = "marvell,mv64x60-i2c";
> +			reg = <c000 20>;
> +			virtual-reg = <f810c000>;
> +			freq_m = <8>;
> +			freq_n = <3>;
> +			timeout = <3e8>;		/* 1000 = 1 second */
> +			retries = <1>;
> +			interrupts = <25>;
> +			interrupt-parent = <&/mv64x60/pic>;
> +		};
> +
> +		pic {

Needs a unit address.

> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			compatible = "marvell,mv64x60-pic";
> +			reg = <0000 88>;
> +			interrupt-controller;
> +		};
> +
> +		mpp@f000 {
> +			compatible = "marvell,mv64x60-mpp";
> +			reg = <f000 10>;
> +		};
> +
> +		gpp@f100 {
> +			compatible = "marvell,mv64x60-gpp";
> +			reg = <f100 20>;
> +		};
> +
> +		pci@90000000 {
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			device_type = "pci";
> +			compatible = "marvell,mv64x60-pci";
> +			reg = <0c78 8>;
> +			ranges = <01000000 0        0 c1000000 0 01000000
> +				  02000000 0 90000000 90000000 0 30000000>;
> +			bus-range = <0 ff>;
> +			clock-frequency = <3EF1480>;
> +			interrupt-pci-iack = <0c34>;
> +			interrupt-parent = <&/mv64x60/pic>;
> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +				/* IDSEL 0x1 */
> +				0800 0 0 1 &/mv64x60/pic 5a
> +				0800 0 0 2 &/mv64x60/pic 5b
> +				0800 0 0 3 &/mv64x60/pic 5e
> +				0800 0 0 4 &/mv64x60/pic 5f
> +
> +				/* IDSEL 0x2 */
> +				1000 0 0 1 &/mv64x60/pic 5b
> +				1000 0 0 2 &/mv64x60/pic 5e
> +				1000 0 0 3 &/mv64x60/pic 5f
> +				1000 0 0 4 &/mv64x60/pic 5a
> +
> +				/* IDSEL 0x3 */
> +				1800 0 0 1 &/mv64x60/pic 5e
> +				1800 0 0 2 &/mv64x60/pic 5f
> +				1800 0 0 3 &/mv64x60/pic 5a
> +				1800 0 0 4 &/mv64x60/pic 5b
> +
> +				/* IDSEL 0x4 */
> +				2000 0 0 1 &/mv64x60/pic 5f
> +				2000 0 0 2 &/mv64x60/pic 5a
> +				2000 0 0 3 &/mv64x60/pic 5b
> +				2000 0 0 4 &/mv64x60/pic 5e
> +
> +				/* IDSEL 0x6 */
> +				3000 0 0 1 &/mv64x60/pic 5b
> +				3000 0 0 2 &/mv64x60/pic 5e
> +				3000 0 0 3 &/mv64x60/pic 5f
> +				3000 0 0 4 &/mv64x60/pic 5a
> +			>;
> +		};
> +
> +		cpu-error@0070 {

The unit address should notr include leading zeroes.

> +			compatible = "marvell,mv64x60-cpu-error";
> +			reg = <0070 10 0128 28>;
> +			interrupts = <03>;
> +			interrupt-parent = <&/mv64x60/pic>;
> +		};
> +
> +		sram-ctrl@0380 {
> +			compatible = "marvell,mv64x60-sram-ctrl";
> +			reg = <0380 80>;
> +			interrupts = <0d>;
> +			interrupt-parent = <&/mv64x60/pic>;
> +		};
> +
> +		pci-error@1d40 {
> +			compatible = "marvell,mv64x60-pci-error";
> +			reg = <1d40 40 0c28 4>;
> +			interrupts = <0c>;
> +			interrupt-parent = <&/mv64x60/pic>;
> +		};
> +
> +		mem-ctrl@1400 {
> +			compatible = "marvell,mv64x60-mem-ctrl";
> +			reg = <1400 60>;
> +			interrupts = <11>;
> +			interrupt-parent = <&/mv64x60/pic>;
> +		};
> +	};
> +
> +	cpld@f8200000 {
> +		compatible = "altera,maxii";
> +		reg = <f8200000 40000>;
> +		virtual-reg = <f8200000>;
> +	};
> +
> +	chosen {
> +		bootargs = "ip=on";
> +		linux,stdout-path = "/mv64x60@f8100000/mpsc@8000";
> +	};
> +};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
