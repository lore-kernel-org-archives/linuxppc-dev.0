Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 71558DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 09:26:51 +1100 (EST)
Message-ID: <47742519.8060502@pikatech.com>
Date: Thu, 27 Dec 2007 17:20:09 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Problems with arch/powerpc
Content-Type: multipart/mixed; boundary="------------020107010809070505090708"
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020107010809070505090708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If this should go in linuxppc-embedded please let me know. It seems that 
the board supports are getting posted here.

PIKA has an embedded PPC440EP board based on the AMCC Yosemite board. I 
got the Linux 2.6.19.2 kernel working by basically copying the Yosemite 
configuration. Now I am trying to move from the ppc to the powerpc 
architecture using Josh Boyer's for-2.6.25 kernel. And there is no 
Yosemite config :( We are using u-boot 1.3.0.

I have the kernel booting, but the OS runs very strange. I cannot run 
the ash shell, it fails on the first setjmp. But I can run the hush 
shell (we are using busybox). So it goes, many things work, others don't.

I am mounting the root filesystem over NFS, so the ethernet seem to work 
well.

But cat /proc/interrupts shows:

           CPU0
 16:        126   UIC   Level     serial
 17:        520   UIC   Level     MAL TX EOB
 18:        804   UIC   Level     MAL RX EOB
 19:          0   UIC   Level     MAL SERR
 20:          0   UIC   Level     MAL TX DE
 21:          0   UIC   Level     MAL RX DE
 28:          0   UIC   Level     EMAC
BAD:          0

Which is quite different from the older kernel:

           CPU0
  0:       3075  UIC0 Level     serial
  2:       1526  UIC0 Level     IBM IIC
  7:          0  UIC0 Level     IBM IIC
 10:       1388  UIC0 Level     MAL TX EOB
 11:       1839  UIC0 Level     MAL RX EOB
 32:          0  UIC1 Level     MAL SERR
 33:          0  UIC1 Level     MAL TX DE
 34:          0  UIC1 Level     MAL RX DE
 40:          1  UIC1 Level     ohci_hcd:usb1
 60:          0  UIC1 Level     EMAC
BAD:          0



I have attached the dts file. It is based on the bamboo. I can provide 
any other config, the only thing I can't provide is the hardware ;) 
Since the new kernel doesn't show UIC0 or UIC1, just UIC I am wondering 
if something is wrong with the dts.

I have to admit the dts file confuses me a bit. So I suspect that is 
where the problem is. If anybody has any other ideas, don't hesitate to 
suggest!

Cheers,
   Sean

--------------020107010809070505090708
Content-Type: text/plain;
 name="taco.dts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="taco.dts"

/*
 * Device Tree Source for PIKA Taco
 *
 * Copyright 2007 PIKA Technologies
 *
 * This file is licensed under the terms of the GNU General Public
 * License version 2.  This program is licensed "as is" without
 * any warranty of any kind, whether express or implied.
 */

/ {
	#address-cells = <2>;
	#size-cells = <1>;
	model = "pika,taco";
	compatible = "pika,taco";
	dcr-parent = <&/cpus/cpu@0>;

	aliases {
		ethernet0 = &EMAC0;
		serial0 = &UART0;
	};

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu@0 {
			device_type = "cpu";
			model = "PowerPC,440EP";
			reg = <0>;
			clock-frequency = <0>; /* Filled in by zImage */
			timebase-frequency = <0>; /* Filled in by zImage */
			i-cache-line-size = <20>;
			d-cache-line-size = <20>;
			i-cache-size = <8000>;
			d-cache-size = <8000>;
			dcr-controller;
			dcr-access-method = "native";
		};
	};

	memory {
		device_type = "memory";
		reg = <0 0 0>; /* Filled in by zImage */
	};

	UIC0: interrupt-controller0 {
		compatible = "ibm,uic-440ep","ibm,uic";
		interrupt-controller;
		cell-index = <0>;
		dcr-reg = <0c0 009>;
		#address-cells = <0>;
		#size-cells = <0>;
		#interrupt-cells = <2>;
	};

	UIC1: interrupt-controller1 {
		compatible = "ibm,uic-440ep","ibm,uic";
		interrupt-controller;
		cell-index = <1>;
		dcr-reg = <0d0 009>;
		#address-cells = <0>;
		#size-cells = <0>;
		#interrupt-cells = <2>;
		interrupts = <1e 4 1f 4>; /* cascade */
		interrupt-parent = <&UIC0>;
	};

	SDR0: sdr {
		compatible = "ibm,sdr-440ep";
		dcr-reg = <00e 002>;
	};

	CPR0: cpr {
		compatible = "ibm,cpr-440ep";
		dcr-reg = <00c 002>;
	};

	plb {
		compatible = "ibm,plb-440ep", "ibm,plb-440gp", "ibm,plb4";
		#address-cells = <2>;
		#size-cells = <1>;
		ranges;
		clock-frequency = <0>; /* Filled in by zImage */

		SDRAM0: sdram {
			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
			dcr-reg = <010 2>;
		};

		DMA0: dma {
			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
			dcr-reg = <100 027>;
		};

		MAL0: mcmal {
			compatible = "ibm,mcmal-440ep", "ibm,mcmal-440gp", "ibm,mcmal";
			dcr-reg = <180 62>;
			num-tx-chans = <4>;
			num-rx-chans = <2>;
			interrupt-parent = <&MAL0>;
			interrupts = <0 1 2 3 4>;
			#interrupt-cells = <1>;
			#address-cells = <0>;
			#size-cells = <0>;
			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
					/*RXEOB*/ 1 &UIC0 b 4
					/*SERR*/  2 &UIC1 0 4
					/*TXDE*/  3 &UIC1 1 4
					/*RXDE*/  4 &UIC1 2 4>;
		};

		POB0: opb {
		  	compatible = "ibm,opb-440ep", "ibm,opb-440gp", "ibm,opb";
			#address-cells = <1>;
			#size-cells = <1>;
		  	ranges = <00000000 0 00000000 80000000
			          80000000 0 80000000 80000000>;
		  	interrupt-parent = <&UIC1>;
		  	interrupts = <7 4>;
		  	clock-frequency = <0>; /* Filled in by zImage */

			EBC0: ebc {
				compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
				dcr-reg = <012 2>;
				#address-cells = <2>;
				#size-cells = <1>;
				clock-frequency = <0>; /* Filled in by zImage */
				interrupts = <5 1>;
				interrupt-parent = <&UIC1>;
			};

			UART0: serial@ef600300 {
		   		device_type = "serial";
		   		compatible = "ns16550";
		   		reg = <ef600300 8>;
		   		virtual-reg = <ef600300>;
		   		clock-frequency = <0>; /* Filled in by zImage */
		   		current-speed = <1c200>;
		   		interrupt-parent = <&UIC0>;
		   		interrupts = <0 4>;
	   		};

			IIC0: i2c@ef600700 {
				device_type = "i2c";
				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
				reg = <ef600700 14>;
				interrupt-parent = <&UIC0>;
				interrupts = <2 4>;
			};

			IIC1: i2c@ef600800 {
				device_type = "i2c";
				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
				reg = <ef600800 14>;
				interrupt-parent = <&UIC0>;
				interrupts = <7 4>;
			};

			ZMII0: emac-zmii@ef600d00 {
				device_type = "zmii-interface";
				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
				reg = <ef600d00 c>;
			};

			EMAC0: ethernet@ef600e00 {
				linux,network-index = <0>;
				device_type = "network";
				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
				interrupt-parent = <&UIC1>;
				interrupts = <1c 4 1d 4>;
				reg = <ef600e00 70>;
				local-mac-address = [000000000000];
				mal-device = <&MAL0>;
				mal-tx-channel = <0 1>;
				mal-rx-channel = <0>;
				cell-index = <0>;
				max-frame-size = <5dc>;
				rx-fifo-size = <1000>;
				tx-fifo-size = <800>;
				phy-mode = "rmii";
				phy-map = <00000000>;
				zmii-device = <&ZMII0>;
				zmii-channel = <0>;
			};

			usb@ef601000 {
				compatible = "ohci-be";
				reg = <ef601000 80>;
				interrupts = <8 1 9 1>;
				interrupt-parent = < &UIC1 >;
			};
		};
	};

	chosen {
		linux,stdout-path = "/plb/opb/serial@ef600300";
	};
};

--------------020107010809070505090708--
