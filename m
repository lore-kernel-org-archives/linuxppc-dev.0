Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55CC8B6F5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jul 2011 22:20:30 +1000 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1Qcchr-0005lr-8l
	from <mingo@elte.hu>
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2011 14:20:23 +0200
Date: Fri, 1 Jul 2011 14:15:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/mm: Fix memory_block_size_bytes() for
	non-pseries
Message-ID: <20110701121516.GD28008@elte.hu>
References: <1308013071.2874.785.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308013071.2874.785.camel@pasglop>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Just compiling pseries in the kernel causes it to override
> memory_block_size_bytes() regardless of what is the runtime
> platform.
> 
> This cleans up the implementation of that function, fixing
> a bug or two while at it, so that it's harmless (and potentially
> useful) for other platforms. Without this, bugs in that code
> would trigger a WARN_ON() in drivers/base/memory.c when
> booting some different platforms. 
> 
> If/when we have another platform supporting memory hotplug we
> might want to either move that out to a generic place or
> make it a ppc_md. callback.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 33867ec..9d6a8ef 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -12,6 +12,8 @@
>  #include <linux/of.h>
>  #include <linux/memblock.h>
>  #include <linux/vmalloc.h>
> +#include <linux/memory.h>
> +
>  #include <asm/firmware.h>
>  #include <asm/machdep.h>
>  #include <asm/pSeries_reconfig.h>
> @@ -20,24 +22,25 @@
>  static unsigned long get_memblock_size(void)
>  {
>  	struct device_node *np;
> -	unsigned int memblock_size = 0;
> +	unsigned int memblock_size = MIN_MEMORY_BLOCK_SIZE;
> +	struct resource r;
>  
>  	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>  	if (np) {
> -		const unsigned long *size;
> +		const __be64 *size;
>  
>  		size = of_get_property(np, "ibm,lmb-size", NULL);
> -		memblock_size = size ? *size : 0;
> -
> +		if (size)
> +			memblock_size = be64_to_cpup(size);
>  		of_node_put(np);
> -	} else {
> +	} else  if (machine_is(pseries)) {
> +		/* This fallback really only applies to pseries */
>  		unsigned int memzero_size = 0;
> -		const unsigned int *regs;
>  
>  		np = of_find_node_by_path("/memory@0");
>  		if (np) {
> -			regs = of_get_property(np, "reg", NULL);
> -			memzero_size = regs ? regs[3] : 0;
> +			if (!of_address_to_resource(np, 0, &r))
> +				memzero_size = resource_size(&r);
>  			of_node_put(np);
>  		}
>  
> @@ -50,16 +53,21 @@ static unsigned long get_memblock_size(void)
>  			sprintf(buf, "/memory@%x", memzero_size);
>  			np = of_find_node_by_path(buf);
>  			if (np) {
> -				regs = of_get_property(np, "reg", NULL);
> -				memblock_size = regs ? regs[3] : 0;
> +				if (!of_address_to_resource(np, 0, &r))
> +					memblock_size = resource_size(&r);
>  				of_node_put(np);
>  			}
>  		}
>  	}
> -
>  	return memblock_size;
>  }
>  
> +/* WARNING: This is going to override the generic definition whenever
> + * pseries is built-in regardless of what platform is active at boot
> + * time. This is fine for now as this is the only "option" and it
> + * should work everywhere. If not, we'll have to turn this into a
> + * ppc_md. callback
> + */

Just a small nit, please use the customary (multi-line) comment 
style:

  /*
   * Comment .....
   * ...... goes here.
   */

specified in Documentation/CodingStyle.

Thanks,

        Ingo
