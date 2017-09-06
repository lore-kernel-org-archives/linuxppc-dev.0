Return-Path: <srs0=nvuf=ah=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xn4Qb3jnvzDrFT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 10:36:39 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xn4QZ45tfz8tS1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 10:36:38 +1000 (AEST)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xn4QZ0fsCz9t3Z
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2017 10:36:37 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id q68so2724200pgq.2
 for <linuxppc-dev@ozlabs.org>; Tue, 05 Sep 2017 17:36:37 -0700 (PDT)
Date: Wed, 6 Sep 2017 10:36:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mahesh@linux.vnet.ibm.com, alistair@popple.id.au,
 linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [rfc 2/3] powerpc/mce: Extract physical_address for UE errors
Message-ID: <20170906103621.092395dd@roar.ozlabs.ibm.com>
In-Reply-To: <20170905041555.27696-3-bsingharora@gmail.com>
References: <20170905041555.27696-1-bsingharora@gmail.com>
 <20170905041555.27696-3-bsingharora@gmail.com>
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

On Tue,  5 Sep 2017 14:15:54 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> Walk the page table for NIP and extract the instruction. Then
> use the instruction to find the effective address via analyse_instr().
> 
> We might have page table walking races, but we expect them to
> be rare, the physical address extraction is best effort. The idea
> is to then hook up this infrastructure to memory failure eventually.

Cool. Too bad hardware doesn't give us the RA.

> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/include/asm/mce.h  |  2 +-
>  arch/powerpc/kernel/mce.c       |  6 ++++-
>  arch/powerpc/kernel/mce_power.c | 60 +++++++++++++++++++++++++++++++++++++----
>  3 files changed, 61 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
> index 75292c7..3a1226e 100644
> --- a/arch/powerpc/include/asm/mce.h
> +++ b/arch/powerpc/include/asm/mce.h
> @@ -204,7 +204,7 @@ struct mce_error_info {
>  
>  extern void save_mce_event(struct pt_regs *regs, long handled,
>  			   struct mce_error_info *mce_err, uint64_t nip,
> -			   uint64_t addr);
> +			   uint64_t addr, uint64_t phys_addr);
>  extern int get_mce_event(struct machine_check_event *mce, bool release);
>  extern void release_mce_event(void);
>  extern void machine_check_queue_event(void);
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index e254399..f41a75d 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -82,7 +82,7 @@ static void mce_set_error_info(struct machine_check_event *mce,
>   */
>  void save_mce_event(struct pt_regs *regs, long handled,
>  		    struct mce_error_info *mce_err,
> -		    uint64_t nip, uint64_t addr)
> +		    uint64_t nip, uint64_t addr, uint64_t phys_addr)
>  {
>  	int index = __this_cpu_inc_return(mce_nest_count) - 1;
>  	struct machine_check_event *mce = this_cpu_ptr(&mce_event[index]);
> @@ -140,6 +140,10 @@ void save_mce_event(struct pt_regs *regs, long handled,
>  	} else if (mce->error_type == MCE_ERROR_TYPE_UE) {
>  		mce->u.ue_error.effective_address_provided = true;
>  		mce->u.ue_error.effective_address = addr;
> +		if (phys_addr != ULONG_MAX) {
> +			mce->u.ue_error.physical_address_provided = true;
> +			mce->u.ue_error.physical_address = phys_addr;
> +		}
>  	}
>  	return;
>  }
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index b76ca19..b77a698 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -27,6 +27,25 @@
>  #include <asm/mmu.h>
>  #include <asm/mce.h>
>  #include <asm/machdep.h>
> +#include <asm/pgtable.h>
> +#include <asm/pte-walk.h>
> +#include <asm/sstep.h>
> +
> +static unsigned long addr_to_pfn(struct mm_struct *mm, unsigned long addr)
> +{
> +	pte_t *ptep;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	if (mm == current->mm)
> +		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
> +	else
> +		ptep = find_init_mm_pte(addr, NULL);
> +	local_irq_restore(flags);
> +	if (!ptep)
> +		return ULONG_MAX;
> +	return pte_pfn(*ptep);

I think you need to check that it's still cacheable memory here?
!pte_speical && pfn <= highest_memmap_pfn?


> +}
>  
>  static void flush_tlb_206(unsigned int num_sets, unsigned int action)
>  {
> @@ -489,7 +508,8 @@ static int mce_handle_ierror(struct pt_regs *regs,
>  
>  static int mce_handle_derror(struct pt_regs *regs,
>  		const struct mce_derror_table table[],
> -		struct mce_error_info *mce_err, uint64_t *addr)
> +		struct mce_error_info *mce_err, uint64_t *addr,
> +		uint64_t *phys_addr)
>  {
>  	uint64_t dsisr = regs->dsisr;
>  	int handled = 0;
> @@ -555,7 +575,37 @@ static int mce_handle_derror(struct pt_regs *regs,
>  		mce_err->initiator = table[i].initiator;
>  		if (table[i].dar_valid)
>  			*addr = regs->dar;
> -
> +		else if (mce_err->severity == MCE_SEV_ERROR_SYNC &&
> +				table[i].error_type == MCE_ERROR_TYPE_UE) {
> +			/*
> +			 * Carefully look at the NIP to determine
> +			 * the instruction to analyse. Reading the NIP
> +			 * in real-mode is tricky and can lead to recursive
> +			 * faults
> +			 */

What recursive faults? If you ensure NIP is cacheable memory, I guess you
can get a recursive machine check from reading it, but that's probably
tolerable.

> +			int instr;
> +			struct mm_struct *mm;
> +			unsigned long nip = regs->nip;
> +			unsigned long pfn = 0, instr_addr;
> +			struct instruction_op op;
> +			struct pt_regs tmp = *regs;
> +
> +			if (user_mode(regs))
> +				mm = current->mm;
> +			else
> +				mm = &init_mm;
> +
> +			pfn = addr_to_pfn(mm, nip);
> +			if (pfn != ULONG_MAX) {
> +				instr_addr = (pfn << PAGE_SHIFT) + (nip & ~PAGE_MASK);
> +				instr = *(unsigned int *)(instr_addr);
> +				if (!analyse_instr(&op, &tmp, instr)) {
> +					pfn = addr_to_pfn(mm, op.ea);
> +					*addr = op.ea;
> +					*phys_addr = pfn;
> +				}

Instruction may no longer be a load/store at this point, right? Or
instruction or page tables could have changed so this does not point to
a valid pfn of cacheable memory. memory_failure() has some checks, but
I wouldn't mind if you put some checks in here so you can enumerate all
the ways this can go wrong :P

Hopefully after Paulus's instruction analyzer rework you'll be able to
avoid the pt_regs on stack, but that's probably okay for a backport.
MCEs have a lot of stack and don't use too much.

Thanks,
Nick
