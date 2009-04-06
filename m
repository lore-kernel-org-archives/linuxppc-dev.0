Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 88027DDE00
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 23:28:04 +1000 (EST)
Received: by gxk1 with SMTP id 1so7197339gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Apr 2009 06:28:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b804a7950247ceb99706be8cadb9bf5da5f73b09.1238983497.git.michael@ellerman.id.au>
References: <b804a7950247ceb99706be8cadb9bf5da5f73b09.1238983497.git.michael@ellerman.id.au>
Date: Mon, 6 Apr 2009 07:27:45 -0600
Message-ID: <fa686aa40904060627w1797960eo113a68087a1391bb@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Print information about mapping hw irqs to
	virtual irqs
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Ellerman <michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 5, 2009 at 8:05 PM, Michael Ellerman <michael@ellerman.id.au> w=
rote:
> The irq remapping layer seems to cause some confusion when people
> see a different irq number in /proc/interrupts vs the one they
> request in their driver or DTS.
>
> So have the irq remapping layer print out a message when we map an
> irq. The message is only printed the first time the irq is mapped,
> and it's KERN_DEBUG so most people won't see it.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/kernel/irq.c | =A0 =A04 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 5576147..8c1a496 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -672,11 +672,13 @@ unsigned int irq_create_mapping(struct irq_host *ho=
st,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NO_IRQ;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 pr_debug("irq: -> obtained virq %d\n", virq);
>
> =A0 =A0 =A0 =A0if (irq_setup_virq(host, virq, hwirq))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NO_IRQ;
>
> + =A0 =A0 =A0 printk(KERN_DEBUG "irq: irq %lu on host %s mapped to virtua=
l irq %u\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hwirq, host->of_node ? host->of_node->full_=
name : "null", virq);
> +
> =A0 =A0 =A0 =A0return virq;
> =A0}
> =A0EXPORT_SYMBOL_GPL(irq_create_mapping);
> --
> 1.6.1.2
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
