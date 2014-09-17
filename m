Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEA8A1A0A72
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 17:07:30 +1000 (EST)
Message-ID: <1410937650.27681.13.camel@concordia>
Subject: Re: [5/5] pseries: Implement memory hotplug remove in the kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 17:07:30 +1000
In-Reply-To: <54174D36.4000002@linux.vnet.ibm.com>
References: <54174D36.4000002@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 2014-09-15 at 15:33 -0500, Nathan Fontenot wrote:
> This patch adds the ability to do memory hotplug remove in the kernel.
> 
> Currently the hotplug add/remove of memory is handled by the drmgr
> command. The drmgr command performs the add/remove by performing
> some work in user-space and making requests to the kernel to handle
> other pieces. By moving all of the work to the kernel we can do the
> add and remove faster, and provide a common place to do memory hotplug
> for both the PowerVM and PowerKVM environments.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c |  140 +++++++++++++++++++++++
>  1 file changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index b254773..160c424 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -193,7 +193,137 @@ static int pseries_remove_mem_node(struct device_node *np)
>  	pseries_remove_memblock(base, lmb_size);
>  	return 0;
>  }
> +
> +static int lmb_is_removable(struct of_drconf_cell *lmb)
> +{

Do we not already have something like this?

> +	int i, scns_per_block;
> +	int rc = 1;

I can see this makes the &= work below.

But what if block_sz / MIN_MEMORY_BLOCK_SIZE = 0 ?

> +	unsigned long pfn, block_sz;
> +	u64 phys_addr;
> +
> +	phys_addr = be64_to_cpu(lmb->base_addr);
> +	block_sz = memory_block_size_bytes();
> +	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
> +
> +	for (i = 0; i < scns_per_block; i++) {
> +		pfn = PFN_DOWN(phys_addr);
> +		if (!pfn_present(pfn))
> +			continue;
> +
> +		rc &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
> +		phys_addr += MIN_MEMORY_BLOCK_SIZE;
> +	}
> +
> +	return rc;
> +}

> +static int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
> +{

...

> +}

Most of the same comments as for add.

cheers
