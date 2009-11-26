Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4CDC1007E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 15:51:08 +1100 (EST)
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 15:51:01 +1100
Message-ID: <1259211061.16367.260.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-25 at 18:49 +0100, Segher Boessenkool wrote:
> > +/memreserve/ 0x01800000 0xe800000;	/* memory hole (includes I/O area) */
> 
> Like others have said already, don't do this.  If you need
> a workaround, put it in the platform code.
> 
> > +/memreserve/ 0x10000000 0x0004000;	/* DSP RAM */
> 
> This address is fixed in the DSP hardware, right?  If not,
> you shouldn't do a reserve here.
> 
> > +	chosen {
> > +		/* root filesystem on 2nd partition of SD card */
> > +		bootargs = "nobats root=/dev/mmcblk0p2 rootwait udbg-immortal";
> 
> Question: why do you need/want nobats?

Good point. I can't even guarantee that the kernel will work reliably
with nobats :-) At least you really want the kernel .text to be fully
covered by an IBAT.

> What does this clock freq mean?  Hollywood has lots of
> clocks, many of them configurable.  Bus frequency is in
> the cpu node already.  The binding doesn't say what this
> is either, since you didn't write a binding :-)
> 
> Just remove it?

BTW. If we want to play with clocks, maybe you should look at
my proposed binding for clocks and implementing the clk API :-)

> > +		ranges = <0x0c000000 0x0c000000 0x00010000
> > +			  0x0d000000 0x0d000000 0x00010000
> > +			  0x0d040000 0x0d040000 0x00050000
> > +			  0x0d800000 0x0d800000 0x00001000
> 
> All of 0cXXXXXX and 0dXXXXXX actually.
> 
> > +			  0x133e0000 0x133e0000 0x00c20000>;
> 
> This is just part of MEM2, don't treat it special here.
> 
> > +		video@0c002000 {
> > +			compatible = "nintendo,hollywood-video";
> > +			reg = <0x0c002000 0x100>;
> > +			interrupts = <8>;
> > +			interrupt-parent = <&PIC0>;
> 
> If you say interrupt-parent = <..> in the root node, you can
> leave it out in most of the rest of the tree.  Using the Flipper
> PIC for this sounds like a good plan.

Well, for the rest of the tree except stuff whose interrupt parent
is PIC1. With two PICs I prefer being explicit.

> > +		PIC0: pic0@0c003000 {
> > +			#interrupt-cells = <1>;
> > +			compatible = "nintendo,flipper-pic";
> > +			reg = <0x0c003000 0x8>;
> 
> This register block is bigger actually.  It's not only PIC,
> but some other bus stuff as well, dunno what to do here.

Add nodes for the other things ?

> > +			interrupt-controller;
> > +		};
> > +
> > +		resetswitch@0c003000 {
> > +			compatible = "nintendo,hollywood-resetswitch";
> > +			reg = <0x0c003000 0x4>;
> 
> That's the same address.  Don't do that.
> 
> Create a flipper-processor-interface node for the whole 3000
> block (size 100)?  You can hang the PIC as a subnode under it,
> without a "reg".

Yeah.

> > +		/* Team Twiizers' 'mini' firmware IPC */
> > +		mini@0d000000 {
> 
> Although mini is awesome, it isn't hardware, and doesn't
> belong in the device tree.

So what is at d0000000 ?

> > +		serial@0d006400 {
> > +			compatible = "nintendo,hollywood-serial";
> 
> You might want to pick a more descriptive name for this,
> "serial" is usually understaood to mean "RS232".  Which
> this isn't.

What is it then ? You definitely want some other name if it's not
classic rs232 style serial.

Cheers,
Ben.
