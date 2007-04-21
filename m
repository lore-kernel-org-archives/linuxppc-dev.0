Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 85D10DDEEF
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 09:17:21 +1000 (EST)
In-Reply-To: <20070419073555.D2C3EDDEFD@ozlabs.org>
References: <20070419073555.D2C3EDDEFD@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5f69d29368a24aad95648b40e0dfc07e@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 6/7] MPIC MSI allocator
Date: Sat, 21 Apr 2007 18:17:13 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 19, 2007, Michael Ellerman wrote:
> To support MSI on MPIC we need a way to reserve and allocate hardware 
> irq
> numbers, this patch implements an allocator for that.

> Index: msi-new/arch/powerpc/sysdev/mpic_msi.c
> ===================================================================
> --- /dev/null
> +++ msi-new/arch/powerpc/sysdev/mpic_msi.c
...
> +irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num)
> +{
> +	unsigned long flags;
> +	int offset, order = fls(num) - 1;

get_count_order would be more clear.  Also it has
a correction factor.  (Applies several places).

> +#ifdef CONFIG_MPIC_BROKEN_U3
> +static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic)
> +{
> +	irq_hw_number_t hwirq;
> +	struct irq_host_ops *ops = mpic->irqhost->ops;
> +	struct device_node *np;
> +	int flags, index, i;
> +	struct of_irq oirq;
> +
> +	pr_debug("mpic: found U3, guessing msi allocator setup\n");
> +
> +	/* Reserve source numbers we know are reserved in the HW */
> +	for (i = 0;   i < 8;   i++) __mpic_msi_reserve_hwirq(mpic, i);
> +	for (i = 42;  i < 46;  i++) __mpic_msi_reserve_hwirq(mpic, i);
> +	for (i = 100; i < 105; i++) __mpic_msi_reserve_hwirq(mpic, i);

More lines please.

> +#else
> +static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic) { return -1; 
> }

and here.

> +	if (len % 8 != 0) {
> +		printk(KERN_WARNING "mpic: Malformed msi-available-ranges "
> +		       "property on %s\n", mpic->of_node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	bitmap_allocate_region(mpic->hwirq_bitmap, 0,
> +			       fls(mpic->irq_count) - 1);
> +
> +	/* Format is: (<u32 start> <u32 count>)+ */
> +	len /= sizeof(u32);
> +	for (i = 0; i < len / 2; i++, p += 2)

how about just dividing by the calculated 8 above?  or use
count = len / 8.

> +		mpic_msi_free_hwirqs(mpic, *p, *(p + 1));
> +
> +	return 0;
> +}
> +
> +int mpic_msi_init_allocator(struct mpic *mpic)
> +{
> +	int rc, size;
> +
> +	BUG_ON(mpic->hwirq_bitmap);
> +	spin_lock_init(&mpic->bitmap_lock);
> +
> +	size = mpic->irq_count / 8;
> +	pr_debug("mpic: allocator bitmap size is 0x%x bytes\n", size);

BITS_TO_LONGS() * sizeof(long).   We need to round up to longs to
use bitmask_*, especially being a big endian architecture.

milton
