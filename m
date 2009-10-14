Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id 7A198B7063
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 06:02:48 +1100 (EST)
Received: by yxe11 with SMTP id 11so96700yxe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 12:02:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <a78e4bb1b3a65314dd4bd0c253a0abf242bd34a6.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
	<a78e4bb1b3a65314dd4bd0c253a0abf242bd34a6.1255499081.git.michael@ellerman.id.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 13:02:27 -0600
Message-ID: <fa686aa40910141202i3ed4b58fy1c0626e8f327438b@mail.gmail.com>
Subject: Re: [PATCH 3/6] powerpc: Remove get_irq_desc()
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

On Tue, Oct 13, 2009 at 11:44 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> get_irq_desc() is a powerpc-specific version of irq_to_desc(). That
> is reason enough to remove it, but it also doesn't know about sparse
> irq_desc support which irq_to_desc() does (when we enable it).
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/include/asm/irq.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 -
> =A0arch/powerpc/kernel/crash.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
> =A0arch/powerpc/kernel/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 28 ++++++++++++----------
> =A0arch/powerpc/platforms/512x/mpc5121_ads_cpld.c =A0| =A0 =A02 +-
> =A0arch/powerpc/platforms/52xx/media5200.c =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/powerpc/platforms/82xx/pq2ads-pci-pic.c =A0 =A0| =A0 =A02 +-
> =A0arch/powerpc/platforms/85xx/socrates_fpga_pic.c | =A0 =A02 +-
> =A0arch/powerpc/platforms/86xx/gef_pic.c =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +=
-
> =A0arch/powerpc/platforms/cell/beat_interrupt.c =A0 =A0| =A0 =A02 +-
> =A0arch/powerpc/platforms/cell/spider-pic.c =A0 =A0 =A0 =A0| =A0 =A04 +-
> =A0arch/powerpc/platforms/iseries/irq.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +-
> =A0arch/powerpc/platforms/powermac/pic.c =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +=
++---
> =A0arch/powerpc/platforms/pseries/xics.c =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +=
++---
> =A0arch/powerpc/sysdev/cpm1.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
> =A0arch/powerpc/sysdev/cpm2_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 10 +++++---
> =A0arch/powerpc/sysdev/fsl_msi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
> =A0arch/powerpc/sysdev/i8259.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A04 +-
> =A0arch/powerpc/sysdev/ipic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
> =A0arch/powerpc/sysdev/mpc8xx_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 +-
> =A0arch/powerpc/sysdev/mpic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 18 +++++++-------
> =A0arch/powerpc/sysdev/mv64x60_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +-
> =A0arch/powerpc/sysdev/qe_lib/qe_ic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 +-
> =A0arch/powerpc/sysdev/tsi108_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 +-
> =A0arch/powerpc/sysdev/uic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A06 ++--
> =A0arch/powerpc/sysdev/xilinx_intc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +-
> =A025 files changed, 62 insertions(+), 60 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/ir=
q.h
> index b83fcc8..03dc28c 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -17,8 +17,6 @@
> =A0#include <asm/atomic.h>
>
>
> -#define get_irq_desc(irq) (&irq_desc[(irq)])
> -
> =A0/* Define a way to iterate across irqs. */
> =A0#define for_each_irq(i) \
> =A0 =A0 =A0 =A0for ((i) =3D 0; (i) < NR_IRQS; ++(i))
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index 0a8439a..6f4613d 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -373,7 +373,7 @@ void default_machine_crash_shutdown(struct pt_regs *r=
egs)
> =A0 =A0 =A0 =A0hard_irq_disable();
>
> =A0 =A0 =A0 =A0for_each_irq(i) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct irq_desc *desc =3D irq_desc + i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(i);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (desc->status & IRQ_INPROGRESS)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->chip->eoi(i);
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index e5d1211..6563221 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -190,7 +190,7 @@ int show_interrupts(struct seq_file *p, void *v)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (i < NR_IRQS) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D get_irq_desc(i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D irq_to_desc(i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&desc->lock, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0action =3D desc->action;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!action || !action->handler)
> @@ -230,23 +230,25 @@ skip:
> =A0#ifdef CONFIG_HOTPLUG_CPU
> =A0void fixup_irqs(cpumask_t map)
> =A0{
> + =A0 =A0 =A0 struct irq_desc *desc;
> =A0 =A0 =A0 =A0unsigned int irq;
> =A0 =A0 =A0 =A0static int warned;
>
> =A0 =A0 =A0 =A0for_each_irq(irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpumask_t mask;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq_desc[irq].status & IRQ_PER_CPU)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D irq_to_desc(irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc && desc->status & IRQ_PER_CPU)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpumask_and(&mask, irq_desc[irq].affinity, =
&map);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpumask_and(&mask, desc->affinity, &map);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (any_online_cpu(mask) =3D=3D NR_CPUS) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("Breaking affinity =
for irq %i\n", irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mask =3D map;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq_desc[irq].chip->set_affinity)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_desc[irq].chip->set_aff=
inity(irq, &mask);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (irq_desc[irq].action && !(warned++=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->chip->set_affinity)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->chip->set_affinity(ir=
q, &mask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (desc->action && !(warned++))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk("Cannot set affinit=
y for irq %i\n", irq);
> =A0 =A0 =A0 =A0}
>
> @@ -273,7 +275,7 @@ static inline void handle_one_irq(unsigned int irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 desc =3D irq_desc + irq;
> + =A0 =A0 =A0 desc =3D irq_to_desc(irq);
> =A0 =A0 =A0 =A0saved_sp_limit =3D current->thread.ksp_limit;
>
> =A0 =A0 =A0 =A0irqtp->task =3D curtp->task;
> @@ -535,7 +537,7 @@ struct irq_host *irq_alloc_host(struct device_node *o=
f_node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0smp_wmb();
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clear norequest flags *=
/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_irq_desc(i)->status &=
=3D ~IRQ_NOREQUEST;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_to_desc(i)->status &=3D=
 ~IRQ_NOREQUEST;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Legacy flags are left t=
o default at this point,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * one can then use irq_cr=
eate_mapping() to
> @@ -602,7 +604,7 @@ static int irq_setup_virq(struct irq_host *host, unsi=
gned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_number_t hw=
irq)
> =A0{
> =A0 =A0 =A0 =A0/* Clear IRQ_NOREQUEST flag */
> - =A0 =A0 =A0 get_irq_desc(virq)->status &=3D ~IRQ_NOREQUEST;
> + =A0 =A0 =A0 irq_to_desc(virq)->status &=3D ~IRQ_NOREQUEST;
>
> =A0 =A0 =A0 =A0/* map it */
> =A0 =A0 =A0 =A0smp_wmb();
> @@ -732,7 +734,7 @@ unsigned int irq_create_of_mapping(struct device_node=
 *controller,
>
> =A0 =A0 =A0 =A0/* Set type if specified and different than the current on=
e */
> =A0 =A0 =A0 =A0if (type !=3D IRQ_TYPE_NONE &&
> - =A0 =A0 =A0 =A0 =A0 type !=3D (get_irq_desc(virq)->status & IRQF_TRIGGE=
R_MASK))
> + =A0 =A0 =A0 =A0 =A0 type !=3D (irq_to_desc(virq)->status & IRQF_TRIGGER=
_MASK))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_type(virq, type);
> =A0 =A0 =A0 =A0return virq;
> =A0}
> @@ -804,7 +806,7 @@ void irq_dispose_mapping(unsigned int virq)
> =A0 =A0 =A0 =A0irq_map[virq].hwirq =3D host->inval_irq;
>
> =A0 =A0 =A0 =A0/* Set some flags */
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_NOREQUEST;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_NOREQUEST;
>
> =A0 =A0 =A0 =A0/* Free it */
> =A0 =A0 =A0 =A0irq_free_virt(virq, 1);
> @@ -1001,7 +1003,7 @@ void irq_early_init(void)
> =A0 =A0 =A0 =A0unsigned int i;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < NR_IRQS; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_irq_desc(i)->status |=3D IRQ_NOREQUEST;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_to_desc(i)->status |=3D IRQ_NOREQUEST;
> =A0}
>
> =A0/* We need to create the radix trees late */
> @@ -1064,7 +1066,7 @@ static int virq_debug_show(struct seq_file *m, void=
 *private)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"chip name", "host name");
>
> =A0 =A0 =A0 =A0for (i =3D 1; i < NR_IRQS; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D get_irq_desc(i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D irq_to_desc(i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&desc->lock, flags);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (desc->action && desc->action->handler)=
 {
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerp=
c/platforms/512x/mpc5121_ads_cpld.c
> index a6ce805..cd70ee1 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
> @@ -132,7 +132,7 @@ static int
> =A0cpld_pic_host_map(struct irq_host *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t h=
w)
> =A0{
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, &cpld_pic, handle_level_irq=
);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platf=
orms/52xx/media5200.c
> index 68e4f16..4780203 100644
> --- a/arch/powerpc/platforms/52xx/media5200.c
> +++ b/arch/powerpc/platforms/52xx/media5200.c
> @@ -114,7 +114,7 @@ void media5200_irq_cascade(unsigned int virq, struct =
irq_desc *desc)
> =A0static int media5200_irq_map(struct irq_host *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t h=
w)
> =A0{
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
>
> =A0 =A0 =A0 =A0pr_debug("%s: h=3D%p, virq=3D%i, hwirq=3D%i\n", __func__, =
h, virq, (int)hw);
> =A0 =A0 =A0 =A0set_irq_chip_data(virq, &media5200_irq);
> diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/=
platforms/82xx/pq2ads-pci-pic.c
> index 7ee979f..a682331 100644
> --- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> +++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> @@ -107,7 +107,7 @@ static void pq2ads_pci_irq_demux(unsigned int irq, st=
ruct irq_desc *desc)
> =A0static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_number_t hw=
)
> =A0{
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
> =A0 =A0 =A0 =A0set_irq_chip_data(virq, h->host_data);
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, &pq2ads_pci_ic, handle_leve=
l_irq);
> =A0 =A0 =A0 =A0return 0;
> diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/power=
pc/platforms/85xx/socrates_fpga_pic.c
> index 60edf63..e59920a 100644
> --- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
> +++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
> @@ -245,7 +245,7 @@ static int socrates_fpga_pic_host_map(struct irq_host=
 *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_number_t hwirq)
> =A0{
> =A0 =A0 =A0 =A0/* All interrupts are LEVEL sensitive */
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, &socrates_fpga_pic_chip,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0handle_fasteoi_irq);
>
> diff --git a/arch/powerpc/platforms/86xx/gef_pic.c b/arch/powerpc/platfor=
ms/86xx/gef_pic.c
> index 50d0a2b..978d6cb 100644
> --- a/arch/powerpc/platforms/86xx/gef_pic.c
> +++ b/arch/powerpc/platforms/86xx/gef_pic.c
> @@ -163,7 +163,7 @@ static int gef_pic_host_map(struct irq_host *h, unsig=
ned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_number_t hwirq)
> =A0{
> =A0 =A0 =A0 =A0/* All interrupts are LEVEL sensitive */
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, &gef_pic_chip, handle_level=
_irq);
>
> =A0 =A0 =A0 =A0return 0;
> diff --git a/arch/powerpc/platforms/cell/beat_interrupt.c b/arch/powerpc/=
platforms/cell/beat_interrupt.c
> index 7225484..4a2bbff 100644
> --- a/arch/powerpc/platforms/cell/beat_interrupt.c
> +++ b/arch/powerpc/platforms/cell/beat_interrupt.c
> @@ -136,7 +136,7 @@ static void beatic_pic_host_unmap(struct irq_host *h,=
 unsigned int virq)
> =A0static int beatic_pic_host_map(struct irq_host *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number=
_t hw)
> =A0{
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
> =A0 =A0 =A0 =A0int64_t err;
>
> =A0 =A0 =A0 =A0err =3D beat_construct_and_connect_irq_plug(virq, hw);
> diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/plat=
forms/cell/spider-pic.c
> index 4e56556..9dd63c5 100644
> --- a/arch/powerpc/platforms/cell/spider-pic.c
> +++ b/arch/powerpc/platforms/cell/spider-pic.c
> @@ -102,7 +102,7 @@ static void spider_ack_irq(unsigned int virq)
>
> =A0 =A0 =A0 =A0/* Reset edge detection logic if necessary
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (get_irq_desc(virq)->status & IRQ_LEVEL)
> + =A0 =A0 =A0 if (irq_to_desc(virq)->status & IRQ_LEVEL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0/* Only interrupts 47 to 50 can be set to edge */
> @@ -119,7 +119,7 @@ static int spider_set_irq_type(unsigned int virq, uns=
igned int type)
> =A0 =A0 =A0 =A0struct spider_pic *pic =3D spider_virq_to_pic(virq);
> =A0 =A0 =A0 =A0unsigned int hw =3D irq_map[virq].hwirq;
> =A0 =A0 =A0 =A0void __iomem *cfg =3D spider_get_irq_config(pic, hw);
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
> =A0 =A0 =A0 =A0u32 old_mask;
> =A0 =A0 =A0 =A0u32 ic;
>
> diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platform=
s/iseries/irq.c
> index 94f4447..f8446ea 100644
> --- a/arch/powerpc/platforms/iseries/irq.c
> +++ b/arch/powerpc/platforms/iseries/irq.c
> @@ -214,7 +214,7 @@ void __init iSeries_activate_IRQs()
> =A0 =A0 =A0 =A0unsigned long flags;
>
> =A0 =A0 =A0 =A0for_each_irq (irq) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(irq)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(irq);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (desc && desc->chip && desc->chip->star=
tup) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&desc->l=
ock, flags);
> diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platfor=
ms/powermac/pic.c
> index d212006..484d21e 100644
> --- a/arch/powerpc/platforms/powermac/pic.c
> +++ b/arch/powerpc/platforms/powermac/pic.c
> @@ -152,12 +152,12 @@ static unsigned int pmac_startup_irq(unsigned int v=
irq)
> =A0 =A0 =A0 =A0 unsigned long bit =3D 1UL << (src & 0x1f);
> =A0 =A0 =A0 =A0 int i =3D src >> 5;
>
> - =A0 =A0 =A0 spin_lock_irqsave(&pmac_pic_lock, flags);
> - =A0 =A0 =A0 if ((irq_desc[virq].status & IRQ_LEVEL) =3D=3D 0)
> + =A0 =A0 =A0 spin_lock_irqsave(&pmac_pic_lock, flags);
> + =A0 =A0 =A0 if ((irq_to_desc(virq)->status & IRQ_LEVEL) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_le32(&pmac_irq_hw[i]->ack, bit);
> =A0 =A0 =A0 =A0 __set_bit(src, ppc_cached_irq_mask);
> =A0 =A0 =A0 =A0 __pmac_set_irq_mask(src, 0);
> - =A0 =A0 =A0 spin_unlock_irqrestore(&pmac_pic_lock, flags);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&pmac_pic_lock, flags);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -285,7 +285,7 @@ static int pmac_pic_host_match(struct irq_host *h, st=
ruct device_node *node)
> =A0static int pmac_pic_host_map(struct irq_host *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t h=
w)
> =A0{
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
> =A0 =A0 =A0 =A0int level;
>
> =A0 =A0 =A0 =A0if (hw >=3D max_irqs)
> diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platfor=
ms/pseries/xics.c
> index 419f8a6..75935ae 100644
> --- a/arch/powerpc/platforms/pseries/xics.c
> +++ b/arch/powerpc/platforms/pseries/xics.c
> @@ -156,7 +156,7 @@ static int get_irq_server(unsigned int virq, unsigned=
 int strict_check)
> =A0 =A0 =A0 =A0cpumask_t cpumask;
> =A0 =A0 =A0 =A0cpumask_t tmp =3D CPU_MASK_NONE;
>
> - =A0 =A0 =A0 cpumask_copy(&cpumask, irq_desc[virq].affinity);
> + =A0 =A0 =A0 cpumask_copy(&cpumask, irq_to_desc(virq)->affinity);
> =A0 =A0 =A0 =A0if (!distribute_irqs)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return default_server;
>
> @@ -419,7 +419,7 @@ static int xics_host_map(struct irq_host *h, unsigned=
 int virq,
> =A0 =A0 =A0 =A0/* Insert the interrupt mapping into the radix tree for fa=
st lookup */
> =A0 =A0 =A0 =A0irq_radix_revmap_insert(xics_host, virq, hw);
>
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, xics_irq_chip, handle_faste=
oi_irq);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -843,7 +843,7 @@ void xics_migrate_irqs_away(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* We need to get IPIs still. */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (irq =3D=3D XICS_IPI || irq =3D=3D XICS=
_IRQ_SPURIOUS)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc =3D irq_to_desc(virq);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* We only need to migrate enabled IRQS */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (desc =3D=3D NULL || desc->chip =3D=3D =
NULL
> @@ -872,7 +872,7 @@ void xics_migrate_irqs_away(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virq, cpu);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Reset affinity to all cpus */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpumask_setall(irq_desc[virq].affinity);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpumask_setall(irq_to_desc(virq)->affinity)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->chip->set_affinity(virq, cpu_all_mas=
k);
> =A0unlock:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&desc->lock, flags)=
;
> diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
> index 82424cd..5235373 100644
> --- a/arch/powerpc/sysdev/cpm1.c
> +++ b/arch/powerpc/sysdev/cpm1.c
> @@ -102,7 +102,7 @@ static int cpm_pic_host_map(struct irq_host *h, unsig=
ned int virq,
> =A0{
> =A0 =A0 =A0 =A0pr_debug("cpm_pic_host_map(%d, 0x%lx)\n", virq, hw);
>
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, &cpm_pic, handle_fasteoi_ir=
q);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pi=
c.c
> index 78f1f7c..722cf72 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.c
> +++ b/arch/powerpc/sysdev/cpm2_pic.c
> @@ -115,11 +115,13 @@ static void cpm2_ack(unsigned int virq)
>
> =A0static void cpm2_end_irq(unsigned int virq)
> =A0{
> + =A0 =A0 =A0 struct irq_desc *desc;
> =A0 =A0 =A0 =A0int =A0 =A0 bit, word;
> =A0 =A0 =A0 =A0unsigned int irq_nr =3D virq_to_hw(virq);
>
> - =A0 =A0 =A0 if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRES=
S))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && irq_desc[irq_nr].action)=
 {
> + =A0 =A0 =A0 desc =3D irq_to_desc(irq_nr);
> + =A0 =A0 =A0 if (!(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && desc->action) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bit =3D irq_to_siubit[irq_nr];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0word =3D irq_to_siureg[irq_nr];
> @@ -138,7 +140,7 @@ static void cpm2_end_irq(unsigned int virq)
> =A0static int cpm2_set_irq_type(unsigned int virq, unsigned int flow_type=
)
> =A0{
> =A0 =A0 =A0 =A0unsigned int src =3D virq_to_hw(virq);
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
> =A0 =A0 =A0 =A0unsigned int vold, vnew, edibit;
>
> =A0 =A0 =A0 =A0if (flow_type =3D=3D IRQ_TYPE_NONE)
> @@ -210,7 +212,7 @@ static int cpm2_pic_host_map(struct irq_host *h, unsi=
gned int virq,
> =A0{
> =A0 =A0 =A0 =A0pr_debug("cpm2_pic_host_map(%d, 0x%lx)\n", virq, hw);
>
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, &cpm2_pic, handle_level_irq=
);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.=
c
> index da38a1f..7174374 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -55,7 +55,7 @@ static int fsl_msi_host_map(struct irq_host *h, unsigne=
d int virq,
> =A0{
> =A0 =A0 =A0 =A0struct irq_chip *chip =3D &fsl_msi_chip;
>
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_TYPE_EDGE_FALLING;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_TYPE_EDGE_FALLING;
>
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, chip, handle_edge_irq);
>
> diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
> index a96584a..78ed945 100644
> --- a/arch/powerpc/sysdev/i8259.c
> +++ b/arch/powerpc/sysdev/i8259.c
> @@ -175,12 +175,12 @@ static int i8259_host_map(struct irq_host *h, unsig=
ned int virq,
>
> =A0 =A0 =A0 =A0/* We block the internal cascade */
> =A0 =A0 =A0 =A0if (hw =3D=3D 2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_NOREQUE=
ST;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_NOREQUES=
T;
>
> =A0 =A0 =A0 =A0/* We use the level handler only for now, we might want to
> =A0 =A0 =A0 =A0 * be more cautious here but that works for now
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, &i8259_pic, handle_level_ir=
q);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
> index cb7689c..f042c1d 100644
> --- a/arch/powerpc/sysdev/ipic.c
> +++ b/arch/powerpc/sysdev/ipic.c
> @@ -605,7 +605,7 @@ static int ipic_set_irq_type(unsigned int virq, unsig=
ned int flow_type)
> =A0{
> =A0 =A0 =A0 =A0struct ipic *ipic =3D ipic_from_irq(virq);
> =A0 =A0 =A0 =A0unsigned int src =3D ipic_irq_to_hw(virq);
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
> =A0 =A0 =A0 =A0unsigned int vold, vnew, edibit;
>
> =A0 =A0 =A0 =A0if (flow_type =3D=3D IRQ_TYPE_NONE)
> diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8x=
x_pic.c
> index 5d2d552..0117958 100644
> --- a/arch/powerpc/sysdev/mpc8xx_pic.c
> +++ b/arch/powerpc/sysdev/mpc8xx_pic.c
> @@ -72,7 +72,7 @@ static void mpc8xx_end_irq(unsigned int virq)
>
> =A0static int mpc8xx_set_irq_type(unsigned int virq, unsigned int flow_ty=
pe)
> =A0{
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
>
> =A0 =A0 =A0 =A0desc->status &=3D ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
> =A0 =A0 =A0 =A0desc->status |=3D flow_type & IRQ_TYPE_SENSE_MASK;
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 30c44e6..4fd57ab 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -572,7 +572,7 @@ static int irq_choose_cpu(unsigned int virt_irq)
> =A0 =A0 =A0 =A0cpumask_t mask;
> =A0 =A0 =A0 =A0int cpuid;
>
> - =A0 =A0 =A0 cpumask_copy(&mask, irq_desc[virt_irq].affinity);
> + =A0 =A0 =A0 cpumask_copy(&mask, irq_to_desc(virt_irq)->affinity);
> =A0 =A0 =A0 =A0if (cpus_equal(mask, CPU_MASK_ALL)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0static int irq_rover;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0static DEFINE_SPINLOCK(irq_rover_lock);
> @@ -621,7 +621,7 @@ static struct mpic *mpic_find(unsigned int irq)
> =A0 =A0 =A0 =A0if (irq < NUM_ISA_INTERRUPTS)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> - =A0 =A0 =A0 return irq_desc[irq].chip_data;
> + =A0 =A0 =A0 return irq_to_desc(irq)->chip_data;
> =A0}
>
> =A0/* Determine if the linux irq is an IPI */
> @@ -648,14 +648,14 @@ static inline u32 mpic_physmask(u32 cpumask)
> =A0/* Get the mpic structure from the IPI number */
> =A0static inline struct mpic * mpic_from_ipi(unsigned int ipi)
> =A0{
> - =A0 =A0 =A0 return irq_desc[ipi].chip_data;
> + =A0 =A0 =A0 return irq_to_desc(ipi)->chip_data;
> =A0}
> =A0#endif
>
> =A0/* Get the mpic structure from the irq number */
> =A0static inline struct mpic * mpic_from_irq(unsigned int irq)
> =A0{
> - =A0 =A0 =A0 return irq_desc[irq].chip_data;
> + =A0 =A0 =A0 return irq_to_desc(irq)->chip_data;
> =A0}
>
> =A0/* Send an EOI */
> @@ -735,7 +735,7 @@ static void mpic_unmask_ht_irq(unsigned int irq)
>
> =A0 =A0 =A0 =A0mpic_unmask_irq(irq);
>
> - =A0 =A0 =A0 if (irq_desc[irq].status & IRQ_LEVEL)
> + =A0 =A0 =A0 if (irq_to_desc(irq)->status & IRQ_LEVEL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpic_ht_end_irq(mpic, src);
> =A0}
>
> @@ -745,7 +745,7 @@ static unsigned int mpic_startup_ht_irq(unsigned int =
irq)
> =A0 =A0 =A0 =A0unsigned int src =3D mpic_irq_to_hw(irq);
>
> =A0 =A0 =A0 =A0mpic_unmask_irq(irq);
> - =A0 =A0 =A0 mpic_startup_ht_interrupt(mpic, src, irq_desc[irq].status);
> + =A0 =A0 =A0 mpic_startup_ht_interrupt(mpic, src, irq_to_desc(irq)->stat=
us);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -755,7 +755,7 @@ static void mpic_shutdown_ht_irq(unsigned int irq)
> =A0 =A0 =A0 =A0struct mpic *mpic =3D mpic_from_irq(irq);
> =A0 =A0 =A0 =A0unsigned int src =3D mpic_irq_to_hw(irq);
>
> - =A0 =A0 =A0 mpic_shutdown_ht_interrupt(mpic, src, irq_desc[irq].status)=
;
> + =A0 =A0 =A0 mpic_shutdown_ht_interrupt(mpic, src, irq_to_desc(irq)->sta=
tus);
> =A0 =A0 =A0 =A0mpic_mask_irq(irq);
> =A0}
>
> @@ -772,7 +772,7 @@ static void mpic_end_ht_irq(unsigned int irq)
> =A0 =A0 =A0 =A0 * latched another edge interrupt coming in anyway
> =A0 =A0 =A0 =A0 */
>
> - =A0 =A0 =A0 if (irq_desc[irq].status & IRQ_LEVEL)
> + =A0 =A0 =A0 if (irq_to_desc(irq)->status & IRQ_LEVEL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpic_ht_end_irq(mpic, src);
> =A0 =A0 =A0 =A0mpic_eoi(mpic);
> =A0}
> @@ -856,7 +856,7 @@ int mpic_set_irq_type(unsigned int virq, unsigned int=
 flow_type)
> =A0{
> =A0 =A0 =A0 =A0struct mpic *mpic =3D mpic_from_irq(virq);
> =A0 =A0 =A0 =A0unsigned int src =3D mpic_irq_to_hw(virq);
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
> =A0 =A0 =A0 =A0unsigned int vecpri, vold, vnew;
>
> =A0 =A0 =A0 =A0DBG("mpic: set_irq_type(mpic:@%p,virq:%d,src:0x%x,type:0x%=
x)\n",
> diff --git a/arch/powerpc/sysdev/mv64x60_pic.c b/arch/powerpc/sysdev/mv64=
x60_pic.c
> index 2aa4ed0..485b924 100644
> --- a/arch/powerpc/sysdev/mv64x60_pic.c
> +++ b/arch/powerpc/sysdev/mv64x60_pic.c
> @@ -213,7 +213,7 @@ static int mv64x60_host_map(struct irq_host *h, unsig=
ned int virq,
> =A0{
> =A0 =A0 =A0 =A0int level1;
>
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
>
> =A0 =A0 =A0 =A0level1 =3D (hwirq & MV64x60_LEVEL1_MASK) >> MV64x60_LEVEL1=
_OFFSET;
> =A0 =A0 =A0 =A0BUG_ON(level1 > MV64x60_LEVEL1_GPP);
> diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_=
lib/qe_ic.c
> index 3faa42e..fc09874 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
> @@ -189,7 +189,7 @@ static inline void qe_ic_write(volatile __be32 =A0__i=
omem * base, unsigned int reg
>
> =A0static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
> =A0{
> - =A0 =A0 =A0 return irq_desc[virq].chip_data;
> + =A0 =A0 =A0 return irq_to_desc(virq)->chip_data;
> =A0}
>
> =A0#define virq_to_hw(virq) =A0 =A0 =A0 ((unsigned int)irq_map[virq].hwir=
q)
> @@ -263,7 +263,7 @@ static int qe_ic_host_map(struct irq_host *h, unsigne=
d int virq,
> =A0 =A0 =A0 =A0chip =3D &qe_ic->hc_irq;
>
> =A0 =A0 =A0 =A0set_irq_chip_data(virq, qe_ic);
> - =A0 =A0 =A0 get_irq_desc(virq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 irq_to_desc(virq)->status |=3D IRQ_LEVEL;
>
> =A0 =A0 =A0 =A0set_irq_chip_and_handler(virq, chip, handle_level_irq);
>
> diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi10=
8_pci.c
> index cf244a4..02f6009 100644
> --- a/arch/powerpc/sysdev/tsi108_pci.c
> +++ b/arch/powerpc/sysdev/tsi108_pci.c
> @@ -398,7 +398,7 @@ static int pci_irq_host_map(struct irq_host *h, unsig=
ned int virq,
> =A0 =A0 =A0 =A0DBG("%s(%d, 0x%lx)\n", __func__, virq, hw);
> =A0 =A0 =A0 =A0if ((virq >=3D 1) && (virq <=3D 4)){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq =3D virq + IRQ_PCI_INTAD_BASE - 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_irq_desc(irq)->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_to_desc(irq)->status |=3D IRQ_LEVEL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_chip(irq, &tsi108_pci_irq);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
> index 466ce9a..cf97935 100644
> --- a/arch/powerpc/sysdev/uic.c
> +++ b/arch/powerpc/sysdev/uic.c
> @@ -57,7 +57,7 @@ struct uic {
>
> =A0static void uic_unmask_irq(unsigned int virq)
> =A0{
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
> =A0 =A0 =A0 =A0struct uic *uic =3D get_irq_chip_data(virq);
> =A0 =A0 =A0 =A0unsigned int src =3D uic_irq_to_hw(virq);
> =A0 =A0 =A0 =A0unsigned long flags;
> @@ -101,7 +101,7 @@ static void uic_ack_irq(unsigned int virq)
>
> =A0static void uic_mask_ack_irq(unsigned int virq)
> =A0{
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
> =A0 =A0 =A0 =A0struct uic *uic =3D get_irq_chip_data(virq);
> =A0 =A0 =A0 =A0unsigned int src =3D uic_irq_to_hw(virq);
> =A0 =A0 =A0 =A0unsigned long flags;
> @@ -129,7 +129,7 @@ static int uic_set_irq_type(unsigned int virq, unsign=
ed int flow_type)
> =A0{
> =A0 =A0 =A0 =A0struct uic *uic =3D get_irq_chip_data(virq);
> =A0 =A0 =A0 =A0unsigned int src =3D uic_irq_to_hw(virq);
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0int trigger, polarity;
> =A0 =A0 =A0 =A0u32 tr, pr, mask;
> diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xili=
nx_intc.c
> index 40edad5..ab74371 100644
> --- a/arch/powerpc/sysdev/xilinx_intc.c
> +++ b/arch/powerpc/sysdev/xilinx_intc.c
> @@ -79,7 +79,7 @@ static void xilinx_intc_mask(unsigned int virq)
>
> =A0static int xilinx_intc_set_type(unsigned int virq, unsigned int flow_t=
ype)
> =A0{
> - =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(virq);
>
> =A0 =A0 =A0 =A0desc->status &=3D ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
> =A0 =A0 =A0 =A0desc->status |=3D flow_type & IRQ_TYPE_SENSE_MASK;
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
