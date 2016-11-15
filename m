Return-Path: <michal.simek@xilinx.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0073.outbound.protection.outlook.com [104.47.42.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ66K48BKzDvl0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 23:25:13 +1100 (AEDT)
Subject: Re: [Patch v7 4/7] irqchip: xilinx: Rename get_irq to xintc_get_irq
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
 <monstr@monstr.eu>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
 <20161114121351.10924-5-Zubair.Kakakhel@imgtec.com>
CC: <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <efdc0f8d-2217-ad93-453a-a79bc26b61fa@xilinx.com>
Date: Tue, 15 Nov 2016 13:24:56 +0100
MIME-Version: 1.0
In-Reply-To: <20161114121351.10924-5-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14.11.2016 13:13, Zubair Lutfullah Kakakhel wrote:
> Now that the driver is generic and used by multiple archs,
> get_irq is too generic.
> 
> Rename get_irq to xintc_get_irq to avoid any conflicts
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V6 -> V7
> Rebase to v4.9-rc5
> 
> V5 -> V6
> Removed __func__ in printk
> Rebase to v4.9-rc3
> 
> V4 -> V5
> Rebased to v4.9-rc1
> Use __func__ in pr_err
> 
> V3 -> V4
> New patch.
> ---
>  arch/microblaze/include/asm/irq.h | 2 +-
>  arch/microblaze/kernel/irq.c      | 4 ++--
>  drivers/irqchip/irq-xilinx-intc.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
> index bab3b13..d785def 100644
> --- a/arch/microblaze/include/asm/irq.h
> +++ b/arch/microblaze/include/asm/irq.h
> @@ -16,6 +16,6 @@ struct pt_regs;
>  extern void do_IRQ(struct pt_regs *regs);
>  
>  /* should be defined in each interrupt controller driver */
> -extern unsigned int get_irq(void);
> +extern unsigned int xintc_get_irq(void);
>  
>  #endif /* _ASM_MICROBLAZE_IRQ_H */
> diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
> index 11e24de..903dad8 100644
> --- a/arch/microblaze/kernel/irq.c
> +++ b/arch/microblaze/kernel/irq.c
> @@ -29,12 +29,12 @@ void __irq_entry do_IRQ(struct pt_regs *regs)
>  	trace_hardirqs_off();
>  
>  	irq_enter();
> -	irq = get_irq();
> +	irq = xintc_get_irq();
>  next_irq:
>  	BUG_ON(!irq);
>  	generic_handle_irq(irq);
>  
> -	irq = get_irq();
> +	irq = xintc_get_irq();
>  	if (irq != -1U) {
>  		pr_debug("next irq: %d\n", irq);
>  		++concurrent_irq;
> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
> index 7331d8c..34ec609 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -101,7 +101,7 @@ static struct irq_chip intc_dev = {
>  	.irq_mask_ack = intc_mask_ack,
>  };
>  
> -unsigned int get_irq(void)
> +unsigned int xintc_get_irq(void)
>  {
>  	unsigned int hwirq, irq = -1;
>  
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
