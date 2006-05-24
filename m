Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 1CC5267B1B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 17:23:44 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4O7dwHM013590
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 00:39:58 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4O7NdRp008349
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 02:23:41 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306425AB9@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Wed, 24 May 2006 15:23:37 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> On May 18, 2006, at 3:05 AM, Zang Roy-r61911 wrote:
> 
> >>
> >>> The tsi108 serial port is not a sub node of "soc".  well, 
> any way, I 
> >>> can try soc!
> >>
> >> What is it ? Where is it ? "soc" is a bit of a generic name for 
> >> something in the device-tree in fact... we might want to 
> define a way 
> >> to expose any bus via some kind of soc mecanism even if it's not a 
> >> root bus.
> >>
> >>
> > Should I just use add_legacy_soc_port() instead of a new function 
> > add_legacy_tsi_port()?
> 
> I think seeing your dts will help here.  We need to have a 
> concept of a "bridge" that may be similar to an "soc".
mpc7448hpc2 dts :
/*
 * MPC7448HPC2 (Taiga) board Device Tree Source
 *
 * Copyright 2006 Freescale Semiconductor Inc.
 * 2006 Roy Zang <Roy Zang at freescale.com>.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */


/ {
	model = "mpc7448hpc2";
	compatible = "mpc74xx";
	#address-cells = <1>;
	#size-cells = <1>;
	linux,phandle = <100>;

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells =<0>;
		linux,phandle = <200>;
				
		PowerPC,7448@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <8000>;		// L1, 32K bytes
			i-cache-size = <8000>;		// L1, 32K bytes
			timebase-frequency = <0>;	// 33 MHz, from uboot
			clock-frequency = <0>;		// From U-Boot
			bus-frequency = <0>;		// From U-Boot
			32-bit;
			linux,phandle = <201>;
			linux,boot-cpu;
		};
	};

	memory {
		device_type = "memory";
		linux,phandle = <300>;
		reg = <00000000 20000000	// DDR2   512M at 0
		       >;
	};

  	tsi108@c0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		#interrupt-cells = <2>;
		device_type = "tsi-bridge";
		ranges = <00000000 c0000000 00010000>;
		reg = <c0000000 00010000>;
		bus-frequency = <0>;

		i2c@7000 {
			interrupt-parent = <7400>;
			interrupts = <E 3>;
			reg = <7000 400>;
			device_type = "i2c";
			compatible  = "tsi-i2c";
		};

		mdio@6000 {
			device_type = "mdio";
			compatible = "tsi-ethernet";	// FIXME

			ethernet-phy@6000 {
				linux,phandle = <6000>;
				interrupt-parent = <7400>;
				interrupts = <2 1>;
				reg = <6000 50>;
				device_type = "ethernet-phy";
			};

			ethernet-phy@6400 {
				linux,phandle = <6400>;
				interrupt-parent = <7400>;
				interrupts = <2 1>;
				reg = <6400 50>;
				device_type = "ethernet-phy";
			};

		};

		ethernet@6200 {
			#size-cells = <0>;
			device_type = "network";
			model = "TSI-ETH";		// FIXME
			compatible = "tsi-ethernet";	// FIXME
			reg = <6200 200>;
			address = [ 00 06 D2 00 00 01 ];
			interrupts = <10 3 10 3 10 3>;
			interrupt-parent = <7400>;
			phy-handle = <6000>;
		};

		ethernet@6600 {
			#address-cells = <1>;
			#size-cells = <0>;
			device_type = "network";
			model = "TSI-ETH";		// FIXME
			compatible = "tsi-ethernet";	// FIXME
			reg = <6600 200>;
			address = [ 00 06 D2 00 00 02 ];
			interrupts = <11 3 11 3 11 3>;
			interrupt-parent = <7400>;
			phy-handle = <6400>;
		};

		serial@7808 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <7808 200>;
			clock-frequency = <3f6b5a00>;
			interrupts = <c 3>;
			interrupt-parent = <7400>;
		};

		serial@7c08 {
			device_type = "serial";
			compatible = "ns16550";
			reg = <7c08 200>;
			clock-frequency = <3f6b5a00>;
			interrupts = <d 3>;
			interrupt-parent = <7400>;
		};

	  	pic@7400 {
			linux,phandle = <7400>;
			clock-frequency = <0>;
			interrupt-controller;
			#address-cells = <0>;
			#interrupt-cells = <2>;
			reg = <7400 400>;
			built-in;
			compatible = "chrp,open-pic";
			device_type = "open-pic";
                       	big-endian;
		};
		pci@1000 {
			compatible = "tsi10x";
			device_type = "pci";
			linux,phandle = <1000>;
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			reg = <1000 1000>;
			bus-range = <0 0>;
			ranges = <02000000 0 e0000000 e0000000 0 1A000000	
				  01000000 0 00000000 fa000000 0 00010000>;
			clock-frequency = <7f28154>;
			interrupt-parent = <7400>;
			interrupts = <8 0>;
			interrupt-map-mask = <f800 0 0 7>;
			interrupt-map = <

				/* IDSEL 0x11 */
				8800 0 0 1 7400 24 0
				8800 0 0 2 7400 25 0
				8800 0 0 3 7400 26 0
				8800 0 0 4 7400 27 0

				/* IDSEL 0x12 */
				9000 0 0 1 7400 25 0
				9000 0 0 2 7400 26 0
				9000 0 0 3 7400 27 0
				9000 0 0 4 7400 24 0

				/* IDSEL 0x13 */
				9800 0 0 1 7400 26 0
				9800 0 0 2 7400 27 0
				9800 0 0 3 7400 24 0
				9800 0 0 4 7400 25 0

				/* IDSEL 0x14 */
				a000 0 0 1 7400 27 0
				a000 0 0 2 7400 24 0
				a000 0 0 3 7400 25 0
				a000 0 0 4 7400 26 0
				>;
		};
	};

};

 
