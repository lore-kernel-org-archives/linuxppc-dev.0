Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7B02B6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:16:57 +1000 (EST)
Received: by iym7 with SMTP id 7so695649iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:16:55 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fd94023491cca4b3eb3a06da3f69c8afadc9a8b1.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<fd94023491cca4b3eb3a06da3f69c8afadc9a8b1.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:16:33 +0200
Message-ID: <BANLkTimAU0nh-5dh5TWERwauoA-RWM973w@mail.gmail.com>
Subject: Re: [PATCH 35/37] powerpc: add virq_is_host to reduce virq_to_host
	usage
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
> Some irq_host implementations are using virq_to_host to check if
> they are the irq_host for a virtual irq. =A0To allow us to make space
> versus time tradeoffs, replace this usage with an assertive
> virq_is_host that confirms or denies the irq is associated with the
> given irq_host.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/include/asm/irq.h =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/kernel/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 ++++++
> =A0arch/powerpc/sysdev/xics/xics-common.c | =A0 =A02 +-
> =A03 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/ir=
q.h
> index 6f4a3ef..a65d170 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -128,6 +128,7 @@ struct irq_host {
> =A0struct irq_data;
> =A0extern irq_hw_number_t irqd_to_hwirq(struct irq_data *d);
> =A0extern irq_hw_number_t virq_to_hw(unsigned int virq);
> +extern bool virq_is_host(unsigned int virq, struct irq_host *host);
> =A0extern struct irq_host *virq_to_host(unsigned int virq);
>
> =A0/**
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 0715a09..73cf290 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -510,6 +510,12 @@ irq_hw_number_t virq_to_hw(unsigned int virq)
> =A0}
> =A0EXPORT_SYMBOL_GPL(virq_to_hw);
>
> +bool virq_is_host(unsigned int virq, struct irq_host *host)
> +{
> + =A0 =A0 =A0 return irq_map[virq].host =3D=3D host;
> +}
> +EXPORT_SYMBOL_GPL(virq_is_host);
> +
> =A0struct irq_host *virq_to_host(unsigned int virq)
> =A0{
> =A0 =A0 =A0 =A0return irq_map[virq].host;
> diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev=
/xics/xics-common.c
> index 43b2a79..445c5a0 100644
> --- a/arch/powerpc/sysdev/xics/xics-common.c
> +++ b/arch/powerpc/sysdev/xics/xics-common.c
> @@ -213,7 +213,7 @@ void xics_migrate_irqs_away(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* We can't set affinity on ISA interrupts=
 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (virq < NUM_ISA_INTERRUPTS)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (virq_to_host(virq) !=3D xics_host)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!virq_is_host(virq, xics_host))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq =3D (unsigned int)virq_to_hw(virq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* We need to get IPIs still. */
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
