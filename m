Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C189DDFB3
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 12:59:26 +1100 (EST)
Subject: Re: MPC5200 VIRQ question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <49406730.8040609@mlbassoc.com>
References: <4937E048.90206@mlbassoc.com> <1228723422.7101.35.camel@pasglop>
	<49406730.8040609@mlbassoc.com>
Content-Type: text/plain
Date: Thu, 11 Dec 2008 12:59:18 +1100
Message-Id: <1228960758.22413.134.camel@pasglop>
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


> >> 	fpga@f8000000 {
> >> 		device_type = "board-control";
> >> 		#address-cells = <1>;
> >> 		#size-cells = <1>;
> >> 		// Note: includes sub-devices like CAN, A/D, etc
> >> 		reg = <0xf8000000 0x100000>;
> >>
> >> 		fpga_ic: fpga_ic@f8000000 {
> >> 			device_type = "fpga-int-ctlr";
> >> 			interrupt-controller;
> >> 			#address-cells = <0>;
> >> 			#interrupt-cells = <2>;
> >> 			interrupts = <2 26 3>; // IRQ2
> 
> BTW, this is wrong! Are the IRQ mappings on the MPC5200 documented
> somewhere? I've looked and looked without much joy.  Only by
> experimentation did I discover that "<1 2 3>" corresponds to IRQ2.

The content of the interrupts property depends on a given PIC binding. I
don't know if Grant or Sylvain published their binding but in the
meantime, you can look at the code that decodes that stuff :-) It's in
arch/powerpc/platforms/mpc52xx_pic.c : mpc52xx_irqhost_xlate().

My understanding from a quick look at the code is that the first
number (called L1) is the "category" (0 = CRIT, 1 = MAIN, 2 = PERP, ...)
since I think inside the 52xx, interrupts are divided into such
categories coming from different sources. The second number would thus
be the number within that category.

It looks to me that the external IRQs 1..3 are of type "main" (1) and
number 1 to 3. That would give you a binding of <1 <n> <s>> where n is
1..3 and s is the sense code

For mpc52xx, the sense code is 0=high level,1=rising edge,2=falling edge
and 3=low level (still from looking at the code).

The mpc52xx irq binding is indeed more complicated than most :-) 

> This part is still a bit fuzzy.  Where/how does my interrupt controller
> driver get this VIRQ?  Here's how I created my controller:
> 
>     fpga_can_irq = irq_of_parse_and_map(fpga_ic, 0);
>     D_printk(("%s: fpga_irq = %d\n", __func__, (u32) fpga_can_irq));
>     if (fpga_can_irq == 0) {
>         printk(KERN_ERR "%s: Can't find FPGA Interrupt Controller IRQ", __func__);
>         return -EINVAL;
>     }
>     if (request_irq(fpga_can_irq, &fpga_irq_cascade, 0, "FPGA CAN", 0)) {
>         printk(KERN_ERR "%s: Can't attach to FPGA Interrupt Controller IRQ", __func__);
>         return -EINVAL;
>     }
>     fpga_irq_host = irq_alloc_host(of_node_get(fpga_node), IRQ_HOST_MAP_LINEAR,
>                                            16, &fpga_irq_host_ops, -1);
> 
> When I try to get the interrupt number for the CAN sub-device,
> I always get zero :-(
> 
>     for_each_compatible_node(np, "can", "am,can") {
>         memset(r, 0, sizeof(r));
>         rc = of_address_to_resource(np, 0, &r[0]);
>         if (rc) {
>             return rc;
>         }
>         rc = of_irq_to_resource(np, 0, &r[1]);
>         if (rc) {
>             return rc;
>         }
>     }
> 
> Note: the of_address_to_resource() call works fine, but the
> of_irq_to_resource() fails - always returns 0.  Any ideas what
> I'm doing wrong?

We should trace what your fpga_irq_host_ops are doing.

Add some debug to irq_of_parse_and_map() first. This function first
calls of_irq_map_one() which will walk the device-tree to match your
interrupt to a controller node (going through all the interrupt-map's on
the way if any, but you don't have any) and should return with
oirq.controller being the device-node of your fpga_ic. If not, then we
missed a bogon in the device-tree.

At this stage, if it hasn't failed, it will call
irq_create_of_mapping().

That function will then try to find an irq_host matching the device node
passed in. This is achieved by calling the ->match() callback all the
irq_host's in the system. So verify that your fpga irq host "match"
function properly checks that the device-tree node it's passed indeed
matches the fpga_ic and returns 1 if it does.

It will then call your host xlate() callback to translate the
device-tree specifier (in your case <0 0> into a hw interrupt number. I
don't know why you are using 2 cells for your interrupts, you want to
encode a sense code ? If not, I suggest using only one cell and make it
the local HW interrupt number in your FPGA.

At this point, all your xlate has to do is to return inspec[0] in hwirq
and then return 0. Again, look at what mpc52xx_pic.c or mpic.c do here.

The code then establishes the virq -> hwirq mapping with
irq_create_mapping() which will allocate a virq for you.

Cheers,
Ben.
