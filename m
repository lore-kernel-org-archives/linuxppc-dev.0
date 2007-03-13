Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88936DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 18:15:02 +1100 (EST)
Subject: Re: [PATCH] Add irq host and hwirq pair fields to output when
	showing interrupts.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei <wei.zhang@freescale.com>
In-Reply-To: <1173755968459-git-send-email-wei.zhang@freescale.com>
References: <1173755968459-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 08:14:52 +0100
Message-Id: <1173770092.24454.69.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, r54964@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-03-13 at 11:19 +0800, Zhang Wei wrote:
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> ---
>  arch/powerpc/kernel/irq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 919fbf5..2a30ffd 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -194,7 +194,7 @@ #else
>  		seq_printf(p, "%10u ", kstat_irqs(i));
>  #endif /* CONFIG_SMP */
>  		if (desc->chip)
> -			seq_printf(p, " %s ", desc->chip->typename);
> +			seq_printf(p, " (%3d) @%s ", (irq_map[i].host->revmap_type == IRQ_HOST_MAP_LEGACY) ? i : virq_to_hw(i), desc->chip->typename);
>  		else
>  			seq_puts(p, "  None      ");
>  		seq_printf(p, "%s", (desc->status & IRQ_LEVEL) ? "Level " : "Edge  ");

Well, first, we shouldn't modify the output of /proc/interrupts as this
will likely break all sort of userland tools displaying it (well, I
think).

Now, regarding the patch itself, printing the hw irq is not that useful
without some indication of which host it belongs to. Best is to add a
name() or something like that to the host ops.

Ben.
