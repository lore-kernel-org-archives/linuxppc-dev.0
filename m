Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 482F3DDF09
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 08:36:02 +1000 (EST)
Subject: Re: [PATCH] powerpc: uninline of_iomap function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Krafft <krafft@de.ibm.com>
In-Reply-To: <20070424173202.15e5ce42@localhost>
References: <20070423193538.576702568@arndb.de>
	<20070423193913.119032752@arndb.de>
	<1177378533.14873.48.camel@localhost.localdomain>
	<20070424173202.15e5ce42@localhost>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 08:35:48 +1000
Message-Id: <1177454148.14873.130.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 17:32 +0200, Christian Krafft wrote:
> From: Christian Krafft <krafft@de.ibm.com>
> There is no big reason to have that function inlined.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Index: linux-2.6.21-rc4/arch/powerpc/kernel/prom_parse.c
> ===================================================================
> --- linux-2.6.21-rc4.orig/arch/powerpc/kernel/prom_parse.c
> +++ linux-2.6.21-rc4/arch/powerpc/kernel/prom_parse.c
> @@ -1042,3 +1042,15 @@ const void *of_get_mac_address(struct de
>  }
>  EXPORT_SYMBOL(of_get_mac_address);
>  
> +void __iomem *of_iomap(struct device_node *np, int index)
> +{
> +	struct resource res;
> +
> +	if (of_address_to_resource(np, index, &res))
> +		return NULL;
> +
> +	return ioremap(res.start, 1 + res.end - res.start);
> +}
> +EXPORT_SYMBOL(of_iomap);
> +
> +
> Index: linux-2.6.21-rc4/include/asm-powerpc/prom.h
> ===================================================================
> --- linux-2.6.21-rc4.orig/include/asm-powerpc/prom.h
> +++ linux-2.6.21-rc4/include/asm-powerpc/prom.h
> @@ -19,7 +19,6 @@
>  #include <linux/proc_fs.h>
>  #include <linux/platform_device.h>
>  #include <asm/atomic.h>
> -#include <asm/io.h>
>  
>  /* Definitions used by the flattened device tree */
>  #define OF_DT_HEADER		0xd00dfeed	/* marker */
> @@ -352,16 +351,14 @@ static inline int of_irq_to_resource(str
>  	return irq;
>  }
>  
> -static inline void __iomem *of_iomap(struct device_node *np, int index)
> -{
> -	struct resource res;
> -
> -	if (of_address_to_resource(np, index, &res))
> -		return NULL;
> -
> -	return ioremap(res.start, 1 + res.end - res.start);
> -}
> -
> +/**
> + * of_iomap - Maps the memory mapped IO for a given device_node
> + * @device:	the device whose io range will be mapped
> + * @index:	index of the io range
> + *
> + * Returns a pointer to the mapped memory
> + */
> +extern void __iomem *of_iomap(struct device_node *device, int index);
>  
>  #endif /* __KERNEL__ */
>  #endif /* _POWERPC_PROM_H */
> 
> 
