Return-Path: <B40534@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26D522C0109
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 20:59:00 +1000 (EST)
Received: from mail34-va3 (localhost [127.0.0.1])	by mail34-va3-R.bigfish.com
 (Postfix) with ESMTP id 3664A2A01A7	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 16 Apr 2013 10:58:56 +0000 (UTC)
Received: from VA3EHSMHS033.bigfish.com (unknown [10.7.14.238])	by
 mail34-va3.bigfish.com (Postfix) with ESMTP id D78A51E006D	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 10:58:54 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
Date: Tue, 16 Apr 2013 10:58:52 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EE77D8@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi scott,

Could you ACK these patches?

[PATCH v3 2/4] powerpc/mpic: add global timer support
[PATCH v3 3/4] powerpc/mpic: create mpic subsystem object
[PATCH v3 4/4] powerpc/fsl: add MPIC timer wakeup support

Thanks.

> -----Original Message-----
> From: Wang Dongsheng-B40534
> Sent: Tuesday, April 09, 2013 10:22 AM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> Subject: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
>=20
> Add irq_set_wake support. Just add IRQF_NO_SUSPEND to desc->action->flag.
> So the wake up interrupt will not be disable in suspend_device_irqs.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> v3:
> * Modify: Change "EINVAL" to "ENXIO" in mpic_irq_set_wake()
>=20
> v2:
> * Add: Check freescale chip in mpic_irq_set_wake().
> * Remove: Support mpic_irq_set_wake() in ht_chip.
>=20
>  arch/powerpc/sysdev/mpic.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 3b2efd4..ae709d2 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -920,6 +920,22 @@ int mpic_set_irq_type(struct irq_data *d, unsigned
> int flow_type)
>  	return IRQ_SET_MASK_OK_NOCOPY;
>  }
>=20
> +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on) {
> +	struct irq_desc *desc =3D container_of(d, struct irq_desc, irq_data);
> +	struct mpic *mpic =3D mpic_from_irq_data(d);
> +
> +	if (!(mpic->flags & MPIC_FSL))
> +		return -ENXIO;
> +
> +	if (on)
> +		desc->action->flags |=3D IRQF_NO_SUSPEND;
> +	else
> +		desc->action->flags &=3D ~IRQF_NO_SUSPEND;
> +
> +	return 0;
> +}
> +
>  void mpic_set_vector(unsigned int virq, unsigned int vector)  {
>  	struct mpic *mpic =3D mpic_from_irq(virq); @@ -957,6 +973,7 @@ static
> struct irq_chip mpic_irq_chip =3D {
>  	.irq_unmask	=3D mpic_unmask_irq,
>  	.irq_eoi	=3D mpic_end_irq,
>  	.irq_set_type	=3D mpic_set_irq_type,
> +	.irq_set_wake	=3D mpic_irq_set_wake,
>  };
>=20
>  #ifdef CONFIG_SMP
> @@ -971,6 +988,7 @@ static struct irq_chip mpic_tm_chip =3D {
>  	.irq_mask	=3D mpic_mask_tm,
>  	.irq_unmask	=3D mpic_unmask_tm,
>  	.irq_eoi	=3D mpic_end_irq,
> +	.irq_set_wake	=3D mpic_irq_set_wake,
>  };
>=20
>  #ifdef CONFIG_MPIC_U3_HT_IRQS
> --
> 1.8.0
