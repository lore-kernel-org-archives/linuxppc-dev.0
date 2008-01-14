Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 Jan 2008 10:34:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 3/4] powerpc: Katana750i - Add DTS file
Message-ID: <20080114233406.GB20649@localhost.localdomain>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<20080114225926.GB22862@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080114225926.GB22862@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 14, 2008 at 03:59:26PM -0700, Mark A. Greer wrote:
> From: Mark A. Greer <mgreer@mvista.com>
> 
> Add DTS file for the Emerson Katana 750i & 752i platforms.

[snip]
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	model = "Katana-75xi";	/* Default */
> +	compatible = "emerson,katana-750i";
> +	coherency-off;

Where is this flag used from?

> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,750 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <733333333>;		/* Default */
> +			bus-frequency = <133333333>;		/* Default */
> +			timebase-frequency = <33333333>;	/* Default */
> +			i-cache-line-size = <0x20>;
> +			d-cache-line-size = <0x20>;
> +			i-cache-size = <0x8000>;
> +			d-cache-size = <0x8000>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x04000000>;	/* Default (64MB) */
> +	};
> +
> +	mv64x60@f8100000 { /* Marvell Discovery */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		model = "mv64360";	/* Default */
> +		compatible = "marvell,mv64360";
> +		clock-frequency = <133333333>;
> +		hs_reg_valid;
> +		reg = <0xf8100000 0x00010000>;
> +		virtual-reg = <0xf8100000>;

You seem to have virtual-reg properties on a *lot* of nodes, are they
really necessary?  virtual-reg should be used *only* for things which
you need to access very early in the bootwrapper.  Usually that's only
the serial port for the console.  Come to that, the CPU is a 750 which
has a real mode, so it seems dubious that you would need any
virtual-reg values at all.

[snip]
> +		flash@e8000000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "cfi-flash";
> +			bank-width = <4>;
> +			device-width = <2>;
> +			reg = <0xe8000000 0x04000000>;
> +			monitor@0 {
> +				label = "Monitor";

If you're using the "label" property, it would be normal to name the
nodes simply "partition@address".

> +				reg = <0x00000000 0x00100000>;
> +			};
> +			pkernel@100000 {
> +				label = "Primary Kernel";
> +				reg = <0x00100000 0x00180000>;
> +			};
> +			pfs@280000 {
> +				label = "Primary Filesystem";
> +				reg = <0x00280000 0x01e00000>;
> +			};
> +			skernel@2080000 {
> +				label = "Secondary Kernel";
> +				reg = <0x02080000 0x00180000>;
> +			};
> +			sfs@2200000 {
> +				label = "Secondary Filesystem";
> +				reg = <0x02200000 0x01e00000>;
> +			};
> +			user@100000 { /* overlay all but monitor */
> +				label = "User FLASH";
> +				reg = <0x00100000 0x03f00000>;
> +			};
> +		};
> +
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";

This device_type value should not be here.

> +			compatible = "marvell,mv64360-mdio";
> +			PHY0: ethernet-phy@12 {
> +				device_type = "ethernet-phy";
> +				compatible = "broadcom,bcm5461";
> +				reg = <12>;
> +			};
> +			PHY1: ethernet-phy@11 {
> +				device_type = "ethernet-phy";
> +				compatible = "broadcom,bcm5461";
> +				reg = <11>;
> +			};
> +			PHY2: ethernet-phy@4 {
> +				device_type = "ethernet-phy";
> +				compatible = "broadcom,bcm5461";
> +				reg = <4>;
> +			};
> +		};
> +
> +		multiethernet@2000 {

This needs some sort of "compatible" value.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2000 0x2000>;
> +			ethernet@0 {

[snip]
> +		CUNIT: cunit@f200 {

What is this device?  It needs some sort of "compatible" value.

> +			reg = <0xf200 0x200>;
> +		};
> +
> +		MPSCROUTING: mpscrouting@b400 {

Ditto.

> +			reg = <0xb400 0xc>;
> +		};
> +
> +		MPSCINTR: mpscintr@b800 {

Ditto.

> +			reg = <0xb800 0x100>;
> +			virtual-reg = <0xf810b800>;
> +		};

[snip]
> +		i2c@c000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "i2c";

This device_type value shouldn't be here either.

> +			compatible = "marvell,mv64360-i2c";
> +			reg = <0xc000 0x20>;
> +			virtual-reg = <0xf810c000>;
> +			freq_m = <8>;
> +			freq_n = <3>;
> +			interrupts = <37>;
> +			interrupt-parent = <&PIC>;
> +			rtc@68 {
> +				compatible = "dallas,ds1307";
> +				reg = <0x68>;
> +			};
> +		};

[snip]
> +		mpp@f000 {
> +			compatible = "marvell,mv64360-mpp";
> +			reg = <0xf000 0x10>;
> +		};
> +
> +		gpp@f100 {
> +			compatible = "marvell,mv64360-gpp";
> +			reg = <0xf100 0x20>;
> +		};

What are these two devices?

> +		pci@80000000 {
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			device_type = "pci";
> +			compatible = "marvell,mv64360-pci";
> +			cell-index = <1>;
> +			reg = <0x0c78 0x8>;
> +			ranges = <0x01000000 0x0 0x0
> +					0xb0000000 0x0 0x04000000
> +				  0x02000000 0x0 0x80000000
> +					0x80000000 0x0 0x30000000>;
> +			bus-range = <0x0 0xff>;
> +			clock-frequency = <66000000>;
> +			interrupt-pci-iack = <0x0cb4>;
> +			interrupt-parent = <&PIC>;
> +			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> +			interrupt-map = <
> +				/* IDSEL 0x04 - PMC 1 */
> +				0x2000 0 0 1 &PIC 73
> +				0x2000 0 0 2 &PIC 74
> +				0x2000 0 0 3 &PIC 78
> +				0x2000 0 0 4 &PIC 72
> +
> +				/* IDSEL 0x05 - PMC 2 */
> +				0x2800 0 0 1 &PIC 74
> +				0x2800 0 0 2 &PIC 78
> +				0x2800 0 0 3 &PIC 72
> +				0x2800 0 0 4 &PIC 73
> +
> +				/* IDSEL 0x06 - T8110 */
> +				0x3000 0 0 1 &PIC 78
> +
> +				/* IDSEL 0x08 - i82544 */
> +				0x4000 0 0 1 &PIC 78
> +			>;
> +		};
> +
> +		pci@f8080000 { /* Required to acces Hotswap register */
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			device_type = "pci";
> +			compatible = "marvell,mv64360-pci";
> +			cell-index = <0>;
> +			reg = <0x0cf8 0x8>;
> +			ranges = <0x01000000 0x0 0x0
> +					0xf8080000 0x0 0x00010000
> +				  0x02000000 0x0 0xf8090000
> +					0xf8090000 0x0 0x00010000>;
> +			bus-range = <0x0 0xff>;

Two PCI bridges with identical bus-range values seems potentially
problematic...

> +		};

[snip]
> +	chosen {
> +		bootargs = "ip=on";

The dts file should not include a "bootargs" value.  The wrapper will
fill that in from the kernel config.

> +		linux,stdout-path = "/mv64x60@f8100000/mpsc@8000";
> +	};
> +};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
