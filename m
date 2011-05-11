Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48370B6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:17:29 +1000 (EST)
Received: by gwj17 with SMTP id 17so319975gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:17:25 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <e01cafe6352e8e4715788f959b747c1363459cee.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<e01cafe6352e8e4715788f959b747c1363459cee.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:17:04 +0200
Message-ID: <BANLkTikoZvnOROzNKpvxjxud_-cWXL4Dnw@mail.gmail.com>
Subject: Re: [PATCH 36/37] powerpc: remove virq_to_host
To: Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 11, 2011 at 7:30 AM, Milton Miller <miltonm@bga.com> wrote:
> The only references to the irq_map[].host field are internal to
> arch/powerpc/kernel/irq.c
>
> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> ---
> =A0arch/powerpc/include/asm/irq.h | =A0 =A01 -
> =A0arch/powerpc/kernel/irq.c =A0 =A0 =A0| =A0 =A06 ------
> =A02 files changed, 0 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/ir=
q.h
> index a65d170..1bff591 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -129,7 +129,6 @@ struct irq_data;
> =A0extern irq_hw_number_t irqd_to_hwirq(struct irq_data *d);
> =A0extern irq_hw_number_t virq_to_hw(unsigned int virq);
> =A0extern bool virq_is_host(unsigned int virq, struct irq_host *host);
> -extern struct irq_host *virq_to_host(unsigned int virq);
>
> =A0/**
> =A0* irq_alloc_host - Allocate a new irq_host data structure
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 73cf290..4368b5e 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -516,12 +516,6 @@ bool virq_is_host(unsigned int virq, struct irq_host=
 *host)
> =A0}
> =A0EXPORT_SYMBOL_GPL(virq_is_host);
>
> -struct irq_host *virq_to_host(unsigned int virq)
> -{
> - =A0 =A0 =A0 return irq_map[virq].host;
> -}
> -EXPORT_SYMBOL_GPL(virq_to_host);
> -
> =A0static int default_irq_host_match(struct irq_host *h, struct device_no=
de *np)
> =A0{
> =A0 =A0 =A0 =A0return h->of_node !=3D NULL && h->of_node =3D=3D np;
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
