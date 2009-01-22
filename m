Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 6B472DDF00
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 01:37:58 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LQ0gs-0000RM-T7
	for linuxppc-dev@ozlabs.org; Thu, 22 Jan 2009 06:37:54 -0800
Message-ID: <21605367.post@talk.nabble.com>
Date: Thu, 22 Jan 2009 06:37:54 -0800 (PST)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: eth0: Could not attach to PHY
In-Reply-To: <49783993.4090408@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <21589420.post@talk.nabble.com> <49783993.4090408@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


first of all,thanks Heiko for ur reply.
but i m afraid that i understand nothing from ur answer,
can u give me the steps to do ur suggestion?

is ur suggestion is about to change the device tree of my board?
Here is the dts file of my board, if so what are the modifictions i have to
do to execute ur suggestions
*****************************************************************************
/*
 * MPC8555 AMC Device Tree Source
 *
 * Copyright 2006 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */


/ {
	model = "MPC8555AMC";
	compatible = "mpc85xx";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8555@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <8000>;		// L1, 32K
			i-cache-size = <8000>;		// L1, 32K
			timebase-frequency = <0>;	// 33 MHz, from uboot
			bus-frequency = <0>;		// From uboot
			clock-frequency = <0>;		// From uboot
			32-bit;
			linux,boot-cpu;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 20000000>;	
	};

	soc8555@e0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		#interrupt-cells = <2>;
		device_type = "soc";
		ranges = <0 e0000000 00100000>;
		reg = <e0000000 00100000>;	// CCSRBAR 1M
		bus-frequency = <0>;

		i2c@3000 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3000 100>;
			interrupts = <1b 2>;
			interrupt-parent = <40000>;
			dfsrr;
		};

		mdio@24520 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			linux,phandle = <24520>;
			ethernet-phy@10 {
				linux,phandle = <2452010>;
				interrupt-parent = <40000>;
				interrupts = <30 1>;
				reg = <10>;
				device_type = "ethernet-phy";
			};
			ethernet-phy@11 {
				linux,phandle = <2452011>;
				interrupt-parent = <40000>;
				interrupts = <30 1>;
				reg = <11>;
				device_type = "ethernet-phy";
			};
		};

		ethernet@24000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <24000 1000>;
			mac-address = [ 00 E0 0C 00 73 00 ];
			interrupts = <d 2 e 2 12 2>;
			interrupt-parent = <40000>;
			phy-handle = <2452010>;
		};

		ethernet@25000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <25000 1000>;
			mac-address = [ 00 E0 0C 00 73 01 ];
			interrupts = <13 2 14 2 18 2>;
			interrupt-parent = <40000>;
			phy-handle = <2452011>;
		};
		
		serial@4500 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4500 100>;
			clock-frequency = <0>;
			interrupts = <1a 2>;
			interrupt-parent = <40000>;
		};

		dma@21300 {    //Create DMA controller node, the address is @DMA general
status reg
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "fsl,mpc8555-dma";
			reg = <21300 4>;  //register mapping for DMA general status reg
			ranges = <0 21100 200>;
			cell-index = <0>;  //controller index.  0 for controller @ 0x21000, 1 for
controller @ 0xc000
			
			dma-channel@0 {  //Create DMA channel nodes
				compatible = "fsl,mpc8555-dma-channel";
				reg = <0 80>;  //DMA registers are from offset 0x21100 to 0x21180
				cell-index = <0>; //DMA Channel 0
				interrupts = <4 2>;  //interrupt number is 0x04 and the level is 2 that
maps to active high level sensitive type enabled
				interrupt-parent = <40000>;
			};
		};

		dspb@50080 {
				reg = <0 A0>;  //EIVPR4 since DSP-B will interrupt the PQ on EX-IRQ4
				interrupts = <34 1>;  //interrupt# is 0x34 and the level is 1 that maps
to level sensitive,active low interrupt
				interrupt-parent = <40000>;
			};

		pic@40000 {
			linux,phandle = <40000>;
			clock-frequency = <0>;
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <40000 40000>;
			built-in;
			compatible = "chrp,open-pic";
			device_type = "open-pic";
                        big-endian;
			interrupts = <
				0 2 1 2 2 2 3 2
				4 2 5 2 6 2 7 2
				8 2 9 2 a 2 b 2
				c 2 d 2 e 2 f 2
				10 2 11 2 12 2 13 2
				14 2 15 2 16 2 17 2
				18 2 19 2 1a 2 1b 2
				1c 2 1d 2 1e 2 1f 2
				20 2 21 2 22 2 23 2
				24 2 25 2 26 2 27 2
				28 2 29 2 2a 2 2b 2
				2c 2 2d 2 2e 2 2f 2
				30 1
				>;
			interrupt-parent = <40000>;
		};
	};
};


*****************************************************************************



Heiko Schocher wrote:
> 
> Hello wael,
> 
> wael showair <showair2003@yahoo.com> wrote:
>> i have a board with MPC8555 processor
>> uboot version 1.1.6
>> linux kernel 2.6.19-rc5
>> ltib version: 6.2.2-sv
>> gcc 3.4.3
>> 
>> it boots successfully
>> i want to upgrade my linux kernel to 2.6.27
>> i upgraded the following:
>> ltib version 8.1.2-sv
>> gcc 4.1
>> linux kernel 2.6.27
>> & i kept the uboot with the same version 1.1.6
>> 
>> the kernel booting stucks as follows:
>> 
>> *****************************************************************************
>> U-Boot 1.1.6 (Feb  8 2007 - 14:00:17)
> [...]
>> RPC: Registered tcp transport module.
>> 24520:10 not found
>> eth0: Could not attach to PHY
> 
> Here is your problem. For some reason, your network driver
> couldnt find the PHY ... Maybe there is something changed
> between 2.6.19-rc5 and 2.6.27.
> 
>> IP-Config: Failed to open eth0
>> IP-Config: Failed to open eth1
>> IP-Config: No network devices available.
> 
> and so, there is no network device ...
> 
> I have no 85xx board, but maybe following commit is something
> for you:
> 
> gianfar: Convert gianfar to an of_platform_driver
> author	Andy Fleming <afleming@freescale.com>
> 	Tue, 16 Dec 2008 23:29:15 +0000 (15:29 -0800)
> committer	David S. Miller <davem@davemloft.net>
> 	Tue, 16 Dec 2008 23:29:15 +0000 (15:29 -0800)
> commit	b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4
> tree	f8643c2fd1b137dd6c00bcd385ad36adfca4f540	tree | snapshot
> parent	257d938a0c17838c740eb68f0005b041444ac2c2	commit | diff
> gianfar: Convert gianfar to an of_platform_driver
> 
> Does the same for the accompanying MDIO driver, and then modifies the TBI
> configuration method.  The old way used fields in einfo, which no longer
> exists.  The new way is to create an MDIO device-tree node for each
> instance
> of gianfar, and create a tbi-handle property to associate ethernet
> controllers
> with the TBI PHYs they are connected to.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> ----------------------------------------------------------------------
> 
> bye
> Heiko
> -- 
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/eth0%3A-Could-not-attach-to-PHY-tp21589420p21605367.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
