Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B56A9B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:00:25 +1000 (EST)
Received: by iym7 with SMTP id 7so681628iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:00:22 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <69f5978c647fad7a57b39de2a3c10f2f2bccb642.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<69f5978c647fad7a57b39de2a3c10f2f2bccb642.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:00:02 +0200
Message-ID: <BANLkTimAHAOEovwD9NDesSLkNyy7WQe--w@mail.gmail.com>
Subject: Re: [PATCH 23/37] powerpc: radix trees are available before init_IRQ
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
> Since the generic irq code uses a radix tree for sparse interrupts,
> the initcall ordering has been changed to initialize radix trees before
> irqs. =A0 We no longer need to defer creating revmap radix trees to the
> arch_initcall irq_late_init.
>
> Also, the kmem caches are allocated so we don't need to use
> zalloc_maybe_bootmem.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>

w00t.  Looks right to me.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/kernel/irq.c | =A0 78 ++---------------------------------=
---------
> =A01 files changed, 4 insertions(+), 74 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 826552c..f42e869 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -493,7 +493,6 @@ struct irq_map_entry {
>
> =A0static LIST_HEAD(irq_hosts);
> =A0static DEFINE_RAW_SPINLOCK(irq_big_lock);
> -static unsigned int revmap_trees_allocated;
> =A0static DEFINE_MUTEX(revmap_trees_mutex);
> =A0static struct irq_map_entry irq_map[NR_IRQS];
> =A0static unsigned int irq_virq_count =3D NR_IRQS;
> @@ -537,7 +536,7 @@ struct irq_host *irq_alloc_host(struct device_node *o=
f_node,
> =A0 =A0 =A0 =A0/* Allocate structure and revmap table if using linear map=
ping */
> =A0 =A0 =A0 =A0if (revmap_type =3D=3D IRQ_HOST_MAP_LINEAR)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size +=3D revmap_arg * sizeof(unsigned int=
);
> - =A0 =A0 =A0 host =3D zalloc_maybe_bootmem(size, GFP_KERNEL);
> + =A0 =A0 =A0 host =3D kzalloc(size, GFP_KERNEL);
> =A0 =A0 =A0 =A0if (host =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> @@ -605,6 +604,9 @@ struct irq_host *irq_alloc_host(struct device_node *o=
f_node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_wmb();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->revmap_data.linear.revmap =3D rmap;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 case IRQ_HOST_MAP_TREE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_RADIX_TREE(&host->revmap_data.tree, GF=
P_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> @@ -839,13 +841,6 @@ void irq_dispose_mapping(unsigned int virq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->revmap_data.linear.r=
evmap[hwirq] =3D NO_IRQ;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case IRQ_HOST_MAP_TREE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check if radix tree allocated yet, if =
not then nothing to
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* remove.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_rmb();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (revmap_trees_allocated < 1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&revmap_trees_mutex);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radix_tree_delete(&host->revmap_data.tree,=
 hwirq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&revmap_trees_mutex);
> @@ -906,14 +901,6 @@ unsigned int irq_radix_revmap_lookup(struct irq_host=
 *host,
> =A0 =A0 =A0 =A0WARN_ON(host->revmap_type !=3D IRQ_HOST_MAP_TREE);
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Check if the radix tree exists and has bee initialized=
.
> - =A0 =A0 =A0 =A0* If not, we fallback to slow mode
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (revmap_trees_allocated < 2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return irq_find_mapping(host, hwirq);
> -
> - =A0 =A0 =A0 /* Now try to resolve */
> - =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * No rcu_read_lock(ing) needed, the ptr returned can't go=
 under us
> =A0 =A0 =A0 =A0 * as it's referencing an entry in the static irq_map tabl=
e.
> =A0 =A0 =A0 =A0 */
> @@ -935,18 +922,8 @@ unsigned int irq_radix_revmap_lookup(struct irq_host=
 *host,
> =A0void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t h=
wirq)
> =A0{
> -
> =A0 =A0 =A0 =A0WARN_ON(host->revmap_type !=3D IRQ_HOST_MAP_TREE);
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Check if the radix tree exists yet.
> - =A0 =A0 =A0 =A0* If not, then the irq will be inserted into the tree wh=
en it gets
> - =A0 =A0 =A0 =A0* initialized.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 smp_rmb();
> - =A0 =A0 =A0 if (revmap_trees_allocated < 1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> =A0 =A0 =A0 =A0if (virq !=3D NO_IRQ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_lock(&revmap_trees_mutex);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0radix_tree_insert(&host->revmap_data.tree,=
 hwirq,
> @@ -1054,53 +1031,6 @@ int arch_early_irq_init(void)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -/* We need to create the radix trees late */
> -static int irq_late_init(void)
> -{
> - =A0 =A0 =A0 struct irq_host *h;
> - =A0 =A0 =A0 unsigned int i;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* No mutual exclusion with respect to accessors of the t=
ree is needed
> - =A0 =A0 =A0 =A0* here as the synchronization is done via the state vari=
able
> - =A0 =A0 =A0 =A0* revmap_trees_allocated.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 list_for_each_entry(h, &irq_hosts, link) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (h->revmap_type =3D=3D IRQ_HOST_MAP_TREE=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_RADIX_TREE(&h->revmap_=
data.tree, GFP_KERNEL);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Make sure the radix trees inits are visible before set=
ting
> - =A0 =A0 =A0 =A0* the flag
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 smp_wmb();
> - =A0 =A0 =A0 revmap_trees_allocated =3D 1;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Insert the reverse mapping for those interrupts alread=
y present
> - =A0 =A0 =A0 =A0* in irq_map[].
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 mutex_lock(&revmap_trees_mutex);
> - =A0 =A0 =A0 for (i =3D 0; i < irq_virq_count; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq_map[i].host &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (irq_map[i].host->revmap_type =3D=
=3D IRQ_HOST_MAP_TREE))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 radix_tree_insert(&irq_map[=
i].host->revmap_data.tree,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 irq_map[i].hwirq, &irq_map[i]);
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 mutex_unlock(&revmap_trees_mutex);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Make sure the radix trees insertions are visible befor=
e setting
> - =A0 =A0 =A0 =A0* the flag
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 smp_wmb();
> - =A0 =A0 =A0 revmap_trees_allocated =3D 2;
> -
> - =A0 =A0 =A0 return 0;
> -}
> -arch_initcall(irq_late_init);
> -
> =A0#ifdef CONFIG_VIRQ_DEBUG
> =A0static int virq_debug_show(struct seq_file *m, void *private)
> =A0{
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
