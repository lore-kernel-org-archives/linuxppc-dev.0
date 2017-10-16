Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFn9Z3kDyzDrFv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:36:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v4 3/5] powerpc/mce: Hookup derror (load/store) UE errors
In-Reply-To: <20170929042655.14570-4-bsingharora@gmail.com>
References: <20170929042655.14570-1-bsingharora@gmail.com>
 <20170929042655.14570-4-bsingharora@gmail.com>
Date: Mon, 16 Oct 2017 16:36:02 +1100
Message-ID: <87lgkblkn1.fsf@concordia.ellerman.id.au>
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

> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index b76ca19..0e584d5 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -27,6 +27,36 @@
>  #include <asm/mmu.h>
>  #include <asm/mce.h>
>  #include <asm/machdep.h>
> +#include <asm/pgtable.h>
> +#include <asm/pte-walk.h>
> +#include <asm/sstep.h>
> +#include <asm/exception-64s.h>
> +
> +/*
> + * Convert an address related to an mm to a PFN. NOTE: we are in real
> + * mode, we could potentially race with page table updates.
> + */

That will blow some serious chunks if we're on pseries.

It seems it can't be triggered on pseries at the moment, but only
because of the feature section around the call to
machine_check_handle_early().

We should maybe move the powernv only code in here inside an #ifdef
POWERNV, just for documentation purposes. But we can do that later.

> +static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
> +{
> +	pte_t *ptep;
> +	unsigned long flags;
> +	struct mm_struct *mm;
> +
> +	if (user_mode(regs))
> +		mm = current->mm;
> +	else
> +		mm = &init_mm;
> +
> +	local_irq_save(flags);
> +	if (mm == current->mm)
> +		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
> +	else
> +		ptep = find_init_mm_pte(addr, NULL);
> +	local_irq_restore(flags);
> +	if (!ptep || pte_special(*ptep))
> +		return ULONG_MAX;
> +	return pte_pfn(*ptep);
> +}

cheers
