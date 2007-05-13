Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id E49CCDDE24
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:25:06 +1000 (EST)
Subject: Re: Fixed  PHY and MPC832x based boards don't work
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20070514003633.6710879e@localhost.localdomain>
References: <1179067171.20638.48.camel@gentoo-jocke.transmode.se>
	<20070514003633.6710879e@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 14 May 2007 00:25:03 +0200
Message-Id: <1179095103.20638.56.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 00:36 +0400, Vitaly Bordug wrote:
> On Sun, 13 May 2007 16:39:30 +0200
> Joakim Tjernlund wrote:
> 
> > Trying to make the Fixed PHY work under my 832x based board on current
> > linus tree without success. Earlier kernels with custom PHY code for
> > ucc_geth work without any special tricks.
> > 
> > If I enable the FIXED_MII_100_FDX option I get:
> > ls bus/mdio_bus/devices/
> > fixed@100:1@ 
> > 
> > but ucc_geth wants its PHYs under 
> > ls -l bus/of_platform/devices/*phy*
> > lrwxrwxrwx    1 root     root            0 May 12 17:32
> > bus/of_platform/devices/ethernet-p hy.1
> > -> ../../../devices/e0100000.qe/e0102320.mdio/ethernet-phy.1/
> > lrwxrwxrwx    1 root     root            0 May 12 17:32
> > bus/of_platform/devices/ethernet-p hy.3
> > -> ../../../devices/e0100000.qe/e0102320.mdio/ethernet-phy.3/
> > lrwxrwxrwx    1 root     root            0 May 12 17:32
> > bus/of_platform/devices/fixed-phy. 2
> > -> ../../../devices/e0100000.qe/e0102320.mdio/fixed-phy.2/ These are
> > 3 PHYs I just added in the DTS tree:
> > 
> > 		mdio@2320 {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 			reg = <2320 18>;
> > 			device_type = "mdio";
> > 			compatible = "ucc_geth_phy";
> > 
> > 			phy1: ethernet-phy@18 {
> > 				linux,phandle = <212000>;
> > 				reg = <18>; // 24
> > 				device_type = "ethernet-phy";
> > 				interface = <3>; //ENET_100_MII
> > 			};
> > 			phy2: fixed-phy@64 {
> > 				linux,phandle = <212001>;
> > 				reg = <d#100>;
> > 				device_type = "ethernet-phy";
> > 			};
> > 			phy3: ethernet-phy@19 {
> > 				linux,phandle = <212002>;
> > 				interrupt-parent = <700>;
> > 				interrupts = <12 2>;
> > 				reg = <19>; // 25
> > 				device_type = "ethernet-phy";
> > 				interface = <3>; //ENET_100_MII
> > 			};
> > 		};
> > 
> > How do I add a fixed PHY so that ucc_geth finds it?
> > 
> well I guess ucc stuff follows gianfar trend in mdio bus specification for the phy.
> So, it would look like %d:%d or something like that.
> 
> Can you please dump the whole dts here?

Sure, it look pretty much like the 832x_mds
phy2 is my experiment to get hold of the fixed phy, but the others should also be converted into a fixed phy. Here goes my DTS:

/ {
	model = "TMCUTU";
	compatible = "MPC83xx";
	#address-cells = <1>;
	#size-cells = <1>;
	linux,phandle = <100>;
	board {
		bd_version = <1>;
		slot_pos = <0>;
		board_type = <0>;
		sys_type = <0>;
		sys_mode = <0>;
		sys_rev = <0>;
		subrack_id = <0>;
		power_on_start = <0>;
		target = <0>;
		bi_r_version = "1234X1234X1234X1234X1234X1234X1234X";
		enable_usb = <0>;
	};
	flash@f8000000 {
 		device_type = "rom";
 		compatible = "direct-mapped";
		probe-type = "CFI";
 		reg = <f8000000 08000000>;
 		bank-width = <2>;
 		partitions = <00000000 00010000 /* HRCW */
 			      00010000 00008000 /* env0 */
 			      00018000 00008000 /* env1 */
 			      00020000 00040000 /* u-boot0 */
 			      00060000 00040000 /* u-boot1 */
 			      000a0000 001e0000 /* kernel */
 			      00280000 07d60000 /* JFFS2 */
			>;
 		partition-names = "HRCW\0env0\0env1\0u-boot0\0u-boot1\0kernel\0JFFS2";
 	};
	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;
		linux,phandle = <200>;

		PowerPC,8321@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <8000>;		// L1, 32K
			i-cache-size = <8000>;		// L1, 32K
			timebase-frequency = <0>; // Estimated by linux
			bus-frequency = <0>;
			clock-frequency = <0>;
			32-bit;
			linux,phandle = <201>;
//			linux,boot-cpu;
		};
	};

	memory {
		device_type = "memory";
		linux,phandle = <300>;
		reg = <00000000 10000000>; //256 MB
		//reg = <00000000 8000000>; //128 MB
	};

	soc8321@e0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		#interrupt-cells = <2>;
		device_type = "soc";
		ranges = <0 e0000000 00100000>;
		reg = <e0000000 00000200>;
		bus-frequency = <0>; //Set by boot
/*
		wdt@200 {
			device_type = "watchdog";
			compatible = "mpc83xx_wdt";
			reg = <200 100>;
		};
*/
		i2c@3000 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3000 100>;
			interrupts = <e 8>;
			interrupt-parent = <700>;
			dfsrr;
		};
/*
		i2c@3100 {
			device_type = "i2c";
			compatible = "fsl-i2c";
			reg = <3100 100>;
			interrupts = <f 8>;
			interrupt-parent = <700>;
			dfsrr;
		};
*/
		serial@4500 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4500 100>;
			clock-frequency = <0>; //Set by boot
			interrupts = <9 8>;
			interrupt-parent = <700>;
		};
/*
		serial@4600 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <4600 100>;
			clock-frequency = <FBC5200>;
			interrupts = <a 8>;
			interrupt-parent = <700>;
		};
*/
/*
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
			//desc mask is for rev1.x, we need runtime fixup for >=2.x 
			descriptor-types-mask = <01010ebf>;
		};
*/
/*
		pci@8500 {
			linux,phandle = <8500>;
			interrupt-map-mask = <f800 0 0 7>;
			interrupt-map = <
					// IDSEL 0x11 AD17
					 8800 0 0 1 700 14 8
					 8800 0 0 2 700 15 8
					 8800 0 0 3 700 16 8
					 8800 0 0 4 700 17 8
                                                                
					// IDSEL 0x12 AD18
					 9000 0 0 1 700 16 8
					 9000 0 0 2 700 17 8
					 9000 0 0 3 700 14 8
					 9000 0 0 4 700 15 8
                                                                
					// IDSEL 0x13 AD19
					 9800 0 0 1 700 17 8
					 9800 0 0 2 700 14 8
					 9800 0 0 3 700 15 8
					 9800 0 0 4 700 16 8
                                                                
					// IDSEL 0x15 AD21
					 a800 0 0 1 700 14 8
					 a800 0 0 2 700 15 8
					 a800 0 0 3 700 16 8
					 a800 0 0 4 700 17 8
                                                                
					// IDSEL 0x16 AD22
					 b000 0 0 1 700 17 8
					 b000 0 0 2 700 14 8
					 b000 0 0 3 700 15 8
					 b000 0 0 4 700 16 8
                                                                
					// IDSEL 0x17 AD23
					 b800 0 0 1 700 16 8
					 b800 0 0 2 700 17 8
					 b800 0 0 3 700 14 8
					 b800 0 0 4 700 15 8
					                        
					// IDSEL 0x18 AD24
					 c000 0 0 1 700 15 8
					 c000 0 0 2 700 16 8
					 c000 0 0 3 700 17 8
					 c000 0 0 4 700 14 8>;

			interrupt-parent = <700>;
			interrupts = <42 8>;
			bus-range = <0 0>;
			ranges = <02000000 0 a0000000 90000000 0 10000000
			          42000000 0 80000000 80000000 0 10000000
			          01000000 0 00000000 d0000000 0 00100000>; 
			clock-frequency = <3f940aa>;
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			reg = <8500 100>;
			compatible = "83xx";
			device_type = "pci";
		};
*/

// IPIC
		pic@700 {
			linux,phandle = <700>;
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <700 100>;
			built-in;
			device_type = "ipic";
		};

		par_io@1400 {
			reg = <1400 100>;
			device_type = "par_io";
			num-ports = <4>;
			ucc_pin@02 {
				linux,phandle = <140001>;
				pio-map = <
			// port  pin  dir  open_drain  assignment  has_irq
				3  4 3 0 2 0 // MDIO
				3  5 1 0 2 0 // MDC

				0 12 1 0 1 0 // TxD0, 18
				0 13 1 0 1 0 // TxD1, 19
				0 14 1 0 1 0 // TxD2, 20
				0 15 1 0 1 0 // TxD3, 21
				0 1b 1 0 1 0 // TxER, 27
				0 1e 1 0 1 0 // TxEN, 30
				3 16 2 0 1 0 // TxCLK->CLK4, 22
				0 16 2 0 1 0 // RxD0, 22
				0 17 2 0 1 0 // RxD1, 23
				0 18 2 0 1 0 // RxD2, 24
				0 19 2 0 1 0 // RxD3, 25
				0 1a 2 0 1 0 // RxER, 26
				0 1c 2 0 1 0 // RxDV, 28
				3 17 2 0 1 0 // RxCLK->CLK3, 23
				0 1d 2 0 1 0 // COL, 29
				0 1f 2 0 1 0 // CRS, 31
				>;
			};
			ucc_pin@03 {
				linux,phandle = <140002>;
				pio-map = <
				1  0 1 0 1 0 // TxD0, 0
				1  1 1 0 1 0 // TxD1, 1
				1  2 1 0 1 0 // TxD2, 2
				1  3 1 0 1 0 // TxD3, 3
				1  9 1 0 1 0 // TxER, 9
				1  c 1 0 1 0 // TxEN, 12
				3 18 2 0 1 0 // TxCLK->CLK10, 24
				1  4 2 0 1 0 // RxD0, 4
				1  5 2 0 1 0 // RxD1, 5
				1  6 2 0 1 0 // RxD2, 6
				1  7 2 0 1 0 // RxD3, 7
				1  8 2 0 1 0 // RxER, 8
				1  a 2 0 1 0 // RxDV, 10
				0  d 2 0 1 0 // RxCLK->CLK9, 13
				1  b 2 0 1 0 // COL, 11
				1  d 2 0 1 0 // CRS, 13
				>; // MDC
			};

			ucc_pin@04 {
				linux,phandle = <140003>;
				pio-map = <
				1 12 1 0 1 0 // TxD0, 18
				1 13 1 0 1 0 // TxD1, 19
				1 14 1 0 1 0 // TxD2, 20
				1 15 1 0 1 0 // TxD3, 21
				1 1b 1 0 1 0 // TxER, 27
				1 1e 1 0 1 0 // TxEN, 30
				3  6 2 0 1 0 // TxCLK->CLK8, 6
				1 16 2 0 1 0 // RxD0, 22
				1 17 2 0 1 0 // RxD1, 23
				1 18 2 0 1 0 // RxD2, 24
				1 19 2 0 1 0 // RxD3, 25
				1 1a 2 0 1 0 // RxER, 26
				1 1c 2 0 1 0 // RxDV, 28
				3 1f 2 0 1 0 // RxCLK->CLK7, 31
				1 1d 2 0 1 0 // COL, 29
				1 1f 2 0 1 0 // CRS, 31
				>; // MDC

			};
		};
	};

// QE
	qe@e0100000 {
		#address-cells = <1>;
		#size-cells = <1>;
		//#interrupt-cells = <2>;
		device_type = "qe";
		model = "QE";
		ranges = <0 e0100000 00100000>;
		reg = <e0100000 480>;
		brg-frequency = <0>; // set by boot
		bus-frequency = <0>; // set by boot

		muram@10000 {
			device_type = "muram";
			ranges = <0 00010000 00004000>;

			data-only@0{
				reg = <0 4000>;
			};
		};
		spi@4c0 {
			device_type = "spi";
			compatible = "fsl_spi";
			reg = <4c0 40>;
			interrupts = <2>;
			interrupt-parent = <80>;
			mode = "cpu";
		};
/*
		spi@500 {
			device_type = "spi";
			compatible = "fsl_spi";
			reg = <500 40>;
			//interrupts = <81 0>;
			interrupts = <1>;
			interrupt-parent = <80>;
			mode = "cpu";
		};
*/
		brg@640 {
			device_type = "brg";
			reg = <668 4>;
		};

		usb@6c0 {
			device_type = "usb";
			compatible = "qe_udc";
			reg = <6c0 40 8B00 100>;
			//reg_pram = <8B00 100>;
			interrupts = <b>;
			interrupt-parent = <80>;
			mode = "slave";
		};

		ucc@3000 { //UCC2
			device_type = "network";
			compatible = "ucc_geth";
			model = "UCC";
			device-id = <2>;
			reg = <3000 200>;
			interrupts = <21>;
			interrupt-parent = <80>;
			mac-address = [ 00 04 9f 00 23 23 ];
			rx-clock = <13>; //CLK3 19
			tx-clock = <14>; //CLK4 20
			phy-handle = <&phy1>;
			phy-connection-type = "mii";
			max-speed = <64>; // 100
			pio-handle = <140001>;
		};

		ucc@2200 { //UCC3
			device_type = "network";
			compatible = "ucc_geth";
			model = "UCC";
			device-id = <3>;
			reg = <2200 200>;
			interrupts = <22>;
			interrupt-parent = <80>;
			mac-address = [ 00 11 22 33 44 55 ];
			rx-clock = <19>; //CLK9, 25
			tx-clock = <1a>; //CLK10, 26
			phy-handle = <&phy2>;
			phy-connection-type = "mii";
			max-speed = <64>; // d#100
			pio-handle = <140002>;
		};

		ucc@3200 { //UCC4
			device_type = "network";
			compatible = "ucc_geth";
			model = "UCC";
			device-id = <4>;
			reg = <3200 200>;
			interrupts = <23>;
			interrupt-parent = <80>;
			mac-address = [ 00 11 22 33 44 99 ];
			rx-clock = <17>; //CLK7, 23
			tx-clock = <18>; //CLK8, 24
			phy-handle = <212002>;
			phy-connection-type = "mii";
			max-speed = <d#100>; //d#100
			pio-handle = <140003>;
		};

		mdio@2320 {
			#address-cells = <1>;
			#size-cells = <0>;
			reg = <2320 18>;
			device_type = "mdio";
			compatible = "ucc_geth_phy";

			phy1: ethernet-phy@18 {
				linux,phandle = <212000>;
				reg = <18>; // 24
				device_type = "ethernet-phy";
				interface = <3>; //ENET_100_MII
			};
			phy2: fixed-phy@64 {
				linux,phandle = <212001>;
				reg = <d#100>;
				device_type = "ethernet-phy";
			};
			phy3: ethernet-phy@19 {
				linux,phandle = <212002>;
				interrupt-parent = <700>;
				interrupts = <12 2>;
				reg = <19>; // 25
				device_type = "ethernet-phy";
				interface = <3>; //ENET_100_MII
			};
		};

		qeic@80 {
			linux,phandle = <80>;
			interrupt-controller;
			device_type = "qeic";
			#address-cells = <0>;
			#interrupt-cells = <1>;
			reg = <80 80>;
			built-in;
			big-endian;
			interrupts = <20 8 21 8>; //high:32 low:33
			interrupt-parent = <700>;
		};

	};
};
