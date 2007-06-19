Return-Path: <dgibson@ozlabs.org>
Date: Tue, 19 Jun 2007 15:42:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Message-ID: <20070619054232.GB32039@localhost.localdomain>
References: <20070618185715.321010@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070618185715.321010@gmx.net>
Cc: linuxppc-dev@ozlabs.org, "list <linuxppc-dev"@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2007 at 08:57:15PM +0200, Gerhard Pircher wrote:
> Hi,
> 
> I'm working on support for the AmigaOne and started to write a device tree source file for use with the cuboot bootwrapper. Additionally to the booting-without-of.txt document and other dts files I found some OpenFirmware related documents on http://playground.sun.com/1275/ and tried to follow their guidelines. Note that I didn't try to compile the dts file yet, as it is not yet complete.
> 
> Some questions arose during the implementation, which I hope some of you can answer:
> 
> 1. The AmigaOne makes use of different G3 (750Cx, 750GL, 750GX) and
> G4 (7400, 7450, 7455, 7457) CPUs. The current dts file defines a cpu
> node with the name "PowerPC,7xxx@0" and the bootwrapper just fills
> in the cpu-, bus- and timebase frequencies. Is this the recommended
> way, or should the bootwrapper create a fresh cpu node with the
> correct name of the CPU (e.g. "PowerPC,7455@ 0" - I guess this would
> require a table with all PVR values and their corresponding CPU
> name. Or is there a function in the kernel that do this?).
> 
> 2. I tried to define all ISA devices, which are integrated in the
> southbridge (VT82C686B). Currently these are child nodes of the
> device tree root. Should they be child nodes of the southbridge's
> PCI-to-ISA device node? If so, where should I specify the register
> address ranges (reg property)? In the PCI device node or in the ISA
> device nodes, as it is now?

They should be children of the PCI<->ISA bridge.  They should specify
there own address ranges in their reg properties - but those address
ranges are in the address space of the ISA bus.  The PCI<->ISA bridge
will need a correct ranges property to map that into the PCI address
space, and the PCI host bridge will need a ranges which maps that into
the processor's 

> 3. The dts files define the device_type of a serial port as
> "serial", whereas the OF spec says "pnpPNP,501". What's the
> difference between the two?

Err... device_type == "pnpPNP,501", or compatible == "pnpPNP,501"?

> 4. I couldn't find any information for a device tree representation
> of the i8259 interrupt controller in the booting-without-of.txt
> file. Is my implementation correct (inspired by the OF documents)?
> 
> I would be grateful, if you could take a look at my dts file and
> comment on every line that doesn't meet your views.

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

> / {
> 	model = "Eyetech,AmigaOne";
> 	compatible = "Eyetech,AmigaOne" "MAI,Teron";
> 	#address-cells = <1>;
> 	#size-cells = <1>;

> 	cpus {
> 		#address-cells = <1>;
> 		#size-cells = <0>;

> 		PowerPC,7xxx@0 {			// Can be 75x or 745x?
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

> 	memory {
> 		device_type = "memory";
> 		reg = <0 0>;				// From U-boot
> 	};

> 	// Should the following nodes be childs of a ISA bus node?

If they're ISA devices, then yes, they should.

> 	dma-controller {
> 		device_type = "dma-controller";
> 		compatible = "chrp,dma";
> 		reg = <0 10 80 10 c0 20>;
> 		/* Channel 4 reserverd, cascade mode, 2x32k transfer/counter
> 		 * widths and bus master capability. Is this really necessary?
> 		 */
> /*		dma = <4 4 20 20 1>; */
> 		#address-cells = <1>;
> 		#size-cells = <0>;			// No physical address.

This node has no children, so #address-cells and #size-cells values
are meaningless.

> 	};

>   	interrupt-controller {
> 		device_type = "interrupt-controller";
> 		compatible = "chrp,iic";

Is there a device binding defined somewhere for "chrp,iic"?

> 		interrupt-controller;
> 		reg = <20 2 a0 2 4d0 2>;
> 		reserved-interrupts = <2>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		#interrupt-cells = <2>;
> 	};

> 	8042@60 {
> 		device_type = "8042";
> 		compatible = "chrp,8042";
> 		reg = <60 10>;
> 		interrupts = <1 3 c 3>;			// IRQ1, IRQ12 (rising edge)
> 		interrupt-parent = <&interrupt-controller>;

This should cause a dtc error.  Either you want &/interrupt-controller
or give the interrupt-controller node a label and refer to that.  It's
either '&/some/full/path' or '&label'.

> 		#address-cells = <1>;
> 		#size-cells = <0>;			// No physical address.

Comment is arguably incorrect.

> 		keyboard {
> 			device_type = "keyboard";
> 			compatible = "pnpPNP,303";
> 			reg = <0>;
> 		};

> 		mouse {
> 			device_type = "mouse";
> 			compatible = "pnpPNP,f03";
> 			reg = <1>;
> 		};
> 	};

> 	timer@40 {
> 		device_type = "timer";

For flat device trees we're generally avoiding setting the device_type
property unless there is a clearly defined "class binding" which
applies.  There are a number of cases here where I'm not sure if
that's true.

> 		reg = <40 20>
> 		#address-cells = <1>;
> 		#size-cells = <0>;

No children, so #a and #s are pointless.

> 	};

> 	rtc@70 {
> 		device_type = "rtc";
> 		compatible = <ds1385-rtc>;
> 		reg = <70 2>;
> 		interrupts = <8 3>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;

Ditto

> 	};

> 	serial@3f8 {
> 		device_type = "serial";
> /*		compatible = "pnpPNP,501";*/
> 		compatible = "ns16550";
> 		reg = <3f8 8>;
> 		interrupts = <4 3>;			// IRQ4 (rising edge)
> 		interrupt-parent = <&interrupt-controller>;
> 		clock-frequency = <0>;			// Not necessary?

Probably necessary, but may need to be filled in from the bootwrapper.

> 		#address-cells = <1>;
> 		#size-cells = <0>;

Ditto.

> 	};

> 	serial@2f8 {
> 		device_type = "serial";
> /*		compatible = "pnpPNP,501";*/
> 		compatible = "ns16550";
> 		reg = <2f8 8>;
> 		interrupts = <3 3>;			// IRQ3 (rising edge)
> 		interrupt-parent = <&interrupt-controller>;
> 		clock-frequency = <0>;			// Not necessary?
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 	};

> 	parallel@378 {
> 		device_type = "parallel";
> 		compatible = "chrp,ecp";
> 		reg = <378 3 778 3>;
> /*		interrupts = <7>;*/			// No IRQ free on AmigaOne!
> 		interrupt-parent = <&interrupt-controller>;
> /*		dma = <3 0 0 0>;*/			// Parallel port DMA mode?
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 	};

> 	fdc@3f0 {
> 		device_type = "fdc";
> 		compatible = "pnpPNP,700";
> 		reg = <3f0 8>;
> 		interrupts = <6 3>;			// IRQ6 (rising edge)
> 		interrupt-parent = <&interrupt-controller>;
> /*		dma = < >;*/				// Floppy DMA mode?
> 		#address-cells = <1>;
> 		#size-cells = <0>;

> 		disk {
> 			device_type = "block";
> 			reg = <0>;
> 		};

Don't think you need this subnode.

> 	};	

>   	pci@80000000 {
> 		device_type = "pci";
> 		bus-frequency = <01fca055>;		// 33.3MHz
> 		bus-range = <0 f>;
> 		reg = <80000000 7f000000>;			// Whole PCI space.
> 		ranges = <01000000 0 0 fe000000 0 00c00000	// PCI I/O
> 			  02000000 0 0 80000000 0 7d000000	// PCI memory
> 			  02000000 0 0 fd000000 0 01000000	// PCI alias memory
> 			  00000000 0 0 fec00000 0 00300000>;	// PCI config
> 		8259-interrupt-acknowledge = <fef00000>;
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 	};
> };


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
