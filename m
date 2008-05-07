Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 7E038DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 17:50:54 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id 9F6DB150F7A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 09:50:51 +0200 (CEST)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1R3HziD10sCs for <linuxppc-dev@ozlabs.org>;
	Wed,  7 May 2008 09:50:49 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id 45D80150E38
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 09:50:49 +0200 (CEST)
Date: Wed, 7 May 2008 09:50:48 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080507075048.GA24827@frolo.macqel>
References: <20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop>
	<47CECB21.3060704@freescale.com>
	<1204760811.21545.231.camel@pasglop>
	<20080307001025.GA27321@netgate.macqel>
	<1204849197.21545.272.camel@pasglop>
	<20080309223109.GA3989@netgate.macqel>
	<20080311003249.GG11559@localhost.localdomain>
	<20080311114601.GA19189@netgate.macqel>
	<C24AB05C-E10D-47F1-A605-C30D4093699C@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
In-Reply-To: <C24AB05C-E10D-47F1-A605-C30D4093699C@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andy,

On Tue, May 06, 2008 at 05:54:02PM -0500, Andy Fleming wrote:
>> Now back to the first an bigger problem :
>> currently, I have an "old" U-boot and I have written myself a dts file.
>>
>> Problem is : ethernet does not work, but that's not a mac-address problem,
>> but something else that I do not understand yet.  The symptom is I get
>>
>> 	ip route add default via 192.168.85.33 dev eth0
>> 	RTNETLINK answers: Network is unreachable
>>
>> I surmise this is because my eth0 does not become up, and I surmise
>> again this is because there is no driver selected to drive the phy.
>>
>> In my arch/ppc setup this was automagically handled by fixed@100:1 IIRC
>>
>> Is there something I can put in my dts file to activate a driver for my 
>> phy ?
>>
>> Best regards
>
> This slipped under my radar, and I'm only just now finding it again.  Have 
> your issues been resolved?

This has actually not been resolved as such, but we use now the newest
U-boot version which is dtb-aware, and linux-2.6.25-rc6, and that together
fixes the ethernet problem.

> If not, could you send a bit more of the boot 
> log?  There should be a little more if the PHY was not found.  If you were 
> operating with a fixed PHY setup before, then the generic PHY driver (which 
> will automatically bind to your PHY) should suffice unless your MDIO bus is 
> broken.
>
> Andy

Of course, the dts file also has changed, because it is now filled by
U-boot.  I have attached it here for info.

Thanks

Philippe

PS:

What's the recommended way to make a powerpc patch (e.g. my defconfig) appear
in the official kernel sources ?  Should I send it to linuxppc-dev@ozlabs.org,
lkml or somewhere else ?

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="macq_image_processor.dts"

/*
 * MPC8540 ADS Device Tree Source - Modified by DEVELTECH for MACQ_IMAGE_PROCESSOR
 *
 * Copyright 2006 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */


/ {
	model = "MACQ_IMAGE_PROCESSOR";
	compatible = "MPC8540ADS", "MPC85xxADS";
	#address-cells = <1>;
	#size-cells = <1>;

	aliases {
		ethernet0 = &enet0;
		serial0 = &serial0;
		pci0 = &pci0;
	};

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8540@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <8000>;		// L1, 32K
			i-cache-size = <8000>;		// L1, 32K
			timebase-frequency = <0>;	//  33.3333 MHz, from uboot
			bus-frequency = <0>;	// 166 MHz
			clock-frequency = <0>;	// 666, 833 or 1000 MHz, from uboot
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 10000000>;	// 256M at 0x0
	};

	soc8540@e0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		ranges = <0 e0000000 00100000>;
		reg = <e0000000 00100000>;	// CCSRBAR 1M
		bus-frequency = <0>;

		memory-controller@2000 {
			compatible = "fsl,8540-memory-controller";
			reg = <2000 1000>;
			interrupt-parent = <&mpic>;
			interrupts = <12 2>;
		};

		l2-cache-controller@20000 {
			compatible = "fsl,8540-l2-cache-controller";
			reg = <20000 1000>;
			cache-line-size = <20>;	// 32 bytes
			cache-size = <40000>;	// L2, 256K
			interrupt-parent = <&mpic>;
			interrupts = <10 2>;
		};

		i2c@3000 {
			#address-cells = <1>;
			#size-cells = <0>;
			cell-index = <0>;
			compatible = "fsl-i2c";
			reg = <3000 100>;
			interrupts = <2b 2>;
			interrupt-parent = <&mpic>;
			dfsrr;

			rtc@68 {
				device_type = "rtc";
				compatible = "stm,m41t81";
				reg = <68>;
				};

			temp-sensor@4c {
				device_type = "temp-sensor";
				compatible = "ns,lm63";
				reg = <4c>;
			};

			temp-sensor@48 {
				device_type = "temp-sensor";
				compatible = "ns,lm75";
				reg = <48>;
			};
		
		};


		mdio@24520 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,gianfar-mdio";
			reg = <24520 20>;

			phy0: ethernet-phy@1 {
				interrupt-parent = <&mpic>;
				interrupts = <4 1>;
				reg = <1>;
				device_type = "ethernet-phy";
			};
		};

		enet0: ethernet@26000 {
			cell-index = <0>;
			device_type = "network";
			model = "FEC";
			compatible = "gianfar";
			reg = <26000 1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <29 2>;
			interrupt-parent = <&mpic>;
			phy-handle = <&phy0>;
		};


		serial0: serial@4500 {
			cell-index = <0>;
			device_type = "serial";
			compatible = "ns16550";
			reg = <4500 100>; 	// reg base, size
			clock-frequency = <0>; 	// should we fill in in uboot?
			interrupts = <2a 2>;
			interrupt-parent = <&mpic>;
		};

		mpic: pic@40000 {
			clock-frequency = <0>;
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <40000 40000>;
			compatible = "chrp,open-pic";
			device_type = "open-pic";
			big-endian;
		};

		dma@21300 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
			reg = <21300 4>;
			ranges = <0 21100 200>;
			cell-index = <0>;
			dma-channel@0 {
				compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
				reg = <0 80>;
				cell-index = <0>;
				interrupt-parent = <&mpic>;
				interrupts = <14 2>;
			};
			dma-channel@80 {
				compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
				reg = <80 80>;
				cell-index = <1>;
				interrupt-parent = <&mpic>;
				interrupts = <15 2>;
			};
			dma-channel@100 {
				compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
				reg = <100 80>;
				cell-index = <2>;
				interrupt-parent = <&mpic>;
				interrupts = <16 2>;
			};
			dma-channel@180 {
				compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
				reg = <180 80>;
				cell-index = <3>;
				interrupt-parent = <&mpic>;
				interrupts = <17 2>;
			};
		};

	};

	pci0: pci@e0008000 {
		cell-index = <0>;
		interrupt-map-mask = <f800 0 0 7>;
		interrupt-map = <

			/* IDSEL 0x12 */
			9000 0 0 1 &mpic 5 1
			9000 0 0 2 &mpic 6 1
			9000 0 0 3 &mpic 7 1
			9000 0 0 4 &mpic 8 1>;

		interrupt-parent = <&mpic>;
		interrupts = <18 2>;
		bus-range = <0 0>;
		ranges = <02000000 0 80000000 80000000 0 20000000
			  01000000 0 00000000 e2000000 0 00100000>;
		clock-frequency = <3f940aa>;
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <e0008000 1000>;
		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
		device_type = "pci";
	};
};

--u3/rZRmxL6MmkK24--
