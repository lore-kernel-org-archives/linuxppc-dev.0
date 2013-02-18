Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 33AC62C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 06:43:05 +1100 (EST)
Subject: Re: [PATCH][UPSTEAM] powerpc/mpic: add irq_set_wake support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1359601823-9861-1-git-send-email-dongsheng.wang@freescale.com>
Date: Mon, 18 Feb 2013 13:43:11 -0600
Message-Id: <3887203D-64E3-4BA5-AB2A-20BE668560A4@kernel.crashing.org>
References: <1359601823-9861-1-git-send-email-dongsheng.wang@freescale.com>
To: Wang Dongsheng <Dongsheng.Wang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 30, 2013, at 9:10 PM, Wang Dongsheng wrote:

> Add irq_set_wake support. Just add IRQF_NO_SUSPEND to =
desc->action->flag.
> So the wake up interrupt will not be disable in suspend_device_irqs.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> arch/powerpc/sysdev/mpic.c |   15 +++++++++++++++
> 1 files changed, 15 insertions(+), 0 deletions(-)

Why are we doing this globally for all interrupts?  Don't we only have =
some specific interrupts that wake us up?

Also, I'm guessing the wake behavior for interrupts is FSL specific so =
should not apply to ALL users of MPIC.

- k

>=20
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 9c6e535..2ed0220 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -920,6 +920,18 @@ int mpic_set_irq_type(struct irq_data *d, =
unsigned int flow_type)
> 	return IRQ_SET_MASK_OK_NOCOPY;
> }
>=20
> +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	struct irq_desc *desc =3D container_of(d, struct irq_desc, =
irq_data);
> +
> +	if (on)
> +		desc->action->flags |=3D IRQF_NO_SUSPEND;
> +	else
> +		desc->action->flags &=3D ~IRQF_NO_SUSPEND;
> +
> +	return 0;
> +}
> +
> void mpic_set_vector(unsigned int virq, unsigned int vector)
> {
> 	struct mpic *mpic =3D mpic_from_irq(virq);
> @@ -957,6 +969,7 @@ static struct irq_chip mpic_irq_chip =3D {
> 	.irq_unmask	=3D mpic_unmask_irq,
> 	.irq_eoi	=3D mpic_end_irq,
> 	.irq_set_type	=3D mpic_set_irq_type,
> +	.irq_set_wake	=3D mpic_irq_set_wake,
> };
>=20
> #ifdef CONFIG_SMP
> @@ -971,6 +984,7 @@ static struct irq_chip mpic_tm_chip =3D {
> 	.irq_mask	=3D mpic_mask_tm,
> 	.irq_unmask	=3D mpic_unmask_tm,
> 	.irq_eoi	=3D mpic_end_irq,
> +	.irq_set_wake	=3D mpic_irq_set_wake,
> };
>=20
> #ifdef CONFIG_MPIC_U3_HT_IRQS
> @@ -981,6 +995,7 @@ static struct irq_chip mpic_irq_ht_chip =3D {
> 	.irq_unmask	=3D mpic_unmask_ht_irq,
> 	.irq_eoi	=3D mpic_end_ht_irq,
> 	.irq_set_type	=3D mpic_set_irq_type,
> +	.irq_set_wake	=3D mpic_irq_set_wake,
> };
> #endif /* CONFIG_MPIC_U3_HT_IRQS */
>=20
> --
> 1.7.5.1
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
