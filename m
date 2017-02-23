Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTL5g5yl1zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:56:55 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 5so3022588pgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:56:55 -0800 (PST)
Date: Thu, 23 Feb 2017 13:56:35 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Rashmica Gupta <rashmica.g@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, bsingharora@gmail.com, dllehr@us.ibm.com,
 mpe@ellerman.id.au
Subject: Re: [RFC] Remove memory from nodes for memtrace.
Message-ID: <20170223135635.5321dcc5@roar.ozlabs.ibm.com>
In-Reply-To: <20170222213910.5628-1-rashmica.g@gmail.com>
References: <20170222213910.5628-1-rashmica.g@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Feb 2017 08:39:10 +1100
Rashmica Gupta <rashmica.g@gmail.com> wrote:

>  Some powerpc hardware features may want to gain access to a
>  chunk of undisturbed real memory.  This update provides a means to unplug
>  said memory from the kernel with a set of sysfs calls.  By writing an integer
>  containing  the size of memory to be unplugged into
>  /sys/kernel/debug/powerpc/memtrace/enable, the code will remove that much
>  memory from the end of each available chip's memory space. In addition, the
>  means to read out the contents of the unplugged memory is also provided by
>  reading out the /sys/kernel/debug/powerpc/memtrace/<chip-id>/dump file.
> 
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Thanks for picking this up. A few suggestions.

> ---
> Written by Douglas Lehr <dllehr@us.ibm.com>.

You could mention original author in the changelog. I thought Anton
wrote some of it too?


>  arch/powerpc/mm/hash_native_64.c          |  39 +++-
>  arch/powerpc/platforms/powernv/Makefile   |   1 +
>  arch/powerpc/platforms/powernv/memtrace.c | 285 ++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/memtrace.c
> 
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index cc33260..44cc6ce 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -3,7 +3,7 @@
>   *
>   * SMP scalability work:
>   *    Copyright (C) 2001 Anton Blanchard <anton@au.ibm.com>, IBM
> - * 
> + *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
>   * as published by the Free Software Foundation; either version
> @@ -181,7 +181,7 @@ static inline void native_lock_hpte(struct hash_pte *hptep)
>  	while (1) {
>  		if (!test_and_set_bit_lock(HPTE_LOCK_BIT, word))
>  			break;
> -		while(test_bit(HPTE_LOCK_BIT, word))
> +		while (test_bit(HPTE_LOCK_BIT, word))
>  			cpu_relax();
>  	}
>  }
> @@ -208,10 +208,10 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
>  	}
>  
>  	for (i = 0; i < HPTES_PER_GROUP; i++) {
> -		if (! (be64_to_cpu(hptep->v) & HPTE_V_VALID)) {
> +		if (!(be64_to_cpu(hptep->v) & HPTE_V_VALID)) {
>  			/* retry with lock held */
>  			native_lock_hpte(hptep);
> -			if (! (be64_to_cpu(hptep->v) & HPTE_V_VALID))
> +			if (!(be64_to_cpu(hptep->v) & HPTE_V_VALID))
>  				break;
>  			native_unlock_hpte(hptep);

Suggest dropping the whitespace cleanups.


>  		}
> @@ -407,6 +407,36 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
>  	tlbie(vpn, psize, psize, ssize, 0);
>  }
>  
> +/*
> + * Remove a bolted kernel entry. Memory hotplug uses this.
> + *
> + * No need to lock here because we should be the only user.
> + */
> +static int native_hpte_removebolted(unsigned long ea, int psize, int ssize)
> +{
> +	unsigned long vpn;
> +	unsigned long vsid;
> +	long slot;
> +	struct hash_pte *hptep;
> +
> +	vsid = get_kernel_vsid(ea, ssize);
> +	vpn = hpt_vpn(ea, vsid, ssize);
> +
> +	slot = native_hpte_find(vpn, psize, ssize);
> +	if (slot == -1)
> +		return -ENOENT;
> +
> +	hptep = htab_address + slot;
> +
> +	/* Invalidate the hpte */
> +	hptep->v = 0;
> +
> +	/* Invalidate the TLB */
> +	tlbie(vpn, psize, psize, ssize, 0);
> +	return 0;
> +}
> +
> +
>  static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
>  				   int bpsize, int apsize, int ssize, int local)
>  {
> @@ -722,6 +752,7 @@ void __init hpte_init_native(void)
>  	mmu_hash_ops.hpte_invalidate	= native_hpte_invalidate;
>  	mmu_hash_ops.hpte_updatepp	= native_hpte_updatepp;
>  	mmu_hash_ops.hpte_updateboltedpp = native_hpte_updateboltedpp;
> +	mmu_hash_ops.hpte_removebolted = native_hpte_removebolted;

I would submit this as a separate patch. Consider if it should be made
dependent on any CONFIG options (e.g., MEMORY_HOTREMOVE), and Aneesh had
been looking at this too so he could help review it.

>  	mmu_hash_ops.hpte_insert	= native_hpte_insert;
>  	mmu_hash_ops.hpte_remove	= native_hpte_remove;
>  	mmu_hash_ops.hpte_clear_all	= native_hpte_clear;
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index b5d98cb..2026661 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -11,4 +11,5 @@ obj-$(CONFIG_EEH)	+= eeh-powernv.o
>  obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
>  obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
>  obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
> +obj-$(CONFIG_MEMORY_HOTREMOVE)         += memtrace.o
>  obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o

I would make a new Kconfig option for it, for the time being.


> +static int check_memblock_online(struct memory_block *mem, void *arg)
> +{
> +	if (mem->state != MEM_ONLINE)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int change_memblock_state(struct memory_block *mem, void *arg)
> +{
> +	unsigned long state = (unsigned long)arg;
> +
> +	mem->state = state;
> +	return 0;
> +}
> +
> +static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
> +{
> +	u64 end_pfn = start_pfn + nr_pages - 1;
> +
> +	if (walk_memory_range(start_pfn, end_pfn, NULL,
> +	    check_memblock_online))
> +		return false;
> +
> +	walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
> +			  change_memblock_state);
> +
> +	if (offline_pages(start_pfn, nr_pages)) {
> +		walk_memory_range(start_pfn, end_pfn, (void *)MEM_ONLINE,
> +				  change_memblock_state);
> +		return false;
> +	}
> +
> +	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
> +			  change_memblock_state);
> +
> +	/* RCU grace period? */
> +	flush_memory_region((u64)__va(start_pfn << PAGE_SHIFT), nr_pages << PAGE_SHIFT);
> +
> +	remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
> +
> +	return true;
> +}

This is the tricky part. Memory hotplug APIs don't seem well suited for
what we're trying to do... Anyway, do a bit of grepping around for
definitions of some of these calls, and how other code uses them. For
example, remove_memory comment says caller must hold 
lock_device_hotplug() first, so we're missing that at least. I think
that's also needed over the memblock state changes.

We don't need an RCU grace period there AFAICT, because offline_pages
should have us covered.


I haven't looked at memory hotplug enough to know why we're open-coding
the memblock stuff there. It would be nice to just be able to call
memblock_remove() like the pseries hotplug code does.

I *think* it is because hot remove mostly comes from when we know about
an online region of memory and we want to take it down. In this case we
also are trying to discover if those addresses are covered by online
memory. Still, I wonder if there are better memblock APIs to do this
with? Balbir may have a better idea of that?


> +/* XXX FIXME DEBUG CRAP */
> +machine_device_initcall(pseries, memtrace_init);

Can remove that, I think.

Thanks,
Nick
