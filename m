Return-Path: <dgibson@ozlabs.org>
Date: Mon, 19 May 2008 10:53:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Remi Machet <rmachet@slac.stanford.edu>
Subject: Re: [PATCH 1/5 v2] powerpc: DTS file for the C2K
Message-ID: <20080519005342.GB24125@yookeroo.seuss>
References: <1210966129.14883.1.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1210966129.14883.1.camel@pcds-ts102.slac.stanford.edu>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 12:28:48PM -0700, Remi Machet wrote:
> Support for the C2K cPCI Single Board Computer from GEFanuc
> (PowerPC MPC7448 with a Marvell MV64460 chipset)
> All features of the board are not supported yet, but the board
> boots, flash works, all Ethernet ports are working and PCI 
> devices are all found (USB and SATA on PCI1 do not work yet).
> 
> Part 1 of 5: DTS file describing the board peripherals. As far as I know
> all peripherals except the FPGA are listed in there (I did not included
> the FPGA because a lot of work is needed there).

Looking pretty good, but a hanful more comments below.

[snip]
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "marvell,mv64360-mdio";

Surely this needs a "reg" property, otherwise how to you access the
mdio bus?

> +			PHY0: ethernet-phy@0 {
> +				device_type = "ethernet-phy";
> +				interrupts = <76>;	/* GPP 12 */
> +				interrupt-parent = <&PIC>;
> +				reg = <0>;
> +			};

[snip]
> +		CUNIT: cunit@f200 {
> +			reg = <0xf200 0x200>;
> +		};
> +
> +		MPSCROUTING: mpscrouting@b400 {
> +			reg = <0xb400 0xc>;
> +		};
> +
> +		MPSCINTR: mpscintr@b800 {
> +			reg = <0xb800 0x100>;
> +			virtual-reg = <0xd800b800>;
> +		};
> +
> +		MPSC0: mpsc@8000 {
> +			device_type = "serial";
> +			compatible = "marvell,mv64360-mpsc";
> +			reg = <0x8000 0x38>;
> +			virtual-reg = <0xd8008000>;
> +			sdma = <&SDMA0>;
> +			brg = <&BRG0>;
> +			cunit = <&CUNIT>;
> +			mpscrouting = <&MPSCROUTING>;
> +			mpscintr = <&MPSCINTR>;
> +			cell-index = <0>;

Heh.  The more I look at this, the more I suspect it should be
structured like the ethernet-group stuff.  Oh well, not your fault.

[snip]
> +		/* Devices attached to the device controller */
> +		devicebus {
> +			compatible = "marvell,mv64306-devctrl";
> +			#address-cells = <1>;
> +			#size-cells = <1>;

This looks like it needs either a "reg" or a "ranges" property.  If
the address space of this "devicebus" is the same as the parent bus
you need an empty "ranges" property.  *No* ranges property means the
subordinate devices can't be directly accessed at all from the parent
bus.

> +			nor_flash {

This needs a unit address, "nor_flash@f8000000".

> +				compatible = "cfi-flash";
> +				reg = <0xf8000000 0x8000000>; /* 128MB */
> +				bank-width = <4>;
> +				device-width = <1>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				partition@0 {
> +					label = "boot";
> +					reg = <0x00000000 0x00080000>;
> +				};
> +				partition@40000 {
> +					label = "kernel";
> +					reg = <0x00080000 0x00400000>;
> +				};
> +				partition@440000 {
> +					label = "initrd";
> +					reg = <0x00480000 0x00B80000>;
> +				};
> +				partition@1000000 {
> +					label = "rootfs";
> +					reg = <0x01000000 0x06800000>;
> +				};
> +				partition@7800000 {
> +					label = "recovery";
> +					reg = <0x07800000 0x00800000>;
> +					read-only;
> +				};
> +			};
> +		};
> +	};
> +	chosen {
> +		bootargs = "ip=off root=/dev/mtdblock3 rootfstype=jffs2";

You don't usually want to encode a default bootargs into the dts file;
kernel command line arguments should usually be left to the user.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
