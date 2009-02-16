Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by ozlabs.org (Postfix) with ESMTP id B48E9DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 22:55:26 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so1415397rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 03:55:23 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 16 Feb 2009 17:25:23 +0530
Message-ID: <f234e2140902160355p148c99d1qc2e5b6f6ae9a716f@mail.gmail.com>
Subject: Regarding irq_of_parse_and_map
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All,

I have mpc8313erdb evaluation board and writing GPIO driver for it. I
know that it is not possible to use directly hardware_irq_number given
from the processor manual. In my case hardware _irq_number is 74 (for
GPIO). As request_irq uses the virtual irq.

So to know or determine what virtual irq it gives I tried with
irq_create_mapping and passed host = NULL and hwirq = 74.

virt_irq = irq_create_mapping (NULL, 74);

the value it gives me is the same as hwirq no. i.e. 74. also the
module is inserted properly and the GPIO is toggling.

1. Here I would like to ask is the way I have done is right ? ? ?
especially the host parameter I have set to NULL; as in this case it
uses default controller, so I chose to use NULL.

2. Also I would like to ask how I can determine the virtual irq using
irq_of_parse_and_map (struct device_node *dev, int index)  ? ? ?

here I am not getting what I should pass *dev and index ? ? ? as in my
mpc8313erdb.dts I could not find any node name 'gpio' so I do not know
what I can use ...

Kindly please acknowledge ... thank you ...

Following is the content of mpc8313erdb.dts
###################### Start #############################
/*
 * MPC8313E RDB Device Tree Source  */
/ {
	model = "MPC8313ERDB";
	compatible = "mpc83xx";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8313@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <4000>;		// L1, 16K
			i-cache-size = <4000>;		// L1, 16K
			timebase-frequency = <0>;	// from bootloader
			bus-frequency = <0>;		// from bootloader
			clock-frequency = <0>;		// from bootloader
			32-bit;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 08000000>;	// 128MB at 0
	};

	nand0 {
		device_type = "nand";
		compatible = "fsl-nand";
		linux,phandle = <301>;
		reg = <e2800000 2000>;
		/*partitions = "nand0:1m(u-boot)ro,3m(kernel),-(jffs2)";*/
	};

	soc8313@e0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		#interrupt-cells = <2>;
		device_type = "soc";
		ranges = <0 e0000000 00100000>;
		reg = <e0000000 00000200>;
		bus-frequency = <0>;

		wdt@200 {
			device_type = "watchdog";
			compatible = "mpc83xx_wdt";
			reg = <200 100>;
		};

		i2c@3000 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3000 100>;
			interrupts = <e 8>;
			interrupt-parent = <700>;
			dfsrr;
		};

		i2c@3100 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3100 100>;
			interrupts = <f 8>;
			interrupt-parent = <700>;
			dfsrr;
		};

		spi@7000 {
			device_type = "spi";
			compatible = "mpc83xx_spi";
			reg = <7000 1000>;
			interrupts = <10 8>;
			interrupt-parent = <700>;
			mode = <0>;
		};

		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
		usb@23000 {
			device_type = "usb";
			compatible = "fsl-usb2-dr";
			reg = <23000 1000>;
			#address-cells = <1>;
			#size-cells = <0>;
			interrupt-parent = <700>;
			interrupts = <26 2>;
			phy_type = "utmi_wide";
			control_init  = <00000280>; // UTMI ext 48 MHz clk
			sleep = <b00 00300000>;
		};

		mdio@24520 {
			device_type = "mdio";
			compatible = "gianfar";
			reg = <24520 20>;
			#address-cells = <1>;
			#size-cells = <0>;
			linux,phandle = <24520>;
			ethernet-phy@1 {
				linux,phandle = <2452001>;
				interrupt-parent = <700>;
				interrupts = <13 2>;
				reg = <1>;
				device_type = "ethernet-phy";
			};
			ethernet-phy@4 {
				linux,phandle = <2452004>;
				interrupt-parent = <700>;
				interrupts = <14 2>;
				reg = <4>;
				device_type = "ethernet-phy";
			};
		};

		ethernet@24000 {
			device_type = "network";
			model = "eTSEC";
			compatible = "gianfar";
			reg = <24000 1000>;
			regs_1588 = <24000 24fff>;
			address = [ 00 00 00 00 00 00 ];
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <25 8 24 8 23 8>;
			interrupt-parent = <700>;
			phy-handle = <2452001>;
			sleep = <b00 20000000>;
			fsl,magic-packet;
		};

		ethernet@25000 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "eTSEC";
			compatible = "gianfar";
			reg = <25000 1000>;
			regs_1588 = <24000 24fff>;
			address = [ 00 00 00 00 00 00 ];
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <22 8 21 8 20 8>;
			interrupt-parent = <700>;
			phy-handle = <2452004>;
			sleep = <b00 10000000>;
			fsl,magic-packet;
		};

		serial@4500 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4500 100>;
			clock-frequency = <0>;
			interrupts = <9 8>;
			interrupt-parent = <700>;
		};

		serial@4600 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4600 100>;
			clock-frequency = <0>;
			interrupts = <a 8>;
			interrupt-parent = <700>;
		};

		pci@8500 {
			interrupt-map-mask = <f800 0 0 7>;
			interrupt-map = <

					/* IDSEL 0x0E -mini PCI */
					 7000 0 0 1 700 12 8
					 7000 0 0 2 700 12 8
					 7000 0 0 3 700 12 8
					 7000 0 0 4 700 12 8

					/* IDSEL 0x0F - PCI slot */
					 7800 0 0 1 700 11 8
					 7800 0 0 2 700 12 8
					 7800 0 0 3 700 11 8
					 7800 0 0 4 700 12 8>;
			interrupt-parent = <700>;
			interrupts = <42 8>;
			bus-range = <0 0>;
			ranges = <02000000 0 90000000 90000000 0 10000000
			          42000000 0 80000000 80000000 0 10000000
			          01000000 0 00000000 e2000000 0 00100000>;
			clock-frequency = <3f940aa>;
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			reg = <8500 100>;
			compatible = "83xx";
			device_type = "pci";
			sleep = <b00 00010000>;
		};

		/* May need to remove if on a part without crypto engine */
		crypto@30000 {
			device_type = "crypto";
			model = "SEC2";
			compatible = "talitos";
			reg = <30000 10000>;
			interrupts = <b 8>;
			interrupt-parent = <700>;
			num-channels = <4>;
			channel-fifo-len = <18>;
			exec-units-mask = <0000007e>;
			/* desc mask is for rev2.0,
			 * we need runtime fixup for >2.0 */
			descriptor-types-mask = <01010ebf>;
			sleep = <b00 03000000>;
		};

		/* IPIC
		 * interrupts cell = <intr #, sense>
		 * sense values match linux IORESOURCE_IRQ_* defines:
		 * sense == 8: Level, low assertion
		 * sense == 2: Edge, high-to-low change
		 */
		pic@700 {
			linux,phandle = <700>;
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <700 100>;
			built-in;
			device_type = "ipic";
		};

		elbc@5000 {
			linux,phandle = <5000>;
			device_type = "elbc";
			compatible = "fsl-elbc";
			reg = <5000 1000>;
			interrupts = <4d 8>;
			interrupt-parent = <700>;
		};

		power@b00 {
			linux,phandle = <b00>;
			device_type = "power";
			compatible = "fsl,mpc831x-pmc", "fsl,mpc83xx-pmc";
			reg = <b00 100
				a00 100>;
			interrupts = <50 8>;
			interrupt-parent = <700>;
		};

		timer@500 {
			linux,phandle = <500>;
			device_type = "timer";
			compatible = "fsl,mpc831x-gtm", "fsl,mpc83xx-gtm";
			reg = <500 100>;
			interrupts = <48 8>;
			interrupt-parent = <700>;
		};
	};
};


Kind Regards,
Vijay Nikam
