Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6A1AB6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:04:18 +1000 (EST)
Received: by iym7 with SMTP id 7so685054iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:04:16 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <a254a95c4fe502cf11a3a094afe0298263c3dbd6.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<a254a95c4fe502cf11a3a094afe0298263c3dbd6.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:03:56 +0200
Message-ID: <BANLkTimAK8889PapC-5POOhaKZyLO3OfpQ@mail.gmail.com>
Subject: Re: [PATCH 24/37] powerpc: return early if irq_host lookup type is
	wrong
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

On Wed, May 11, 2011 at 7:29 AM, Milton Miller <miltonm@bga.com> wrote:
> If for some reason the code incrorectly calls the wrong function to
> manage the revmap, not only should we warn, we should take action.
> However, in the paths we expect to be taken every delivered interrupt
> change to WARN_ON_ONCE. =A0Use the if (WARN_ON(x)) format to get the
> unlikely for free.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>

Looks right.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/kernel/irq.c | =A0 12 +++++++-----
> =A01 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index f42e869..4a5aa8c 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -814,8 +814,7 @@ void irq_dispose_mapping(unsigned int virq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0host =3D irq_map[virq].host;
> - =A0 =A0 =A0 WARN_ON (host =3D=3D NULL);
> - =A0 =A0 =A0 if (host =3D=3D NULL)
> + =A0 =A0 =A0 if (WARN_ON(host =3D=3D NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0/* Never unmap legacy interrupts */
> @@ -898,7 +897,8 @@ unsigned int irq_radix_revmap_lookup(struct irq_host =
*host,
> =A0 =A0 =A0 =A0struct irq_map_entry *ptr;
> =A0 =A0 =A0 =A0unsigned int virq;
>
> - =A0 =A0 =A0 WARN_ON(host->revmap_type !=3D IRQ_HOST_MAP_TREE);
> + =A0 =A0 =A0 if (WARN_ON_ONCE(host->revmap_type !=3D IRQ_HOST_MAP_TREE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return irq_find_mapping(host, hwirq);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * No rcu_read_lock(ing) needed, the ptr returned can't go=
 under us
> @@ -922,7 +922,8 @@ unsigned int irq_radix_revmap_lookup(struct irq_host =
*host,
> =A0void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t h=
wirq)
> =A0{
> - =A0 =A0 =A0 WARN_ON(host->revmap_type !=3D IRQ_HOST_MAP_TREE);
> + =A0 =A0 =A0 if (WARN_ON(host->revmap_type !=3D IRQ_HOST_MAP_TREE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> =A0 =A0 =A0 =A0if (virq !=3D NO_IRQ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&revmap_trees_mutex);
> @@ -937,7 +938,8 @@ unsigned int irq_linear_revmap(struct irq_host *host,
> =A0{
> =A0 =A0 =A0 =A0unsigned int *revmap;
>
> - =A0 =A0 =A0 WARN_ON(host->revmap_type !=3D IRQ_HOST_MAP_LINEAR);
> + =A0 =A0 =A0 if (WARN_ON_ONCE(host->revmap_type !=3D IRQ_HOST_MAP_LINEAR=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return irq_find_mapping(host, hwirq);
>
> =A0 =A0 =A0 =A0/* Check revmap bounds */
> =A0 =A0 =A0 =A0if (unlikely(hwirq >=3D host->revmap_data.linear.size))
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
