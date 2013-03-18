Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0DE772C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 10:36:28 +1100 (EST)
Date: Mon, 18 Mar 2013 18:36:18 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][UPSTEAM] powerpc/mpic: add irq_set_wake support
To: Wang Dongsheng <dongsheng.wang@freescale.com>
In-Reply-To: <1359601823-9861-1-git-send-email-dongsheng.wang@freescale.com>
 (from dongsheng.wang@freescale.com on Wed Jan 30 21:10:23 2013)
Message-ID: <1363649778.27435.21@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/30/2013 09:10:23 PM, Wang Dongsheng wrote:
> Add irq_set_wake support. Just add IRQF_NO_SUSPEND to =20
> desc->action->flag.
> So the wake up interrupt will not be disable in suspend_device_irqs.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
>  arch/powerpc/sysdev/mpic.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 9c6e535..2ed0220 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -920,6 +920,18 @@ int mpic_set_irq_type(struct irq_data *d, =20
> unsigned int flow_type)
>  	return IRQ_SET_MASK_OK_NOCOPY;
>  }
>=20
> +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	struct irq_desc *desc =3D container_of(d, struct irq_desc, =20
> irq_data);
> +
> +	if (on)
> +		desc->action->flags |=3D IRQF_NO_SUSPEND;
> +	else
> +		desc->action->flags &=3D ~IRQF_NO_SUSPEND;
> +
> +	return 0;
> +}

This should really be something like fsl_mpic_irq_set_wake() and only =20
set when we have an FSL MPIC.

>  void mpic_set_vector(unsigned int virq, unsigned int vector)
>  {
>  	struct mpic *mpic =3D mpic_from_irq(virq);
> @@ -957,6 +969,7 @@ static struct irq_chip mpic_irq_chip =3D {
>  	.irq_unmask	=3D mpic_unmask_irq,
>  	.irq_eoi	=3D mpic_end_irq,
>  	.irq_set_type	=3D mpic_set_irq_type,
> +	.irq_set_wake	=3D mpic_irq_set_wake,
>  };
>=20
>  #ifdef CONFIG_SMP
> @@ -971,6 +984,7 @@ static struct irq_chip mpic_tm_chip =3D {
>  	.irq_mask	=3D mpic_mask_tm,
>  	.irq_unmask	=3D mpic_unmask_tm,
>  	.irq_eoi	=3D mpic_end_irq,
> +	.irq_set_wake	=3D mpic_irq_set_wake,
>  };
>=20
>  #ifdef CONFIG_MPIC_U3_HT_IRQS
> @@ -981,6 +995,7 @@ static struct irq_chip mpic_irq_ht_chip =3D {
>  	.irq_unmask	=3D mpic_unmask_ht_irq,
>  	.irq_eoi	=3D mpic_end_ht_irq,
>  	.irq_set_type	=3D mpic_set_irq_type,
> +	.irq_set_wake	=3D mpic_irq_set_wake,
>  };
>  #endif /* CONFIG_MPIC_U3_HT_IRQS */

Why ht?

-Scott=
