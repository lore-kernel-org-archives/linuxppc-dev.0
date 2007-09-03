Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E9D87DDF64
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 11:14:00 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l831E2wY010757
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:14:02 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l831HXbc168860
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:17:33 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l832DxHM002496
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 12:13:59 +1000
Date: Mon, 3 Sep 2007 11:08:59 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 3/6] Walnut DTS
Message-ID: <20070903010859.GD31499@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>>
	<20070831200643.202414000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070831200643.202414000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 31, 2007 at 03:04:52PM -0500, Josh Boyer wrote:
> Device tree source file for the PPC405 Walnut evaluation board.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> ---
>  arch/powerpc/boot/dts/walnut.dts |  183 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
> 
> --- /dev/null
> +++ linux-2.6/arch/powerpc/boot/dts/walnut.dts
> @@ -0,0 +1,183 @@
> +/*
> + * Device Tree Source for IBM Walnut
> + *
> + * Copyright 2007 IBM Corp.
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without
> + * any warranty of any kind, whether express or implied.
> + */
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	model = "ibm,walnut";
> +	compatible = "ibm,walnut";
> +	dcr-parent = <&/cpus/PowerPC,405GP@0>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,405GP@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <bebc200>; /* Filled in by zImage */
> +			timebase-frequency = <0>; /* Filled in by zImage */
> +			i-cache-line-size = <20>;
> +			d-cache-line-size = <20>;
> +			i-cache-size = <4000>;
> +			d-cache-size = <4000>;
> +			dcr-controller;
> +			dcr-access-method = "native";
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0>; /* Filled in by zImage */
> +	};
> +
> +	UIC0: interrupt-controller {
> +		compatible = "ibm,uic";
> +		interrupt-controller;
> +		cell-index = <0>;
> +		dcr-reg = <0c0 9>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	plb {
> +		compatible = "ibm,plb3";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +		clock-frequency = <0>; /* Filled in by zImage */
> +
> +		SDRAM0: memory-controller {
> +			compatible = "ibm,sdram-405gp";
> +			dcr-reg = <010 2>;
> +		};
> +
> +		MAL: mcmal {
> +			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
> +			dcr-reg = <180 62>;
> +			num-tx-chans = <2>;
> +			num-rx-chans = <1>;
> +			interrupt-parent = <&UIC0>;
> +			interrupts = <a 4 b 4 c 4 d 4 e 4>;
> +		};
> +
> +		POB0: opb {
> +			compatible = "ibm,opb";

Need an opb-405gp here, too.

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 ef600000 a00000>;

Hrm... something we ought to clarify is the interpretation of the
POB0_BEAR register with respect to the bridge's ranges property.  For
440 I think the BEAR will need to be interpreted as an OPB address,
rather than a PLB address, but I'm not sure if that will work here
with the limited ranges property you have.

> +			dcr-reg = <0a0 5>;
> +			clock-frequency = <0>; /* Filled in by zImage */
> +
> +			UART0: serial@300 {
> +				device_type = "serial";
> +				compatible = "ns16550";
> +				reg = <300 8>;
> +				virtual-reg = <ef600300>;
> +				clock-frequency = <0>; /* Filled in by zImage */
> +				current-speed = <2580>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <0 4>;
> +			};
> +
> +			UART1: serial@400 {
> +				device_type = "serial";
> +				compatible = "ns16550";
> +				reg = <400 8>;
> +				virtual-reg = <ef600400>;
> +				clock-frequency = <0>; /* Filled in by zImage */
> +				current-speed = <2580>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <1 4>;
> +			};
> +
> +			IIC: i2c@500 {
> +				compatible = "ibm,iic-405gp", "ibm,iic";
> +				reg = <500 11>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <2 4>;
> +			};
> +
> +			GPIO: gpio@700 {
> +				compatible = "ibm,gpio-405gp";
> +				reg = <700 20>;
> +			};
> +
> +			EMAC: ethernet@800 {
> +				linux,network-index = <0>;
> +				device_type = "network";
> +				compatible = "ibm,emac-405gp", "ibm,emac";
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <9 4 f 4>;
> +				reg = <800 70>;
> +				mal-device = <&MAL>;
> +				mal-tx-channel = <0 1>;
> +				mal-rx-channel = <0>;
> +				cell-index = <0>;
> +				max-frame-size = <5dc>;
> +				rx-fifo-size = <1000>;
> +				tx-fifo-size = <800>;
> +				phy-mode = "rmii";
> +				phy-map = <00000001>;
> +			};
> +
> +		};
> +
> +		EBC0: ebc {
> +			compatible = "ibm,ebc-405gp", "ibm,ebc";
> +			dcr-reg = <012 2>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			clock-frequency = <0>; /* Filled in by zImage */
> +
> +			sram@0,0 {
> +				reg = <0 0 80000>;
> +			};
> +
> +			flash@0,80000 {
> +				device_type = "rom";
> +				compatible = "direct-mapped";
> +				probe-type = "JEDEC";
> +				bank-width = <1>;
> +				partitions = <0 80000>;
> +				partition-names = "OpenBIOS";
> +				reg = <0 80000 80000>;
> +			};
> +
> +			ds1743@1,0 {
> +				/* NVRAM and RTC */
> +				compatible = "ds1743";
> +				reg = <1 0 2000>;
> +			};
> +
> +			keyboard@2,0 {
> +				compatible = "intel,82C42PC";
> +				reg = <2 0 2>;
> +			};
> +
> +			ir@3,0 {
> +				compatible = "ti,TIR2000PAG";
> +				reg = <3 0 10>;
> +			};
> +
> +			fpga@7,0 {
> +				compatible = "Walnut-FPGA";
> +				reg = <7 0 10>;
> +				virtual-reg = <f0300005>;
> +			};
> +		};
> +	};
> +
> +	chosen {
> +		linux,stdout-path = "/plb/opb/serial@300";
> +	};
> +};
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
