Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AFA06DE0D8
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 01:28:17 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m7MFSAmi022549
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:28:11 -0700 (MST)
Message-Id: <0718A6AE-8C34-4E36-9365-A893285D3D01@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1219349438-21436-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] POWERPC: Change total_memory to phys_addr_t
Date: Fri, 22 Aug 2008 10:26:24 -0500
References: <1219349438-21436-1-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gah, I just noticed that part of this patch is missing - I will  
resubmit as soon as I figure out what the heck happened.

-Becky

On Aug 21, 2008, at 3:10 PM, Becky Bruce wrote:

> Also change consumers of various lmb funcs/arrays that are now
> phys_addr_t to also be phys_addr_t.
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
> arch/powerpc/mm/mem.c |   19 ++++++++++---------
> 1 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 1c93c25..89dc32b 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -75,14 +75,14 @@ static inline pte_t *virt_to_kpte(unsigned long  
> vaddr)
>
> int page_is_ram(unsigned long pfn)
> {
> -	unsigned long paddr = (pfn << PAGE_SHIFT);
> +	phys_addr_t paddr = ((phys_addr_t)pfn << PAGE_SHIFT);
>
> #ifndef CONFIG_PPC64	/* XXX for now */
> 	return paddr < __pa(high_memory);
> #else
> 	int i;
> 	for (i=0; i < lmb.memory.cnt; i++) {
> -		unsigned long base;
> +		phys_addr_t base;
>
> 		base = lmb.memory.region[i].base;
>
> @@ -195,7 +195,8 @@ EXPORT_SYMBOL_GPL(walk_memory_resource);
> void __init do_init_bootmem(void)
> {
> 	unsigned long i;
> -	unsigned long start, bootmap_pages;
> +	phys_addr_t start;
> +	unsigned long bootmap_pages;
> 	unsigned long total_pages;
> 	int boot_mapsize;
>
> @@ -234,8 +235,8 @@ void __init do_init_bootmem(void)
>
> 	/* reserve the sections we're already using */
> 	for (i = 0; i < lmb.reserved.cnt; i++) {
> -		unsigned long addr = lmb.reserved.region[i].base +
> -				     lmb_size_bytes(&lmb.reserved, i) - 1;
> +		phys_addr_t addr = lmb.reserved.region[i].base +
> +			lmb_size_bytes(&lmb.reserved, i) - 1;
> 		if (addr < lowmem_end_addr)
> 			reserve_bootmem(lmb.reserved.region[i].base,
> 					lmb_size_bytes(&lmb.reserved, i),
> @@ -290,7 +291,7 @@ static int __init mark_nonram_nosave(void)
>  */
> void __init paging_init(void)
> {
> -	unsigned long total_ram = lmb_phys_mem_size();
> +	phys_addr_t total_ram = lmb_phys_mem_size();
> 	phys_addr_t top_of_ram = lmb_end_of_DRAM();
> 	unsigned long max_zone_pfns[MAX_NR_ZONES];
>
> @@ -310,10 +311,10 @@ void __init paging_init(void)
> 	kmap_prot = PAGE_KERNEL;
> #endif /* CONFIG_HIGHMEM */
>
> -	printk(KERN_DEBUG "Top of RAM: 0x%llx, Total RAM: 0x%lx\n",
> -	       (unsigned long long)top_of_ram, total_ram);
> +	printk(KERN_DEBUG "Top of RAM: 0x%llx, Total RAM: 0x%llx\n",
> +	       (unsigned long long)top_of_ram, (unsigned long  
> long)total_ram);
> 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
> -	       (long int)((top_of_ram - total_ram) >> 20));
> +	       (unsigned long)((top_of_ram - total_ram) >> 20));
> 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> #ifdef CONFIG_HIGHMEM
> 	max_zone_pfns[ZONE_DMA] = lowmem_end_addr >> PAGE_SHIFT;
> -- 
> 1.5.5.1
