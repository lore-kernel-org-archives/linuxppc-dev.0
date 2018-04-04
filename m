Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GjNS6CRczF1XC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 09:49:12 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id 91-v6so16478933pld.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 16:49:12 -0700 (PDT)
Date: Thu, 5 Apr 2018 09:49:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
 mpe@ellerman.id.au
Subject: Re: [RESEND 1/3] powerpc/mce: Bug fixes for MCE handling in kernel
 space
Message-ID: <20180405094900.3ce4be8b@roar.ozlabs.ibm.com>
In-Reply-To: <20180404231943.29581-2-bsingharora@gmail.com>
References: <20180404231943.29581-1-bsingharora@gmail.com>
 <20180404231943.29581-2-bsingharora@gmail.com>
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

On Thu,  5 Apr 2018 09:19:41 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> The code currently assumes PAGE_SHIFT as the shift value of
> the pfn, this works correctly (mostly) for user space pages,
> but the correct thing to do is

It would be good to actually explain the problem in the
changelog. I would have thought pte_pfn returns a
PAGE_SIZE based pfn value?

> 
> 1. Extrace the shift value returned via the pte-walk API's

      ^^^ extract?

> 2. Use the shift value to access the instruction address.
> 
> Note, the final physical address still use PAGE_SHIFT for
> computation. handle_ierror() is not modified and handle_derror()
> is modified just for extracting the correct instruction
> address.
> 
> Fixes: ba41e1e1ccb9 ("powerpc/mce: Hookup derror (load/store) UE errors")
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/kernel/mce_power.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index fe6fc63251fe..69c8cc1e8e4f 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -36,7 +36,8 @@
>   * Convert an address related to an mm to a PFN. NOTE: we are in real
>   * mode, we could potentially race with page table updates.
>   */
> -static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
> +static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr,
> +		unsigned int *shift)
>  {
>  	pte_t *ptep;
>  	unsigned long flags;
> @@ -49,9 +50,9 @@ static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
>  
>  	local_irq_save(flags);
>  	if (mm == current->mm)
> -		ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
> +		ptep = find_current_mm_pte(mm->pgd, addr, NULL, shift);
>  	else
> -		ptep = find_init_mm_pte(addr, NULL);
> +		ptep = find_init_mm_pte(addr, shift);
>  	local_irq_restore(flags);
>  	if (!ptep || pte_special(*ptep))
>  		return ULONG_MAX;
> @@ -353,13 +354,14 @@ static int mce_find_instr_ea_and_pfn(struct pt_regs *regs, uint64_t *addr,
>  	unsigned long pfn, instr_addr;
>  	struct instruction_op op;
>  	struct pt_regs tmp = *regs;
> +	unsigned int shift;
>  
> -	pfn = addr_to_pfn(regs, regs->nip);
> +	pfn = addr_to_pfn(regs, regs->nip, &shift);
>  	if (pfn != ULONG_MAX) {
> -		instr_addr = (pfn << PAGE_SHIFT) + (regs->nip & ~PAGE_MASK);
> +		instr_addr = (pfn << shift) + (regs->nip & ((1 << shift) - 1));
>  		instr = *(unsigned int *)(instr_addr);
>  		if (!analyse_instr(&op, &tmp, instr)) {
> -			pfn = addr_to_pfn(regs, op.ea);
> +			pfn = addr_to_pfn(regs, op.ea, &shift);
>  			*addr = op.ea;
>  			*phys_addr = (pfn << PAGE_SHIFT);
>  			return 0;
> @@ -437,7 +439,8 @@ static int mce_handle_ierror(struct pt_regs *regs,
>  				unsigned long pfn;
>  
>  				if (get_paca()->in_mce < MAX_MCE_DEPTH) {
> -					pfn = addr_to_pfn(regs, regs->nip);
> +					pfn = addr_to_pfn(regs, regs->nip,
> +							NULL);
>  					if (pfn != ULONG_MAX) {
>  						*phys_addr =
>  							(pfn << PAGE_SHIFT);
