Return-Path: <dgibson@ozlabs.org>
Date: Wed, 1 Aug 2007 12:08:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070801020836.GB31391@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070730150648.GA5005@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2007 at 07:06:48PM +0400, Valentine Barshak wrote:
> AMCC Sequoia board DTS
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/sequoia.dts |  292 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 292 insertions(+)
> 
> diff -ruN linux.orig/arch/powerpc/boot/dts/sequoia.dts linux/arch/powerpc/boot/dts/sequoia.dts
> --- linux.orig/arch/powerpc/boot/dts/sequoia.dts	1970-01-01 03:00:00.000000000 +0300
> +++ linux/arch/powerpc/boot/dts/sequoia.dts	2007-07-27 20:44:26.000000000 +0400
> @@ -0,0 +1,292 @@
> +/*
> + * Device Tree Source for AMCC Sequoia
> + *
> + * Based on Bamboo code by Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + * Copyright (c) 2006, 2007 IBM Corp.
> + *
> + * FIXME: Draft only!
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without
> + * any warranty of any kind, whether express or implied.
> + *
> + * To build:
> + *   dtc -I dts -O asm -o bamboo.S -b 0 sequoia.dts
> + *   dtc -I dts -O dtb -o bamboo.dtb -b 0 sequoia.dts

Needs updating to remove the bamboo references.  In fact we can
probably get rid of this "To build" comment that's been copied to just
about every dts ever.

> + */
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	model = "amcc,sequoia";
> +	compatible = "amcc,sequoia";
> +	dcr-parent = <&/cpus/PowerPC,440EPx@0>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,440EPx@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <0>; /* Filled in by zImage */
> +			timebase-frequency = <0>; /* Filled in by zImage */
> +			i-cache-line-size = <20>;
> +			d-cache-line-size = <20>;
> +			i-cache-size = <8000>;
> +			d-cache-size = <8000>;
> +			dcr-controller;
> +			dcr-access-method = "native";
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0 0>; /* Filled in by zImage */
> +	};
> +
> +	UIC0: interrupt-controller0 {
> +		compatible = "ibm,uic-440gp","ibm,uic";

The first compatible entry should always be the precise model, so in
this case "ibm,uic-440epx".  If it is (supposed to be) identical to
the UIC in the 440GP, it can also have an "ibm,uic-440gp" entry, but
since I believe all the UICs are supposed to operate the same, I think
that's implicit in the "ibm,uic" entry.

This goes for all the entries below where you list "ibm,....-440gp" or
or "ibm,....-440ep" or "ibm,.....-440spe" first instead of
"ibm,....-440epx".

> +		interrupt-controller;
> +		cell-index = <0>;
> +		dcr-reg = <0c0 009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	UIC1: interrupt-controller1 {
> +		compatible = "ibm,uic-440gp","ibm,uic";
> +		interrupt-controller;
> +		cell-index = <1>;
> +		dcr-reg = <0d0 009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +		interrupts = <1e 4 1f 4>; /* cascade */
> +		interrupt-parent = <&UIC0>;
> +	};
> +
> +	UIC2: interrupt-controller2 {
> +		compatible = "ibm,uic-440gp","ibm,uic";
> +		interrupt-controller;
> +		cell-index = <2>;
> +		dcr-reg = <0e0 009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +		interrupts = <1c 4 1d 4>; /* cascade */
> +		interrupt-parent = <&UIC0>;
> +	};
> +
> +	SDR0: sdr {

What is the SDR?

> +		compatible = "ibm,sdr-440ep";
> +		dcr-reg = <00e 002>;
> +	};
> +
> +	CPR0: cpr {

And the CPR?

> +		compatible = "ibm,cpr-440ep";
> +		dcr-reg = <00c 002>;
> +	};
> +
> +	plb {
> +		compatible = "ibm,plb-440gp", "ibm,plb4";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +		clock-frequency = <0>; /* Filled in by zImage */
> +
> +		SDRAM0: sdram {
> +			device_type = "memory-controller";
> +			compatible = "ibm,sdram-44x-ddr2denali";

Should have a precise -440epx compatible, as well as the more general one.

> +			dcr-reg = <010 2>;
> +		};
> +
> +		DMA0: dma {
> +			compatible = "ibm,dma-440gp", "ibm,dma-4xx";
> +			dcr-reg = <100 027>;
> +		};
> +
> +		MAL0: mcmal {
> +			compatible = "ibm,mcmal-440spe", "ibm,mcmal2";
> +			dcr-reg = <180 62>;
> +			num-tx-chans = <4>;
> +			num-rx-chans = <4>;
> +			interrupt-parent = <&MAL0>;
> +			interrupts = <0 1 2 3 4>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
> +					/*RXEOB*/ 1 &UIC0 b 4
> +					/*SERR*/  2 &UIC1 0 4
> +					/*TXDE*/  3 &UIC1 1 4
> +					/*RXDE*/  4 &UIC1 2 4>;
> +			interrupt-map-mask = <ffffffff>;
> +		};
> +
> +		POB0: opb {
> +		  	compatible = "ibm,opb-440gp", "ibm,opb";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			/* Bamboo is oddball in the 44x world and doesn't use the ERPN
> +			 * bits.
> +			 */

Comment is for Bamboo and does not match the ranges property below.

> +		  	ranges = <00000000 1 00000000 80000000
> +			          80000000 1 80000000 80000000>;
> +		  	interrupt-parent = <&UIC1>;
> +		  	interrupts = <7 4>;
> +		  	clock-frequency = <0>; /* Filled in by zImage */
> +
> +			EBC0: ebc {
> +				compatible = "ibm,ebc-440gp";
> +				dcr-reg = <012 2>;
> +				#address-cells = <2>;
> +				#size-cells = <1>;
> +				clock-frequency = <0>; /* Filled in by zImage */
> +				interrupts = <5 1>;
> +				interrupt-parent = <&UIC1>;
> +
> +				nor_flash@0,0 {
> +					device_type = "rom";
> +					compatible = "direct-mapped";
> +					probe-type = "CFI";

This flash binding needs to be replaced, but I guess that's not really
your problem.

> +					bank-width = <2>;
> +					partitions = <	0	180000
> +							180000	200000
> +							380000	3aa0000
> +							3e20000	140000
> +							3f60000	40000
> +							3fa0000	60000>;
> +					partition-names = "Kernel", "ramdisk", "file system",
> +								"kozio", "env", "u-boot";
> +					reg = <0 000000 4000000>;
> +				};
> +
> +			};
> +
> +			UART0: serial@ef600300 {
> +		   		device_type = "serial";
> +		   		compatible = "ns16550";
> +		   		reg = <ef600300 8>;
> +		   		virtual-reg = <ef600300>;
> +		   		clock-frequency = <0>; /* Filled in by zImage */
> +		   		current-speed = <1c200>;
> +		   		interrupt-parent = <&UIC0>;
> +		   		interrupts = <0 4>;
> +	   		};
> +
> +			UART1: serial@ef600400 {
> +		   		device_type = "serial";
> +		   		compatible = "ns16550";
> +		   		reg = <ef600400 8>;
> +		   		virtual-reg = <ef600400>;
> +		   		clock-frequency = <0>;
> +		   		current-speed = <0>;
> +		   		interrupt-parent = <&UIC0>;
> +		   		interrupts = <1 4>;
> +	   		};
> +
> +			UART2: serial@ef600500 {
> +		   		device_type = "serial";
> +		   		compatible = "ns16550";
> +		   		reg = <ef600500 8>;
> +		   		virtual-reg = <ef600500>;
> +		   		clock-frequency = <0>;
> +		   		current-speed = <0>;
> +		   		interrupt-parent = <&UIC1>;
> +		   		interrupts = <3 4>;
> +	   		};
> +
> +			UART3: serial@ef600600 {
> +		   		device_type = "serial";
> +		   		compatible = "ns16550";
> +		   		reg = <ef600600 8>;
> +		   		virtual-reg = <ef600600>;
> +		   		clock-frequency = <0>;
> +		   		current-speed = <0>;
> +		   		interrupt-parent = <&UIC1>;
> +		   		interrupts = <4 4>;
> +	   		};
> +
> +			IIC0: i2c@ef600700 {
> +				device_type = "i2c";
> +				compatible = "ibm,iic-440gp", "ibm,iic";
> +				reg = <ef600700 14>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <2 4>;
> +			};
> +
> +			IIC1: i2c@ef600800 {
> +				device_type = "i2c";
> +				compatible = "ibm,iic-44gp", "ibm,iic";
> +				reg = <ef600800 14>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <7 4>;
> +			};
> +
> +			ZMII0: emac-zmii@ef600d00 {
> +				device_type = "zmii-interface";
> +				compatible = "ibm,zmii-440gp", "ibm,zmii";
> +				reg = <ef600d00 c>;
> +			};
> +
> +			EMAC0: ethernet@ef600e00 {
> +				linux,network-index = <0>;
> +				device_type = "network";
> +				compatible = "ibm,emac-440spe", "ibm,emac4", "ibm,emac-axon";

"ibm,emac-axon" is definitely wrong, since this isn't an Axon chip.

> +				interrupt-parent = <&EMAC0>;
> +				interrupts = <0 1>;
> +				#interrupt-cells = <1>;
> +				#address-cells = <0>;
> +				#size-cells = <0>;
> +				interrupt-map = </*Status*/ 0 &UIC0 18 4
> +						/*Wake*/  1 &UIC1 1d 4>;
> +				reg = <ef600e00 70>;
> +				local-mac-address = [000000000000];
> +				mal-device = <&MAL0>;
> +				mal-tx-channel = <0 1>;
> +				mal-rx-channel = <0>;
> +				cell-index = <0>;
> +				max-frame-size = <5dc>;
> +				rx-fifo-size = <1000>;
> +				tx-fifo-size = <800>;
> +				phy-mode = "rmii";
> +				phy-map = <00000000>;
> +				zmii-device = <&ZMII0>;
> +				zmii-channel = <0>;
> +			};
> +
> +			EMAC1: ethernet@ef600f00 {
> +				linux,network-index = <1>;
> +				device_type = "network";
> +				compatible = "ibm,emac-440spe", "ibm,emac4", "ibm,emac-axon";
> +				interrupt-parent = <&EMAC1>;
> +				interrupts = <0 1>;
> +				#interrupt-cells = <1>;
> +				#address-cells = <0>;
> +				#size-cells = <0>;
> +				interrupt-map = </*Status*/ 0 &UIC0 19 4
> +						/*Wake*/  1 &UIC1 1f 4>;
> +				reg = <ef600f00 70>;
> +				local-mac-address = [000000000000];
> +				mal-device = <&MAL0>;
> +				mal-tx-channel = <2 3>;
> +				mal-rx-channel = <1>;
> +				cell-index = <1>;
> +				max-frame-size = <5dc>;
> +				rx-fifo-size = <1000>;
> +				tx-fifo-size = <800>;
> +				phy-mode = "rmii";
> +				phy-map = <00000000>;
> +				zmii-device = <&ZMII0>;
> +				zmii-channel = <1>;
> +			};
> +		};
> +	};
> +
> +	chosen {
> +		linux,stdout-path = "/plb/opb/serial@ef600300";
> +		bootargs = "console=ttyS0,115200";
> +	};
> +};
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
