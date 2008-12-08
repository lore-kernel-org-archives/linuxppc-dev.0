Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0D5CDDED4
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2008 19:03:51 +1100 (EST)
Subject: Re: MPC5200 VIRQ question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <4937E048.90206@mlbassoc.com>
References: <4937E048.90206@mlbassoc.com>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 19:03:42 +1100
Message-Id: <1228723422.7101.35.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-12-04 at 06:51 -0700, Gary Thomas wrote:
> I have a MPC5200 based board which has an FPGA for external
> I/O, etc.  This FPGA also funnels interrupts from the various
> external devices through to the CPU.
> 
> I've defined this structure in my DTS:
> 
> 	fpga@f8000000 {
> 		device_type = "board-control";
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		// Note: includes sub-devices like CAN, A/D, etc
> 		reg = <0xf8000000 0x100000>;
> 
> 		fpga_ic: fpga_ic@f8000000 {
> 			device_type = "fpga-int-ctlr";
> 			interrupt-controller;
> 			#address-cells = <0>;
> 			#interrupt-cells = <2>;
> 			interrupts = <2 26 3>; // IRQ2
> 			interrupt-parent = <&mpc5200_pic>;
> 		};
> 		can@f8010000 {
> 			compatible = "am,can";
> 			device_type = "can";
> 			interrupts = <0 0>;
> 			interrupt_parent = <&fpga_ic>;
> 			reg = <0xf8010000 0x200>;
> 		};
> 	};
> 
> Of course, there will be more devices and interrupts later on,
> this is just the first of many.

Nothing obviously wrong so far other than you should use "compatible"
properties to identify your devices, including (especially) the fpga &
its pic, and maybe use slightly more verbose entries than "am,can" :-)

> Now the questions:
>  * How do I choose the VIRQ range supported by my FPGA?

You don't. Linux virtual numbers are allocated sparsely and on the fly.

You basically create an irq_host data structure, specifying what kind of
reverse mapping you want (typically in your case I suspect linear since
your HW interrupt space won't be huge), provide the appropriate
callbacks, all I can suggest here is to look at what others do.

>    I'm interested in this in particular for the MPC5200, but
>    also for other chips (I have many such board configurations).
>  * How do I pass this information along to my drivers?  I would
>    think that the interrupts value for the can interface above
>    would use a [logical] IRQ (an offset from the base VIRQ),
>    so how does the driver get the actual number (VIRQ+offset)
>    when probing the tree?

Depends on the driver. But if they use an OF node, they can do
of_irq_parse_and_map() or something like that. It will walk the tree,
find the controller, map it to an irq_host (via the callbacks your
provided), allocate a virq if not done yet, establish a virq->hw mapping
etc... all for you, and return the virq.

If they are PCI devices, the PCI code does it all for you.

>  * I know how to define the interrupt controller using irq_alloc_host()
>    (once I have the VIRQ range) but it's not clear to me where to stick
>    this initialization when bringing up my platform.

You don't provide a virq range to irq_alloc_host. You provide a type of
reverse mapping (depending on how sparse your HW numbering scheme is)
and for a linear map, how many entries it contains (which is the size of
your -physical- range).

virqs are allocated on the fly.

> Thanks for any pointers/ideas
> 
> n.b. I've read all the arguments about not using "device_type"
> and this will be resolved.  At the moment, I'm basing my
> code on a slightly older kernel codebase (2.6.26), so those
> entries remain.
> 
Cheers,
Ben.
