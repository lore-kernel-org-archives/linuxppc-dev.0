Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0102.outbound.protection.outlook.com [157.56.110.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BB981A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 13:48:04 +1000 (AEST)
Message-ID: <1439264868.4099.34.camel@freescale.com>
Subject: Re: using general IRQs
From: Scott Wood <scottwood@freescale.com>
To: Ran Shalit <ranshalit@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 10 Aug 2015 22:47:48 -0500
In-Reply-To: <CAJ2oMhLMJHc4+xy2iPF78n8A38o2a-ekZNy0s_d_osCP2eKn0Q@mail.gmail.com>
References: <CAJ2oMhLX18merCHtge0oOQ2DSQ8BE1Zd=dAuPWzyTRNmr-DLiA@mail.gmail.com>
 <CAJ2oMhJVqph9vb=Q-vbzRRygT+s3wvtm9nVNJ9TLcB_6iQCVcA@mail.gmail.com>
 <1439260166.4099.14.camel@freescale.com>
 <CAJ2oMhLMJHc4+xy2iPF78n8A38o2a-ekZNy0s_d_osCP2eKn0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-11 at 06:45 +0300, Ran Shalit wrote:
> On Tue, Aug 11, 2015 at 5:29 AM, Scott Wood <scottwood@freescale.com> wrote:
> > On Mon, 2015-08-10 at 13:40 +0300, Ran Shalit wrote:
> > > On Mon, Aug 10, 2015 at 10:48 AM, Ran Shalit <ranshalit@gmail.com> 
> > > wrote:
> > > > Hello,
> > > > 
> > > > MPC8349 has general IRQ numbered 0-7,
> > > > It is required to bind these IRQs with some routine , i.e. they are
> > > > not used with any specific driver.
> > > > 
> > > > - Should they be configured as gpios in device tree so that we can use
> > > > the gpio as irq in linux ? Is there any example ?
> > > > - After configuration, can the gpios be used in linux using the
> > > > standard /sys/class/gpio ?
> > > > 
> > > > Regards,
> > > > Ran
> > 
> > What do you mean by "general IRQ"?  Do you mean external IRQs?
> > 
> > > I am trying to use only IRQ4, so I have tried to configure it as
> > > following in device tree:
> > > 
> > > device tree:
> > > 
> > >   intc@0{
> > >  compatible = "intc";
> > >  #address-cells = <1>;
> > >  #size-cells = <0>;
> > >  reg = <0 0x1000>;
> > >  interrupts = <4 0x8>;
> > >   };
> > > 
> > > But I don't see IRQ4 listed in the interrupt list:
> > > # cat /proc/interrupts
> > 
> > /proc/interrupts shows virtual interrupts, which do not necessarily
> > correspond to anything in the device tree.  In particular, virtual 
> > interrupts
> > under 16 are reserved for ISA interrupts, and thus any mpic interrupts in
> > that range will be remapped.
> > 
> > Additionally, putting an interrupt in the device tree does not make it 
> > show
> > up in /proc/interrupts.  Only interrupts for which a driver has 
> > registered a
> > handler will show up in /proc/interrupts.
> > 
> > -Scott
> > 
> > 
> Hi Scott,
> 
> I meant  external IRQ.
> I am actually trying to use irq 4 interrupt.
> 
> I've added the above in device tree, and in kernel code I do:
> np = of_find_node_by_name(NULL,"hello");

Why are you looking for a node named "hello" when your node is named "intc"?

>   if (np == NULL)
>     {
>     printk("Error node not found\n");
>     }
>   printk("Node np = 0x%0x\n",np);                     <-- Node np = 
> 0xdfffe2f0

How could you possibly have gotten a non-NULL value for np, with the above 
code and node, unless there's something you're not showing?

>   virq = irq_of_parse_and_map(np,0);
> 
>   printk(" VIRQ: %d \n" , virq);                              <-- virq = 0 
> !!??

virq = 0 means the lookup failed.  Either there was no interrupt in the node, 
or it couldn't be mapped for some reason.

>   if (0 > (error=request_irq(virq, &hello_IRQHandler, IRQF_SHARED,
> "hello", &value))) {
>       printk(KERN_WARNING"hello_IRQHandler: Init: Unable to allocate
> IRQ error = %d\n\n", error);
>     return -1;
>   <-- request_irq return -22 ....
>   }
> 
> 
>  But it fails in request_irq (it return -22).
> Also, irq_of_parse_and_map(np,0) returns 0. I think it should have returned 
> 4.

I already explained why it won't return 4 (see the part about virtual 
interrupts).

-Scott
