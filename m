Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3348B7BBC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 15:45:29 +1100 (EST)
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 15:45:22 +1100
Message-ID: <1259210722.16367.256.camel@pasglop>
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

On Sun, 2009-11-22 at 23:01 +0100, Albert Herranz wrote:

> +/memreserve/ 0x01800000 0xe800000;	/* memory hole (includes I/O area) */
> +/memreserve/ 0x10000000 0x0004000;	/* DSP RAM */

Weird layout... nothing you can do about I suppose.

Out of curiosity, what is that DSP RAM ? Some actual DSP core somewhere
in the IO chip setup to use memory from up there ?

I'll skip on some things that I'm sure others will have commented
about :-)

> +	/*
> +	 * The Nintendo Wii has two discontiguous RAM memory areas called
> +	 * MEM1 and MEM2.
> +	 * MEM1 starts at 0x00000000 and contains 24MB of 1T-SRAM.
> +	 * MEM2 starts at 0x10000000 and contains 64MB of DDR2 RAM.
> +	 * Between both memory address ranges there is an address space
> +	 * where memory-mapped I/O registers are found.
> +	 *
> +	 * Currently, Linux 32-bit PowerPC does not support RAM in
> +	 * discontiguous memory address spaces. Thus, in order to use
> +	 * both RAM areas, we declare as RAM the range from the start of
> +	 * MEM1 to the end of useable MEM2 and exclude the needed parts
> +	 * with /memreserve/ statements, at the expense of wasting a bit
> +	 * of memory.
> +	 */
> +	memory {
> +		device_type = "memory";
> +		/* MEM1 + memory hole + MEM2 - firmware/buffers area */
> +		reg = <0x00000000 0x133e0000>;
> +	};

So we do have a nasty hole here in the middle. How bad it is if you try
to just have two ranges in there (ie as if it was discontiguous) ? We
shouldn't be far from being able to do discontig mem actually, should be
easy enough to fix. Tho I don't have (yet) the HW :-) (I'm tempted...)

Same comment as other discussions about the framebuffer here.

> +	cpus {
> +		#cpus = <1>;
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
> +	soc {

Call it "hollywood"

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <1>;
> +		model = "hollywood";
> +		compatible = "nintendo,hollywood";
> +		clock-frequency = <243000000>; /* 243MHz */
> +		ranges = <0x0c000000 0x0c000000 0x00010000
> +			  0x0d000000 0x0d000000 0x00010000
> +			  0x0d040000 0x0d040000 0x00050000
> +			  0x0d800000 0x0d800000 0x00001000
> +			  0x133e0000 0x133e0000 0x00c20000>;
> +
> +		video@0c002000 {
> +			compatible = "nintendo,hollywood-video";
> +			reg = <0x0c002000 0x100>;
> +			interrupts = <8>;
> +			interrupt-parent = <&PIC0>;
> +		};
> +
> +		PIC0: pic0@0c003000 {
> +			#interrupt-cells = <1>;
> +			compatible = "nintendo,flipper-pic";
> +			reg = <0x0c003000 0x8>;
> +			interrupt-controller;
> +		};
> +
> +		resetswitch@0c003000 {
> +			compatible = "nintendo,hollywood-resetswitch";
> +			reg = <0x0c003000 0x4>;
> +			interrupts = <1>;
> +			interrupt-parent = <&PIC0>;
> +		};
> +
> +		audio@0c005000 {
> +			compatible = "nintendo,hollywood-audio";
> +			reg = <0x0c005000 0x200		/* DSP */
> +			       0x0d006c00 0x20>;	/* AI */
> +			interrupts = <6>;
> +			interrupt-parent = <&PIC0>;
> +		};
> +
> +		/* Team Twiizers' 'mini' firmware IPC */

Out of curiosity, what are these ? :-)

> +		mini@0d000000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#interrupt-cells = <1>;
> +			compatible = "twiizers,starlet-mini-ipc";
> +			reg = <0x0d000000 0x40	/* IPC */
> +			       0x13fffffc 0x4>;	/* mini header pointer */
> +		};
> +
> +		serial@0d006400 {
> +			compatible = "nintendo,hollywood-serial";
> +			reg = <0x0d006400 0x100>;
> +			interrupts = <3>;
> +			interrupt-parent = <&PIC0>;
> +		};
> +
> +		/* External Interface bus */
> +		exi@0d006800 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "nintendo,hollywood-exi";
> +			reg = <0x0d006800 0x40>;
> +			interrupts = <4>;
> +			interrupt-parent = <&PIC0>;
> +
> +			USBGECKO0: usbgecko@0d006814 {
> +				compatible = "usbgecko,usbgecko";
> +				reg = <0x0d006814 0x14>;
> +				virtual-reg = <0xcd006814>;
> +			};
> +		};

Similar comment as before, could the above be dynamically probed ? If
you are not a hacker you may not need that at all to use some linux
based piece of SW on the wii right ?

> +		ehci@0d040000 {
> +			compatible = "nintendo,hollywood-ehci";
> +			reg = <0x0d040000 0x100
> +			       0x133e0000 0x80000>; /* 512 KB */
> +			interrupts = <4>;
> +			interrupt-parent = <&PIC1>;
> +		};
> +
> +		ohci0@0d050000 {
> +			compatible = "nintendo,hollywood-ohci";
> +			reg = <0x0d050000 0x100
> +			       0x13460000 0x80000>; /* 512 KB */
> +			interrupts = <5>;
> +			interrupt-parent = <&PIC1>;
> +		};
> +
> +		ohci1@0d060000 {

Why the "1" ?

> +			compatible = "nintendo,hollywood-ohci";
> +			reg = <0x0d060000 0x100
> +			       0x134e0000 0x80000>; /* 512 KB */
> +			interrupts = <6>;
> +			interrupt-parent = <&PIC1>;
> +		};

Are the above OHCI and EHCI "special" ? If not, there's an existing
binding for that sort of thing, which btw requires properties to
indicate the endianness of the registers and in-memory data structures
etc...

> +		sdhc0@0d070000 {
> +			compatible = "nintendo,hollywood-sdhci";
> +			reg = <0x0d070000 0x200>;
> +			interrupts = <7>;
> +			interrupt-parent = <&PIC1>;
> +		};
> +
> +		sdhc1@0d080000 {
> +			compatible = "nintendo,hollywood-sdhci";
> +			reg = <0x0d080000 0x200>;
> +			interrupts = <8>;
> +			interrupt-parent = <&PIC1>;
> +		};

Again, no need for a "1" in there. Names don't have to be unique if the
unit address is different.

> +		PIC1: pic1@0d800030 {
> +			#interrupt-cells = <1>;
> +			compatible = "nintendo,hollywood-pic";
> +			reg = <0x0d800030 0x8>;
> +			interrupt-controller;
> +			interrupts = <14>;
> +			interrupt-parent = <&PIC0>;
> +		};

Ah, a cascaded PIC, fun fun fun

> +		hollywood-ahbprot@0d800064 {
> +			compatible = "nintendo,hollywood-ahbprot";
> +			reg = <0x0d800064 0x4>;
> +		};

What is this ?

> +		gpio0: hollywood-gpio@0d8000c0 {
> +			compatible = "nintendo,hollywood-gpio";
> +			reg = <0x0d8000c0 0x20>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		gpio1: hollywood-gpio@0d8000e0 {
> +			compatible = "nintendo,hollywood-gpio";
> +			reg = <0x0d8000e0 0x20>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};

Same comment about the "1"

> +		hollywood-resets@0d800194 {
> +			compatible = "nintendo,hollywood-resets";
> +			reg = <0x0d800194 0x4>;
> +		};
> +
> +		i2c-video {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		        compatible = "virtual,i2c-gpio";
> +
> +		        gpios = <&gpio0  16 0 /* 31-15 */
> +		                 &gpio0  17 0 /* 31-14 */
> +				>;
> +		        sda-is-open-drain = <1>;
> +		        sda-enforce-dir = <1>;
> +		        scl-is-open-drain = <1>;
> +		        scl-is-output-only = <1>;
> +		        udelay = <2>;
> +
> +		        audio-video-encoder {
> +		                compatible = "nintendo,wii-ave-rvl";
> +		                reg = <0x70>;
> +		        };
> +		};
> +	};
> +};
> +

Cheers,
Ben.
