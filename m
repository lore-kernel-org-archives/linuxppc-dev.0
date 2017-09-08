Return-Path: <srs0=lous=aj=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpNR772dFzDrYp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 13:41:39 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xpNR72d3Kz8tNJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 13:41:39 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xpNR42tjYz9t2Q
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2017 13:41:35 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v883dYL0126614
 for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2017 23:41:33 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cuc9mum4q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Sep 2017 23:41:33 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 8 Sep 2017 13:41:30 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v883fSSI41943234
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Sep 2017 13:41:28 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v883fRHd023467
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Sep 2017 13:41:28 +1000
Subject: Re: [rfc 2/3] powerpc/mce: Extract physical_address for UE errors
To: Balbir Singh <bsingharora@gmail.com>, npiggin@gmail.com,
 alistair@popple.id.au
Cc: linuxppc-dev@ozlabs.org
References: <20170905041555.27696-1-bsingharora@gmail.com>
 <20170905041555.27696-3-bsingharora@gmail.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 8 Sep 2017 09:11:24 +0530
MIME-Version: 1.0
In-Reply-To: <20170905041555.27696-3-bsingharora@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <910bf7a9-a7e1-9f26-2f63-88578bed72a6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/05/2017 09:45 AM, Balbir Singh wrote:
> Walk the page table for NIP and extract the instruction. Then
> use the instruction to find the effective address via analyse_instr().
> 
> We might have page table walking races, but we expect them to
> be rare, the physical address extraction is best effort. The idea
> is to then hook up this infrastructure to memory failure eventually.
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
> +			}
> +		}
>  		found = 1;
>  	}
> 
> @@ -592,19 +642,19 @@ static long mce_handle_error(struct pt_regs *regs,
>  		const struct mce_ierror_table itable[])
>  {
>  	struct mce_error_info mce_err = { 0 };
> -	uint64_t addr;
> +	uint64_t addr, phys_addr;

You may want to initialize phys_addr with ULONG_MAX.

>  	uint64_t srr1 = regs->msr;
>  	long handled;
> 
>  	if (SRR1_MC_LOADSTORE(srr1))
> -		handled = mce_handle_derror(regs, dtable, &mce_err, &addr);
> +		handled = mce_handle_derror(regs, dtable, &mce_err, &addr, &phys_addr);
>  	else
>  		handled = mce_handle_ierror(regs, itable, &mce_err, &addr);
> 
>  	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
>  		handled = mce_handle_ue_error(regs);
> 
> -	save_mce_event(regs, handled, &mce_err, regs->nip, addr);
> +	save_mce_event(regs, handled, &mce_err, regs->nip, addr, phys_addr);
> 
>  	return handled;
>  }
> 

Thanks,
-Mahesh.
