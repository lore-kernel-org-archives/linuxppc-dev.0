Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BCB5DDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 11:35:48 +1000 (EST)
Subject: Re: [PATCH 07/10] add of_iomap function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20070423193913.119032752@arndb.de>
References: <20070423193538.576702568@arndb.de>
	<20070423193913.119032752@arndb.de>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 11:35:33 +1000
Message-Id: <1177378533.14873.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-04-23 at 21:35 +0200, Arnd Bergmann wrote:
> plain text document attachment (powerpc-add-of_remap.diff)
> From: Christian Krafft <krafft@de.ibm.com>
> 
> The of_iomap function maps memory for a given
> device_node and returns a pointer to that memory.
> This is used at some places, so it makes sense to
> a seperate function.

No point in inlining it imho.

Ben.

> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> 
> Index: linux-2.6/arch/powerpc/sysdev/pmi.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/sysdev/pmi.c
> +++ linux-2.6/arch/powerpc/sysdev/pmi.c
> @@ -33,7 +33,7 @@
>  #include <asm/of_platform.h>
>  #include <asm/io.h>
>  #include <asm/pmi.h>
> -
> +#include <asm/prom.h>
>  
>  struct pmi_data {
>  	struct list_head	handler;
> @@ -49,21 +49,6 @@ struct pmi_data {
>  };
>  
> 
> -
> -static void __iomem *of_iomap(struct device_node *np)
> -{
> -	struct resource res;
> -
> -	if (of_address_to_resource(np, 0, &res))
> -		return NULL;
> -
> -	pr_debug("Resource start: 0x%lx\n", res.start);
> -	pr_debug("Resource end: 0x%lx\n", res.end);
> -
> -	return ioremap(res.start, 1 + res.end - res.start);
> -}
> -
> -
>  static int pmi_irq_handler(int irq, void *dev_id)
>  {
>  	struct pmi_data *data;
> @@ -154,7 +139,7 @@ static int pmi_of_probe(struct of_device
>  		goto out;
>  	}
>  
> -	data->pmi_reg = of_iomap(np);
> +	data->pmi_reg = of_iomap(np, 0);
>  	if (!data->pmi_reg) {
>  		printk(KERN_ERR "pmi: invalid register address.\n");
>  		rc = -EFAULT;
> Index: linux-2.6/include/asm-powerpc/prom.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/prom.h
> +++ linux-2.6/include/asm-powerpc/prom.h
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <asm/irq.h>
>  #include <asm/atomic.h>
> +#include <asm/io.h>
>  
>  /* Definitions used by the flattened device tree */
>  #define OF_DT_HEADER		0xd00dfeed	/* marker */
> @@ -355,6 +356,16 @@ static inline int of_irq_to_resource(str
>  	return irq;
>  }
>  
> +static inline void __iomem *of_iomap(struct device_node *np, int index)
> +{
> +	struct resource res;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return NULL;
> +
> +	return ioremap(res.start, 1 + res.end - res.start);
> +}
> +
>  
>  #endif /* __KERNEL__ */
>  #endif /* _POWERPC_PROM_H */
> 
> --
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
