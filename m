Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DFBDB67C44
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 04:46:03 +1100 (EST)
Message-ID: <457EEAD2.2070202@am.sony.com>
Date: Tue, 12 Dec 2006 09:45:54 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 7/15] celleb: supporting interrupts
References: <200612120333.kBC3Xc9L010941@toshiba.co.jp>
In-Reply-To: <200612120333.kBC3Xc9L010941@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ishizaki Kou wrote:
> This patch creates Celleb platform dependent files to support interrupts.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
> ---
> 
> Index: linux-powerpc-git/arch/powerpc/platforms/celleb/interrupt.c
> diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/interrupt.c:1.1
> --- /dev/null	Mon Dec 11 20:37:34 2006
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/interrupt.c	Wed Dec  6 08:43:15 2006
> @@ -0,0 +1,256 @@
> +/*
> + * Celleb/Beat Interrupt controller
> + *
> + * (C) Copyright 2006 TOSHIBA CORPORATION
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/percpu.h>
> +#include <linux/types.h>
> +
> +#include <asm/io.h>
> +#include <asm/pgtable.h>
> +#include <asm/prom.h>
> +#include <asm/ptrace.h>
> +#include <asm/udbg.h>
> +#include <asm/machdep.h>
> +
> +#include "interrupt.h"
> +#include "beat.h"
> +
> +#define	MAX_IRQS	NR_IRQS
> +static spinlock_t beatic_irq_mask_lock;
> +static uint64_t	beatic_irq_mask[(MAX_IRQS+255)/64];
> +
> +static struct irq_host *beatic_host = NULL;
> +
> +/*
> + * In this implementation, "virq" == "IRQ plug number",
> + * "(irq_hw_number_t)hwirq" == "IRQ outlet number".
> + */
> +
> +static void beatic_unmask_irq(unsigned int irq_plug)
> +{
> +	int off;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
> +	off = (irq_plug / 256) * 4;
> +	beatic_irq_mask[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
> +
> +	if (beat_set_interrupt_mask(irq_plug&~255UL,
> +		beatic_irq_mask[off + 0], beatic_irq_mask[off + 1],
> +		beatic_irq_mask[off + 2], beatic_irq_mask[off + 3]) != 0)
> +		panic("Failed to set mask IRQ!");
> +	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
> +}
> +
> +static void beatic_mask_irq(unsigned int irq_plug)
> +{
> +	int off;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&beatic_irq_mask_lock, flags);
> +	off = (irq_plug / 256) * 4;
> +	beatic_irq_mask[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
> +
> +	if (beat_set_interrupt_mask(irq_plug&~255UL,
> +		beatic_irq_mask[off + 0], beatic_irq_mask[off + 1],
> +		beatic_irq_mask[off + 2], beatic_irq_mask[off + 3]) != 0)
> +		panic("Failed to clear mask IRQ!");
> +
> +	spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
> +}
> +
> +static void beatic_end_irq(unsigned int irq_plug)
> +{
> +	int64_t err;
> +
> +	if ((err = beat_downcount_of_interrupt(irq_plug)) != 0) {
> +		if ((err & 0xFFFFFFFF) != 0xFFFFFFF5) /* -11: wrong state */
> +			panic("Failed to downcount IRQ! Error = %16lx", err);
> +
> +		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", irq_plug);
> +	}
> +	beatic_unmask_irq(irq_plug);
> +}
> +
> +static struct irq_chip beatic_pic = {
> +	.typename = " CELL-BEAT ",
> +	.name = " CELL-BEAT ",


I don't think name is used anymore.


> +	struct irq_desc *desc = get_irq_desc(virq);
> +	int64_t	err;

Here you use int64_t...

> +{
> +	u64 *intspec2 = (u64 *)intspec;


...and here you use u64.  Please us a consistant scheme.  Standard
kernel convention is to use s64, u64, etc.
