Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id DC644B6EF2
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Apr 2011 09:43:39 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.52])
	by hrndva-qmta02.mail.rr.com with ESMTP
	id <20110403232351078.JUIZ5185@hrndva-qmta02.mail.rr.com>
	for <linuxppc-dev@ozlabs.org>; Sun, 3 Apr 2011 23:23:51 +0000
Date: Sun, 3 Apr 2011 18:22:13 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: problem PCIe LSI detected at 32 device addresses (ppc460ex)
Message-ID: <20110403232213.GA28042@crust.elkhashab.com>
References: <20110401162619.GA20132@crust.elkhashab.com>
	<20110401225903.GA27320@crust.elkhashab.com>
	<1301867559.2549.32.camel@pasglop>
	<BANLkTikTeAgc2dg3-M7yM185pg7FAdbAGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTikTeAgc2dg3-M7yM185pg7FAdbAGw@mail.gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sun, Apr 03, 2011 at 04:09:26PM -0600, Grant Likely wrote:
> On Sun, Apr 3, 2011 at 3:52 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> >> Ok, I've narrowed the scope of the problem some. ?I moved forward
> >> to a more recent kernel (2.6.31 to 2.6.36) and that resolved the
> >> problem of the controller showing up as every device on the bus.
> >> However, from 2.6.37 to the current HEAD, I have not been able to
> >> build a kernel to run on the 460EX. ?I tried 2.6.37, 2.6.38, and
> >> the HEAD and all result in the following kernel panic. ?I am not
> >> sure how to proceed here. ?I suppose we can stick with 2.6.36 since
> >> it works, but I'd like to understand what it might take to remedy
> >> this.
> >
> > Smells like somebody changed something with the OF flash code... Josh,
> > Grant, any idea what's up there ?
> 
> Not sure, more information would be helpful.
> 
> Ayman, if you do a 'git log v2.6.36.. drivers/mtd/maps/physmap_of.c',
> then you'll see a list of commits touching the mtd driver.  Would you
> be able to do a 'git checkout <sha1-id>' on each of those are report
> back on at what point things stop working?  Actually, a full bisect
> between 2.6.36 and 2.6.37 would be best, but this is a good start if
> you're limited on time.  Once you find the first commit where it
> fails, do a 'git checkout <sha1>~1' to confirm that it is in fact the
> commit that causes the breakage.

I can try to find the commit tomorrow.  In the interim, i've pasted
the dts below.  The board was originally based on the canyonlands, but
we've made some changes, mostly to the pcie.  we run the 1-l port in 
endpoint mode, we have a chain of plx switches and devices on the 4-l 
port.  One item that I don't think would matter, but is not too common 
is that we are booting these over the pci bus from another PPCs memory.
I only mention this since this failure is during boot, though everything
should by local to the cpu by this time.

> 
> Can you also post your device tree please?

Here is the device tree for our custom board.


/dts-v1/;

/ {
	#address-cells = <2>;
	#size-cells = <1>;
	model = "amcc,canyonlands";
	compatible = "amcc,canyonlands";
	dcr-parent = <&{/cpus/cpu@0}>;

	aliases {
		ethernet0 = &EMAC0;
		ethernet1 = &EMAC1;
		serial0 = &UART0;
		serial1 = &UART1;
	};

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu@0 {
			device_type = "cpu";
			model = "PowerPC,460EX";
			reg = <0x00000000>;
			clock-frequency = <0>; /* Filled in by U-Boot */
			timebase-frequency = <0>; /* Filled in by U-Boot */
			i-cache-line-size = <32>;
			d-cache-line-size = <32>;
			i-cache-size = <32768>;
			d-cache-size = <32768>;
			dcr-controller;
			dcr-access-method = "native";
		};
	};

	memory {
		device_type = "memory";
		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by U-Boot */
	};

	UIC0: interrupt-controller0 {
		compatible = "ibm,uic-460ex","ibm,uic";
		interrupt-controller;
		cell-index = <0>;
		dcr-reg = <0x0c0 0x009>;
		#address-cells = <0>;
		#size-cells = <0>;
		#interrupt-cells = <2>;
	};

	UIC1: interrupt-controller1 {
		compatible = "ibm,uic-460ex","ibm,uic";
		interrupt-controller;
		cell-index = <1>;
		dcr-reg = <0x0d0 0x009>;
		#address-cells = <0>;
		#size-cells = <0>;
		#interrupt-cells = <2>;
		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
		interrupt-parent = <&UIC0>;
	};

	UIC2: interrupt-controller2 {
		compatible = "ibm,uic-460ex","ibm,uic";
		interrupt-controller;
		cell-index = <2>;
		dcr-reg = <0x0e0 0x009>;
		#address-cells = <0>;
		#size-cells = <0>;
		#interrupt-cells = <2>;
		interrupts = <0xa 0x4 0xb 0x4>; /* cascade */
		interrupt-parent = <&UIC0>;
	};

	UIC3: interrupt-controller3 {
		compatible = "ibm,uic-460ex","ibm,uic";
		interrupt-controller;
		cell-index = <3>;
		dcr-reg = <0x0f0 0x009>;
		#address-cells = <0>;
		#size-cells = <0>;
		#interrupt-cells = <2>;
		interrupts = <0x10 0x4 0x11 0x4>; /* cascade */
		interrupt-parent = <&UIC0>;
	};

	SDR0: sdr {
		compatible = "ibm,sdr-460ex";
		dcr-reg = <0x00e 0x002>;
	};

	CPR0: cpr {
		compatible = "ibm,cpr-460ex";
		dcr-reg = <0x00c 0x002>;
	};

	L2C0: l2c {
		compatible = "ibm,l2-cache-460ex", "ibm,l2-cache";
		dcr-reg = <0x020 0x008			/* Internal SRAM DCR's */
			   0x030 0x008>;		/* L2 cache DCR's */
		cache-line-size = <32>;		/* 32 bytes */
		cache-size = <262144>;		/* L2, 256K */
		interrupt-parent = <&UIC2>;
		interrupts = <0x17 0x1>;
	};

	plb {
		compatible = "ibm,plb-460ex", "ibm,plb4";
		#address-cells = <2>;
		#size-cells = <1>;
		ranges;
		clock-frequency = <0>; /* Filled in by U-Boot */

		SDRAM0: sdram {
			compatible = "ibm,sdram-460ex", "ibm,sdram-405gp";
			dcr-reg = <0x010 0x002>;
		};

		MAL0: mcmal {
			compatible = "ibm,mcmal-460ex", "ibm,mcmal2";
			dcr-reg = <0x180 0x062>;
			num-tx-chans = <2>;
			num-rx-chans = <16>;
			#address-cells = <0>;
			#size-cells = <0>;
			interrupt-parent = <&UIC2>;
			interrupts = <	/*TXEOB*/ 0x6 0x4
					/*RXEOB*/ 0x7 0x4
					/*SERR*/  0x3 0x4
					/*TXDE*/  0x4 0x4
					/*RXDE*/  0x5 0x4>;
		};

		SATA0: sata@bffd1000 {
			compatible = "amcc,sata-460ex";
			reg = <0x00000004 0xbffd1000 0x00000800	/* SATA */
			       0x00000004 0xbffd0800 0x00000400>;	/* AHBDMA */
			interrupt-parent = <&UIC3>;
			interrupts = <0x0 0x4	/* SATA */
				      0x5 0x4>;	/* AHBDMA */
		};

		POB0: opb {
			compatible = "ibm,opb-460ex", "ibm,opb";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0xb0000000 0x00000004 0xb0000000 0x50000000>;
			clock-frequency = <0>; /* Filled in by U-Boot */

			EBC0: ebc {
				compatible = "ibm,ebc-460ex", "ibm,ebc";
				dcr-reg = <0x012 0x002>;
				#address-cells = <2>;
				#size-cells = <1>;
				clock-frequency = <0>; /* Filled in by U-Boot */
				/* ranges property is supplied by U-Boot */
				interrupts = <0x6 0x4>;
				interrupt-parent = <&UIC1>;

				flash@1,0 {
					compatible = "cfi-flash";
					reg=<0x00000000 0x00000000 0x01000000>;
					bank-width = <2>;
				};

			};

			UART0: serial@ef600300 {
				device_type = "serial";
				compatible = "ns16550";
				reg = <0xef600300 0x00000008>;
				virtual-reg = <0xef600300>;
				clock-frequency = <0>; /* Filled in by U-Boot */
				current-speed = <0>; /* Filled in by U-Boot */
				interrupt-parent = <&UIC1>;
				interrupts = <0x1 0x4>;
			};

			UART1: serial@ef600400 {
				device_type = "serial";
				compatible = "ns16550";
				reg = <0xef600400 0x00000008>;
				virtual-reg = <0xef600400>;
				clock-frequency = <0>; /* Filled in by U-Boot */
				current-speed = <0>; /* Filled in by U-Boot */
				interrupt-parent = <&UIC0>;
				interrupts = <0x1 0x4>;
			};

                        IIC0: i2c@ef600700 {
                                compatible = "ibm,iic-460ex", "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic" ;
                                reg = <0xef600700 0x00000014>;
                                interrupt-parent = <&UIC0>;
                                interrupts = <0x2 0x4>;
                                #address-cells = <1>;
                                #size-cells = <0>;

				at24@50 {
					compatible = "at,24c128";
					reg = <0x50>;
				};
				spd@51 {
					compatible = "at,spd";
					reg = <0x51>;
				};
				at24@52 {
					compatible = "at,24c128";
					reg = <0x52>;
				};
				at24@53 {
					compatible = "at,24c128";
					reg = <0x53>;
				};
				at24@54 {
					compatible = "at,24c128";
					reg = <0x54>;
				};
				at24@55 {
					compatible = "at,24c128";
					reg = <0x55>;
				};
				at24@56 {
					compatible = "at,24c128";
					reg = <0x56>;
				};
				tmp423@4c {
					compatible = "ti,tmp423";
					reg = <0x4c>;
				};
				pcf8575@27 {
					compatible = "ph,pcf8575";
					reg = <0x27>;
				};
				pcf8575@21 {
					compatible = "ph,pcf8575";
					reg = <0x21>;
				};
				pcf8575@20 {
					compatible = "ph,pcf8575";
					reg = <0x20>;
				};



                        };

                        GPIO0: gpio@ef600b00 {
                                compatible = "ibm,ppc4xx-gpio", "ibm,440ep-gpio";
                                reg = <0xef600b00 0x00000048>;
				#gpio-cells = <2>;
				gpio-controller;
                        };

                        GPIO1: gpio@ef600c00 {
                                compatible = "ibm,ppc4xx-gpio", "ibm,440ep-gpio";
                                reg = <0xef600c00 0x00000048>;
				#gpio-cells = <2>;
				gpio-controller;
                        };


 

			ZMII0: emac-zmii@ef600d00 {
				compatible = "ibm,zmii-460ex", "ibm,zmii";
				reg = <0xef600d00 0x0000000c>;
			};

			RGMII0: emac-rgmii@ef601500 {
				compatible = "ibm,rgmii-460ex", "ibm,rgmii";
				reg = <0xef601500 0x00000008>;
				has-mdio;
			};

			TAH0: emac-tah@ef601350 {
				compatible = "ibm,tah-460ex", "ibm,tah";
				reg = <0xef601350 0x00000030>;
			};

			TAH1: emac-tah@ef601450 {
				compatible = "ibm,tah-460ex", "ibm,tah";
				reg = <0xef601450 0x00000030>;
			};

			EMAC0: ethernet@ef600e00 {
				device_type = "network";
				compatible = "ibm,emac-460ex", "ibm,emac4";
				interrupt-parent = <&EMAC0>;
				interrupts = <0x0 0x1>;
				#interrupt-cells = <1>;
				#address-cells = <0>;
				#size-cells = <0>;
				interrupt-map = </*Status*/ 0x0 &UIC2 0x10 0x4
						 /*Wake*/   0x1 &UIC2 0x14 0x4>;
				reg = <0xef600e00 0x00000070>;
				local-mac-address = [000000000000]; /* Filled in by U-Boot */
				mal-device = <&MAL0>;
				mal-tx-channel = <0>;
				mal-rx-channel = <0>;
				cell-index = <0>;
				max-frame-size = <9000>;
				rx-fifo-size = <4096>;
				tx-fifo-size = <2048>;
				phy-mode = "rgmii";
				phy-map = <0x00000000>;
				rgmii-device = <&RGMII0>;
				rgmii-channel = <0>;
				tah-device = <&TAH0>;
				tah-channel = <0>;
				has-inverted-stacr-oc;
				has-new-stacr-staopc;
			};

			EMAC1: ethernet@ef600f00 {
				device_type = "network";
				compatible = "ibm,emac-460ex", "ibm,emac4";
				interrupt-parent = <&EMAC1>;
				interrupts = <0x0 0x1>;
				#interrupt-cells = <1>;
				#address-cells = <0>;
				#size-cells = <0>;
				interrupt-map = </*Status*/ 0x0 &UIC2 0x11 0x4
						 /*Wake*/   0x1 &UIC2 0x15 0x4>;
				reg = <0xef600f00 0x00000070>;
				local-mac-address = [000000000000]; /* Filled in by U-Boot */
				mal-device = <&MAL0>;
				mal-tx-channel = <1>;
				mal-rx-channel = <8>;
				cell-index = <1>;
				max-frame-size = <9000>;
				rx-fifo-size = <4096>;
				tx-fifo-size = <2048>;
				phy-mode = "rgmii";
				phy-map = <0x00000000>;
				rgmii-device = <&RGMII0>;
				rgmii-channel = <1>;
				tah-device = <&TAH1>;
				tah-channel = <1>;
				has-inverted-stacr-oc;
				has-new-stacr-staopc;
				mdio-device = <&EMAC0>;
			};
		};

		PCIX0: pci@c0ec00000 {
			device_type = "pci";
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			compatible = "ibm,plb-pcix-460ex", "ibm,plb-pcix";
			primary;
			large-inbound-windows;
			enable-msi-hole;
			reg = <0x0000000c 0x0ec00000   0x00000008	/* Config space access */
			       0x00000000 0x00000000 0x00000000		/* no IACK cycles */
			       0x0000000c 0x0ed00000   0x00000004   /* Special cycles */
			       0x0000000c 0x0ec80000 0x00000100	/* Internal registers */
			       0x0000000c 0x0ec80100  0x000000fc>;	/* Internal messaging registers */

			/* Outbound ranges, one memory and one IO,
			 * later cannot be changed
			 */
			ranges = <0x02000000 0x00000000 0x80000000 0x0000000d 0x80000000 0x00000000 0x80000000
				  0x01000000 0x00000000 0x00000000 0x0000000c 0x08000000 0x00000000 0x00010000>;

			/* Inbound 2GB range starting at 0 */
			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;

			/* This drives busses 0 to 0x3f */
			bus-range = <0x0 0x3f>;

			/* All PCI interrupts are routed to ext IRQ 2 -> UIC1-0 */
			interrupt-map-mask = <0x0 0x0 0x0 0x0>;
			interrupt-map = < 0x0 0x0 0x0 0x0 &UIC1 0x0 0x8 >;
		};

		PCIE0: pciex@d00000000 {
			device_type = "pci-endpoint";
                        vendor-id=<0x0222>;
                        device-id=<0xaeae>;
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			compatible = "ibm,plb-pciex-460ex", "ibm,plb-pciex";
			primary;
			port = <0x0>; /* port number */
			reg = <0x0000000d 0x00000000 0x20000000	/* Config space access */
			       0x0000000c 0x08010000 0x00001000>;	/* Registers */
			dcr-reg = <0x100 0x020>;
			sdr-base = <0x300>;

			/* Outbound ranges, one memory and one IO,
			 * later cannot be changed
			 */
			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;

			/* Inbound 2GB range starting at 0 */
			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;

			/* This drives busses 40 to 0x7f */
			bus-range = <0x40 0x7f>;

			/* Legacy interrupts (note the weird polarity, the bridge seems
			 * to invert PCIe legacy interrupts).
			 * We are de-swizzling here because the numbers are actually for
			 * port of the root complex virtual P2P bridge. But I want
			 * to avoid putting a node for it in the tree, so the numbers
			 * below are basically de-swizzled numbers.
			 * The real slot is on idsel 0, so the swizzling is 1:1
			 */
			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
			interrupt-map = <
				0x0 0x0 0x0 0x1 &UIC3 0xc 0x4 /* swizzled int A */
				0x0 0x0 0x0 0x2 &UIC3 0xd 0x4 /* swizzled int B */
				0x0 0x0 0x0 0x3 &UIC3 0xe 0x4 /* swizzled int C */
				0x0 0x0 0x0 0x4 &UIC3 0xf 0x4 /* swizzled int D */>;
		};

		PCIE1: pciex@d20000000 {
			device_type = "pci";
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			compatible = "ibm,plb-pciex-460ex", "ibm,plb-pciex";
			primary;
			port = <0x1>; /* port number */
			reg = <0x0000000d 0x20000000 0x20000000	/* Config space access */
			       0x0000000c 0x08011000 0x00001000>;	/* Registers */
			dcr-reg = <0x120 0x020>;
			sdr-base = <0x340>;

			/* Outbound ranges, one memory and one IO,
			 * later cannot be changed
			 */
			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x00000000 0x80000000
				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 0x00010000>;

			/* Inbound 2GB range starting at 0 */
			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;

			/* This drives busses 80 to 0xbf */
			bus-range = <0x80 0xbf>;

			/* Legacy interrupts (note the weird polarity, the bridge seems
			 * to invert PCIe legacy interrupts).
			 * We are de-swizzling here because the numbers are actually for
			 * port of the root complex virtual P2P bridge. But I want
			 * to avoid putting a node for it in the tree, so the numbers
			 * below are basically de-swizzled numbers.
			 * The real slot is on idsel 0, so the swizzling is 1:1
			 */
			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
			interrupt-map = <
				0x0 0x0 0x0 0x1 &UIC3 0x10 0x4 /* swizzled int A */
				0x0 0x0 0x0 0x2 &UIC3 0x11 0x4 /* swizzled int B */
				0x0 0x0 0x0 0x3 &UIC3 0x12 0x4 /* swizzled int C */
				0x0 0x0 0x0 0x4 &UIC3 0x13 0x4 /* swizzled int D */>;
		};
	};
};
