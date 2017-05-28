Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbPhh1Dw5zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 02:00:04 +1000 (AEST)
Subject: Re: [PATCH v1 1/8] powerpc/lib/code-patching: Enhance code patching
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525033650.10891-2-bsingharora@gmail.com>
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 paulus@samba.org, rashmica.g@gmail.com
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <72ff9a8a-dad8-55f3-01b0-29b24298bed0@c-s.fr>
Date: Sun, 28 May 2017 17:59:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170525033650.10891-2-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/05/2017 à 05:36, Balbir Singh a écrit :
> Today our patching happens via direct copy and
> patch_instruction. The patching code is well
> contained in the sense that copying bits are limited.
>
> While considering implementation of CONFIG_STRICT_RWX,
> the first requirement is to a create another mapping
> that will allow for patching. We create the window using
> text_poke_area, allocated via get_vm_area(), which might
> be an overkill. We can do per-cpu stuff as well. The
> downside of these patches that patch_instruction is
> now synchornized using a lock. Other arches do similar
> things, but use fixmaps. The reason for not using
> fixmaps is to make use of any randomization in the
> future. The code also relies on set_pte_at and pte_clear
> to do the appropriate tlb flushing.

Isn't it overkill to remap the text in another area ?

Among the 6 arches implementing CONFIG_STRICT_KERNEL_RWX (arm, arm64, 
parisc, s390, x86/32, x86/64):
- arm, x86/32 and x86/64 set text RW during the modification
- s390 seems to uses a special instruction which bypassed write protection
- parisc doesn't seem to implement any function which modifies kernel text.

Therefore it seems only arm64 does it via another mapping.
Wouldn't it be lighter to just unprotect memory during the modification 
as done on arm and x86 ?

Or another alternative could be to disable DMMU and do the write at 
physical address ?

Christophe

>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/lib/code-patching.c | 88 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 84 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 500b0f6..0a16b2f 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -16,19 +16,98 @@
>  #include <asm/code-patching.h>
>  #include <linux/uaccess.h>
>  #include <linux/kprobes.h>
> +#include <asm/pgtable.h>
> +#include <asm/tlbflush.h>
>
> +struct vm_struct *text_poke_area;
> +static DEFINE_RAW_SPINLOCK(text_poke_lock);
>
> -int patch_instruction(unsigned int *addr, unsigned int instr)
> +/*
> + * This is an early_initcall and early_initcalls happen at the right time
> + * for us, after slab is enabled and before we mark ro pages R/O. In the
> + * future if get_vm_area is randomized, this will be more flexible than
> + * fixmap
> + */
> +static int __init setup_text_poke_area(void)
>  {
> +	text_poke_area = get_vm_area(PAGE_SIZE, VM_ALLOC);
> +	if (!text_poke_area) {
> +		WARN_ONCE(1, "could not create area for mapping kernel addrs"
> +				" which allow for patching kernel code\n");
> +		return 0;
> +	}
> +	pr_info("text_poke area ready...\n");
> +	raw_spin_lock_init(&text_poke_lock);
> +	return 0;
> +}
> +
> +/*
> + * This can be called for kernel text or a module.
> + */
> +static int kernel_map_addr(void *addr)
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
> +	err = map_kernel_page((unsigned long)text_poke_area->addr,
> +			(pfn << PAGE_SHIFT), _PAGE_KERNEL_RW | _PAGE_PRESENT);
> +	pr_devel("Mapped addr %p with pfn %lx\n", text_poke_area->addr, pfn);
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
> +	pr_devel("clearing mm %p, pte %p, kaddr %lx\n", &init_mm, pte, kaddr);
> +	pte_clear(&init_mm, kaddr, pte);
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
> +	 * During early early boot patch_instruction is called
> +	 * when text_poke_area is not ready, but we still need
> +	 * to allow patching. We just do the plain old patching
> +	 */
> +	if (!text_poke_area) {
> +		__put_user_size(instr, addr, 4, err);
> +		asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (addr));
> +		return 0;
> +	}
> +
> +	raw_spin_lock_irqsave(&text_poke_lock, flags);
> +	if (kernel_map_addr(addr)) {
> +		err = -1;
> +		goto out;
> +	}
> +
> +	dest = (unsigned int *)(text_poke_area->addr) +
> +		((kaddr & ~PAGE_MASK) / sizeof(unsigned int));
> +	__put_user_size(instr, dest, 4, err);
> +	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (dest));
> +	kernel_unmap_addr(text_poke_area->addr);
> +out:
> +	raw_spin_unlock_irqrestore(&text_poke_lock, flags);
> +	return err;
> +}
> +NOKPROBE_SYMBOL(patch_instruction);
> +
>  int patch_branch(unsigned int *addr, unsigned long target, int flags)
>  {
>  	return patch_instruction(addr, create_branch(addr, target, flags));
> @@ -514,3 +593,4 @@ static int __init test_code_patching(void)
>  late_initcall(test_code_patching);
>
>  #endif /* CONFIG_CODE_PATCHING_SELFTEST */
> +early_initcall(setup_text_poke_area);
>

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
