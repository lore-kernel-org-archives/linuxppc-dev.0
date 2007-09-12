Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89AA8DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 10:48:01 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IVGOc-0001QF-Du
	for linuxppc-embedded@ozlabs.org; Tue, 11 Sep 2007 17:47:58 -0700
Message-ID: <12626802.post@talk.nabble.com>
Date: Tue, 11 Sep 2007 17:47:58 -0700 (PDT)
From: WITTROCK <jwittrock@maginst.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Interrupt-problem mpc5200
In-Reply-To: <20070911124348.GJ11807@sfrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20070910090305.GG11807@sfrouter> <20070911124348.GJ11807@sfrouter>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Is it possible the interrupt is going off as soon as you unmask it?  Can you
show your "intmod_isr".
I had a similar problem when I pulled a "wittrock" and forgot to make the
interrupt edge sensitive, but from what I can see you have made yours edge
sensitive.

-WITTROCK


S. Fricke wrote:
> 
> 
> Dear Linux-enthusiasts,
> 
> I'm still at the same problem.
> 
> I have now implemented a irq_chip for the hardwired IRQ2. Now I have
> 
> 
> --==>
> volatile static struct mpc52xx_intr __iomem *intr;
> unsigned long flags;
> static DEFINE_SPINLOCK(my_irq_controller_lock);
> 
> /*
>  * HELPER-Function
>  */
> static inline void io_be_setbit(u32 __iomem *addr, int bitno)
> {
>     out_be32(addr, in_be32(addr) | (1 << bitno));
> }
> 
> static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
> {
>     out_be32(addr, in_be32(addr) & ~(1 << bitno));
> }
> 
> /*
>  * IRQ-Zeugs
>  */
> static void my_irq_ack(unsigned int irq)
> {
>     printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
>     spin_lock_irqsave(&my_irq_controller_lock, flags);
>     if(intr)
>         io_be_setbit(&intr->ctrl, 25);
>     spin_unlock_irqrestore(&my_irq_controller_lock, flags);
>     printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
> }
> 
> /* irq - disabled */
> static void my_irq_mask(unsigned int irq)
> {
>     printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
>     spin_lock_irqsave(&my_irq_controller_lock, flags);
>     if(intr)
>         io_be_clrbit(&intr->ctrl, 9); 
>     spin_unlock_irqrestore(&my_irq_controller_lock, flags);
>     printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
> }
> 
> /* irq - enable */
> static void my_irq_unmask(unsigned int irq)
> {
>     printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
>     spin_lock_irqsave(&my_irq_controller_lock, flags);
>     if(intr)
>         io_be_setbit(&intr->ctrl, 9);
>     spin_unlock_irqrestore(&my_irq_controller_lock, flags);
>     printk("%s(%s/%d):\n", __FILE__, __FUNCTION__, __LINE__);
> }
> 
> static struct irq_chip my_irq_chip = { 
>     .typename   = "MY_IRQ_TEST",
>     .ack        = my_irq_ack,
>     .mask       = my_irq_mask,
>     .unmask     = my_irq_unmask,
> };
> 
> static int __init mod_init( void )
> {
>     // ...
> 
>     intr = mpc52xx_find_and_map("mpc52xx-pic");
>     if(!intr) {
>         panic(__FILE__ ": mpc52xx-pic - MAP failed");
>     }
> 
>     set_irq_chip(MPC52xx_IRQ2, &my_irq_chip);
>     a = request_irq(2, intmod_isr, IRQF_DISABLED , "intmod",
> INTMOD_IRQ_BOARD);
>     printk("a: 0x%08x\n", a);
> 
>     // ...
> }
> 
> <==--
> 
> Now my code hangs on the my_irq_unmask(...)-function on "io_be_setbit".
> Why?
> Can anyone help me, or point me to the right newsgroup/forum?
> 
> So long!
> 
> Silvio
> 
> 
> -- 
> -- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com
> --
>    Diplom-Informatiker (FH)
>    Linux-Entwicklung                       JABBER:      fricke@jabber.org
> ----------------------------------------------------------------------------
> 
> 
>  
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/Interrupt-problem-mpc5200-tf4413834.html#a12626802
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
