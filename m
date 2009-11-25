Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81D60B7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 04:49:41 +1100 (EST)
Message-ID: <49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
In-Reply-To: <1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
Date: Wed, 25 Nov 2009 18:49:37 +0100 (CET)
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Albert Herranz" <albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +/memreserve/ 0x01800000 0xe800000;	/* memory hole (includes I/O area) */

Like others have said already, don't do this.  If you need
a workaround, put it in the platform code.

> +/memreserve/ 0x10000000 0x0004000;	/* DSP RAM */

This address is fixed in the DSP hardware, right?  If not,
you shouldn't do a reserve here.

> +	chosen {
> +		/* root filesystem on 2nd partition of SD card */
> +		bootargs = "nobats root=/dev/mmcblk0p2 rootwait udbg-immortal";

Question: why do you need/want nobats?

> +	memory {
> +		device_type = "memory";
> +		/* MEM1 + memory hole + MEM2 - firmware/buffers area */
> +		reg = <0x00000000 0x133e0000>;

This should be  <0 0x01800000  0x10000000 0x04000000>

I'm not sure what at the end of MEM2 you're trying to hide,
but if you need to hide anything, do it in the platform code
isntead.

> +	cpus {
> +		#cpus = <1>;

Don't use #cpus

> +	/* devices contained in the hollywood chipset */
> +	soc {

It's not a SoC, more like a bridge chip.  More to the point,
all the devices you put under this node actually sit in the
root domain logically/physically, so why not put them there
instead.  You'll want a node for the generic control registers,
if you do.

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <1>;
> +		model = "hollywood";

"model" isn't required here, if you don't have anything
good to put in it, just don't use the property.

> +		compatible = "nintendo,hollywood";
> +		clock-frequency = <243000000>; /* 243MHz */

What does this clock freq mean?  Hollywood has lots of
clocks, many of them configurable.  Bus frequency is in
the cpu node already.  The binding doesn't say what this
is either, since you didn't write a binding :-)

Just remove it?

> +		ranges = <0x0c000000 0x0c000000 0x00010000
> +			  0x0d000000 0x0d000000 0x00010000
> +			  0x0d040000 0x0d040000 0x00050000
> +			  0x0d800000 0x0d800000 0x00001000

All of 0cXXXXXX and 0dXXXXXX actually.

> +			  0x133e0000 0x133e0000 0x00c20000>;

This is just part of MEM2, don't treat it special here.

> +		video@0c002000 {
> +			compatible = "nintendo,hollywood-video";
> +			reg = <0x0c002000 0x100>;
> +			interrupts = <8>;
> +			interrupt-parent = <&PIC0>;

If you say interrupt-parent = <..> in the root node, you can
leave it out in most of the rest of the tree.  Using the Flipper
PIC for this sounds like a good plan.

> +		PIC0: pic0@0c003000 {
> +			#interrupt-cells = <1>;
> +			compatible = "nintendo,flipper-pic";
> +			reg = <0x0c003000 0x8>;

This register block is bigger actually.  It's not only PIC,
but some other bus stuff as well, dunno what to do here.

> +			interrupt-controller;
> +		};
> +
> +		resetswitch@0c003000 {
> +			compatible = "nintendo,hollywood-resetswitch";
> +			reg = <0x0c003000 0x4>;

That's the same address.  Don't do that.

Create a flipper-processor-interface node for the whole 3000
block (size 100)?  You can hang the PIC as a subnode under it,
without a "reg".

> +		/* Team Twiizers' 'mini' firmware IPC */
> +		mini@0d000000 {

Although mini is awesome, it isn't hardware, and doesn't
belong in the device tree.

> +			#address-cells = <1>;
> +			#size-cells = <1>;

There are no child nodes, these are meaningless.

> +			#interrupt-cells = <1>;

This isn't an interrupt controller.

> +			compatible = "twiizers,starlet-mini-ipc";
> +			reg = <0x0d000000 0x40	/* IPC */

You can get the IPC controller's address from the "main"
hollywood device node.

> +			       0x13fffffc 0x4>;	/* mini header pointer */

Put this in the platform code, it's not a hardware property.
It's not going to change either.

> +		serial@0d006400 {
> +			compatible = "nintendo,hollywood-serial";

You might want to pick a more descriptive name for this,
"serial" is usually understaood to mean "RS232".  Which
this isn't.

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

I don't think you should put the usbgecko in the device tree,
it's a removable device, not everyone booting with this device
tree blob will have a usbgecko in this EXI port.  It's easy
to probe for as well.

> +		ehci@0d040000 {
> +			compatible = "nintendo,hollywood-ehci";

You might want to put the generic usb-ohci in here as well.
Although you need bug workarounds IIRC.

> +			reg = <0x0d040000 0x100
> +			       0x133e0000 0x80000>; /* 512 KB */

What's this MEM2 range?  A remnant from the old mini scheme?

> +		ohci0@0d050000 {

> +		ohci1@0d060000 {

> +		sdhc0@0d070000 {

> +		sdhc1@0d080000 {

Similar.

> +		hollywood-ahbprot@0d800064 {
> +			compatible = "nintendo,hollywood-ahbprot";
> +			reg = <0x0d800064 0x4>;
> +		};

There is no reason to single out this one register.  The kernel
shouldn't care for it anyway, the firmware sets it already.

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

Yuck, you have to make this two nodes for the GPIO binding?

> +		hollywood-resets@0d800194 {
> +			compatible = "nintendo,hollywood-resets";
> +			reg = <0x0d800194 0x4>;
> +		};

Don't do a separate node.

> +		i2c-video {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		        compatible = "virtual,i2c-gpio";

This is not a device from a company named "virtual".  Just
"i2c-gpio" will do.

As I said elsewhere, there should be a driver for this already,
and a device tree binding.  Add to that if at all possible, don't
make up something new.  Or if you do, give it a better name :-)

> +		        audio-video-encoder {
> +		                compatible = "nintendo,wii-ave-rvl";
> +		                reg = <0x70>;

audio-video-encoder@70 -- the unit address has to match the first
entry in "reg", always.

And "wii-ave-rvl", seriously?  Just call it "wii-audio-video-encoder",
a few extra chars don't hurt :-)


Segher
