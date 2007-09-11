Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id 777FBDDF1C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 00:19:31 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3597647pyi
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 07:19:29 -0700 (PDT)
Message-ID: <fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
Date: Tue, 11 Sep 2007 08:19:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "S. Fricke" <silvio.fricke@gmail.com>
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
In-Reply-To: <20070911124154.GI11807@sfrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070906133050.GE11807@sfrouter> <20070911124154.GI11807@sfrouter>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/11/07, S. Fricke <silvio.fricke@googlemail.com> wrote:
>
> Dear Linux-enthusiasts,
>
> I'm still at the same problem.
>
> I have now implemented a irq_chip for the hardwired IRQ2. Now I have:
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

You probably don't want to do this (unless you are cascading IRQs to
custom external hardware).  All you should need is the call to
request_irq() to register your irq handler, and code in your ISR
handler to clear the interrupt condition.

You do *NOT* want to program the interrupt controller directly.  The
mpc5200 interrupt controller already has a driver.  Don't go twiddling
the registers manually.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
