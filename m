Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06BBAB7BA4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 14:25:41 +1100 (EST)
Subject: Re: Regarding FPGA based cascaded PIC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "thirumalai.p" <thirumalai.p@datapatterns.co.in>
In-Reply-To: <99cb42d33b031818b565d67254059410@datapatterns.co.in>
References: <06737AFD409844ED8DF3D43EFA83A906@itd210>
	<1257315924.13611.54.camel@pasglop>
	<2DA2EE8F96D44EF69D4D8A712410E546@itd210>
	<1257367882.13611.65.camel@pasglop>
	<99cb42d33b031818b565d67254059410@datapatterns.co.in>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 14:24:54 +1100
Message-ID: <1257391494.13611.87.camel@pasglop>
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

On Thu, 2009-11-05 at 08:16 +0530, thirumalai.p wrote:
> 
> I Understood the thing. Thank you very much. So you mean to say that
> my map/xlate functions will get invoked only for the devices which is
> connected the FPGA PIC. 

Right, and I fail to see how it would make any sense the other way
around :-)

Seriously, the map and xlate functions are used to hook up interrupt to
the PIC inputs. So logically, the 3 cascade interrupts are -inputs- to
the parent controller and as such get mapped by that controller. IE. The
parent is the only one to "understand" the format of the "interrupts"
properties for those and the interrupt numbers for those are HW numbers
in the parent space. It wouldn't make -any- sense to call map/xlate of
the child. In fact, for the code in question, the child PIC is just a
device, the fact that that device is itself a PIC is irrelevant.

> So for example suppose if i have an WDT connected
> to my FPGA then the interrupt-parent tag should point to FPGA-PIC. So
> at
> that time the irq_of_parse_and_map() will invoke my map/xlate
> functions
> right.

Yes.

> So i need to define the nodes on my device tree for the devices which
> are
> all going to generate interrupts for FPGA and keeping the
> interrupt-parent
> property as fpga-pic.

Or you can just keep track of the irq_host * of the FPGA and manually
call irq_create_mapping() passing it a HW number in the FPGA irq space
if you don't want to create device nodes for those children but the
device-node approach is preferred. 

> So my device node for WDT is something like the following
> 
>                     wdt@4,2000 {
>                        #interrupt-cells = <2>;
>                        device_type = "watchdog";
>                        compatible = "gef,fpga-wdt";
>                        reg = <0x4 0x2000 0x8>;
>                        interrupts = <0x1a 0x4>;
>                        interrupt-parent = <&fpga_pic>;
>                };
> Correct me if i am wrong.

It looks ok except that if I remember correctly, your FPGA PIC has a
#interrupt-cells value of '3' which means that it expects 3 numbers in
the "interrupts" property to define an interrupt (which your xlate
function is then going to translate into the appropriate HW number and
sense/polarity flags for linux).

So if you use only 2 numbers, you need to fix your #interrupt-cells
property value.

Cheers,
Ben.
 
> > Ben.
> > 
> >> Here is the piece of code that we are using.
> >> 
> >> fpga_pic_irq_host = irq_alloc_host(pic, IRQ_HOST_MAP_LINEAR,
> >>                         DPVPX0659_FPGA_NUM_IRQS,&fpga_pic_host_ops,
> >>                         NO_IRQ);
> >>         if (fpga_pic_irq_host == NULL) {
> >>                 printk("FPGA PIC: Unable to allocate host\n");
> >>                 return;
> >>         }
> >> 
> >>         for (i = 0; i < 3; i++) {
> >>                 fpga_irqs[i] = irq_of_parse_and_map(pic, i);
> >>                 if (fpga_irqs[i] == NO_IRQ) {
> >>                         printk("FPGA PIC: can't get irq %d.\n", i);
> >>                         continue;
> >>                 }
> >>                 printk("interrupt from device tree : %d
> >>                 \n",fpga_irqs[i]);
> >>                
> set_irq_chained_handler(dpvpx0659_fpga_irqs[i],dpvpx0659_fpga_pic_cascade);
> >>         }
> >> 
> >>
> Thank you
> Thirumalai 
