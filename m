Return-Path: <SRS0=h5jx=SC=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 7E065DDEC2
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 17:14:04 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
Date: Sat, 12 Jan 2008 07:13:54 +0100
References: <47852C41.8000506@pikatech.com>
	<20080111115451.15756368@zod.rchland.ibm.com>
	<4787FB77.5070905@pikatech.com>
In-Reply-To: <4787FB77.5070905@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801120713.54856.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 12 January 2008, Sean MacLennan wrote:
> +++ arch/powerpc/boot/dts/warp.dts	2008-01-11 15:58:03.000000000 -0500
> @@ -0,0 +1,234 @@
> +/*
> + * Device Tree Source for PIKA Warp
> + *
> + * Copyright (c) 2008 PIKA Technologies
> + *   Sean MacLennan <smaclennan@pikatech.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without
> + * any warranty of any kind, whether express or implied.
> + */
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	model = "pika,warp";
> +	compatible = "pika,warp";
> +	dcr-parent = <&/cpus/cpu@0>;
> +
> +	aliases {
> +		ethernet0 = &EMAC0;
> +		serial0 = &UART0;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			model = "PowerPC,440EP";
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
> +		compatible = "ibm,uic-440ep","ibm,uic";
> +		interrupt-controller;
> +		cell-index = <0>;
> +		dcr-reg = <0c0 009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	UIC1: interrupt-controller1 {
> +		compatible = "ibm,uic-440ep","ibm,uic";
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
> +	SDR0: sdr {
> +		compatible = "ibm,sdr-440ep";
> +		dcr-reg = <00e 002>;
> +	};
> +
> +	CPR0: cpr {
> +		compatible = "ibm,cpr-440ep";
> +		dcr-reg = <00c 002>;
> +	};
> +
> +	plb {
> +		compatible = "ibm,plb-440ep", "ibm,plb-440gp", "ibm,plb4";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +		clock-frequency = <0>; /* Filled in by zImage */
> +
> +		SDRAM0: sdram {
> +			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
> +			dcr-reg = <010 2>;
> +		};
> +
> +		DMA0: dma {
> +			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
> +			dcr-reg = <100 027>;
> +		};
> +
> +		MAL0: mcmal {
> +			compatible = "ibm,mcmal-440ep", "ibm,mcmal-440gp", "ibm,mcmal";
> +			dcr-reg = <180 62>;
> +			num-tx-chans = <4>;
> +			num-rx-chans = <2>;
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
> +		};
> +
> +		POB0: opb {
> +		  	compatible = "ibm,opb-440ep", "ibm,opb-440gp", "ibm,opb";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		  	ranges = <00000000 0 00000000 80000000
> +			          80000000 0 80000000 80000000>;
> +		  	interrupt-parent = <&UIC1>;
> +		  	interrupts = <7 4>;
> +		  	clock-frequency = <0>; /* Filled in by zImage */
> +
> +			EBC0: ebc {
> +				compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
> +				dcr-reg = <012 2>;
> +				#address-cells = <2>;
> +				#size-cells = <1>;
> +				clock-frequency = <0>; /* Filled in by zImage */
> +				interrupts = <5 1>;
> +				interrupt-parent = <&UIC1>;
> +
> +				fpga@2,0 {
> +					compatible = "pika,fpga";
> +			   		reg = <2 0 2200>;
> +					interrupts = <18 8>;
> +					interrupt-parent = <&UIC0>;
> +				};
> +
> +				nor_flash@0,0 {
> +					compatible = "amd,s29gl512n", "cfi-flash";
> +					bank-width = <2>;
> +					reg = <0 0 4000000>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					partition@0 {
> +						label = "kernel";
> +						reg = <0 180000>;
> +					};
> +					partition@180000 {
> +						label = "root";
> +						reg = <180000 3480000>;
> +					};
> +					partition@3600000 {
> +						label = "user";
> +						reg = <3600000 900000>;
> +					};
> +					partition@3f00000 {
> +						label = "fpga";
> +						reg = <3f00000 40000>;
> +					};
> +					partition@3f40000 {
> +						label = "env";
> +						reg = <3f40000 40000>;
> +					};
> +					partition@3f80000 {
> +						label = "u-boot";
> +						reg = <3f80000 80000>;
> +					};
> +				};
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
> +			IIC0: i2c@ef600700 {
> +				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
> +				reg = <ef600700 14>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <2 4>;
> +			};
> +
> +			GPIO0: gpio@ef600b00 {
> +				compatible = "ibm,gpio-440ep";
> +				reg = <ef600b00 148>;
> +			};

You define here one gpio node that covers both gpio controllers of the 440EP. 
I suggest to use two nodes here, like:

			GPIO0: gpio@ef600b00 {
				compatible = "ibm,gpio-440ep";
				reg = <ef600b00 48>;
			};

			GPIO1: gpio@ef600c00 {
				compatible = "ibm,gpio-440ep";
				reg = <ef600c00 48>;
			};

Best regards,
Stefan
