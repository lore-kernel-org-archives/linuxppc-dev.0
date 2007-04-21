Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id DDED5DDEC2
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 09:17:56 +1000 (EST)
In-Reply-To: <20070419073556.73A6BDDE4A@ozlabs.org>
References: <20070419073556.73A6BDDE4A@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e4520bd4be50f2884003a9421863627c@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 7/7] MPIC MSI backend
Date: Sat, 21 Apr 2007 18:17:45 -0500
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
> MPIC MSI backend. Based on code from Segher, heavily hacked by me.
> Renamed to mpic_htmsi, as it only deals with MSI over Hypertransport.
...
> Index: msi-new/arch/powerpc/sysdev/Makefile
> ===================================================================
> --- msi-new.orig/arch/powerpc/sysdev/Makefile
> +++ msi-new/arch/powerpc/sysdev/Makefile
> @@ -4,6 +4,7 @@ endif
>
>  mpic-obj-y			:= mpic.o
>  mpic-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o
> +mpic-obj-$(CONFIG_PCI_MSI)	+= mpic_htmsi.o
>  obj-$(CONFIG_MPIC)		+= $(mpic-obj-y)

This is overly complicated.  You aren't going to be making this
a seperate link object anyways.   It should end up somehting like

mpic-msi-$(CONFIG_PCI_MSI)	:= mpic_msi.o mpic_htmsi.o
obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-y)

> -static void mpic_unmask_irq(unsigned int irq)
> +void mpic_unmask_irq(unsigned int irq)
...
> -static void mpic_mask_irq(unsigned int irq)
> +void mpic_mask_irq(unsigned int irq)
...
Ok mpic.c is big enough already.

> Index: msi-new/arch/powerpc/sysdev/mpic.h
> ===================================================================
> --- msi-new.orig/arch/powerpc/sysdev/mpic.h
> +++ msi-new/arch/powerpc/sysdev/mpic.h
> @@ -11,14 +11,23 @@
>   *
>   */
>
> +#include <linux/irq.h>
> +

Why do you need this now?   You already had uses of irq_ht_umber_t
and struct mpic.  Unless this should be in the earlier patch?

>  #ifdef CONFIG_PCI_MSI
>  extern void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t 
> hwirq);
> +extern int mpic_htmsi_init(struct mpic *mpic);
>  #else
>  static inline void mpic_msi_reserve_hwirq(struct mpic *mpic,
>  					  irq_hw_number_t hwirq)
>  {
>  	return;
>  }
> +static inline int mpic_htmsi_init(struct mpic *mpic) { return -1; }

more lines please

>  #endif
>
> +extern int mpic_set_irq_type(unsigned int virq, unsigned int 
> flow_type);
> +extern void mpic_end_irq(unsigned int irq);
> +extern void mpic_mask_irq(unsigned int irq);
> +extern void mpic_unmask_irq(unsigned int irq);
> +
>  #endif /* _POWERPC_SYSDEV_MPIC_H */
> Index: msi-new/arch/powerpc/sysdev/mpic_htmsi.c

I just stumbled across drivers/pci/htirq.c, is that of any use?


> +
> +int mpic_htmsi_init(struct mpic *mpic)
> +{
> +	int rc;
> +
> +	rc = mpic_msi_init_allocator(mpic);
> +	if (rc) {
> +		pr_debug("htmsi: Error allocating bitmap!\n");
> +		return rc;
> +	}
> +
> +	pr_debug("htmsi: Registering MPIC MSI callbacks.\n");
> +
> +	BUG_ON(msi_mpic);
> +	msi_mpic = mpic;
> +
> +	ppc_md.setup_msi_irqs = htmsi_setup_msi_irqs;
> +	ppc_md.teardown_msi_irqs = htmsi_teardown_msi_irqs;
> +	ppc_md.msi_check_device = htmsi_msi_check_device;

Unlike the rtas patch, this one didn't advertise it was
going to set the arch hooks unconditionally.

milton
