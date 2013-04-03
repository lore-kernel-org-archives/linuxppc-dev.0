Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D26F22C013E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 11:37:05 +1100 (EST)
Received: from mail75-co1 (localhost [127.0.0.1])	by mail75-co1-R.bigfish.com
 (Postfix) with ESMTP id 342B24801ED	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Apr 2013 00:37:00 +0000 (UTC)
Received: from CO1EHSMHS006.bigfish.com (unknown [10.243.78.238])	by
 mail75-co1.bigfish.com (Postfix) with ESMTP id 6CDF270006B	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 00:36:59 +0000 (UTC)
Date: Tue, 2 Apr 2013 19:36:56 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/4] powerpc/mpic: add irq_set_wake support
To: Wang Dongsheng <dongsheng.wang@freescale.com>
References: <1364884840-28635-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1364884840-28635-1-git-send-email-dongsheng.wang@freescale.com>
 (from dongsheng.wang@freescale.com on Tue Apr  2 01:40:37 2013)
Message-ID: <1364949416.24520.30@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2013 01:40:37 AM, Wang Dongsheng wrote:
> Add irq_set_wake support. Just add IRQF_NO_SUSPEND to =20
> desc->action->flag.
> So the wake up interrupt will not be disable in suspend_device_irqs.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> v2:
> * Add: Check freescale chip in mpic_irq_set_wake().
> * Remove: Support mpic_irq_set_wake() in ht_chip.
>=20
>  arch/powerpc/sysdev/mpic.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 3b2efd4..50d1ee1 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -920,6 +920,22 @@ int mpic_set_irq_type(struct irq_data *d, =20
> unsigned int flow_type)
>  	return IRQ_SET_MASK_OK_NOCOPY;
>  }
>=20
> +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	struct irq_desc *desc =3D container_of(d, struct irq_desc, =20
> irq_data);
> +	struct mpic *mpic =3D mpic_from_irq_data(d);
> +
> +	if (!(mpic->flags & MPIC_FSL))
> +		return -EINVAL;

I was thinking more along the lines of using MPIC_FSL during init to =20
decide whether to write this function to .irq_set_wake, though that =20
could probably wait until there's a second type of MPIC that needs this =20
(if ever).

-Scott=
