Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 965DAB70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Oct 2010 04:55:12 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o93HikM4018253
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Oct 2010 11:44:46 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o93Ht9Ci238266
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Oct 2010 11:55:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o93Ht7wM024738
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Oct 2010 11:55:09 -0600
Date: Sun, 3 Oct 2010 23:25:00 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 7/9] v3 Define memory_block_size_bytes for powerpc/pseries
Message-ID: <20101003175500.GE7896@balbir.in.ibm.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62A0A.4050406@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4CA62A0A.4050406@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>, linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nathan Fontenot <nfont@austin.ibm.com> [2010-10-01 13:35:54]:

> Define a version of memory_block_size_bytes() for powerpc/pseries such that
> a memory block spans an entire lmb.

I hope I am not missing anything obvious, but why not just call it
lmb_size, why do we need memblock_size?

Is lmb_size == memblock_size after your changes true for all
platforms?

> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> 
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c |   66 +++++++++++++++++++-----
>  1 file changed, 53 insertions(+), 13 deletions(-)
> 
> Index: linux-next/arch/powerpc/platforms/pseries/hotplug-memory.c
> ===================================================================
> --- linux-next.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2010-09-30 14:44:37.000000000 -0500
> +++ linux-next/arch/powerpc/platforms/pseries/hotplug-memory.c	2010-09-30 14:47:04.000000000 -0500
> @@ -17,6 +17,54 @@
>  #include <asm/pSeries_reconfig.h>
>  #include <asm/sparsemem.h>
> 
> +static unsigned long get_memblock_size(void)
> +{
> +	struct device_node *np;
> +	unsigned int memblock_size = 0;
> +
> +	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
> +	if (np) {
> +		const unsigned long *size;
> +
> +		size = of_get_property(np, "ibm,lmb-size", NULL);
> +		memblock_size = size ? *size : 0;
> +
> +		of_node_put(np);
> +	} else {
> +		unsigned int memzero_size = 0;
> +		const unsigned int *regs;
> +
> +		np = of_find_node_by_path("/memory@0");
> +		if (np) {
> +			regs = of_get_property(np, "reg", NULL);
> +			memzero_size = regs ? regs[3] : 0;
> +			of_node_put(np);
> +		}
> +
> +		if (memzero_size) {
> +			/* We now know the size of memory@0, use this to find
> +			 * the first memoryblock and get its size.
> +			 */

Nit: comment style is not correct

> +			char buf[64];
> +
> +			sprintf(buf, "/memory@%x", memzero_size);
> +			np = of_find_node_by_path(buf);
> +			if (np) {
> +				regs = of_get_property(np, "reg", NULL);
> +				memblock_size = regs ? regs[3] : 0;
> +				of_node_put(np);
> +			}
> +		}
> +	}



> +
> +	return memblock_size;
> +}
> +
> +unsigned long memory_block_size_bytes(void)
> +{
> +	return get_memblock_size();
> +}
> +
>  static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
>  {
>  	unsigned long start, start_pfn;
> @@ -127,30 +175,22 @@
> 
>  static int pseries_drconf_memory(unsigned long *base, unsigned int action)
>  {
> -	struct device_node *np;
> -	const unsigned long *lmb_size;
> +	unsigned long memblock_size;
>  	int rc;
> 
> -	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
> -	if (!np)
> +	memblock_size = get_memblock_size();
> +	if (!memblock_size)
>  		return -EINVAL;
> 
> -	lmb_size = of_get_property(np, "ibm,lmb-size", NULL);
> -	if (!lmb_size) {
> -		of_node_put(np);
> -		return -EINVAL;
> -	}
> -
>  	if (action == PSERIES_DRCONF_MEM_ADD) {
> -		rc = memblock_add(*base, *lmb_size);
> +		rc = memblock_add(*base, memblock_size);
>  		rc = (rc < 0) ? -EINVAL : 0;
>  	} else if (action == PSERIES_DRCONF_MEM_REMOVE) {
> -		rc = pseries_remove_memblock(*base, *lmb_size);
> +		rc = pseries_remove_memblock(*base, memblock_size);
>  	} else {
>  		rc = -EINVAL;
>  	}
> 
> -	of_node_put(np);
>  	return rc;
>  }
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 

-- 
	Three Cheers,
	Balbir
