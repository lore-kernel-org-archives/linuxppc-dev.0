Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A007CB7B8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 07:52:10 +1100 (EST)
Subject: Re: Regarding FPGA based cascaded PIC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thirumalai <thirumalai.p@datapatterns.co.in>
In-Reply-To: <2DA2EE8F96D44EF69D4D8A712410E546@itd210>
References: <06737AFD409844ED8DF3D43EFA83A906@itd210>
	<1257315924.13611.54.camel@pasglop>
	<2DA2EE8F96D44EF69D4D8A712410E546@itd210>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 07:51:22 +1100
Message-ID: <1257367882.13611.65.camel@pasglop>
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

On Wed, 2009-11-04 at 18:09 +0530, Thirumalai wrote:
> you understood correctly. Here the problem lies.Correct me if i am wrong. So 
> you are telling that irq_of_parse_and_map() will invoke the map/xlate of my 
> FPGA pic. Right.
> 
> But this is what not happening. Instead of calling my map/xlate functions 
> the irq_of_parse_and_map() function is invoking mpic's map/xlate function.

irq_of_parse_and_map() will call the map/xlate function of the parent
PIC for the given interrupt.

In your case, the interrupts you are calling it for are defined as being
interrupts wiring the FPGA to the MPIC, hence are MPIC inputs, and thus
will be parsed/mapped by the MPIC. From the MPIC standpoint, the FPGA is
just a device.

So the code is doing what you tell it to do :-)

I don't understand what you are actually trying to acheive. If those 3
interrupts aren't outputs from the FPGA to the MPIC but input to the
FPGA then they shouldn't be there, they should be device interrupts
connected to the FPGA. Those will end up with map/xlate called in the
FPGA host.

Ben.

> Here is the piece of code that we are using.
> 
> fpga_pic_irq_host = irq_alloc_host(pic, IRQ_HOST_MAP_LINEAR,
>                         DPVPX0659_FPGA_NUM_IRQS,&fpga_pic_host_ops,
>                         NO_IRQ);
>         if (fpga_pic_irq_host == NULL) {
>                 printk("FPGA PIC: Unable to allocate host\n");
>                 return;
>         }
> 
>         for (i = 0; i < 3; i++) {
>                 fpga_irqs[i] = irq_of_parse_and_map(pic, i);
>                 if (fpga_irqs[i] == NO_IRQ) {
>                         printk("FPGA PIC: can't get irq %d.\n", i);
>                         continue;
>                 }
>                 printk("interrupt from device tree : %d \n",fpga_irqs[i]);
>                 set_irq_chained_handler(dpvpx0659_fpga_irqs[i],dpvpx0659_fpga_pic_cascade);
>         }
> 
> 
