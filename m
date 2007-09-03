Return-Path: <dgibson@ozlabs.org>
Date: Mon, 3 Sep 2007 11:34:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: [RFC] AmigaOne device tree source v2
Message-ID: <20070903013431.GG31499@localhost.localdomain>
References: <20070831175006.17240@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070831175006.17240@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 31, 2007 at 07:50:06PM +0200, Gerhard Pircher wrote:
> Hi,
> 
> I updated the AmigaOne device tree based on the comments in this thread:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-June/038069.html
> All the ISA devices are now subnodes of the PCI2ISA bridge, which marks
> the first 64k (of PCI address space) as I/O space. The pci node doesn't
> contain any interrupt routing information, because interrupt routing
> differs between the three AmigaOne models. Thus I would like to omit it,
> if it is not really necessary. 

Interrupt routing information is really necessary.  If it differs
between the models then either you will need different device tree
source for each of them, or you will need to fill in the correct
interrupt routing information from the bootwrapper, whichever approach
is easier.

> The PCI host for bus 0 is a subnode of
> the pci node, but I'm not sure if this is correct.
> 
> Please take a look at the reg and ranges properties of the PCI devices.
> The PCI OF spec defined "zero" reg properties (like
> reg = <00xxxx00 00000000 00000000 00000000 00000000>, where xxxx is
> the device number), even if all the other BARs are defined. What are
> they good for?
> The BARs of the VIA IDE controller are assumed to be relocateable,
> even if the address is fixed in compatibility mode.
> BTW: Is there a way to specify the addresses for PCI config with
> indirect addressing?

I believe that's handled by the bridge's compatible and reg
properties.  The platform or bridge code will have to know that this
type of bridge (as encoded in compatible) uses indirect addressing,
and which resource (from the reg property) has the indirect access
registers.

I don't know enough about PCI to answer most of the above questions,
but I spotted a bunch of problems with the device tree anyway...
> /*
>  * AmigaOne Device Tree Source
>  *
>  * Copyright 2007 Gerhard Pircher (gerhard_pircher@gmx.net)
>  *
>  * This program is free software; you can redistribute  it and/or modify it
>  * under  the terms of  the GNU General  Public License as published by the
>  * Free Software Foundation;  either version 2 of the  License, or (at your
>  * option) any later version.
>  */
> 
> 
> / {
> 	model = "Eyetech,AmigaOne";
> 	compatible = "Eyetech,AmigaOne" "MAI,Teron";
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 
> 	cpus {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		cpu@0 {
> 			device_type = "cpu";
> 			reg = <0>;
> 			d-cache-line-size = <20>;	// 32 bytes
> 			i-cache-line-size = <20>;	// 32 bytes
> 			d-cache-size = <8000>;		// L1, 32K
> 			i-cache-size = <8000>;		// L1, 32K
> 			timebase-frequency = <0>;	// 33.3 MHz, from U-boot
> 			clock-frequency = <0>;		// From U-boot
> 			bus-frequency = <0>;		// From U-boot
> 			32-bit;
> 		};
> 	};
> 
> 	memory {
> 		device_type = "memory";
> 		reg = <0 0>;				// From U-boot
> 	};
> 
>   	pci@80000000 {
> 		device_type = "pci";
> 		bus-frequency = <01fca055>;		// 33.3MHz
> 		bus-range = <0 1>;
> 		reg = <80000000 7f000000>;				// Whole PCI space.

'reg' and 'ranges' should not typically overlap.  'reg' should only
encode control registers for the bridge, not the whole PCI space (not
that I'm even entirely sure what you mean by that).

> 		ranges = <01000000 0 00000000 fe000000 0 00c00000	// PCI I/O
> 			  02000000 0 80000000 80000000 0 7d000000	// PCI memory
> 			  02000000 0 fd000000 fd000000 0 01000000>;	// PCI alias memory
> 		8259-interrupt-acknowledge = <fef00000>;
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 
> 		host@0 {

The unit address (after the @) should be derived from the first range
listed in the 'reg' property.  It's a bus address, not a slot number.

> 			vendor-id = 0x000010cc;

Um.. evidentally you have never even tried compiling this device tree,
since this is invalid syntax.  That would need to be:
			vendor-id = <000010cc>;
and likewise all the others below.

> 			device-id = 0x00000660;
> 			revision-id = 0x00000001;
> 			class-code = 0x00060000;
> 			subsystem-id = 0x00000000;
> 			subsystem-vendor-id = 0x00000000;
> 			devsel-speed = 0x00000001;
> 			66mhz-capable;
> 			min-grant = 0x00000000;
> 			max-latency = 0x00000000;
> 			// AGP aperture is unset.
> 			reg = <42000010 0 00000000 0 00400000>;
> 			assigned-addresses = <42000010 0 00000000 0 00400000>;
> 		}
> 
> 		isa@7 {
> 			device_type = "isa";
> 			vendor-id = 0x00001106;
> 			device-id = 0x00000686;
> 			revision-id = 0x00000010;
> 			class-code = 0x00060100;
> 			subsystem-id = 0x00000000;
> 			subsystem-vendor-id = 0x00000000;
> 			devsel-speed = 0x00000001;
> 			min-grant = 0x00000000;
> 			max-latency = 0x00000000;
> 			/* First 64k for I/O at 0x0 on PCI mapped to 0x0 on ISA. */
> 			ranges = <00000001 0 01000000 0 00000000 00010000>;
> 			interrupt-parent = <&/pci@80000000/isa@7/interrupt-controller>;

Probably worth using a label on the interrupt node to avoid giving a
full path here.

> 			#interrupt-cells = <2>;
> 			#address-cells = <2>;
> 			#size-cells = <1>;
> 
> 			dma-controller {

All these devices should have unit addresses.

> 				device_type = "dma-controller";
> 				compatible = "pnpPNP,200";
> 				reg = <00000001 00000000 00000010
> 				       00000001 00000080 00000010
> 				       00000001 000000c0 00000020>;
> 				/* Channel 4 reserverd, cascade mode, 2x32k transfer/counter
> 				 * widths and bus master capability. Is this really necessary?
> 				 */
> /*				dma = <4 4 20 20 1>; */
> 			};
> 
> 		  	interrupt-controller {
> 				device_type = "interrupt-controller";
> 				compatible = "pnpPNP,000";
> 				interrupt-controller;
> 				reg = <00000001 00000020 00000002
> 				       00000001 000000a0 00000002
> 				       00000001 000004d0 00000002>;
> 				reserved-interrupts = <2>;	
> 			};
> 
> 			8042@60 {
> 				device_type = "8042";
> 				compatible = "pnpPNP,303";
> 				reg = <00000001 00000060 00000010>;
> 				interrupts = <1 3 c 3>;			// IRQ1, IRQ12 (rising edge)
> 
> 				keyboard {
> 					device_type = "keyboard";
> 					compatible = "pnpPNP,303";	// Here again?
> 					reg = <0 0 0>;
> 				};
> 
> 				mouse {
> 					device_type = "mouse";
> 					compatible = "pnpPNP,f03";
> 					reg = <0 0 0>;
> 				};
> 			};
> 
> 			timer@40 {
> /*				device_type = "timer"; */		// No device type binding for now.
> 				compatibe = "pnpPNP,100";		// Also add pcspkr to platform devices.
> 				reg = <00000001 00000040 00000020>;
> 			};
> 
> 			rtc@70 {
> 				device_type = "rtc";
> 				compatible = "pnpPNP,b00";		// <ds1385-rtc>; // What should be used here?
> 				reg = <00000001 00000070 00000002>;
> 				interrupts = <8 3>;
> 			};
> 
> 			serial@2f8 {
> 				device_type = "serial";
> 				compatible = "pnpPNP,501" "pnpPNP,500";	// "ns16550"; add property check to OF serial code.
> 				reg = <00000001 000002f8 00000008>;
> 				interrupts = <3 3>;			// IRQ3 (rising edge)
> 				clock-frequency = <0>;			// Not necessary?
> 			};
> 
> 			serial@3f8 {
> 				device_type = "serial";
> 				compatible = "pnpPNP,501" "pnpPNP,500";	// "ns16550"; add property check to OF serial code.
> 				reg = <00000001 000003f8 00000008>;
> 				interrupts = <4 3>;			// IRQ4 (rising edge)
> 				clock-frequency = <0>;			// Not necessary?
> 			};
> 
> 			parallel@378 {
> 				device_type = "parallel";
> 				compatible = "pnpPNP,400"; 		// "pnpPNP,401"	// No ECP support for now.
> 				reg = <00000001 00000378 00000003
> 				       00000001 00000778 00000003>;
> /*				interrupts = <7>; */			// No IRQ free on AmigaOne!
> /*				dma = <3 0 0 0>; */			// Parallel port DMA mode?
> 			};
> 
> 			fdc@3f0 {
> 				device_type = "fdc";
> 				compatible = "pnpPNP,700";
> 				reg = <00000001 000003f0 00000008>;
> 				interrupts = <6 3>;			// IRQ6 (rising edge)
> /*				dma = < >; */				// Floppy DMA mode?
> 
> 				disk@0 {
> 					device_type = "block";
> 					reg = <0 0 0>;
> 				};
> 			};
> 		};
> 
> 		ide@7,1 {

This will need a compatible property, at least.

> 			// Is there a device_type defined for IDE controllers?
> 			vendor-id = 0x00001106;
> 			device-id  = 0x00000571;
> 			revision-id = 0x00000006;
> 			// Class code with PCI IDE programming interface indicator.
> 			class-code = 0x0001018f;
> 			subsystem-id = 0;
> 			subsystem-vendor-id = 0;
> 			devsel-speed = 0x00000001;
> 			min-grant = 0;
> 			max-latency = 0;
> 			fast-back-to-back;
> 			// Assume base addresses are relocateable, even if
> 			// controller operates in compatibility mode. Right?
> 			reg = <21003910 0 00000000 0 00000000
> 			       21003914 0 00000000 0 00000000
> 			       21003918 0 00000000 0 00000000
> 			       2100391c 0 00000000 0 00000000
> 			       21003920 0 00000000 0 00000000>;
> 			assigned-addresses = <01003910 0 000001f0 0 00000008
> 					      01003914 0 000003f4 0 00000004
> 					      01003918 0 00000170 0 00000008
> 					      0100391c 0 00000374 0 00000004
> 					      01003920 0 0000cc00 0 00000010>;
> 	};
> 
> 	chosen {
> 		linux,stdout-path = "/pci@80000000/isa@7/serial@2f8";
> 	};
> };
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
