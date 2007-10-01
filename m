Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C92FBDDE39
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 07:11:22 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 01 Oct 2007 23:11:20 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20071001210025.314240@gmx.net>
Message-ID: <20071001211120.156280@gmx.net>
MIME-Version: 1.0
References: <20071001210025.314240@gmx.net>
Subject: Re: Problem with OF interrupt parsing code
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

And here comes the device tree source:

/*
 * AmigaOne Device Tree Source
 *
 * Copyright 2007 Gerhard Pircher (gerhard_pircher@gmx.net)
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/ {
	model = "AmigaOne";
	compatible = "eyetech,amigaone","mai-logic,teron";
	coherency-off;
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;

		cpu@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <8000>;		// L1, 32K
			i-cache-size = <8000>;		// L1, 32K
			timebase-frequency = <0>;	// 33.3 MHz, from U-boot
			clock-frequency = <0>;		// From U-boot
			bus-frequency = <0>;		// From U-boot
			32-bit;
		};
	};

	memory {
		device_type = "memory";
		reg = <0 0>;				// From U-boot
	};

  	pci@80000000 {
		device_type = "pci";
		compatible = "mai-logic,articia-s";
		bus-frequency = <01fca055>;		// 33.3MHz
		bus-range = <0 ff>;
		ranges = <01000000 0 00000000 fe000000 0 00c00000	// PCI I/O
			  02000000 0 80000000 80000000 0 7d000000	// PCI memory
			  02000000 0 fd000000 fd000000 0 01000000>;	// PCI alias memory
		8259-interrupt-acknowledge = <fef00000>;
		interrupt-parent = <&i8259>;
		#interrupt-cells = <1>;
		#address-cells = <3>;
		#size-cells = <2>;

		host@0 {
			compatible = "pciclass,0600";
			vendor-id = <000010cc>;
			device-id = <00000660>;
			revision-id = <00000001>;
			class-code = <00060000>;
			subsystem-id = <0>;
			subsystem-vendor-id = <0>;
			devsel-speed = <00000001>;
			66mhz-capable;
			min-grant = <0>;
			max-latency = <0>;
			// AGP aperture is unset.
			reg = <42000010 0 00000000 0 00400000>;
			assigned-addresses = <42000010 0 00000000 0 00400000>;
		};

		isa@7 {
			device_type = "isa";
			compatible = "pciclass,0601";
			vendor-id = <00001106>;
			device-id = <00000686>;
			revision-id = <00000010>;
			class-code = <00060100>;
			subsystem-id = <0>;
			subsystem-vendor-id = <0>;
			devsel-speed = <00000001>;
			min-grant = <0>;
			max-latency = <0>;
			/* First 64k for I/O at 0x0 on PCI mapped to 0x0 on ISA. */
			ranges = <00000001 0 01000000 0 00000000 00010000>;
			interrupt-parent = <&i8259>;
			#interrupt-cells = <2>;
			#address-cells = <2>;
			#size-cells = <1>;

			dma-controller@0 {
				device_type = "dma-controller";
				compatible = "pnpPNP,200";
				reg = <00000001 00000000 00000020
				       00000001 00000080 00000010
				       00000001 000000c0 00000020>;
				/* Channel 4 reserverd, cascade mode, 2x32k transfer/counter
				 * widths and bus master capability. Is this really necessary?
				 */
/*				dma = <4 4 20 20 1>; */
			};

		  	i8259: interrupt-controller@20 {
				device_type = "interrupt-controller";
				compatible = "pnpPNP,000";
				interrupt-controller;
				reg = <00000001 00000020 00000002
				       00000001 000000a0 00000002
				       00000001 000004d0 00000002>;
				reserved-interrupts = <2>;
			};

			timer@40 {
/*				device_type = "timer"; */		// No device type binding for now.
				compatibe = "pnpPNP,100";		// Also add pcspkr to platform devices.
				reg = <00000001 00000040 00000020>;
			};

			8042@60 {
				device_type = "8042";
				reg = <00000001 00000060 00000001
				       00000001 00000064 00000001>;
				interrupts = <1 3 c 3>;			// IRQ1, IRQ12 (rising edge)
				#address-cells = <1>;
				#size-cells = <0>;

				keyboard@0 {
					device_type = "keyboard";
					compatible = "pnpPNP,303";
					reg = <0>;
				};

				mouse@1 {
					device_type = "mouse";
					compatible = "pnpPNP,f03";
					reg = <1>;
				};
			};

			rtc@70 {
				device_type = "rtc";
				compatible = "pnpPNP,b00";
				reg = <00000001 00000070 00000002>;
				interrupts = <8 3>;
			};

			serial@2f8 {
				device_type = "serial";
				compatible = "pnpPNP,501","pnpPNP,500";	// "ns16550"; add property check to OF serial code.
				reg = <00000001 000002f8 00000008>;
				interrupts = <3 3>;			// IRQ3 (rising edge)
				clock-frequency = <001C2000>;		// Not necessary?
			};

			serial@3f8 {
				device_type = "serial";
				compatible = "pnpPNP,501","pnpPNP,500";	// "ns16550"; add property check to OF serial code.
				reg = <00000001 000003f8 00000008>;
				interrupts = <4 3>;			// IRQ4 (rising edge)
				clock-frequency = <001C2000>;		// Not necessary?
			};

			parallel@378 {
				device_type = "parallel";
				compatible = "pnpPNP,400"; 		// "pnpPNP,401"	// No ECP support for now.
				reg = <00000001 00000378 00000003
				       00000001 00000778 00000003>;
/*				interrupts = <7>; */
/*				dma = <3 0 0 0>; */			// Parallel port DMA mode?
			};

			fdc@3f0 {
				device_type = "fdc";
				compatible = "pnpPNP,700";
				reg = <00000001 000003f0 00000008>;
				interrupts = <6 3>;			// IRQ6 (rising edge)
/*				dma = < >; */				// Floppy DMA mode?
				#address-cells = <1>;
				#size-cells = <0>;

				disk@0 {
					device_type = "block";
					reg = <0>;
				};
			};
		};

		ide@7,1 {
			compatible = "pciclass,01018f";
			vendor-id = <00001106>;
			device-id = <00000571>;
			revision-id = <00000006>;
			// Class code with PCI IDE programming interface indicator.
			class-code = <0001018f>;
			subsystem-id = <0>;
			subsystem-vendor-id = <0>;
			devsel-speed = <00000001>;
			min-grant = <0>;
			max-latency = <0>;
			fast-back-to-back;
			// Assume base addresses are relocateable, even if
			// controller operates in compatibility mode.
			reg = <21003910 0 00000000 0 00000000
			       21003914 0 00000000 0 00000000
			       21003918 0 00000000 0 00000000
			       2100391c 0 00000000 0 00000000
			       21003920 0 00000000 0 00000000>;
			assigned-addresses = <01003910 0 000001f0 0 00000008
					      01003914 0 000003f4 0 00000004
					      01003918 0 00000170 0 00000008
					      0100391c 0 00000374 0 00000004
					      01003920 0 0000cc00 0 00000010>;
			interrupt-parent = <&i8259>;
			interrupts = <e 3 f 3>;
			#interrupt-cells = <2>;
		};
	};

	chosen {
		linux,stdout-path = "/pci@80000000/isa@7/serial@2f8";
	};
};

-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
