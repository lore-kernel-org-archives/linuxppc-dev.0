Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 09CFDDDEAB
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 02:57:56 +1000 (EST)
Message-ID: <46C33056.8090901@ru.mvista.com>
Date: Wed, 15 Aug 2007 20:56:54 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/4] PowerPC 440EPx: Sequoia DTS
References: <20070814184107.GA6696@ru.mvista.com>
	<20070814184843.GA12438@ru.mvista.com>
	<20070815034359.GA22849@localhost.localdomain>
In-Reply-To: <20070815034359.GA22849@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Aug 14, 2007 at 10:48:43PM +0400, Valentine Barshak wrote:
>> AMCC Sequoia device tree.
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> ---
>>  arch/powerpc/boot/dts/sequoia.dts |  289 ++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 289 insertions(+)
>>
>> diff -ruN linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6/arch/powerpc/boot/dts/sequoia.dts
>> --- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	1970-01-01 03:00:00.000000000 +0300
>> +++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-08-14 19:32:56.000000000 +0400
>> @@ -0,0 +1,289 @@
>> +/*
>> + * Device Tree Source for AMCC Sequoia
>> + *
>> + * Based on Bamboo code by Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> + * Copyright (c) 2006, 2007 IBM Corp.
>> + *
>> + * FIXME: Draft only!
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without
>> + * any warranty of any kind, whether express or implied.
>> + *
>> + */
>> +
>> +/ {
>> +	#address-cells = <2>;
>> +	#size-cells = <1>;
>> +	model = "amcc,sequoia";
>> +	compatible = "amcc,sequoia";
>> +	dcr-parent = <&/cpus/PowerPC,440EPx@0>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		PowerPC,440EPx@0 {
>> +			device_type = "cpu";
>> +			reg = <0>;
>> +			clock-frequency = <0>; /* Filled in by zImage */
>> +			timebase-frequency = <0>; /* Filled in by zImage */
>> +			i-cache-line-size = <20>;
>> +			d-cache-line-size = <20>;
>> +			i-cache-size = <8000>;
>> +			d-cache-size = <8000>;
>> +			dcr-controller;
>> +			dcr-access-method = "native";
>> +		};
>> +	};
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0 0 0>; /* Filled in by zImage */
>> +	};
>> +
>> +	UIC0: interrupt-controller0 {
>> +		compatible = "ibm,uic-440epx","ibm,uic";
>> +		interrupt-controller;
>> +		cell-index = <0>;
>> +		dcr-reg = <0c0 009>;
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +		#interrupt-cells = <2>;
>> +	};
>> +
>> +	UIC1: interrupt-controller1 {
>> +		compatible = "ibm,uic-440epx","ibm,uic";
>> +		interrupt-controller;
>> +		cell-index = <1>;
>> +		dcr-reg = <0d0 009>;
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +		#interrupt-cells = <2>;
>> +		interrupts = <1e 4 1f 4>; /* cascade */
>> +		interrupt-parent = <&UIC0>;
>> +	};
>> +
>> +	UIC2: interrupt-controller2 {
>> +		compatible = "ibm,uic-440epx","ibm,uic";
>> +		interrupt-controller;
>> +		cell-index = <2>;
>> +		dcr-reg = <0e0 009>;
>> +		#address-cells = <0>;
>> +		#size-cells = <0>;
>> +		#interrupt-cells = <2>;
>> +		interrupts = <1c 4 1d 4>; /* cascade */
>> +		interrupt-parent = <&UIC0>;
>> +	};
>> +
>> +	SDR0: sdr {
>> +		compatible = "ibm,sdr-440epx", "ibm,sdr-440ep";
> 
> Ok, I take it the 440EP really does have SDR and CPR devices with
> which the EPx variants are compatible?

Right.

> 
>> +		dcr-reg = <00e 002>;
>> +	};
>> +
>> +	CPR0: cpr {
>> +		compatible = "ibm,cpr-440epx", "ibm,sdr-440ep";
>> +		dcr-reg = <00c 002>;
>> +	};
>> +
>> +	plb {
>> +		compatible = "ibm,plb-440epx", "ibm,plb4";
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +		clock-frequency = <0>; /* Filled in by zImage */
>> +
>> +		SDRAM0: sdram {
>> +			device_type = "memory-controller";
>> +			compatible = "ibm,sdram-44x-ddr2denali";
> 
> Should have an ibm,sdram-440epx entry as well, just in case of chip
> specific bugs / workarounds.

OK

> 
>> +			dcr-reg = <010 2>;
>> +		};
>> +
>> +		DMA0: dma {
>> +			compatible = "ibm,dma-440epx", "ibm,dma-4xx";
>> +			dcr-reg = <100 027>;
>> +		};
>> +
>> +		MAL0: mcmal {
>> +			compatible = "ibm,mcmal-440epx", "ibm,mcmal-440spe", "ibm,mcmal2";
> 
> What's the 440spe entry about?

Will remove. No need in 440spe with the updated EMAC driver.

> 
>> +			dcr-reg = <180 62>;
>> +			num-tx-chans = <4>;
>> +			num-rx-chans = <4>;
>> +			interrupt-parent = <&MAL0>;
>> +			interrupts = <0 1 2 3 4>;
>> +			#interrupt-cells = <1>;
>> +			#address-cells = <0>;
>> +			#size-cells = <0>;
>> +			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
>> +					/*RXEOB*/ 1 &UIC0 b 4
>> +					/*SERR*/  2 &UIC1 0 4
>> +					/*TXDE*/  3 &UIC1 1 4
>> +					/*RXDE*/  4 &UIC1 2 4>;
>> +			interrupt-map-mask = <ffffffff>;
>> +		};
>> +
>> +		POB0: opb {
>> +		  	compatible = "ibm,opb-440epx", "ibm,opb";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			/* Bamboo is oddball in the 44x world and doesn't use the ERPN
>> +			 * bits.
>> +			 */
> 
> This incorrect and outdated comment is still here.

Sorry :)

> 
>> +		  	ranges = <00000000 1 00000000 80000000
>> +			          80000000 1 80000000 80000000>;
>> +		  	interrupt-parent = <&UIC1>;
>> +		  	interrupts = <7 4>;
>> +		  	clock-frequency = <0>; /* Filled in by zImage */
>> +
>> +			EBC0: ebc {
>> +				compatible = "ibm,ebc-440epx";
> 
> Should have "ibm,ebc" too.

OK

> 
>> +				dcr-reg = <012 2>;
>> +				#address-cells = <2>;
>> +				#size-cells = <1>;
>> +				clock-frequency = <0>; /* Filled in by zImage */
>> +				interrupts = <5 1>;
>> +				interrupt-parent = <&UIC1>;
>> +
>> +				nor_flash@0,0 {
>> +					device_type = "rom";
>> +					compatible = "direct-mapped";
>> +					probe-type = "CFI";
>> +					bank-width = <2>;
>> +					partitions = <	0	180000
>> +							180000	200000
>> +							380000	3aa0000
>> +							3e20000	140000
>> +							3f60000	40000
>> +							3fa0000	60000>;
>> +					partition-names = "Kernel", "ramdisk", "file system",
>> +								"kozio", "env", "u-boot";
>> +					reg = <0 000000 4000000>;
>> +				};
>> +
>> +			};
>> +
>> +			UART0: serial@ef600300 {
>> +		   		device_type = "serial";
>> +		   		compatible = "ns16550";
>> +		   		reg = <ef600300 8>;
>> +		   		virtual-reg = <ef600300>;
>> +		   		clock-frequency = <0>; /* Filled in by zImage */
>> +		   		current-speed = <1c200>;
>> +		   		interrupt-parent = <&UIC0>;
>> +		   		interrupts = <0 4>;
>> +	   		};
>> +
>> +			UART1: serial@ef600400 {
>> +		   		device_type = "serial";
>> +		   		compatible = "ns16550";
>> +		   		reg = <ef600400 8>;
>> +		   		virtual-reg = <ef600400>;
>> +		   		clock-frequency = <0>;
>> +		   		current-speed = <0>;
>> +		   		interrupt-parent = <&UIC0>;
>> +		   		interrupts = <1 4>;
>> +	   		};
>> +
>> +			UART2: serial@ef600500 {
>> +		   		device_type = "serial";
>> +		   		compatible = "ns16550";
>> +		   		reg = <ef600500 8>;
>> +		   		virtual-reg = <ef600500>;
>> +		   		clock-frequency = <0>;
>> +		   		current-speed = <0>;
>> +		   		interrupt-parent = <&UIC1>;
>> +		   		interrupts = <3 4>;
>> +	   		};
>> +
>> +			UART3: serial@ef600600 {
>> +		   		device_type = "serial";
>> +		   		compatible = "ns16550";
>> +		   		reg = <ef600600 8>;
>> +		   		virtual-reg = <ef600600>;
>> +		   		clock-frequency = <0>;
>> +		   		current-speed = <0>;
>> +		   		interrupt-parent = <&UIC1>;
>> +		   		interrupts = <4 4>;
>> +	   		};
>> +
>> +			IIC0: i2c@ef600700 {
>> +				device_type = "i2c";
>> +				compatible = "ibm,iic-440epx", "ibm,iic";
>> +				reg = <ef600700 14>;
>> +				interrupt-parent = <&UIC0>;
>> +				interrupts = <2 4>;
>> +			};
>> +
>> +			IIC1: i2c@ef600800 {
>> +				device_type = "i2c";
>> +				compatible = "ibm,iic-440epx", "ibm,iic";
>> +				reg = <ef600800 14>;
>> +				interrupt-parent = <&UIC0>;
>> +				interrupts = <7 4>;
>> +			};
>> +
>> +			ZMII0: emac-zmii@ef600d00 {
>> +				device_type = "zmii-interface";
>> +				compatible = "ibm,zmii-440epx", "ibm,zmii";
>> +				reg = <ef600d00 c>;
>> +			};
>> +
>> +			EMAC0: ethernet@ef600e00 {
>> +				linux,network-index = <0>;
>> +				device_type = "network";
>> +				compatible = "ibm,emac-440epx", "ibm,emac-440spe", "ibm,emac4";
> 
> Again what's the ibm,emac-440spe about?

It's about to be removed from here :)

> 
>> +				interrupt-parent = <&EMAC0>;
>> +				interrupts = <0 1>;
>> +				#interrupt-cells = <1>;
>> +				#address-cells = <0>;
>> +				#size-cells = <0>;
>> +				interrupt-map = </*Status*/ 0 &UIC0 18 4
>> +						/*Wake*/  1 &UIC1 1d 4>;
>> +				reg = <ef600e00 70>;
>> +				local-mac-address = [000000000000];
>> +				mal-device = <&MAL0>;
>> +				mal-tx-channel = <0 1>;
>> +				mal-rx-channel = <0>;
>> +				cell-index = <0>;
>> +				max-frame-size = <5dc>;
>> +				rx-fifo-size = <1000>;
>> +				tx-fifo-size = <800>;
>> +				phy-mode = "rmii";
>> +				phy-map = <00000000>;
>> +				zmii-device = <&ZMII0>;
>> +				zmii-channel = <0>;
>> +			};
>> +
>> +			EMAC1: ethernet@ef600f00 {
>> +				linux,network-index = <1>;
>> +				device_type = "network";
>> +				compatible = "ibm,emac-440epx", "ibm,emac-440spe", "ibm,emac4";
>> +				interrupt-parent = <&EMAC1>;
>> +				interrupts = <0 1>;
>> +				#interrupt-cells = <1>;
>> +				#address-cells = <0>;
>> +				#size-cells = <0>;
>> +				interrupt-map = </*Status*/ 0 &UIC0 19 4
>> +						/*Wake*/  1 &UIC1 1f 4>;
>> +				reg = <ef600f00 70>;
>> +				local-mac-address = [000000000000];
>> +				mal-device = <&MAL0>;
>> +				mal-tx-channel = <2 3>;
>> +				mal-rx-channel = <1>;
>> +				cell-index = <1>;
>> +				max-frame-size = <5dc>;
>> +				rx-fifo-size = <1000>;
>> +				tx-fifo-size = <800>;
>> +				phy-mode = "rmii";
>> +				phy-map = <00000000>;
>> +				zmii-device = <&ZMII0>;
>> +				zmii-channel = <1>;
>> +			};
>> +		};
>> +	};
>> +
>> +	chosen {
>> +		linux,stdout-path = "/plb/opb/serial@ef600300";
>> +		bootargs = "console=ttyS0,115200";
>> +	};
>> +};
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
> 
Thanks,
Valentine.
