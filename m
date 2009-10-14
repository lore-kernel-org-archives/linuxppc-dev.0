Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id 700ADB7043
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 05:37:38 +1100 (EST)
Received: by yxe11 with SMTP id 11so71904yxe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 11:37:36 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1dec053fee540bd474f88d4850d4ab213ea7215d.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
	<1dec053fee540bd474f88d4850d4ab213ea7215d.1255499081.git.michael@ellerman.id.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 12:37:16 -0600
Message-ID: <fa686aa40910141137l6aace10v8818639870062771@mail.gmail.com>
Subject: Re: [PATCH 5/6] powerpc: Rearrange and fix show_interrupts() for
	sparse irq_descs
To: Michael Ellerman <michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2009 at 11:45 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> Move the default case out of the if, ie. when we're just displaying
> an irq. And consolidate all the odd cases at the top, ie. printing
> the header and footer.
>
> And in the process cope with sparse irq_descs.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Looks reasonable to me
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/kernel/irq.c | =A0 64 ++++++++++++++++++++++++++---------=
----------
> =A01 files changed, 37 insertions(+), 27 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index baa49eb..63e27d5 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -187,33 +187,7 @@ int show_interrupts(struct seq_file *p, void *v)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for_each_online_cpu(j)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0seq_printf(p, "CPU%d =A0 =
=A0 =A0 ", j);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0seq_putc(p, '\n');
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (i < NR_IRQS) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D irq_to_desc(i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&desc->lock, flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 action =3D desc->action;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!action || !action->handler)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto skip;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, "%3d: ", i);
> -#ifdef CONFIG_SMP
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_online_cpu(j)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, "%10u ", ksta=
t_irqs_cpu(i, j));
> -#else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, "%10u ", kstat_irqs(i));
> -#endif /* CONFIG_SMP */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->chip)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, " %s ", desc-=
>chip->typename);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_puts(p, " =A0None =A0 =
=A0 =A0");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, "%s", (desc->status & IRQ_LEV=
EL) ? "Level " : "Edge =A0");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, " =A0 =A0%s", action->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (action =3D action->next; action; actio=
n =3D action->next)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, ", %s", actio=
n->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_putc(p, '\n');
> -skip:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&desc->lock, flags);
> - =A0 =A0 =A0 } else if (i =3D=3D NR_IRQS) {
> + =A0 =A0 =A0 } else if (i =3D=3D nr_irqs) {
> =A0#if defined(CONFIG_PPC32) && defined(CONFIG_TAU_INT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tau_initialized){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0seq_puts(p, "TAU: ");
> @@ -223,7 +197,43 @@ skip:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0#endif /* CONFIG_PPC32 && CONFIG_TAU_INT*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0seq_printf(p, "BAD: %10u\n", ppc_spurious_=
interrupts);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 desc =3D irq_to_desc(i);
> + =A0 =A0 =A0 if (!desc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&desc->lock, flags);
> +
> + =A0 =A0 =A0 action =3D desc->action;
> + =A0 =A0 =A0 if (!action || !action->handler)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto skip;
> +
> + =A0 =A0 =A0 seq_printf(p, "%3d: ", i);
> +#ifdef CONFIG_SMP
> + =A0 =A0 =A0 for_each_online_cpu(j)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, "%10u ", kstat_irqs_cpu(i, j)=
);
> +#else
> + =A0 =A0 =A0 seq_printf(p, "%10u ", kstat_irqs(i));
> +#endif /* CONFIG_SMP */
> +
> + =A0 =A0 =A0 if (desc->chip)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, " %s ", desc->chip->typename)=
;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_puts(p, " =A0None =A0 =A0 =A0");
> +
> + =A0 =A0 =A0 seq_printf(p, "%s", (desc->status & IRQ_LEVEL) ? "Level " :=
 "Edge =A0");
> + =A0 =A0 =A0 seq_printf(p, " =A0 =A0%s", action->name);
> +
> + =A0 =A0 =A0 for (action =3D action->next; action; action =3D action->ne=
xt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(p, ", %s", action->name);
> + =A0 =A0 =A0 seq_putc(p, '\n');
> +
> +skip:
> + =A0 =A0 =A0 spin_unlock_irqrestore(&desc->lock, flags);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> --
> 1.6.2.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
