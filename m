Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A18AB6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 08:59:14 +1100 (EST)
Subject: Re: [RFC PATCH v2 1/6] powerpc: wii: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1259880447-5008-2-git-send-email-albert_herranz@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
	<1259880447-5008-2-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 08:59:05 +1100
Message-ID: <1260568745.16132.360.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 23:47 +0100, Albert Herranz wrote:
> Add a device tree source file for the Nintendo Wii video game console.
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> v1 -> v2
> - Document new bindings in Documentation/powerpc/dts-bindings.
>   Suggestion by Grant Likely.
> - Use same form for model property and compatible properties on the root
>   node.  Suggestion by Grant Likely.
> - Drop the model property in the soc node.  Suggestion by Grant Likely.
> - Move interrupt-parent to the soc node instead of explicitly adding it to
>   each child node.  Suggestion by Grant Likely.
> - Declare all available memory and deal with the hole and fb area in the
>   platform code. Suggestion by Segher Boessenkool.
> - Rename the "soc" node to "hollywood". Suggestion by Benjamin Herrenschmidt.
> - Remove the usbgecko node from the device tree and autodetect it in
>   platform code. Suggestion by Segher Boessenkool.
> - Don't use #cpus in cpus node. Suggestion by Segher Boessenkool.
> - Remove clock-frequency property from the soc node.
>   Suggestion by Segher Boessenkool.
> - Create a processor-interface node and place flipper-pic into it.
>   Suggestion by Segher Boessenkool.
> - Remove #interrupt-cells from the hollywood node.
>   Suggestion by Segher Boessenkool.
> - Remove the mini header pointer from the device tree and deal with it
>   in platform code. Suggestion by Segher Boessenkool.
> - Add "usb-ohci" to the compatible property of ohci nodes.
>   Suggestion by Segher Boessenkool.
> - Add "usb-ehci" to the compatible property of ehci nodes.
>   Suggestion by Segher Boessenkool.
> - Don't use a different name if the unit address is different.
>   Suggestion by Benjamin Herrenschmidt.
> - Don't use "nobats", do a workaround in mmu_mapin_ram instead.
>   Suggestion by Benjamin Herrenschmidt.
> - Rename "mini" node to "ipc" and set it compatible with
>   "nintendo,hollywood-ipc".
> - Massive cleanups. Suggestions by Segher Boessenkool.
> - Comment out i2c over gpio bindings until a standard is agreed.
> - Use a single gpio controller node. It's just one controller with two
>  "views".
> 
>  .../powerpc/dts-bindings/nintendo/wii.txt          |  184 +++++++++++++++++
>  arch/powerpc/boot/dts/wii.dts                      |  218 ++++++++++++++++++++
>  2 files changed, 402 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/nintendo/wii.txt
>  create mode 100644 arch/powerpc/boot/dts/wii.dts
> 
> diff --git a/Documentation/powerpc/dts-bindings/nintendo/wii.txt b/Documentation/powerpc/dts-bindings/nintendo/wii.txt
> new file mode 100644
> index 0000000..a7e155a
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/nintendo/wii.txt
> @@ -0,0 +1,184 @@
> +
> +Nintendo Wii device tree
> +========================
> +
> +0) The root node
> +
> +  This node represents the Nintendo Wii video game console.
> +
> +  Required properties:
> +
> +   - model : Should be "nintendo,wii"
> +   - compatible : Should be "nintendo,wii"
> +
> +1) The "hollywood" node
> +
> +  This node represents the multi-function "Hollywood" chip, which packages
> +  many of the devices found in the Nintendo Wii.
> +
> +  Required properties:
> +
> +   - compatible : Should be "nintendo,hollywood"
> +
> +1.a) The Video Interface (VI) node
> +
> +  Represents the interface between the graphics processor and a external
> +  video encoder.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-vi","nintendo,flipper-vi"
> +   - reg : should contain the VI registers location and length
> +   - interrupts : should contain the VI interrupt
> +
> +1.b) The Processor Interface (PI) node
> +
> +  Represents the data and control interface between the main processor
> +  and graphics and audio processor.
> +
> +  Required properties:
> +
> +  - compatible : should be "nintendo,hollywood-pi","nintendo,flipper-pi"
> +  - reg : should contain the PI registers location and length
> +
> +1.b.i) The "Flipper" interrupt controller node
> +
> +  Represents the "Flipper" interrupt controller within the "Hollywood" chip.
> +  The node for the "Flipper" interrupt controller must be placed under
> +  the PI node.
> +
> +  Required properties:
> +
> +  - #interrupt-cells : <1>
> +  - compatible : should be "nintendo,flipper-pic"
> +  - interrupt-controller
> +
> +1.c) The Digital Signal Procesor (DSP) node
> +
> +  Represents the digital signal processor interface, designed to offload
> +  audio related tasks.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-dsp","nintendo,flipper-dsp"
> +   - reg : should contain the DSP registers location and length
> +   - interrupts : should contain the DSP interrupt
> +
> +1.d) The Serial Interface (SI) node
> +
> +  Represents the interface to the four single bit serial interfaces.
> +  The SI is a proprietary serial interface used normally to control gamepads.
> +  It's NOT a RS232-type interface.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-si","nintendo,flipper-si"
> +   - reg : should contain the SI registers location and length
> +   - interrupts : should contain the SI interrupt
> +
> +1.e) The Audio Interface (AI) node
> +
> +  Represents the interface to the external 16-bit stereo digital-to-analog
> +  converter.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-ai","nintendo,flipper-ai"
> +   - reg : should contain the AI registers location and length
> +   - interrupts : should contain the AI interrupt
> +
> +1.f) The External Interface (EXI) node
> +
> +  Represents the multi-channel SPI-like interface.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-exi","nintendo,flipper-exi"
> +   - reg : should contain the EXI registers location and length
> +   - interrupts : should contain the EXI interrupt
> +
> +1.g) The Open Host Controller Interface (OHCI) nodes
> +
> +  Represent the USB 1.x Open Host Controller Interfaces.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-usb-ohci","usb-ohci"
> +   - reg : should contain the OHCI registers location and length
> +   - interrupts : should contain the OHCI interrupt
> +
> +1.h) The Enhanced Host Controller Interface (EHCI) node
> +
> +  Represents the USB 2.0 Enhanced Host Controller Interface.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-usb-ehci","usb-ehci"
> +   - reg : should contain the EHCI registers location and length
> +   - interrupts : should contain the EHCI interrupt
> +
> +1.i) The Secure Digital Host Controller Interface (SDHCI) nodes
> +
> +  Represent the Secure Digital Host Controller Interfaces.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-sdhci","sdhci"
> +   - reg : should contain the SDHCI registers location and length
> +   - interrupts : should contain the SDHCI interrupt
> +
> +1.j) The Inter-Processsor Communication (IPC) node
> +
> +  Represent the Inter-Processor Communication interface. This interface
> +  enables communications between the Broadway and the Starlet processors.
> +
> +   - compatible : should be "nintendo,hollywood-ipc"
> +   - reg : should contain the IPC registers location and length
> +   - interrupts : should contain the IPC interrupt
> +
> +1.k) The "Hollywood" interrupt controller node
> +
> +  Represents the "Hollywood" interrupt controller within the
> +  "Hollywood" chip.
> +
> +  Required properties:
> +
> +  - #interrupt-cells : <1>
> +  - compatible : should be "nintendo,hollywood-pic"
> +  - reg : should contain the controller registers location and length
> +  - interrupt-controller
> +  - interrupts : should contain the cascade interrupt of the "flipper" pic
> +  - interrupt-parent: should contain the phandle of the "flipper" pic
> +
> +1.l) The General Purpose I/O (GPIO) controller node
> +
> +  Represents the dual access 32 GPIO controller interface.
> +
> +  Required properties:
> +
> +  - #gpio-cells : <2>
> +  - compatible : should be "nintendo,hollywood-gpio"
> +  - reg : should contain the IPC registers location and length
> +  - gpio-controller
> +
> +1.m) The control node
> +
> +  Represents the control interface used to setup several miscellaneous
> +  settings of the "Hollywood" chip like boot memory mappings, resets,
> +  disk interface mode, etc.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-control"
> +   - reg : should contain the control registers location and length
> +
> +1.n) The Disk Interface (DI) node
> +
> +  Represents the interface used to communicate with mass storage devices.
> +
> +  Required properties:
> +
> +   - compatible : should be "nintendo,hollywood-di"
> +   - reg : should contain the DI registers location and length
> +   - interrupts : should contain the DI interrupt
> +
> diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
> new file mode 100644
> index 0000000..77528c9
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/wii.dts
> @@ -0,0 +1,218 @@
> +/*
> + * arch/powerpc/boot/dts/wii.dts
> + *
> + * Nintendo Wii platform device tree source
> + * Copyright (C) 2008-2009 The GameCube Linux Team
> + * Copyright (C) 2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +/dts-v1/;
> +
> +/*
> + * This is commented-out for now.
> + * Until a later patch is merged, the kernel can use only the first
> + * contiguous RAM range and will BUG() if the memreserve is outside
> + * that range.
> + */
> +/*/memreserve/ 0x10000000 0x0004000;*/	/* DSP RAM */
> +
> +/ {
> +	model = "nintendo,wii";
> +	compatible = "nintendo,wii";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	chosen {
> +		bootargs = "root=/dev/mmcblk0p2 rootwait udbg-immortal";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x01800000	/* MEM1 24MB 1T-SRAM */
> +		       0x10000000 0x04000000>;	/* MEM2 64MB GDDR3 */
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,broadway@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <729000000>; /* 729MHz */
> +			bus-frequency = <243000000>; /* 243MHz core-to-bus 3x */
> +			timebase-frequency = <60750000>; /* 243MHz / 4 */
> +			i-cache-line-size = <32>;
> +			d-cache-line-size = <32>;
> +			i-cache-size = <32768>;
> +			d-cache-size = <32768>;
> +		};
> +	};
> +
> +	/* devices contained in the hollywood chipset */
> +	hollywood {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "nintendo,hollywood";
> +                ranges = <0x0c000000 0x0c000000 0x01000000
> +			  0x0d000000 0x0d000000 0x00800000
> +			  0x0d800000 0x0d800000 0x00800000>;
> +		interrupt-parent = <&PIC0>;
> +
> +		video@0c002000 {
> +			compatible = "nintendo,hollywood-vi",
> +					"nintendo,flipper-vi";
> +			reg = <0x0c002000 0x100>;
> +			interrupts = <8>;
> +		};
> +
> +		processor-interface@0c003000 {
> +			compatible = "nintendo,hollywood-pi",
> +					"nintendo,flipper-pi";
> +			reg = <0x0c003000 0x100>;
> +
> +			PIC0: pic0 {
> +				#interrupt-cells = <1>;
> +				compatible = "nintendo,flipper-pic";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		dsp@0c005000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "nintendo,hollywood-dsp",
> +					"nintendo,flipper-dsp";
> +			reg = <0x0c005000 0x200>;
> +			interrupts = <6>;
> +		};
> +
> +		gamepad-controller@0d006400 {
> +			compatible = "nintendo,hollywood-si",
> +					"nintendo,flipper-si";
> +			reg = <0x0d006400 0x100>;
> +			interrupts = <3>;
> +		};
> +
> +		audio@0c006c00 {
> +			compatible = "nintendo,hollywood-ai",
> +					"nintendo,flipper-ai";
> +			reg = <0x0d006c00 0x20>;
> +			interrupts = <6>;
> +		};
> +
> +		/* External Interface bus */
> +		exi@0d006800 {
> +			compatible = "nintendo,hollywood-exi",
> +					"nintendo,flipper-exi";
> +			reg = <0x0d006800 0x40>;
> +			virtual-reg = <0x0d006800>;
> +			interrupts = <4>;
> +		};
> +
> +		usb@0d040000 {
> +			compatible = "nintendo,hollywood-usb-ehci",
> +					"usb-ehci";
> +			reg = <0x0d040000 0x100>;
> +			interrupts = <4>;
> +			interrupt-parent = <&PIC1>;
> +		};
> +
> +		usb@0d050000 {
> +			compatible = "nintendo,hollywood-usb-ohci",
> +					"usb-ohci";
> +			reg = <0x0d050000 0x100>;
> +			interrupts = <5>;
> +			interrupt-parent = <&PIC1>;
> +		};
> +
> +		usb@0d060000 {
> +			compatible = "nintendo,hollywood-usb-ohci",
> +					"usb-ohci";
> +			reg = <0x0d060000 0x100>;
> +			interrupts = <6>;
> +			interrupt-parent = <&PIC1>;
> +		};
> +
> +		sd@0d070000 {
> +			compatible = "nintendo,hollywood-sdhci",
> +					"sdhci";
> +			reg = <0x0d070000 0x200>;
> +			interrupts = <7>;
> +			interrupt-parent = <&PIC1>;
> +		};
> +
> +		sdio@0d080000 {
> +			compatible = "nintendo,hollywood-sdhci",
> +					"sdhci";
> +			reg = <0x0d080000 0x200>;
> +			interrupts = <8>;
> +			interrupt-parent = <&PIC1>;
> +		};
> +
> +		ipc@0d000000 {
> +			compatible = "nintendo,hollywood-ipc";
> +			reg = <0x0d000000 0x10>;
> +			interrupts = <30>;
> +			interrupt-parent = <&PIC1>;
> +		};
> +
> +		PIC1: pic1@0d800030 {
> +			#interrupt-cells = <1>;
> +			compatible = "nintendo,hollywood-pic";
> +			reg = <0x0d800030 0x10>;
> +			interrupt-controller;
> +			interrupts = <14>;
> +		};
> +
> +		GPIO: gpio@0d8000c0 {
> +			#gpio-cells = <2>;
> +			compatible = "nintendo,hollywood-gpio";
> +			reg = <0x0d8000c0 0x40>;
> +			gpio-controller;
> +
> +			/*
> +			 * This is commented out while a standard binding
> +			 * for i2c over gpio is defined.
> +			 */
> +			/*
> +			i2c-video {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			        compatible = "i2c-gpio";
> +
> +			        gpios = <&GPIO 15 0
> +			                 &GPIO 14 0>;
> +			        clock-frequency = <250000>;
> +				no-clock-stretching;
> +			        scl-is-open-drain;
> +			        sda-is-open-drain;
> +			        sda-enforce-dir;
> +
> +			        AVE: audio-video-encoder@70 {
> +			                compatible = "nintendo,wii-audio-video-encoder";
> +			                reg = <0x70>;
> +			        };
> +			};
> +			*/
> +		};
> +
> +		control@0d800100 {
> +			compatible = "nintendo,hollywood-control";
> +			reg = <0x0d800100 0x300>;
> +		};
> +
> +		disk@0d806000 {
> +			compatible = "nintendo,hollywood-di";
> +			reg = <0x0d806000 0x40>;
> +			interrupts = <2>;
> +		};
> +	};
> +};
> +
