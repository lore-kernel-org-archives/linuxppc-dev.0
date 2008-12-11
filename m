Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [204.133.123.27])
	by ozlabs.org (Postfix) with ESMTP id 98600DDF72
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 01:59:44 +1100 (EST)
Message-ID: <49412AD4.1070403@mlbassoc.com>
Date: Thu, 11 Dec 2008 07:59:32 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MPC5200 VIRQ question
References: <4937E048.90206@mlbassoc.com>
	<1228723422.7101.35.camel@pasglop>	<49406730.8040609@mlbassoc.com>
	<1228960758.22413.134.camel@pasglop>
In-Reply-To: <1228960758.22413.134.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>>> 	fpga@f8000000 {
>>>> 		device_type = "board-control";
>>>> 		#address-cells = <1>;
>>>> 		#size-cells = <1>;
>>>> 		// Note: includes sub-devices like CAN, A/D, etc
>>>> 		reg = <0xf8000000 0x100000>;
>>>>
>>>> 		fpga_ic: fpga_ic@f8000000 {
>>>> 			device_type = "fpga-int-ctlr";
>>>> 			interrupt-controller;
>>>> 			#address-cells = <0>;
>>>> 			#interrupt-cells = <2>;
>>>> 			interrupts = <2 26 3>; // IRQ2
>> BTW, this is wrong! Are the IRQ mappings on the MPC5200 documented
>> somewhere? I've looked and looked without much joy.  Only by
>> experimentation did I discover that "<1 2 3>" corresponds to IRQ2.
> 
> The content of the interrupts property depends on a given PIC binding. I
> don't know if Grant or Sylvain published their binding but in the
> meantime, you can look at the code that decodes that stuff :-) It's in
> arch/powerpc/platforms/mpc52xx_pic.c : mpc52xx_irqhost_xlate().
> 
> My understanding from a quick look at the code is that the first
> number (called L1) is the "category" (0 = CRIT, 1 = MAIN, 2 = PERP, ...)
> since I think inside the 52xx, interrupts are divided into such
> categories coming from different sources. The second number would thus
> be the number within that category.
> 
> It looks to me that the external IRQs 1..3 are of type "main" (1) and
> number 1 to 3. That would give you a binding of <1 <n> <s>> where n is
> 1..3 and s is the sense code
> 
> For mpc52xx, the sense code is 0=high level,1=rising edge,2=falling edge
> and 3=low level (still from looking at the code).
> 
> The mpc52xx irq binding is indeed more complicated than most :-) 

Thanks for the elucidation;  I would think it useful to have this spelled
out somewhere - without having to dig through the [truly] awful MPC5200
manual!  A simple bit of documentation can go a long way...  e.g.

  IRQ1 = <1 1 n>
  IRQ2 = <1 2 n>
    ...
  CAN0 = <2 11 0>
    ... etc

>> This part is still a bit fuzzy.  Where/how does my interrupt controller
>> driver get this VIRQ?  Here's how I created my controller:
>>
>>     fpga_can_irq = irq_of_parse_and_map(fpga_ic, 0);
>>     D_printk(("%s: fpga_irq = %d\n", __func__, (u32) fpga_can_irq));
>>     if (fpga_can_irq == 0) {
>>         printk(KERN_ERR "%s: Can't find FPGA Interrupt Controller IRQ", __func__);
>>         return -EINVAL;
>>     }
>>     if (request_irq(fpga_can_irq, &fpga_irq_cascade, 0, "FPGA CAN", 0)) {
>>         printk(KERN_ERR "%s: Can't attach to FPGA Interrupt Controller IRQ", __func__);
>>         return -EINVAL;
>>     }
>>     fpga_irq_host = irq_alloc_host(of_node_get(fpga_node), IRQ_HOST_MAP_LINEAR,
>>                                            16, &fpga_irq_host_ops, -1);
>>
>> When I try to get the interrupt number for the CAN sub-device,
>> I always get zero :-(
>>
>>     for_each_compatible_node(np, "can", "am,can") {
>>         memset(r, 0, sizeof(r));
>>         rc = of_address_to_resource(np, 0, &r[0]);
>>         if (rc) {
>>             return rc;
>>         }
>>         rc = of_irq_to_resource(np, 0, &r[1]);
>>         if (rc) {
>>             return rc;
>>         }
>>     }
>>
>> Note: the of_address_to_resource() call works fine, but the
>> of_irq_to_resource() fails - always returns 0.  Any ideas what
>> I'm doing wrong?
> 
> We should trace what your fpga_irq_host_ops are doing.
> 
> Add some debug to irq_of_parse_and_map() first. This function first
> calls of_irq_map_one() which will walk the device-tree to match your
> interrupt to a controller node (going through all the interrupt-map's on
> the way if any, but you don't have any) and should return with
> oirq.controller being the device-node of your fpga_ic. If not, then we
> missed a bogon in the device-tree.
> 
> At this stage, if it hasn't failed, it will call
> irq_create_of_mapping().
> 

I traced through this and this is where it was failing.

unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
{
	struct of_irq oirq;

	if (of_irq_map_one(dev, index, &oirq))
		return NO_IRQ;

	return irq_create_of_mapping(oirq.controller, oirq.specifier,
				     oirq.size);
}

Notice that of_irq_map_one() can fail for a myriad of reasons - all quiet
(without debugging on).  This function simply masks those into "sorry..."

After a lot of looking I found this in mt DTS:
		can@f8010000 {
			compatible = "am,can";
			device_type = "can";
			interrupts = <0>;
			cell-index = <0>;
			interrupt_parent = <&fpga_ic>;
			reg = <0xf8010000 0x200>;
		};
See the bug?  Truly not obvious, is it?  and the fact that 'irq_of_parse_and_map()'
just tossed a "sorry == NO_IRQ" didn't help find it.

This line:
			interrupt_parent = <&fpga_ic>;
should read:
			interrupt-parent = <&fpga_ic>;

I fixed that and got the rest figured out.

Thanks for the help.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
