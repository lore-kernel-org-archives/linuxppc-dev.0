Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id D2127DDE04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 09:53:02 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KyaCI-0007gW-0a
	for linuxppc-dev@ozlabs.org; Fri, 07 Nov 2008 14:52:58 -0800
Message-ID: <20389723.post@talk.nabble.com>
Date: Fri, 7 Nov 2008 14:52:58 -0800 (PST)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: How to add my device node in the device tree
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,
My board processor is MPC8555, it is an AMC board.
i want to add a node for my device to the device tree.

simply here is the old device tree :
***************************************
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
****************************************

i want to add a node for the DMA in this tree. the PIC PDF tells me that DMA
channel 0 is connected to Internal interrupt number 4 so i add the following
node just before the pic node & after the serial node:

******************************************

		DMA@21100 {
			reg = <21100 44>;
			interrupts = <4 2>;  
			interrupt-parent = <40000>;		
		};
******************************************

but when i called the of_find_node_by_name(NULL, "DMA");
unfortunately it returns NULL & i cant the a node with such a name.
i have checked this by printing all of the nodes in my tree which are:
cpus
PowerPC,8555
memory
soc8555
i2c
mdio
...
serial
pic
choosen
choosen

without a node of name DMA for sure.
so what else should i do to create this node?
thanks in advance for your help.

-- 
View this message in context: http://www.nabble.com/How-to-add-my-device-node-in-the-device-tree-tp20389723p20389723.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
