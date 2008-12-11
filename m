Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id 54EC2DDFC7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 13:04:26 +1100 (EST)
Received: by qyk14 with SMTP id 14so1505328qyk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 18:04:24 -0800 (PST)
Message-ID: <9e4733910812101804y25fb30d3m81950a56039d84b6@mail.gmail.com>
Date: Wed, 10 Dec 2008 21:04:24 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Gary Thomas" <gary@mlbassoc.com>
Subject: Re: MPC5200 VIRQ question
In-Reply-To: <49406730.8040609@mlbassoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4937E048.90206@mlbassoc.com> <1228723422.7101.35.camel@pasglop>
	<49406730.8040609@mlbassoc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 10, 2008 at 8:04 PM, Gary Thomas <gary@mlbassoc.com> wrote:
> Benjamin Herrenschmidt wrote:
>> On Thu, 2008-12-04 at 06:51 -0700, Gary Thomas wrote:
>>> I have a MPC5200 based board which has an FPGA for external
>>> I/O, etc.  This FPGA also funnels interrupts from the various
>>> external devices through to the CPU.
>>>
>>> I've defined this structure in my DTS:
>>>
>>>      fpga@f8000000 {
>>>              device_type = "board-control";
>>>              #address-cells = <1>;
>>>              #size-cells = <1>;
>>>              // Note: includes sub-devices like CAN, A/D, etc
>>>              reg = <0xf8000000 0x100000>;
>>>
>>>              fpga_ic: fpga_ic@f8000000 {
>>>                      device_type = "fpga-int-ctlr";
>>>                      interrupt-controller;
>>>                      #address-cells = <0>;
>>>                      #interrupt-cells = <2>;
>>>                      interrupts = <2 26 3>; // IRQ2
>
> BTW, this is wrong! Are the IRQ mappings on the MPC5200 documented
> somewhere? I've looked and looked without much joy.  Only by
> experimentation did I discover that "<1 2 3>" corresponds to IRQ2.

Documentation/powerpc/mpc52xx-device-tree-bindings.txt

1. Interrupt mapping
--------------------
The mpc5200 pic driver splits hardware IRQ numbers into two levels.  The
split reflects the layout of the PIC hardware itself, which groups
interrupts into one of three groups; CRIT, MAIN or PERP.  Also, the
Bestcomm dma engine has it's own set of interrupt sources which are
cascaded off of peripheral interrupt 0, which the driver interprets as a
fourth group, SDMA.

The interrupts property for device nodes using the mpc5200 pic consists
of three cells; <L1 L2 level>

    L1 := [CRIT=0, MAIN=1, PERP=2, SDMA=3]
    L2 := interrupt number; directly mapped from the value in the
          "ICTL PerStat, MainStat, CritStat Encoded Register"
    level := [LEVEL_HIGH=0, EDGE_RISING=1, EDGE_FALLING=2, LEVEL_LOW=3]



>
>>>                      interrupt-parent = <&mpc5200_pic>;
>>>              };
>>>              can@f8010000 {
>>>                      compatible = "am,can";
>>>                      device_type = "can";
>>>                      interrupts = <0 0>;
>>>                      interrupt_parent = <&fpga_ic>;
>>>                      reg = <0xf8010000 0x200>;
>>>              };
>>>      };
>>>
>>> Of course, there will be more devices and interrupts later on,
>>> this is just the first of many.
>>
>> Nothing obviously wrong so far other than you should use "compatible"
>> properties to identify your devices, including (especially) the fpga &
>> its pic, and maybe use slightly more verbose entries than "am,can" :-)
>
> Fair enough, but these are 100% internal devices.  I'm only using the
> OF tree for them as that seems to be the accepted method (IMO, it's
> a bit wrong-headed, but that's another discussion...)
>
>>
>>> Now the questions:
>>>  * How do I choose the VIRQ range supported by my FPGA?
>>
>> You don't. Linux virtual numbers are allocated sparsely and on the fly.
>>
>> You basically create an irq_host data structure, specifying what kind of
>> reverse mapping you want (typically in your case I suspect linear since
>> your HW interrupt space won't be huge), provide the appropriate
>> callbacks, all I can suggest here is to look at what others do.
>>
>>>    I'm interested in this in particular for the MPC5200, but
>>>    also for other chips (I have many such board configurations).
>>>  * How do I pass this information along to my drivers?  I would
>>>    think that the interrupts value for the can interface above
>>>    would use a [logical] IRQ (an offset from the base VIRQ),
>>>    so how does the driver get the actual number (VIRQ+offset)
>>>    when probing the tree?
>>
>> Depends on the driver. But if they use an OF node, they can do
>> of_irq_parse_and_map() or something like that. It will walk the tree,
>> find the controller, map it to an irq_host (via the callbacks your
>> provided), allocate a virq if not done yet, establish a virq->hw mapping
>> etc... all for you, and return the virq.
>>
>
> This part is still a bit fuzzy.  Where/how does my interrupt controller
> driver get this VIRQ?  Here's how I created my controller:
>
>    fpga_can_irq = irq_of_parse_and_map(fpga_ic, 0);
>    D_printk(("%s: fpga_irq = %d\n", __func__, (u32) fpga_can_irq));
>    if (fpga_can_irq == 0) {
>        printk(KERN_ERR "%s: Can't find FPGA Interrupt Controller IRQ", __func__);
>        return -EINVAL;
>    }
>    if (request_irq(fpga_can_irq, &fpga_irq_cascade, 0, "FPGA CAN", 0)) {
>        printk(KERN_ERR "%s: Can't attach to FPGA Interrupt Controller IRQ", __func__);
>        return -EINVAL;
>    }
>    fpga_irq_host = irq_alloc_host(of_node_get(fpga_node), IRQ_HOST_MAP_LINEAR,
>                                           16, &fpga_irq_host_ops, -1);
>
> When I try to get the interrupt number for the CAN sub-device,
> I always get zero :-(
>
>    for_each_compatible_node(np, "can", "am,can") {
>        memset(r, 0, sizeof(r));
>        rc = of_address_to_resource(np, 0, &r[0]);
>        if (rc) {
>            return rc;
>        }
>        rc = of_irq_to_resource(np, 0, &r[1]);
>        if (rc) {
>            return rc;
>        }
>    }
>
> Note: the of_address_to_resource() call works fine, but the
> of_irq_to_resource() fails - always returns 0.  Any ideas what
> I'm doing wrong?
>
>> If they are PCI devices, the PCI code does it all for you.
>
> Sadly, 100% home grown, not PCI.
>
>>
>>>  * I know how to define the interrupt controller using irq_alloc_host()
>>>    (once I have the VIRQ range) but it's not clear to me where to stick
>>>    this initialization when bringing up my platform.
>>
>> You don't provide a virq range to irq_alloc_host. You provide a type of
>> reverse mapping (depending on how sparse your HW numbering scheme is)
>> and for a linear map, how many entries it contains (which is the size of
>> your -physical- range).
>>
>> virqs are allocated on the fly.
>>
>
> Once I get the above call to work, I'll have to figure out how
> to get at the VIRQ (so my cascade handler can signal the right
> interrupt)
>
> n.b. I only ask these questions after much investigation and
> experimentation; I'm not asking you to do my job for me, just
> help through the maze of twisty little passages!
>
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Jon Smirl
jonsmirl@gmail.com
