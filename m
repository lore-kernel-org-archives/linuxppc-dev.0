Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 76419DDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 22:41:26 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so1827364rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 03:41:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090216180857.GA18069@ld0162-tx32.am.freescale.net>
References: <f234e2140902160355p148c99d1qc2e5b6f6ae9a716f@mail.gmail.com>
	<20090216180857.GA18069@ld0162-tx32.am.freescale.net>
Date: Tue, 17 Feb 2009 17:11:24 +0530
Message-ID: <f234e2140902170341y31662e8fla8a8cf87473ed419@mail.gmail.com>
Subject: Re: Regarding irq_of_parse_and_map
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I added the gpio node as follows to mpc8313erdb.dts;

gpio@c00 {
	linux,phandle = <c00>;
	device_type = "gpio";
	compatible = "";
	reg = <c00 100>;
	interrupts = <4a 8>;
	interrupt-parent = <700>;
	};

The only thing I need to know what should I write at 'compatible' tag
? ? ? the compatible tag format is "manufacturer,model" the
manufacturer is 'fsl' i.e. I think freescale but the model, as it is
the model number where I can find this model ? ? ? Please let me know
... thanks ...

Also I would like to ask if the above device node is written according
to bindings ... I think it should be right as I referred
'bootingwithout-of.txt' ... but please correct me if I am worng ? ? ?

If yes then I would like to confirm my further action is to compile
with dtc and create dtb and load it on the target and boot the board
... Am I Right ? ? ?

Kindly please acknowledge ... thank you ...

Following is the content of mpc8313erdb.dts to make it sure if it is
in bindings ...
################### DTS ##############################
/* MPC8313E RDB Device Tree Source */

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
###################### END #######################################

Kind Regards,
Vijay Nikam

On 2/16/09, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, Feb 16, 2009 at 05:25:23PM +0530, Vijay Nikam wrote:
> > 2. Also I would like to ask how I can determine the virtual irq using
> > irq_of_parse_and_map (struct device_node *dev, int index)  ? ? ?
> >
> > here I am not getting what I should pass *dev and index ? ? ? as in my
> > mpc8313erdb.dts I could not find any node name 'gpio' so I do not know
> > what I can use ...
>
> You'd need to add a gpio node to the device tree.  If you do this, be
> sure to follow existing bindings.
>
> >
> > Kindly please acknowledge ... thank you ...
> >
> > Following is the content of mpc8313erdb.dts
>
> That device tree looks very old, as if it came from a BSP rather than
> upstream Linux.
>
> -Scott
>
