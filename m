Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxk4b00kTzDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:20:45 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u62so3961622pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 04:20:45 -0700 (PDT)
Message-ID: <1498562395.7935.13.camel@gmail.com>
Subject: Re: [PATCH v4 1/9] powerpc/lib/code-patching: Use alternate map for
 patch_instruction()
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org,  mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org
Date: Tue, 27 Jun 2017 21:19:55 +1000
In-Reply-To: <c83c773d-1dc0-b55e-6537-5841891b6098@c-s.fr>
References: <20170627074903.19324-1-bsingharora@gmail.com>
 <20170627074903.19324-2-bsingharora@gmail.com>
 <c83c773d-1dc0-b55e-6537-5841891b6098@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-27 at 10:32 +0200, Christophe LEROY wrote:
> 
> Le 27/06/2017 à 09:48, Balbir Singh a écrit :
> > This patch creates the window using text_poke_area, allocated
> > via get_vm_area(). text_poke_area is per CPU to avoid locking.
> > text_poke_area for each cpu is setup using late_initcall, prior
> > to setup of these alternate mapping areas, we continue to use
> > direct write to change/modify kernel text. With the ability
> > to use alternate mappings to write to kernel text, it provides
> > us the freedom to then turn text read-only and implement
> > CONFIG_STRICT_KERNEL_RWX.
> > 
> > This code is CPU hotplug aware to ensure that the we have mappings
> > for any new cpus as they come online and tear down mappings for
> > any cpus that are offline.
> > 
> > Other arches do similar things, but use fixmaps. The reason
> > for not using fixmaps is to make use of any randomization in
> > the future.
> > 
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> > ---
> >   arch/powerpc/lib/code-patching.c | 160 ++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 156 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> > index 500b0f6..19b8368 100644
> > --- a/arch/powerpc/lib/code-patching.c
> > +++ b/arch/powerpc/lib/code-patching.c
> > @@ -12,23 +12,172 @@
> >   #include <linux/vmalloc.h>
> >   #include <linux/init.h>
> >   #include <linux/mm.h>
> > -#include <asm/page.h>
> > -#include <asm/code-patching.h>
> > +#include <linux/cpuhotplug.h>
> > +#include <linux/slab.h>
> >   #include <linux/uaccess.h>
> >   #include <linux/kprobes.h>
> >   
> > +#include <asm/pgtable.h>
> > +#include <asm/tlbflush.h>
> > +#include <asm/page.h>
> > +#include <asm/code-patching.h>
> >   
> > -int patch_instruction(unsigned int *addr, unsigned int instr)
> > +static int __patch_instruction(unsigned int *addr, unsigned int instr)
> >   {
> >   	int err;
> >   
> >   	__put_user_size(instr, addr, 4, err);
> >   	if (err)
> >   		return err;
> > -	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (addr));
> > +	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (addr));
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_STRICT_KERNEL_RWX
> > +static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
> > +
> > +static int text_area_cpu_up(unsigned int cpu)
> > +{
> > +	struct vm_struct *area;
> > +
> > +	area = get_vm_area(PAGE_SIZE, VM_ALLOC);
> > +	if (!area) {
> > +		WARN_ONCE(1, "Failed to create text area for cpu %d\n",
> > +			cpu);
> > +		return -1;
> > +	}
> > +	this_cpu_write(text_poke_area, area);
> > +	return 0;
> > +}
> > +
> > +static int text_area_cpu_down(unsigned int cpu)
> > +{
> > +	free_vm_area(this_cpu_read(text_poke_area));
> > +	return 0;
> > +}
> > +
> > +/*
> > + * This is an early_initcall and early_initcalls happen at the right time
> > + * for us, after slab is enabled and before we mark ro pages R/O. In the
> > + * future if get_vm_area is randomized, this will be more flexible than
> > + * fixmap
> > + */
> > +static int __init setup_text_poke_area(void)
> > +{
> > +	BUG_ON(!cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +		"powerpc/text_poke:online", text_area_cpu_up,
> > +		text_area_cpu_down));
> > +
> > +	pr_info("text_poke area ready...\n");
> > +	return 0;
> > +}
> > +
> > +/*
> > + * This can be called for kernel text or a module.
> > + */
> > +static int map_patch_area(void *addr, unsigned long text_poke_addr)
> > +{
> > +	unsigned long pfn;
> > +	int err;
> > +
> > +	if (is_vmalloc_addr(addr))
> > +		pfn = vmalloc_to_pfn(addr);
> > +	else
> > +		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
> > +
> > +	err = map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT),
> > +				pgprot_val(PAGE_KERNEL));
> > +	pr_devel("Mapped addr %lx with pfn %lx:%d\n", text_poke_addr, pfn, err);
> > +	if (err)
> > +		return -1;
> > +	return 0;
> > +}
> > +
> > +static inline int unmap_patch_area(unsigned long addr)
> > +{
> > +	pte_t *ptep;
> > +	pmd_t *pmdp;
> > +	pud_t *pudp;
> > +	pgd_t *pgdp;
> > +
> > +	pgdp = pgd_offset_k(addr);
> > +	if (unlikely(!pgdp))
> > +		return -EINVAL;
> > +	pudp = pud_offset(pgdp, addr);
> > +	if (unlikely(!pudp))
> > +		return -EINVAL;
> > +	pmdp = pmd_offset(pudp, addr);
> > +	if (unlikely(!pmdp))
> > +		return -EINVAL;
> > +	ptep = pte_offset_kernel(pmdp, addr);
> > +	if (unlikely(!ptep))
> > +		return -EINVAL;
> > +
> > +	pr_devel("clearing mm %p, pte %p, addr %lx\n", &init_mm, ptep, addr);
> > +	/*
> > +	 * In hash, pte_clear flushes the tlb, in radix, we have to
> > +	 */
> > +	pte_clear(&init_mm, addr, ptep);
> > +	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> >   	return 0;
> >   }
> >   
> > +int patch_instruction(unsigned int *addr, unsigned int instr)
> > +{
> > +	int err;
> > +	unsigned int *dest = NULL;
> > +	unsigned long flags;
> > +	unsigned long text_poke_addr;
> > +	unsigned long kaddr = (unsigned long)addr;
> > +
> > +	/*
> > +	 * During early early boot patch_instruction is called
> > +	 * when text_poke_area is not ready, but we still need
> > +	 * to allow patching. We just do the plain old patching
> > +	 * We use slab_is_available and per cpu read * via this_cpu_read
> > +	 * of text_poke_area. Per-CPU areas might not be up early
> > +	 * this can create problems with just using this_cpu_read()
> > +	 */
> > +	if (!slab_is_available() || !this_cpu_read(text_poke_area))
> > +		return __patch_instruction(addr, instr);
> > +
> > +	local_irq_save(flags);
> > +
> > +	text_poke_addr = (unsigned long)__this_cpu_read(text_poke_area)->addr;
> > +	if (map_patch_area(addr, text_poke_addr)) {
> > +		err = -1;
> > +		goto out;
> > +	}
> > +
> > +	dest = (unsigned int *)(text_poke_addr) +
> > +			((kaddr & ~PAGE_MASK) / sizeof(unsigned int));
> > +
> > +	/*
> > +	 * We use __put_user_size so that we can handle faults while
> > +	 * writing to dest and return err to handle faults gracefully
> > +	 */
> > +	__put_user_size(instr, dest, 4, err);
> > +	if (!err)
> > +		asm ("dcbst 0, %0; sync; icbi 0,%0; icbi 0,%1; sync; isync"
> > +			::"r" (dest), "r"(addr));
> > +	err = unmap_patch_area(text_poke_addr);
> > +	if (err)
> > +		pr_warn("failed to unmap %lx\n", text_poke_addr);
> > +out:
> > +	local_irq_restore(flags);
> > +	return err;
> > +}
> > +
> > +#else /* !CONFIG_STRICT_KERNEL_RWX */
> > +
> > +int patch_instruction(unsigned int *addr, unsigned int instr)
> > +{
> > +	return __patch_instruction(addr, instr);
> > +}
>

It does get inlined, but I'll double check.

Balbir Singh. 
