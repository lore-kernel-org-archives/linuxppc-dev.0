Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76EC1DDF50
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 11:04:47 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc - Initialize the irq radix tree earlier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <1217848124-3719-2-git-send-email-sebastien.dugue@bull.net>
References: <1217848124-3719-1-git-send-email-sebastien.dugue@bull.net>
	<1217848124-3719-2-git-send-email-sebastien.dugue@bull.net>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 11:03:46 +1000
Message-Id: <1217898226.24157.120.camel@pasglop>
Mime-Version: 1.0
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gilles.carry@ext.bull.net, tglx@linutronix.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-04 at 13:08 +0200, Sebastien Dugue wrote:
> The radix tree used for fast irq reverse mapping by the XICS is initialized
> late in the boot process, after the first interrupt (IPI) gets registered
> and after the first IPI is received.
> 
>   This patch moves the initialization of the XICS radix tree earlier into
> the boot process in smp_xics_probe() (the mm is already up but no interrupts
> have been registered at that point) to avoid having to insert a mapping into
> the tree in interrupt context. This will help in simplifying the locking
> constraints and move to a lockless radix tree in subsequent patches.

I'm not too happy with the moving of the radix tree init to platform
code.

The fact that the revmap code uses a radix tree should be mostly
transparent to the XICS code. I don't like adding this explicit code
from xics to initialize it.

I think the tree should still be initialized from generic code and it
can be done as late as we want as interrupts work without the tree being
there, they are just a bit slower.

I believe the right approach is:

 - Remove the populating of the tree from the revmap function as
   you already do
 - Move it to irq_create_mapping() for the normal case
 - For pre-existing interrupt, have the generic code that initializes
   the radix tree walk through all interrupts and setup the revmap for
   them. If that needs locking vs. concurrent irq_create_mapping, it's
   easy to use one of the available spinlocks for that.

Cheers,
Ben.


> Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/kernel/irq.c             |   17 -----------------
>  arch/powerpc/platforms/pseries/smp.c  |    1 +
>  arch/powerpc/platforms/pseries/xics.c |    5 +++++
>  arch/powerpc/platforms/pseries/xics.h |    1 +
>  4 files changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index d972dec..9bef9f3 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -1016,23 +1016,6 @@ void irq_early_init(void)
>  		get_irq_desc(i)->status |= IRQ_NOREQUEST;
>  }
>  
> -/* We need to create the radix trees late */
> -static int irq_late_init(void)
> -{
> -	struct irq_host *h;
> -	unsigned long flags;
> -
> -	irq_radix_wrlock(&flags);
> -	list_for_each_entry(h, &irq_hosts, link) {
> -		if (h->revmap_type == IRQ_HOST_MAP_TREE)
> -			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_ATOMIC);
> -	}
> -	irq_radix_wrunlock(flags);
> -
> -	return 0;
> -}
> -arch_initcall(irq_late_init);
> -
>  #ifdef CONFIG_VIRQ_DEBUG
>  static int virq_debug_show(struct seq_file *m, void *private)
>  {
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
> index 9d8f8c8..3d4429a 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -130,6 +130,7 @@ static void smp_xics_message_pass(int target, int msg)
>  
>  static int __init smp_xics_probe(void)
>  {
> +	xics_radix_revmap_init();
>  	xics_request_IPIs();
>  
>  	return cpus_weight(cpu_possible_map);
> diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
> index 0fc830f..d6e28f9 100644
> --- a/arch/powerpc/platforms/pseries/xics.c
> +++ b/arch/powerpc/platforms/pseries/xics.c
> @@ -556,6 +556,11 @@ static struct irq_host_ops xics_host_ops = {
>  	.xlate = xics_host_xlate,
>  };
>  
> +void __init xics_radix_revmap_init(void)
> +{
> +	INIT_RADIX_TREE(&xics_host->revmap_data.tree, GFP_ATOMIC);
> +}
> +
>  static void __init xics_init_host(void)
>  {
>  	if (firmware_has_feature(FW_FEATURE_LPAR))
> diff --git a/arch/powerpc/platforms/pseries/xics.h b/arch/powerpc/platforms/pseries/xics.h
> index 1c5321a..11490be 100644
> --- a/arch/powerpc/platforms/pseries/xics.h
> +++ b/arch/powerpc/platforms/pseries/xics.h
> @@ -19,6 +19,7 @@ extern void xics_setup_cpu(void);
>  extern void xics_teardown_cpu(void);
>  extern void xics_kexec_teardown_cpu(int secondary);
>  extern void xics_cause_IPI(int cpu);
> +extern void xics_radix_revmap_init(void);
>  extern  void xics_request_IPIs(void);
>  extern void xics_migrate_irqs_away(void);
>  
