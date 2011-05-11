Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E73DB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:18:33 +1000 (EST)
Received: by iym7 with SMTP id 7so697045iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:18:31 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <2e97f048f0a39de47c9af61c1b53fb6fba6260d6.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<2e97f048f0a39de47c9af61c1b53fb6fba6260d6.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:18:11 +0200
Message-ID: <BANLkTi=03Te6kqs8G48FJr6zmQVaP3N2Vw@mail.gmail.com>
Subject: Re: [PATCH 37/37] powerpc: make IRQ_NOREQUEST last to clear,
	first to set
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
> When allocating irqs, wait to clear the IRQ_NOREQUEST flag until the
> host map hook has been called.
>
> When freeing irqs, set the IRQ_NOREQUEST flag before calling the host
> unmap hook.

A description describing why this change is being made would be
appreciated here.

g.

>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> ---
> =A0arch/powerpc/kernel/irq.c | =A0 14 +++++++-------
> =A01 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 4368b5e..a24d37d 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -586,14 +586,14 @@ struct irq_host *irq_alloc_host(struct device_node =
*of_node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_map[i].host =3D host;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_wmb();
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Clear norequest flags */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_clear_status_flags(i, I=
RQ_NOREQUEST);
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Legacy flags are left t=
o default at this point,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * one can then use irq_cr=
eate_mapping() to
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * explicitly change them
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ops->map(host, i, i);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Clear norequest flags */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_clear_status_flags(i, I=
RQ_NOREQUEST);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case IRQ_HOST_MAP_LINEAR:
> @@ -664,8 +664,6 @@ static int irq_setup_virq(struct irq_host *host, unsi=
gned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 irq_clear_status_flags(virq, IRQ_NOREQUEST);
> -
> =A0 =A0 =A0 =A0/* map it */
> =A0 =A0 =A0 =A0smp_wmb();
> =A0 =A0 =A0 =A0irq_map[virq].hwirq =3D hwirq;
> @@ -676,6 +674,8 @@ static int irq_setup_virq(struct irq_host *host, unsi=
gned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto errdesc;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 irq_clear_status_flags(virq, IRQ_NOREQUEST);
> +
> =A0 =A0 =A0 =A0return 0;
>
> =A0errdesc:
> @@ -819,6 +819,8 @@ void irq_dispose_mapping(unsigned int virq)
> =A0 =A0 =A0 =A0if (host->revmap_type =3D=3D IRQ_HOST_MAP_LEGACY)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> + =A0 =A0 =A0 irq_set_status_flags(virq, IRQ_NOREQUEST);
> +
> =A0 =A0 =A0 =A0/* remove chip and handler */
> =A0 =A0 =A0 =A0irq_set_chip_and_handler(virq, NULL, NULL);
>
> @@ -848,8 +850,6 @@ void irq_dispose_mapping(unsigned int virq)
> =A0 =A0 =A0 =A0smp_mb();
> =A0 =A0 =A0 =A0irq_map[virq].hwirq =3D host->inval_irq;
>
> - =A0 =A0 =A0 irq_set_status_flags(virq, IRQ_NOREQUEST);
> -
> =A0 =A0 =A0 =A0irq_free_descs(virq, 1);
> =A0 =A0 =A0 =A0/* Free it */
> =A0 =A0 =A0 =A0irq_free_virt(virq, 1);
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
