Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81D4E67CEC
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:23:26 +1100 (EST)
Date: Wed, 15 Nov 2006 19:23:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 2/5] [POWERPC] 8xx: generic 8xx code arch/powerpc port
Message-ID: <20061115182316.GA20719@lst.de>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012816.17455.12059.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061114012816.17455.12059.stgit@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 14, 2006 at 04:28:16AM +0300, Vitaly Bordug wrote:
> --- /dev/null
> +++ b/arch/powerpc/kernel/dma-mapping.c

Can we please give this a more descriptive name? MIPS names the
equivalent dma-noncoherent.c which makes a lot of sense to me.

> +#include <linux/module.h>
> +#include <linux/signal.h>
> +#include <linux/sched.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/ptrace.h>
> +#include <linux/mman.h>
> +#include <linux/mm.h>
> +#include <linux/swap.h>
> +#include <linux/stddef.h>
> +#include <linux/vmalloc.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/bootmem.h>
> +#include <linux/highmem.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/hardirq.h>
> +
> +#include <asm/pgalloc.h>
> +#include <asm/prom.h>
> +#include <asm/io.h>
> +#include <asm/mmu_context.h>
> +#include <asm/pgtable.h>
> +#include <asm/mmu.h>
> +#include <asm/uaccess.h>
> +#include <asm/smp.h>
> +#include <asm/machdep.h>

Do you really need all these headers?

> +int map_page(unsigned long va, phys_addr_t pa, int flags);

this one doesn't seem to be used ever.  And even if it was a non-static
forward-declaration in a .c is not something we'd want.

> +/*
> + * VM region handling support.
> + *
> + * This should become something generic, handling VM region allocations for
> + * vmalloc and similar (ioremap, module space, etc).
> + *
> + * I envisage vmalloc()'s supporting vm_struct becoming:
> + *
> + *  struct vm_struct {
> + *    struct vm_region	region;
> + *    unsigned long	flags;
> + *    struct page	**pages;
> + *    unsigned int	nr_pages;
> + *    unsigned long	phys_addr;
> + *  };
> + *
> + * get_vm_area() would then call vm_region_alloc with an appropriate
> + * struct vm_region head (eg):
> + *
> + *  struct vm_region vmalloc_head = {
> + *	.vm_list	= LIST_HEAD_INIT(vmalloc_head.vm_list),
> + *	.vm_start	= VMALLOC_START,
> + *	.vm_end		= VMALLOC_END,
> + *  };
> + *
> + * However, vmalloc_head.vm_start is variable (typically, it is dependent on
> + * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
> + * would have to initialise this each time prior to calling vm_region_alloc(

Yeah, I suspect you should do that instead of adding another copy of
a copy of core VM code..

Btw, is there anything ppc-specific in the noncoherent dma code?
It might be a good idea to put it into lib/ otherwise, I'll contribute
a dma-coherent.c for simple architectures for there aswell..

> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -447,3 +447,102 @@ void bad_page_fault(struct pt_regs *regs
>  
>  	die("Kernel access of bad area", regs, sig);
>  }
> +
> +#ifdef CONFIG_8xx
> +

Can we put this functions into a separate file instea of an
ifdefed section

> +/* The pgtable.h claims some functions generically exist, but I
> + * can't find them......
> + */
> +pte_t *va_to_pte(unsigned long address)
> +{
> +	pgd_t *dir;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	if (address < TASK_SIZE)
> +		return NULL;
> +
> +	dir = pgd_offset(&init_mm, address);
> +	if (dir) {
> +		pmd = pmd_offset(dir, address & PAGE_MASK);
> +		if (pmd && pmd_present(*pmd)) {
> +			pte = pte_offset_kernel(pmd, address & PAGE_MASK);
> +			if (pte && pte_present(*pte))
> +				return(pte);
> +		}
> +	}
> +	return NULL;
> +}

But wha do you need this for anyway?  It's not used anywhere currently,
and it's not 8xx-specific at all?

> +unsigned long va_to_phys(unsigned long address)
> +{
> +	pte_t *pte;
> +
> +	pte = va_to_pte(address);
> +	if (pte)
> +		return(((unsigned long)(pte_val(*pte)) & PAGE_MASK) | (address & ~(PAGE_MASK)));
> +	return (0);
> +}

Shouldn't you use virt_to_phys instead?

Also for the last two I'd prefer if you'd find a way to avoid adding
them.
