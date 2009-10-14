Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f218.google.com (mail-gx0-f218.google.com
	[209.85.217.218]) by ozlabs.org (Postfix) with ESMTP id 336AAB70B3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 05:46:16 +1100 (EST)
Received: by gxk10 with SMTP id 10so93212gxk.3
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 11:46:15 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <91cec5c64da4ca31a025fc7c45d9f1b93c8b98da.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
	<91cec5c64da4ca31a025fc7c45d9f1b93c8b98da.1255499081.git.michael@ellerman.id.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 12:44:22 -0600
Message-ID: <fa686aa40910141144y1776c476uc8e26e06eb57e6ac@mail.gmail.com>
Subject: Re: [PATCH 6/6] powerpc: Enable sparse irq_descs on powerpc
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
> Defining CONFIG_SPARSE_IRQ enables generic code that gets rid of the
> static irq_desc array, and replaces it with an array of pointers to
> irq_descs.
>
> It also allows node local allocation of irq_descs, however we
> currently don't have the information available to do that, so we just
> allocate them on all on node 0.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Why not make sparse IRQs manditory for all platforms?  Is there a
performance concern with doing so?  From a maintenance perspective,
I'd rather see IRQ descs manged in one way only to keep the code
simple.

Cheers,
g.

> ---
> =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 13 ++++++++++++
> =A0arch/powerpc/include/asm/irq.h =A0| =A0 =A03 ++
> =A0arch/powerpc/kernel/irq.c =A0 =A0 =A0 | =A0 40 +++++++++++++++++++++++=
+++++++++------
> =A0arch/powerpc/kernel/ppc_ksyms.c | =A0 =A01 -
> =A0arch/powerpc/kernel/setup_64.c =A0| =A0 =A05 ----
> =A05 files changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2230e75..825d889 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -388,6 +388,19 @@ config IRQ_ALL_CPUS
> =A0 =A0 =A0 =A0 =A0CPU. =A0Generally saying Y is safe, although some prob=
lems have been
> =A0 =A0 =A0 =A0 =A0reported with SMP Power Macintoshes with this option e=
nabled.
>
> +config SPARSE_IRQ
> + =A0 =A0 =A0 bool "Support sparse irq numbering"
> + =A0 =A0 =A0 default y
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This enables support for sparse irqs. This is useful fo=
r distro
> + =A0 =A0 =A0 =A0 kernels that want to define a high CONFIG_NR_CPUS value=
 but still
> + =A0 =A0 =A0 =A0 want to have low kernel memory footprint on smaller mac=
hines.
> +
> + =A0 =A0 =A0 =A0 ( Sparse IRQs can also be beneficial on NUMA boxes, as =
they spread
> + =A0 =A0 =A0 =A0 =A0 out the irq_desc[] array in a more NUMA-friendly wa=
y. )
> +
> + =A0 =A0 =A0 =A0 If you don't know what to do here, say Y.
> +
> =A0config NUMA
> =A0 =A0 =A0 =A0bool "NUMA support"
> =A0 =A0 =A0 =A0depends on PPC64
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/ir=
q.h
> index 03dc28c..c85a32f 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -38,6 +38,9 @@ extern atomic_t ppc_n_lost_interrupts;
> =A0/* Number of irqs reserved for the legacy controller */
> =A0#define NUM_ISA_INTERRUPTS =A0 =A0 16
>
> +/* Same thing, used by the generic IRQ code */
> +#define NR_IRQS_LEGACY =A0 =A0 =A0 =A0 NUM_ISA_INTERRUPTS
> +
> =A0/* This type is the placeholder for a hardware interrupt number. It ha=
s to
> =A0* be big enough to enclose whatever representation is used by a given
> =A0* platform.
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 63e27d5..eba5392 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -85,7 +85,10 @@ extern int tau_interrupts(int);
> =A0#endif /* CONFIG_PPC32 */
>
> =A0#ifdef CONFIG_PPC64
> +
> +#ifndef CONFIG_SPARSE_IRQ
> =A0EXPORT_SYMBOL(irq_desc);
> +#endif
>
> =A0int distribute_irqs =3D 1;
>
> @@ -613,8 +616,16 @@ void irq_set_virq_count(unsigned int count)
> =A0static int irq_setup_virq(struct irq_host *host, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_number_t hw=
irq)
> =A0{
> + =A0 =A0 =A0 struct irq_desc *desc;
> +
> + =A0 =A0 =A0 desc =3D irq_to_desc_alloc_node(virq, 0);
> + =A0 =A0 =A0 if (!desc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("irq: -> allocating desc failed\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* Clear IRQ_NOREQUEST flag */
> - =A0 =A0 =A0 irq_to_desc(virq)->status &=3D ~IRQ_NOREQUEST;
> + =A0 =A0 =A0 desc->status &=3D ~IRQ_NOREQUEST;
>
> =A0 =A0 =A0 =A0/* map it */
> =A0 =A0 =A0 =A0smp_wmb();
> @@ -623,11 +634,14 @@ static int irq_setup_virq(struct irq_host *host, un=
signed int virq,
>
> =A0 =A0 =A0 =A0if (host->ops->map(host, virq, hwirq)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("irq: -> mapping failed, freeing\=
n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_free_virt(virq, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> +
> +error:
> + =A0 =A0 =A0 irq_free_virt(virq, 1);
> + =A0 =A0 =A0 return -1;
> =A0}
>
> =A0unsigned int irq_create_direct_mapping(struct irq_host *host)
> @@ -1008,12 +1022,24 @@ void irq_free_virt(unsigned int virq, unsigned in=
t count)
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&irq_big_lock, flags);
> =A0}
>
> -void irq_early_init(void)
> +int arch_early_irq_init(void)
> =A0{
> - =A0 =A0 =A0 unsigned int i;
> + =A0 =A0 =A0 struct irq_desc *desc;
> + =A0 =A0 =A0 int i;
>
> - =A0 =A0 =A0 for (i =3D 0; i < NR_IRQS; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_to_desc(i)->status |=3D IRQ_NOREQUEST;
> + =A0 =A0 =A0 for (i =3D 0; i < NR_IRQS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D irq_to_desc(i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->status |=3D IRQ_NOREQ=
UEST;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int arch_init_chip_data(struct irq_desc *desc, int node)
> +{
> + =A0 =A0 =A0 desc->status |=3D IRQ_NOREQUEST;
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0/* We need to create the radix trees late */
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ks=
yms.c
> index c8b27bb..07115d6 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -162,7 +162,6 @@ EXPORT_SYMBOL(screen_info);
>
> =A0#ifdef CONFIG_PPC32
> =A0EXPORT_SYMBOL(timer_interrupt);
> -EXPORT_SYMBOL(irq_desc);
> =A0EXPORT_SYMBOL(tb_ticks_per_jiffy);
> =A0EXPORT_SYMBOL(cacheable_memcpy);
> =A0EXPORT_SYMBOL(cacheable_memzero);
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c
> index 797ea95..8e5ec92 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -357,11 +357,6 @@ void __init setup_system(void)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0initialize_cache_info();
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Initialize irq remapping subsystem
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 irq_early_init();
> -
> =A0#ifdef CONFIG_PPC_RTAS
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Initialize RTAS if available
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
