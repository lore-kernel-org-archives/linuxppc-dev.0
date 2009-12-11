Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FA96B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 09:13:26 +1100 (EST)
Subject: Re: [RFC PATCH v2 3/4] powerpc: allow ioremap within reserved
	memory regions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1260297833-17625-4-git-send-email-albert_herranz@yahoo.es>
References: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>
	<1260297833-17625-4-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 09:13:20 +1100
Message-ID: <1260569600.16132.375.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-08 at 19:43 +0100, Albert Herranz wrote:
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> v1 -> v2
> - use a run-time flag to allow/disallow remapping reserved regions
> - use lmbs to determine reserved regions

We won't need that once we fix proper discontig mem.

BTW. Question: Why do we need that fixup of yours to fold the 2 LMBs
into one ?

Wouldn't it be easier just to keep the 2 LMBs ? You already fix the
mapin_ram thingy, so you could easily fix it up to just iterate over the
LMBs instead no ? For now, it could only BAT map the first LMB to
simplify things and we can fix the BAT mapping for the second one in a
second step too.

Wouldn't that work with simpler code ? An in the case of ioremap, the
test becomes simply to check if it's RAM by checking if it's in the LMB
rather than if it's reserved, which should be easier and wouldn't
require your flag to "enable" the tweak since it could perfectly be kept
as standard behaviour

Also the code in arch/powerpc/mm/mem.c will already deal with holes
just fine and will pass the hole size information to the VM which should
make it behave properly.

Thus I have the feeling that keeping the 2 LMBs rather than coalescing
would simplify the code basically by only requiring a small fixup of the
maping RAM bit.

I'm acking the patches for now, so you can always come up with a fixup
on top of them and we can merge the current ones.


>  arch/powerpc/mm/init_32.c    |    5 +++++
>  arch/powerpc/mm/mmu_decl.h   |    1 +
>  arch/powerpc/mm/pgtable_32.c |    4 +++-
>  include/linux/lmb.h          |    1 +
>  lib/lmb.c                    |    7 ++++++-
>  5 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index 703c7c2..4ec900a 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -82,6 +82,11 @@ extern struct task_struct *current_set[NR_CPUS];
>  int __map_without_bats;
>  int __map_without_ltlbs;
>  
> +/*
> + * This tells the system to allow ioremapping memory marked as reserved.
> + */
> +int __allow_ioremap_reserved;
> +
>  /* max amount of low RAM to map in */
>  unsigned long __max_low_memory = MAX_LOW_MEM;
>  
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index 9aa39fe..34dacc3 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -115,6 +115,7 @@ extern void settlbcam(int index, unsigned long virt, phys_addr_t phys,
>  extern void invalidate_tlbcam_entry(int index);
>  
>  extern int __map_without_bats;
> +extern int __allow_ioremap_reserved;
>  extern unsigned long ioremap_base;
>  extern unsigned int rtas_data, rtas_size;
>  
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index b55bbe8..177e403 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -26,6 +26,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/init.h>
>  #include <linux/highmem.h>
> +#include <linux/lmb.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -191,7 +192,8 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
>  	 * Don't allow anybody to remap normal RAM that we're using.
>  	 * mem_init() sets high_memory so only do the check after that.
>  	 */
> -	if (mem_init_done && (p < virt_to_phys(high_memory))) {
> +	if (mem_init_done && (p < virt_to_phys(high_memory)) &&
> +	    !(__allow_ioremap_reserved && lmb_is_region_reserved(p, size))) {
>  		printk("__ioremap(): phys addr 0x%llx is RAM lr %p\n",
>  		       (unsigned long long)p, __builtin_return_address(0));
>  		return NULL;
> diff --git a/include/linux/lmb.h b/include/linux/lmb.h
> index 2442e3f..ef82b8f 100644
> --- a/include/linux/lmb.h
> +++ b/include/linux/lmb.h
> @@ -54,6 +54,7 @@ extern u64 __init lmb_phys_mem_size(void);
>  extern u64 lmb_end_of_DRAM(void);
>  extern void __init lmb_enforce_memory_limit(u64 memory_limit);
>  extern int __init lmb_is_reserved(u64 addr);
> +extern int lmb_is_region_reserved(u64 base, u64 size);
>  extern int lmb_find(struct lmb_property *res);
>  
>  extern void lmb_dump_all(void);
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 0343c05..9cee171 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -263,7 +263,7 @@ long __init lmb_reserve(u64 base, u64 size)
>  	return lmb_add_region(_rgn, base, size);
>  }
>  
> -long __init lmb_overlaps_region(struct lmb_region *rgn, u64 base, u64 size)
> +long lmb_overlaps_region(struct lmb_region *rgn, u64 base, u64 size)
>  {
>  	unsigned long i;
>  
> @@ -493,6 +493,11 @@ int __init lmb_is_reserved(u64 addr)
>  	return 0;
>  }
>  
> +int lmb_is_region_reserved(u64 base, u64 size)
> +{
> +	return lmb_overlaps_region(&lmb.reserved, base, size);
> +}
> +
>  /*
>   * Given a <base, len>, find which memory regions belong to this range.
>   * Adjust the request and return a contiguous chunk.
