Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B49DDE095
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 08:00:36 +1000 (EST)
Subject: Re: [v0 PATCH 1/4] EDAC: MPIC Hypertransport IRQ support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harry Ciao <qingtao.cao@windriver.com>
In-Reply-To: <1242377034-7378-2-git-send-email-qingtao.cao@windriver.com>
References: <1242377034-7378-1-git-send-email-qingtao.cao@windriver.com>
	<1242377034-7378-2-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain
Date: Mon, 18 May 2009 08:00:23 +1000
Message-Id: <1242597623.18075.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-15 at 16:43 +0800, Harry Ciao wrote:
> Support EDAC INT mode for Hypertransport devices, where southbridge
> NMI Request messages posted through Hypertransport Channel will
> be transferred to a MPIC interrupt instance that latches MPIC INT0
> pin. Also, Hypertransport Hostbridge controller may latch MPIC INT2
> pin for Hypertransport Link Errors.
> 
> Since multiple Hypertransport southbridges such as AMD8131 & AMD8111
> could post NMI request messages, EDAC core should be responsible
> for maintaining the mapping from hwirq == 0 to a virq.
> 
> The edac_mpic_irq.c is inert for EDAC drivers where related hardware
> is not connecting to MPIC, so it should be controlled by CONFIG_MPIC.

It would have been simpler to ajust avoid this layer completely and
always just map the interrupts.

IE. There is no problem with calling irq_create_mapping() for the same
hwirq multiple times, though they aren't refcounted, so just don't call
irq_dispose_mapping() and you're done :-)

IRQ mappings don't need to be disposed of, especially with mpic where
they don't actually occupy resources (the reverse map is of fixed size
anyway).

Ben.

> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 07a31cf..62778ee 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -17,6 +17,10 @@ ifdef CONFIG_PCI
>  edac_core-objs	+= edac_pci.o edac_pci_sysfs.o
>  endif
>  
> +ifdef CONFIG_MPIC
> +edac_core-objs += edac_mpic_irq.o
> +endif
> +
>  obj-$(CONFIG_EDAC_AMD76X)		+= amd76x_edac.o
>  obj-$(CONFIG_EDAC_CPC925)		+= cpc925_edac.o
>  obj-$(CONFIG_EDAC_I5000)		+= i5000_edac.o
> diff --git a/drivers/edac/edac_mpic_irq.c b/drivers/edac/edac_mpic_irq.c
> new file mode 100644
> index 0000000..26b43c0
> --- /dev/null
> +++ b/drivers/edac/edac_mpic_irq.c
> @@ -0,0 +1,145 @@
> +/*
> + * edac_mpic_irq.c -
> + * 	For all EDAC Hypertransport southbridge devices(such as AMD8111
> + * 	or AMD8131) that could post upstream NMI Request Messages, this
> + * 	driver is used to manage the mapping from the hardware IRQ that
> + * 	carried in the NMI Request Message to its related virtual IRQ.
> + *
> + * 	The EDAC driver for a specific Hypertransport southbridge device
> + * 	must implement its mach-specific method for edac_mach_get_irq().
> + *
> + * Copyright (c) 2009 Wind River Systems, Inc.
> + *
> + * Authors:	Cao Qingtao <qingtao.cao@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +#include <linux/edac.h>
> +
> +struct irqmap {
> +	int virq;
> +	int count;
> +};
> +
> +static struct irqmap hwirq2virqs[MPIC_HWIRQS] = {
> +	[MPIC_HWIRQ_HT_NMI] = {
> +		.virq = NO_IRQ,
> +		.count = 0,
> +	},
> +	[MPIC_HWIRQ_INTERNAL_ERROR] = {
> +		.virq = NO_IRQ,
> +		.count = 0,
> +	},
> +};
> +
> +#ifdef CONFIG_PPC_MAPLE
> +static int edac_maple_get_irq(int hwirq)
> +{
> +	struct device_node *np, *mpic_node = NULL;
> +	int irq = NO_IRQ;
> +
> +	/*
> +	 * Locate MPIC in the device-tree. Note that there is a bug
> +	 * in Maple device-tree where the type of the controller is
> +	 * open-pic and not interrupt-controller
> +	 */
> +	for_each_node_by_type(np, "interrupt-controller") {
> +		if (of_device_is_compatible(np, "open-pic")) {
> +			mpic_node = np;
> +			break;
> +		}
> +	}
> +
> +	if (mpic_node == NULL) {
> +		for_each_node_by_type(np, "open-pic") {
> +			mpic_node = np;
> +			break;
> +		}
> +	}
> +
> +	if (mpic_node) {
> +		irq = irq_create_of_mapping(mpic_node, &hwirq, 1);
> +		of_node_put(mpic_node);
> +	} else
> +		printk(KERN_ERR "Failed to locate the MPIC DTB node\n");
> +
> +	return irq;
> +}
> +#endif
> +
> +/*
> + * NOTE:
> + * The EDAC driver should implement and register its machine-specific
> + * method to get a virtual IRQ here.
> + */
> +static int edac_mach_get_irq(int hwirq)
> +{
> +	int virq = NO_IRQ;
> +
> +#ifdef CONFIG_PPC_MAPLE
> +	virq = edac_maple_get_irq(hwirq);
> +#endif
> +
> +	return virq;
> +}
> +
> +int edac_get_mpic_irq(int hwirq)
> +{
> +	struct irqmap *irq;
> +
> +	if ((hwirq != MPIC_HWIRQ_HT_NMI) &&
> +	    (hwirq != MPIC_HWIRQ_INTERNAL_ERROR))
> +		return NO_IRQ;
> +
> +	irq = &hwirq2virqs[hwirq];
> +
> +	if (irq->virq == NO_IRQ) {
> +		if (irq->count == 0) {
> +			irq->virq = edac_mach_get_irq(hwirq);
> +			if (irq->virq != NO_IRQ)
> +				irq->count++;
> +			else
> +				irq->count = -1; /* error */
> +		}
> +	} else
> +		irq->count++;
> +
> +	return irq->virq;
> +}
> +EXPORT_SYMBOL_GPL(edac_get_mpic_irq);
> +
> +void edac_put_mpic_irq(int hwirq)
> +{
> +	struct irqmap *irq;
> +
> +	if ((hwirq != MPIC_HWIRQ_HT_NMI) &&
> +	    (hwirq != MPIC_HWIRQ_INTERNAL_ERROR))
> +		return;
> +
> +	irq = &hwirq2virqs[hwirq];
> +
> +	if (irq->count <= 0)
> +		return;
> +
> +	if (--irq->count == 0) {
> +		irq_dispose_mapping(irq->virq);
> +		irq->virq = NO_IRQ;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(edac_put_mpic_irq);
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 7cf92e8..804dbb6 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -38,4 +38,27 @@ static inline void opstate_init(void)
>  	return;
>  }
>  
> +#ifdef CONFIG_MPIC
> +enum {
> +	/*
> +	 * Vector carried in southbridge NMI Request Messages
> +	 * posted through Hypertransport Channel
> +	 */
> +	MPIC_HWIRQ_HT_NMI = 0,
> +
> +	/*
> +	 * Vector for MPIC Internal Error
> +	 */
> +	MPIC_HWIRQ_INTERNAL_ERROR = 2,
> +
> +	MPIC_HWIRQS,	/* must be the very last */
> +};
> +
> +/* Create a hwirq2virq mapping for the specified hwirq */
> +extern int edac_get_mpic_irq(int hwirq);
> +
> +/* Dispose the hwirq2virq mapping for the specified hwirq */
> +extern void edac_put_mpic_irq(int hwirq);
> +#endif
> +
>  #endif
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
