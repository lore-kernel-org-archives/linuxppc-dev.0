Return-Path: <jeff@theptrgroup.com>
Subject: Re: cpm2-scc-uart on mpc8265 not working
From: jeff angielski <jeff@theptrgroup.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <49500029.90809@freescale.com>
References: <1229977289.19292.16.camel@penguin> <49500029.90809@freescale.com>
Content-Type: text/plain
Date: Tue, 23 Dec 2008 13:43:32 -0500
Message-Id: <1230057813.11655.27.camel@penguin>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-22 at 15:01 -0600, Scott Wood wrote:
> > 
> > 		cpm@119c0 {
> > 			#address-cells = <1>;
> > 			#size-cells = <1>;
> > 			compatible = "fsl,mrdig-cpm", "fsl,cpm2";
> > 			reg = <0x119c0 0x30>;
> > 			ranges;
> > 
> > 			muram@0 {
> > 				#address-cells = <1>;
> > 				#size-cells = <1>;
> > 				ranges = <0x0 0x0 0x10000>;
> > 
> > 				data@0 {
> > 					compatible = "fsl,cpm-muram-data";
> > 					reg = <0x0 0x2000 0x9800 0x800>;
> > 				};
> > 			};
> > 
> > 			brg@119f0 {
> > 				compatible = "fsl,mrdig-brg",
> > 				             "fsl,cpm2-brg",
> > 				             "fsl,cpm-brg";
> > 				reg = <0x119f0 0x10 0x115f0 0x10>;
> > 			};
> > 
> > 			/* TODO: I believe the SCCs are setup correctly */
> > 			/* SCC1 */
> > 			serial@11a00 {
> > 				device_type = "serial";
> > 				compatible = "fsl,mrdig-scc-uart",
> > 				             "fsl,cpm2-scc-uart";
> > 				reg = <0x11a00 0x20 0x8000 0x100>;
> > 				interrupts = <40 8>;
> > 				interrupt-parent = <&PIC>;
> > 				fsl,cpm-brg = <1>;
> > 				fsl,cpm-command = <0x0800000>;
> > 			};
> > 
> > 			/* SCC2 */
> > 			serial@11a20 {
> > 				device_type = "serial";
> > 				compatible = "fsl,mrdig-scc-uart",
> > 				             "fsl,cpm2-scc-uart";
> > 				reg = <0x11a20 0x20 0x8000 0x100>;
> > 				interrupts = <41 8>;
> > 				interrupt-parent = <&PIC>;
> > 				fsl,cpm-brg = <2>;
> > 				fsl,cpm-command = <0x4a00000>;
> > 			};
> > 
> > 			/* SCC3  - set this up now or later with SDLC? */
> > 			serial@11a40 {
> > 				device_type = "serial";
> > 				compatible = "fsl,mrdig-scc-uart",
> > 				             "fsl,cpm2-scc-uart";
> > 				reg = <0x11a40 0x20 0x8000 0x100>;
> > 				interrupts = <42 8>;
> > 				interrupt-parent = <&PIC>;
> > 				fsl,cpm-brg = <3>;
> > 				fsl,cpm-command = <0x8c00000>;
> > 			};
> 
> You're assigning the same DPRAM region to all 3 of these serial ports. 
> SCC2 is 0x8100, and SCC3 is 0x8200.  This is likely your problem.

I fixed up the DPRAM regions.  

I also fixed up the muram region which had not been updated for the
mpc8265 - it still had the old mpc8272 definitions.

The kernel does not hang anymore but I still don't see anything on the
serial port.  Using an o'scope I can see data on the line, it is just
that bit period is about 560uS - way to slow.

The bootargs have console=ttyCPMO,115200 and I can see the
cpm_uart_console_setup() is trying to set the system to 115kbps.  So at
the logical level everything appears ok.

Here is the latest DTS file.  

/dts-v1/;

/ {
	model = "MRDIG 1.1";
	compatible = "mrdig";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8265@0 {
			device_type = "cpu";
			reg = <0x0>;
			d-cache-line-size = <32>;
			i-cache-line-size = <32>;
			d-cache-size = <16384>;
			i-cache-size = <16384>;
			/* filled by u-boot */
			timebase-frequency = <0>;
			bus-frequency = <0>;	
			clock-frequency = <0>;
		};
	};

	memory {
		device_type = "memory";
		reg = <0x0 0x0>;
	};

	localbus@f0010100 {
		compatible = "mpc8265-localbus",
		             "fsl,pq2-localbus";
		#address-cells = <2>;
		#size-cells = <1>;
		reg = <0xf0010100 0x40>;

		/*
		 * BR0 flash
		 * BR1 sdram - here or in the /memory
		 * BR2 PCI
		 * BR3 Sysace
		 * BR4 CPLD
		 * BR5 FPGA
		 * BR6 FPGA
		 * BR7 FPGA
		 * BR8 FPGA
		 * BR9 FPGA
		 * BR10 AIS
		 */
		 
		 /* TODO: Do we list all ranges?
		  * TODO: What are correct size?
		  * TODO: Add FPGA regions
		  */
		ranges = <0x0 0x0 0xfe000000 0x2000000
				  0x1 0x0 0xe6000000 0x8000
				  0x2 0x0 0xe5000000 0x8000
		          0x3 0x0 0xe4000000 0x8000>;

		/* TODO: I think this is right... */
		flash@fe000000 {
			compatible = "cfi-flash";
			reg = <0x0 0xfe000000 0x2000000>;
			bank-width = <2>;
			device-width = <2>;
		};

		board-control@1,0 {
			reg = <0x1 0x0 0x20>;
			compatible = "mpc8265-bcsr";
		};

		/* How should this be setup? */
		PCI_PIC: interrupt-controller@3,0 {
			compatible = "mpc8265-pci-pic",
			             "pq2ads-pci-pic";
			#interrupt-cells = <1>;
			interrupt-controller;
			reg = <0x3 0x0 0x8>;
			interrupt-parent = <&PIC>;
			interrupts = <20 8>;
		};
	
	};


	pci@f0010800 {
		device_type = "pci";
		reg = <0xf0010800 0x10c 0xf00101ac 0x8 0xf00101c4 0x8>;
		compatible = "mpc8265-pci", "pq2-pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		clock-frequency = <66666666>;
		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
		/* TODO: what is the last field of parent */
		interrupt-map = <

			/* ourself, no IDSEL - cpci slot 1 */
			0x0000 0x0 0x0 0x1 &PCI_PIC 0
			0x0000 0x0 0x0 0x2 &PCI_PIC 1
			0x0000 0x0 0x0 0x3 &PCI_PIC 2
			0x0000 0x0 0x0 0x4 &PCI_PIC 3

			/* IDSEL 31 - cpci slot 2 */
			0xf800 0x0 0x0 0x4 &PCI_PIC 4
			0xf800 0x0 0x0 0x1 &PCI_PIC 5
			0xf800 0x0 0x0 0x2 &PCI_PIC 6
			0xf800 0x0 0x0 0x3 &PCI_PIC 7

			/* IDSEL 30 - cpci slot 3 */
			0xf000 0x0 0x0 0x3 &PCI_PIC 8
			0xf000 0x0 0x0 0x4 &PCI_PIC 9
			0xf000 0x0 0x0 0x1 &PCI_PIC 10
			0xf000 0x0 0x0 0x2 &PCI_PIC 11 

			/* IDSEL 29 - cpci slot 4 */
			0xe800 0x0 0x0 0x2 &PCI_PIC 12
			0xe800 0x0 0x0 0x3 &PCI_PIC 13
			0xe800 0x0 0x0 0x4 &PCI_PIC 14
			0xe800 0x0 0x0 0x1 &PCI_PIC 15

			/* IDSEL 28 - cpci slot 5 */
			0xe000 0x0 0x0 0x1 &PCI_PIC 16 
			0xe000 0x0 0x0 0x2 &PCI_PIC 17
			0xe000 0x0 0x0 0x3 &PCI_PIC 18
			0xe000 0x0 0x0 0x4 &PCI_PIC 19

			/* IDSEL 27 - cpci slot 6 */
			0xd800 0x0 0x0 0x4 &PCI_PIC 20
			0xd800 0x0 0x0 0x1 &PCI_PIC 21
			0xd800 0x0 0x0 0x2 &PCI_PIC 22
			0xd800 0x0 0x0 0x3 &PCI_PIC 23

			/* IDSEL 26 - cpci slot 7 */
			0xd000 0x0 0x0 0x3 &PCI_PIC 24
			0xd000 0x0 0x0 0x4 &PCI_PIC 25
			0xd000 0x0 0x0 0x1 &PCI_PIC 26
			0xd000 0x0 0x0 0x2 &PCI_PIC 27

			/* IDSEL 25 - cpci slot 8 */
			0xc800 0x0 0x0 0x3 &PCI_PIC 28
			0xc800 0x0 0x0 0x4 &PCI_PIC 29
			0xc800 0x0 0x0 0x1 &PCI_PIC 30
			0xc800 0x0 0x0 0x2 &PCI_PIC 31>;

		interrupt-parent = <&PIC>;
		interrupts = <18 8>;

		/* 
		 * processor view
		 * local address          pci address
		 * 0x80000000-0x9fffffff  0x800000000-0x9fffffff pci mem (prefetch)
		 * 0xa0000000-0xbfffffff  0xa00000000-0xbfffffff pci mem 
		 * 0xf4000000-0xf7ffffff  0x800000000-0x03ffffff pci io
		 *
		 * PCI master view
		 * 0x00000000-0x1fffffff  0x000000000-0x1fffffff local phys mem
		 */
		ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x20000000
		          0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
		          0x01000000 0x0 0x00000000 0xf4000000 0x0 0x04000000>;
	};

	soc@f0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		compatible = "mpc8265-soc","pq2-soc";
		ranges = <0x0 0xf0000000 0x53000>;

		cpm@119c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "mpc8265-cpm", "fsl,cpm2";
			reg = <0x119c0 0x30>;
			ranges;

			muram@0 {
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0x0 0x0 0x10000>;

				data@0 {
					/*
					reg = <0x0 0x2000 0x9800 0x800>;
					*/
					compatible = "fsl,cpm-muram-data";
					reg = <0x0 0x6000 0x8000 0x1000 0xb000 0x1000>;
				};
			};

			brg@119f0 {
				compatible = "mpc8265-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg = <0x119f0 0x10 0x115f0 0x10>;
			};

			/* TODO: I believe the SCCs are setup correctly */
			/* SCC1 */
			serial@11a00 {
				device_type = "serial";
				compatible = "mpc8265-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <0x11a00 0x20 0x8000 0x100>;
				interrupts = <40 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <1>;
				fsl,cpm-command = <0x0800000>;
			};

			/* SCC2 */
			serial@11a20 {
				device_type = "serial";
				compatible = "mpc8265-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <0x11a20 0x20 0x8100 0x100>;
				interrupts = <41 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <2>;
				fsl,cpm-command = <0x4a00000>;
			};

			/* SCC3  - set this up now or later with SDLC? */
			serial@11a40 {
				device_type = "serial";
				compatible = "mpc8265-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <0x11a40 0x20 0x8200 0x100>;
				interrupts = <42 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <3>;
				fsl,cpm-command = <0x8c00000>;
			};

			/* SCC4 */
			serial@11a60 {
				device_type = "serial";
				compatible = "mpc8265-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <0x11a60 0x20 0x8300 0x100>;
				interrupts = <43 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <4>;
				fsl,cpm-command = <0xce00000>;
			};

			/* TODO: Figure this out for mrdig */
			mdio@10d40 {
				device_type = "mdio";
				compatible = "mpc8265-mdio-bitbang",
				             "cpm2-mdio-bitbang";
				reg = <0x10d40 0x14>;
				#address-cells = <1>;
				#size-cells = <0>;
				mdio-pin = <18>;
				mdc-pin = <19>;

				PHY0: ethernet-phy@0 {
					interrupt-parent = <&PIC>;
					interrupts = <23 8>;
					reg = <0x0>;
					device_type = "ethernet-phy";
				};

				PHY1: ethernet-phy@1 {
					interrupt-parent = <&PIC>;
					interrupts = <23 8>;
					reg = <0x3>;
					device_type = "ethernet-phy";
				};

				/* TODO: reg and interrupt?  */
				PHY2: ethernet-phy@2 {
					interrupt-parent = <&PIC>;
					interrupts = <23 8>;
					reg = <0x3>;
					device_type = "ethernet-phy";
				};

			};

			/* FCC1 */
			ethernet@11300 {
				device_type = "network";
				compatible = "mpc8265-fcc-enet",
				             "cpm2-fcc-enet";
				reg = <0x11300 0x20 0x8400 0x100 0x11390 0x1>;
				local-mac-address = [ 00 00 00 00 00 00 ];
				interrupts = <32 8>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY0>;
				linux,network-index = <0>;
				cpm-command = <0x12000300>;
			};

			/* FCC2 */
			ethernet@11320 {
				device_type = "network";
				compatible = "mpc8265-fcc-enet",
				             "cpm2-fcc-enet";
				reg = <0x11320 0x20 0x8500 0x100 0x113b0 0x1>;
				local-mac-address = [ 00 00 00 00 00 00 ];
				interrupts = <33 8>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY1>;
				linux,network-index = <1>;
				cpm-command = <0x16200300>;
			};

			/* FCC3 */
			ethernet@11340 {
				device_type = "network";
				compatible = "mpc8265-fcc-enet",
				             "cpm2-fcc-enet";
				reg = <0x11340 0x20 0x8600 0x100 0x113d0 0x1>;
				local-mac-address = [ 00 00 00 00 00 00 ];
				interrupts = <34 8>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY2>;
				linux,network-index = <1>;
				cpm-command = <0x1ac00300>;
			};


			i2c@11860 {
				compatible = "mpc8265-i2c", "cpm2-i2c";
				reg = <0x11860 0x20 0x8afc 0x2>;
				interrupts = <1 8>;
				interrupt-parent = <&PIC>;
				cpm-command = <0x29600000>;
				#address-cells = <1>;
				#size-cells = <0>;
			};
		};

		/* TODO: What to do for us? */
		PIC: interrupt-controller@10c00 {
			#interrupt-cells = <2>;
			interrupt-controller;
			reg = <0x10c00 0x80>;
			compatible = "mpc8265-pic", "cpm2-pic";
		};
	};

	chosen {
		linux,stdout-path = "/soc/cpm/serial@11a00";
	};
};
