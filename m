Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 May 2008 11:53:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Remi Machet <rmachet@slac.stanford.edu>
Subject: Re: [PATCH 1/5] powerpc: DTS file for the C2K
Message-ID: <20080516015354.GA27188@yookeroo.seuss>
References: <1210897371.13992.13.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1210897371.13992.13.camel@pcds-ts102.slac.stanford.edu>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 15, 2008 at 05:22:50PM -0700, Remi Machet wrote:
> Support for the C2K cPCI Single Board Computer from GEFanuc
> (PowerPC MPC7448 with a Marvell MV64460 chipset)
> All features of the board are not supported yet, but the board
> boots, flash works, all Ethernet ports are working and PCI 
> devices are all found (USB and SATA on PCI1 do not work yet).
> 
> Part 1 of 5: DTS file describing the board peripherals. As far as I know
> all peripherals except the FPGA are listed in there (I did not included
> the FPGA because a lot of work is needed there).
> 
> Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
> ---
>  c2k.dts |  353 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 353 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/c2k.dts b/arch/powerpc/boot/dts/c2k.dts
> new file mode 100644
> index 0000000..21281b8
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/c2k.dts
> @@ -0,0 +1,353 @@
> +/* Device Tree Source for GEFanuc C2K
> + *
> + * Author: Remi Machet <rmachet@slac.stanford.edu>
> + * 
> + * Originated from prpmc2800.dts
> + *
> + * 2008 (c) Stanford University
> + * 2007 (c) MontaVista, Software, Inc.  
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	model = "C2K";
> +	compatible = "GEFanuc,C2K";
> +	coherency-off;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,7447 {

This needs a unit address.  So, either "PowerPC,7447@0" or simply
"cpu@0".  The latter is the newer convention, but if you do that you
should add a compatible property listing "PowerPC,7447".

[snip]
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";

Remove this device_type.

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

These devices should really have compatible properties, but that's
not really your problem, it needs to be addressed by whoever's
responsible for the mpsc binding.

[snip]
> +		i2c@c000 {
> +			device_type = "i2c";

Remove this device_type.

[snip]
> +		PCI0: pci@80000000 {
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			device_type = "pci";
> +			compatible = "marvell,mv64360-pci";
> +			cell-index = <0>;

This is a suspicious looking use of cell-index, though again this
could be a problem in the binding rather than your tree per se.
cell-index should *only* be present if it's used to index into some
shared resource register.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
