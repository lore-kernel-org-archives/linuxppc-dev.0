Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t74nx243PzDt4K
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 06:54:45 +1100 (AEDT)
Date: Mon, 31 Oct 2016 13:51:59 -0600 (MDT)
From: Thomas Gleixner <tglx@linutronix.de>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
cc: monstr@monstr.eu, jason@lakedaemon.net, marc.zyngier@arm.com,
 linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [Patch V6 2/6] irqchip: xilinx: Clean up irqdomain argument and
 read/write
In-Reply-To: <1477916207-25157-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Message-ID: <alpine.DEB.2.20.1610311335380.5011@nanos>
References: <1477916207-25157-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1477916207-25157-3-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 31 Oct 2016, Zubair Lutfullah Kakakhel wrote:
> The drivers read/write function handling is a bit quirky.

Can you please explain in more detail what's quirky and why it should be
done differently, 

> And the irqmask is passed directly to the handler.

I can't make any sense out of that sentence.  Which handler? If you talk
about the write function, then I don't see a change. So what are you
talking about?

> Add a new irqchip struct to pass to the handler and
> cleanup read/write handling.

I still don't see what it cleans up. You move the write function pointer
into a data structure, which is exposed by another pointer. So you create
two levels of indirection in the hotpath. The function prototype is still
the same. So all this does is making things slower unless I'm missing
something.

> -static unsigned int (*read_fn)(void __iomem *);
> -static void (*write_fn)(u32, void __iomem *);
> +struct xintc_irq_chip {
> +	void __iomem *base;
> +	struct	irq_domain *domain;
> +	struct	irq_chip chip;

The tabs between struct and the structure name are bogus.

> +	u32	intr_mask;
> +	unsigned int (*read)(void __iomem *iomem);
> +	void (*write)(u32 data, void __iomem *iomem);

Please structure that like a table:

	void			__iomem *base;
	struct irq_domain	*domain;
	struct irq_chip		chip;
	u32			intr_mask;
	unsigned int		(*read)(void __iomem *iomem);
	void			(*write)(u32 data, void __iomem *iomem);

Can you see how that makes parsing the struct simpler, because the data
types are clearly to identify?

> +static struct xintc_irq_chip *xintc_irqc;
>  
>  static void intc_write32(u32 val, void __iomem *addr)
>  {
> @@ -54,6 +60,18 @@ static unsigned int intc_read32_be(void __iomem *addr)
>  	return ioread32be(addr);
>  }
>  
> +static inline unsigned int xintc_read(struct xintc_irq_chip *xintc_irqc,
> +					     int reg)
> +{
> +	return xintc_irqc->read(xintc_irqc->base + reg);
> +}
> +
> +static inline void xintc_write(struct xintc_irq_chip *xintc_irqc,
> +				     int reg, u32 data)
> +{
> +	xintc_irqc->write(data, xintc_irqc->base + reg);
> +}
> +
>  static void intc_enable_or_unmask(struct irq_data *d)
>  {
>  	unsigned long mask = 1 << d->hwirq;
> @@ -65,21 +83,21 @@ static void intc_enable_or_unmask(struct irq_data *d)
>  	 * acks the irq before calling the interrupt handler
>  	 */
>  	if (irqd_is_level_type(d))
> -		write_fn(mask, intc_baseaddr + IAR);
> +		xintc_write(xintc_irqc, IAR, mask);

So this whole thing makes only sense, when you want to support multiple
instances of that chip and then you need to store the xintc_irqc pointer as
irqchip data and retrieve it from there. Unless you do that, this "cleanup"
is just churn for nothing with the effect of making things less efficient.

Thanks,

	tglx
