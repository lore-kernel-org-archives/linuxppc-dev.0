Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 30E09DE07B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 13:59:31 +1000 (EST)
Subject: Re: [RFC/PATCH 1/4] Move xics_setup_8259_cascade() into
	platforms/pseries/setup.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
References: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 13:59:21 +1000
Message-Id: <1208491161.6958.383.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-04-01 at 17:42 +1100, Michael Ellerman wrote:
> The code in xics.c to setup the i8259 cascaded irq handler is not really
> xics specific, so move it into setup.c - we will clean this up further in
> a subsequent patch.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/pseries/setup.c |   53 +++++++++++++++++++++++++++++++-
>  arch/powerpc/platforms/pseries/xics.c  |   48 -----------------------------
>  arch/powerpc/platforms/pseries/xics.h  |    3 --
>  3 files changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index fdb9b1c..43e4801 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -127,6 +127,51 @@ void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
>  	desc->chip->eoi(irq);
>  }
>  
> +static void __init xics_setup_8259_cascade(void)
> +{
> +	struct device_node *np, *old, *found = NULL;
> +	int cascade, naddr;
> +	const u32 *addrp;
> +	unsigned long intack = 0;
> +
> +	for_each_node_by_type(np, "interrupt-controller")
> +		if (of_device_is_compatible(np, "chrp,iic")) {
> +			found = np;
> +			break;
> +		}
> +	if (found == NULL) {
> +		printk(KERN_DEBUG "xics: no ISA interrupt controller\n");
> +		return;
> +	}
> +	cascade = irq_of_parse_and_map(found, 0);
> +	if (cascade == NO_IRQ) {
> +		printk(KERN_ERR "xics: failed to map cascade interrupt");
> +		return;
> +	}
> +	pr_debug("xics: cascade mapped to irq %d\n", cascade);
> +
> +	for (old = of_node_get(found); old != NULL ; old = np) {
> +		np = of_get_parent(old);
> +		of_node_put(old);
> +		if (np == NULL)
> +			break;
> +		if (strcmp(np->name, "pci") != 0)
> +			continue;
> +		addrp = of_get_property(np, "8259-interrupt-acknowledge", NULL);
> +		if (addrp == NULL)
> +			continue;
> +		naddr = of_n_addr_cells(np);
> +		intack = addrp[naddr-1];
> +		if (naddr > 1)
> +			intack |= ((unsigned long)addrp[naddr-2]) << 32;
> +	}
> +	if (intack)
> +		printk(KERN_DEBUG "xics: PCI 8259 intack at 0x%016lx\n", intack);
> +	i8259_init(found, intack);
> +	of_node_put(found);
> +	set_irq_chained_handler(cascade, pseries_8259_cascade);
> +}
> +
>  static void __init pseries_mpic_init_IRQ(void)
>  {
>  	struct device_node *np, *old, *cascade = NULL;
> @@ -206,6 +251,12 @@ static void __init pseries_mpic_init_IRQ(void)
>  	set_irq_chained_handler(cascade_irq, pseries_8259_cascade);
>  }
>  
> +static void __init pseries_xics_init_IRQ(void)
> +{
> +	xics_init_IRQ();
> +	xics_setup_8259_cascade();
> +}
> +
>  static void pseries_lpar_enable_pmcs(void)
>  {
>  	unsigned long set, reset;
> @@ -235,7 +286,7 @@ static void __init pseries_discover_pic(void)
>  			smp_init_pseries_mpic();
>  			return;
>  		} else if (strstr(typep, "ppc-xicp")) {
> -			ppc_md.init_IRQ       = xics_init_IRQ;
> +			ppc_md.init_IRQ       = pseries_xics_init_IRQ;
>  			setup_kexec_cpu_down_xics();
>  			smp_init_pseries_xics();
>  			return;
> diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
> index ca52b58..5a72f27 100644
> --- a/arch/powerpc/platforms/pseries/xics.c
> +++ b/arch/powerpc/platforms/pseries/xics.c
> @@ -655,52 +655,6 @@ static void __init xics_init_one_node(struct device_node *np,
>  	}
>  }
>  
> -
> -static void __init xics_setup_8259_cascade(void)
> -{
> -	struct device_node *np, *old, *found = NULL;
> -	int cascade, naddr;
> -	const u32 *addrp;
> -	unsigned long intack = 0;
> -
> -	for_each_node_by_type(np, "interrupt-controller")
> -		if (of_device_is_compatible(np, "chrp,iic")) {
> -			found = np;
> -			break;
> -		}
> -	if (found == NULL) {
> -		printk(KERN_DEBUG "xics: no ISA interrupt controller\n");
> -		return;
> -	}
> -	cascade = irq_of_parse_and_map(found, 0);
> -	if (cascade == NO_IRQ) {
> -		printk(KERN_ERR "xics: failed to map cascade interrupt");
> -		return;
> -	}
> -	pr_debug("xics: cascade mapped to irq %d\n", cascade);
> -
> -	for (old = of_node_get(found); old != NULL ; old = np) {
> -		np = of_get_parent(old);
> -		of_node_put(old);
> -		if (np == NULL)
> -			break;
> -		if (strcmp(np->name, "pci") != 0)
> -			continue;
> -		addrp = of_get_property(np, "8259-interrupt-acknowledge", NULL);
> -		if (addrp == NULL)
> -			continue;
> -		naddr = of_n_addr_cells(np);
> -		intack = addrp[naddr-1];
> -		if (naddr > 1)
> -			intack |= ((unsigned long)addrp[naddr-2]) << 32;
> -	}
> -	if (intack)
> -		printk(KERN_DEBUG "xics: PCI 8259 intack at 0x%016lx\n", intack);
> -	i8259_init(found, intack);
> -	of_node_put(found);
> -	set_irq_chained_handler(cascade, pseries_8259_cascade);
> -}
> -
>  void __init xics_init_IRQ(void)
>  {
>  	struct device_node *np;
> @@ -733,8 +687,6 @@ void __init xics_init_IRQ(void)
>  
>  	xics_setup_cpu();
>  
> -	xics_setup_8259_cascade();
> -
>  	ppc64_boot_msg(0x21, "XICS Done");
>  }
>  
> diff --git a/arch/powerpc/platforms/pseries/xics.h b/arch/powerpc/platforms/pseries/xics.h
> index c26bcff..1c5321a 100644
> --- a/arch/powerpc/platforms/pseries/xics.h
> +++ b/arch/powerpc/platforms/pseries/xics.h
> @@ -28,7 +28,4 @@ struct xics_ipi_struct {
>  
>  extern struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
>  
> -struct irq_desc;
> -extern void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc);
> -
>  #endif /* _POWERPC_KERNEL_XICS_H */
