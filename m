Return-Path: <albert_herranz@yahoo.es>
Received: from smtp104.mail.ukl.yahoo.com (smtp104.mail.ukl.yahoo.com
	[77.238.184.36]) by ozlabs.org (Postfix) with SMTP id CF8BBB6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 05:34:26 +1100 (EST)
Message-ID: <4B0D78B0.502@yahoo.es>
Date: Wed, 25 Nov 2009 19:34:24 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
In-Reply-To: <49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> +/memreserve/ 0x01800000 0xe800000;	/* memory hole (includes I/O area) */
> 
> Like others have said already, don't do this.  If you need
> a workaround, put it in the platform code.
> 

I'll do. Thanks.

>> +/memreserve/ 0x10000000 0x0004000;	/* DSP RAM */
> 
> This address is fixed in the DSP hardware, right?  If not,
> you shouldn't do a reserve here.
> 

AFAIK, it is hardcoded in hardware.

>> +	chosen {
>> +		/* root filesystem on 2nd partition of SD card */
>> +		bootargs = "nobats root=/dev/mmcblk0p2 rootwait udbg-immortal";
> 
> Question: why do you need/want nobats?
> 

We need nobats (or a hack in the mmu_mapin_ram() code) because of the discontiguous ram problem.

>> +	memory {
>> +		device_type = "memory";
>> +		/* MEM1 + memory hole + MEM2 - firmware/buffers area */
>> +		reg = <0x00000000 0x133e0000>;
> 
> This should be  <0 0x01800000  0x10000000 0x04000000>
> 

Ok.

> I'm not sure what at the end of MEM2 you're trying to hide,
> but if you need to hide anything, do it in the platform code
> isntead.
> 
>> +	cpus {
>> +		#cpus = <1>;
> 
> Don't use #cpus
> 

I'll remove it if it's not needed. Thanks.

>> +	/* devices contained in the hollywood chipset */
>> +	soc {
> 
> It's not a SoC, more like a bridge chip.  More to the point,
> all the devices you put under this node actually sit in the
> root domain logically/physically, so why not put them there
> instead.  You'll want a node for the generic control registers,
> if you do.
> 

So, if i use a node here, what should be the proper name for it?

>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		#interrupt-cells = <1>;
>> +		model = "hollywood";
> 
> "model" isn't required here, if you don't have anything
> good to put in it, just don't use the property.
> 

I'll get rid of it.

>> +		compatible = "nintendo,hollywood";
>> +		clock-frequency = <243000000>; /* 243MHz */
> 
> What does this clock freq mean?  Hollywood has lots of
> clocks, many of them configurable.  Bus frequency is in
> the cpu node already.  The binding doesn't say what this
> is either, since you didn't write a binding :-)
> 
> Just remove it?

That's the bus frequency. If it's not needed there, I vote for dropping it.

> 
>> +		ranges = <0x0c000000 0x0c000000 0x00010000
>> +			  0x0d000000 0x0d000000 0x00010000
>> +			  0x0d040000 0x0d040000 0x00050000
>> +			  0x0d800000 0x0d800000 0x00001000
> 
> All of 0cXXXXXX and 0dXXXXXX actually.
> 
>> +			  0x133e0000 0x133e0000 0x00c20000>;
> 
> This is just part of MEM2, don't treat it special here.
> 

Ok.

>> +		video@0c002000 {
>> +			compatible = "nintendo,hollywood-video";
>> +			reg = <0x0c002000 0x100>;
>> +			interrupts = <8>;
>> +			interrupt-parent = <&PIC0>;
> 
> If you say interrupt-parent = <..> in the root node, you can
> leave it out in most of the rest of the tree.  Using the Flipper
> PIC for this sounds like a good plan.
> 

Yeah, agreed.

>> +		PIC0: pic0@0c003000 {
>> +			#interrupt-cells = <1>;
>> +			compatible = "nintendo,flipper-pic";
>> +			reg = <0x0c003000 0x8>;
> 
> This register block is bigger actually.  It's not only PIC,
> but some other bus stuff as well, dunno what to do here.
> 

Heh, you're the expert here :)

>> +			interrupt-controller;
>> +		};
>> +
>> +		resetswitch@0c003000 {
>> +			compatible = "nintendo,hollywood-resetswitch";
>> +			reg = <0x0c003000 0x4>;
> 
> That's the same address.  Don't do that.
> 
> Create a flipper-processor-interface node for the whole 3000
> block (size 100)?  You can hang the PIC as a subnode under it,
> without a "reg".
> 

Ok.

>> +		/* Team Twiizers' 'mini' firmware IPC */
>> +		mini@0d000000 {
> 
> Although mini is awesome, it isn't hardware, and doesn't
> belong in the device tree.
> 

True, now that I'm starting to understand what's supposed to be and what's supposed not to be in the device tree.

>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
> 
> There are no child nodes, these are meaningless.
> 

Yeah.
In previous versions of the tree, before AHBPROT was discovered, all hardware accessed via the firmware ipc interface hanged here, though.

>> +			#interrupt-cells = <1>;
> 
> This isn't an interrupt controller.
> 

Yup, not applicable anymore.

>> +			compatible = "twiizers,starlet-mini-ipc";
>> +			reg = <0x0d000000 0x40	/* IPC */
> 
> You can get the IPC controller's address from the "main"
> hollywood device node.
> 

What about the interrupt associated to the IPC hardware?

>> +			       0x13fffffc 0x4>;	/* mini header pointer */
> 
> Put this in the platform code, it's not a hardware property.
> It's not going to change either.
> 

Ok.

>> +		serial@0d006400 {
>> +			compatible = "nintendo,hollywood-serial";
> 
> You might want to pick a more descriptive name for this,
> "serial" is usually understaood to mean "RS232".  Which
> this isn't.
> 

Nintendo calls it "Serial Interface" (SI).
Would "nintendo,hollywood-serial-interface" work here?

>> +		/* External Interface bus */
>> +		exi@0d006800 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			compatible = "nintendo,hollywood-exi";
>> +			reg = <0x0d006800 0x40>;
>> +			interrupts = <4>;
>> +			interrupt-parent = <&PIC0>;
>> +
>> +			USBGECKO0: usbgecko@0d006814 {
>> +				compatible = "usbgecko,usbgecko";
>> +				reg = <0x0d006814 0x14>;
>> +				virtual-reg = <0xcd006814>;
>> +			};
> 
> I don't think you should put the usbgecko in the device tree,
> it's a removable device, not everyone booting with this device
> tree blob will have a usbgecko in this EXI port.  It's easy
> to probe for as well.
> 

Ok.

>> +		ehci@0d040000 {
>> +			compatible = "nintendo,hollywood-ehci";
> 
> You might want to put the generic usb-ohci in here as well.
> Although you need bug workarounds IIRC.
> 

Yes.

>> +			reg = <0x0d040000 0x100
>> +			       0x133e0000 0x80000>; /* 512 KB */
> 
> What's this MEM2 range?  A remnant from the old mini scheme?
> 
>> +		ohci0@0d050000 {
> 
>> +		ohci1@0d060000 {
> 
>> +		sdhc0@0d070000 {
> 
>> +		sdhc1@0d080000 {
> 
> Similar.
> 

Yes. This can be removed now.

>> +		hollywood-ahbprot@0d800064 {
>> +			compatible = "nintendo,hollywood-ahbprot";
>> +			reg = <0x0d800064 0x4>;
>> +		};
> 
> There is no reason to single out this one register.  The kernel
> shouldn't care for it anyway, the firmware sets it already.
> 

As long as a recent firmware version is used, yes.

How should all these register be declared in the device tree?
Using a block of registers and declaring the block as "nintendo,hollywood-control" or something?

>> +		gpio0: hollywood-gpio@0d8000c0 {
>> +			compatible = "nintendo,hollywood-gpio";
>> +			reg = <0x0d8000c0 0x20>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +		};
>> +
>> +		gpio1: hollywood-gpio@0d8000e0 {
>> +			compatible = "nintendo,hollywood-gpio";
>> +			reg = <0x0d8000e0 0x20>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +		};
> 
> Yuck, you have to make this two nodes for the GPIO binding?
> 

Yup. Two gpio nodes for two 32 gpio words.

>> +		hollywood-resets@0d800194 {
>> +			compatible = "nintendo,hollywood-resets";
>> +			reg = <0x0d800194 0x4>;
>> +		};
> 
> Don't do a separate node.
> 

So this should be part of the "control" block?

>> +		i2c-video {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		        compatible = "virtual,i2c-gpio";
> 
> This is not a device from a company named "virtual".  Just
> "i2c-gpio" will do.
> 
> As I said elsewhere, there should be a driver for this already,
> and a device tree binding.  Add to that if at all possible, don't
> make up something new.  Or if you do, give it a better name :-)
> 

Plese, see my previous comment on this.

>> +		        audio-video-encoder {
>> +		                compatible = "nintendo,wii-ave-rvl";
>> +		                reg = <0x70>;
> 
> audio-video-encoder@70 -- the unit address has to match the first
> entry in "reg", always.
> 
> And "wii-ave-rvl", seriously?  Just call it "wii-audio-video-encoder",
> a few extra chars don't hurt :-)
> 

Agreed too. :)

Thanks!
Albert
