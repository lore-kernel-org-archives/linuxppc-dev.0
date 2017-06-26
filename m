Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwyd91nCkzDqjs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 15:42:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 1/9] powerpc/lib/code-patching: Enhance code patching
In-Reply-To: <20170606042945.24997-2-bsingharora@gmail.com>
References: <20170606042945.24997-1-bsingharora@gmail.com>
 <20170606042945.24997-2-bsingharora@gmail.com>
Date: Mon, 26 Jun 2017 15:42:52 +1000
Message-ID: <87mv8ve23n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> Today our patching happens via direct copy and
> patch_instruction. The patching code is well
> contained in the sense that copying bits are limited.
>
> While considering implementation of CONFIG_STRICT_RWX,
> the first requirement is to a create another mapping
> that will allow for patching. We create the window using
> text_poke_area, allocated via get_vm_area(), which might
> be an overkill. text_poke_area is per CPU to avoid locking
> Other arches do similar things, but use fixmaps. The reason
> for not using fixmaps is to make use of any randomization in
> the future. The code also relies on set_pte_at and pte_clear
> to do the appropriate tlb flushing.
>
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 500b0f6..c0a0834 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -12,23 +12,154 @@
>  #include <linux/vmalloc.h>
>  #include <linux/init.h>
>  #include <linux/mm.h>
> +#include <linux/cpuhotplug.h>
>  #include <asm/page.h>
>  #include <asm/code-patching.h>
>  #include <linux/uaccess.h>
>  #include <linux/kprobes.h>
> +#include <asm/pgtable.h>
> +#include <asm/tlbflush.h>
>  
> +static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
> +static unsigned int text_area_patch_avail;

All of this should be under #ifdef STRICT_RWX. So that when STRICT_RWX=n
we basically use the old code.

> -int patch_instruction(unsigned int *addr, unsigned int instr)
> +static int text_area_cpu_up(unsigned int cpu)
> +{
> +	struct vm_struct *area;
> +
> +	area = get_vm_area(PAGE_SIZE, VM_ALLOC);
> +	if (!area) {
> +		WARN_ONCE(1, "Failed to create text area for cpu %d\n",
> +			cpu);
> +		return -1;

This is good, it will block bringing up a CPU if we can't get the VM
area, which is the safe option.

> +	}
> +	this_cpu_write(text_poke_area, area);
> +	return 0;
> +}
> +
> +static int text_area_cpu_down(unsigned int cpu)
> +{
> +	free_vm_area(this_cpu_read(text_poke_area));
> +	return 0;
> +}
> +
> +/*
> + * This is an early_initcall and early_initcalls happen at the right time
> + * for us, after slab is enabled and before we mark ro pages R/O. In the
> + * future if get_vm_area is randomized, this will be more flexible than
> + * fixmap
> + */
> +static int __init setup_text_poke_area(void)
>  {
> +	struct vm_struct *area;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		area = get_vm_area(PAGE_SIZE, VM_ALLOC);
> +		if (!area) {
> +			WARN_ONCE(1, "Failed to create text area for cpu %d\n",
> +				cpu);
> +			/* Should we disable strict rwx? */
> +			continue;
> +		}
> +		this_cpu_write(text_poke_area, area);
> +	}

So I think skip this.

> +	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +		"powerpc/text_poke:online", text_area_cpu_up,
> +		text_area_cpu_down);

Use the cpuhp_setup_state() version, which will call it on the boot CPU.
And then just BUG_ON() if it fails.

Also switch this to a late_initcall(), so that if we do BUG_ON() it's
nice and late and the kernel is mostly up.

> +	text_area_patch_avail = 1;

Instead of this global flag, we should just check that each CPUs
text_poke_area is non-NULL before using it ...

> +	/*
> +	 * The barrier here ensures the write is visible to
> +	 * patch_instruction()
> +	 */
> +	smp_wmb();
> +	pr_info("text_poke area ready...\n");
> +	return 0;
> +}
> +
> +/*
> + * This can be called for kernel text or a module.
> + */
> +static int kernel_map_addr(void *addr)

map_patch_area() ?

> +{
> +	unsigned long pfn;
>  	int err;
>  
> -	__put_user_size(instr, addr, 4, err);
> +	if (is_vmalloc_addr(addr))
> +		pfn = vmalloc_to_pfn(addr);
> +	else
> +		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
> +

.. in here.

ie.     if (!this_cpu_read(text_poke_area))
		return -Exxx;

> +	err = map_kernel_page(
> +			(unsigned long)__this_cpu_read(text_poke_area)->addr,
> +			(pfn << PAGE_SHIFT), pgprot_val(PAGE_KERNEL));

Use a local or two to make that less gross.

> +	pr_devel("Mapped addr %p with pfn %lx\n",
> +			__this_cpu_read(text_poke_area)->addr, pfn);

err?

>  	if (err)
> -		return err;
> -	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (addr));
> +		return -1;
>  	return 0;
>  }
>  
> +static inline void kernel_unmap_addr(void *addr)
> +{
> +	pte_t *pte;
> +	unsigned long kaddr = (unsigned long)addr;
> +
> +	pte = pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(kaddr),
> +				kaddr), kaddr), kaddr);

This is pretty fragile, I'd rather you checked each level returned
something sane.

> +	pr_devel("clearing mm %p, pte %p, kaddr %lx\n", &init_mm, pte, kaddr);
> +	pte_clear(&init_mm, kaddr, pte);
> +	flush_tlb_kernel_range(kaddr, kaddr + PAGE_SIZE);
> +}
> +
> +int patch_instruction(unsigned int *addr, unsigned int instr)
> +{
> +	int err;
> +	unsigned int *dest = NULL;
> +	unsigned long flags;
> +	unsigned long kaddr = (unsigned long)addr;
> +
> +	/*
> +	 * Make sure we can see any write of text_area_patch_avail
> +	 */
> +	smp_rmb();
> +
> +	/*
> +	 * During early early boot patch_instruction is called
> +	 * when text_poke_area is not ready, but we still need
> +	 * to allow patching. We just do the plain old patching
> +	 * We use text_area_patch_avail, since per cpu read
> +	 * via __this_cpu_read of text_poke_area might not
> +	 * yet be available.
> +	 * TODO: Make text_area_patch_avail per cpu?
> +	 */
> +	if (!text_area_patch_avail) {

This should check for text_poke_area != NULL.

> +		__put_user_size(instr, addr, 4, err);
> +		if (err)
> +			return err;
> +		asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (addr));
> +		return 0;

> +	}
> +
> +	local_irq_save(flags);
> +	if (kernel_map_addr(addr)) {
> +		err = -1;
> +		goto out;
> +	}
> +
> +	dest = (unsigned int *)(__this_cpu_read(text_poke_area)->addr) +
> +		((kaddr & ~PAGE_MASK) / sizeof(unsigned int));

!!!

> +	__put_user_size(instr, dest, 4, err);

Can you just write a comment explaining why we use __put_user() - in
short, so a fault becomes an error return, not a actual crash.

> +	if (!err)
> +		asm ("dcbst 0, %0; sync; icbi 0,%0; icbi 0,%1; sync; isync"
> +			::"r" (dest), "r"(addr));
> +	kernel_unmap_addr(__this_cpu_read(text_poke_area)->addr);
> +out:
> +	local_irq_restore(flags);
> +	return err;
> +}
> +NOKPROBE_SYMBOL(patch_instruction);
> +
>  int patch_branch(unsigned int *addr, unsigned long target, int flags)
>  {
>  	return patch_instruction(addr, create_branch(addr, target, flags));
> @@ -514,3 +645,4 @@ static int __init test_code_patching(void)
>  late_initcall(test_code_patching);
>  
>  #endif /* CONFIG_CODE_PATCHING_SELFTEST */
> +early_initcall(setup_text_poke_area);

As mentioned before, this should be late_initcall().

cheers
