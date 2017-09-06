Return-Path: <srs0=f3gt=ah=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xn9m55JGdzDrJL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 14:37:09 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xn9m53R9Pz8t37
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 14:37:09 +1000 (AEST)
Received: from mail-vk0-x22d.google.com (mail-vk0-x22d.google.com
 [IPv6:2607:f8b0:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xn9m46FwFz9sNV
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2017 14:37:08 +1000 (AEST)
Received: by mail-vk0-x22d.google.com with SMTP id x85so10172623vkx.5
 for <linuxppc-dev@ozlabs.org>; Tue, 05 Sep 2017 21:37:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906103621.092395dd@roar.ozlabs.ibm.com>
References: <20170905041555.27696-1-bsingharora@gmail.com>
 <20170905041555.27696-3-bsingharora@gmail.com>
 <20170906103621.092395dd@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 6 Sep 2017 14:37:05 +1000
Message-ID: <CAKTCnzmWiNgW1Q8A6S30=gTn-EuLQYVBneXX9MKHQOH+n8buAg@mail.gmail.com>
Subject: Re: [rfc 2/3] powerpc/mce: Extract physical_address for UE errors
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 6, 2017 at 10:36 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Tue,  5 Sep 2017 14:15:54 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> Walk the page table for NIP and extract the instruction. Then
>> use the instruction to find the effective address via analyse_instr().
>>
>> We might have page table walking races, but we expect them to
>> be rare, the physical address extraction is best effort. The idea
>> is to then hook up this infrastructure to memory failure eventually.
>
> Cool. Too bad hardware doesn't give us the RA.
>
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>>  arch/powerpc/include/asm/mce.h  |  2 +-
>>  arch/powerpc/kernel/mce.c       |  6 ++++-
>>  arch/powerpc/kernel/mce_power.c | 60 +++++++++++++++++++++++++++++++++++++----
>>  3 files changed, 61 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
>> index 75292c7..3a1226e 100644
>> --- a/arch/powerpc/include/asm/mce.h
>> +++ b/arch/powerpc/include/asm/mce.h
>> @@ -204,7 +204,7 @@ struct mce_error_info {
>>
>>  extern void save_mce_event(struct pt_regs *regs, long handled,
>>                          struct mce_error_info *mce_err, uint64_t nip,
>> -                        uint64_t addr);
>> +                        uint64_t addr, uint64_t phys_addr);
>>  extern int get_mce_event(struct machine_check_event *mce, bool release);
>>  extern void release_mce_event(void);
>>  extern void machine_check_queue_event(void);
>> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
>> index e254399..f41a75d 100644
>> --- a/arch/powerpc/kernel/mce.c
>> +++ b/arch/powerpc/kernel/mce.c
>> @@ -82,7 +82,7 @@ static void mce_set_error_info(struct machine_check_event *mce,
>>   */
>>  void save_mce_event(struct pt_regs *regs, long handled,
>>                   struct mce_error_info *mce_err,
>> -                 uint64_t nip, uint64_t addr)
>> +                 uint64_t nip, uint64_t addr, uint64_t phys_addr)
>>  {
>>       int index = __this_cpu_inc_return(mce_nest_count) - 1;
>>       struct machine_check_event *mce = this_cpu_ptr(&mce_event[index]);
>> @@ -140,6 +140,10 @@ void save_mce_event(struct pt_regs *regs, long handled,
>>       } else if (mce->error_type == MCE_ERROR_TYPE_UE) {
>>               mce->u.ue_error.effective_address_provided = true;
>>               mce->u.ue_error.effective_address = addr;
>> +             if (phys_addr != ULONG_MAX) {
>> +                     mce->u.ue_error.physical_address_provided = true;
>> +                     mce->u.ue_error.physical_address = phys_addr;
>> +             }
>>       }
>>       return;
>>  }
>> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
>> index b76ca19..b77a698 100644
>> --- a/arch/powerpc/kernel/mce_power.c
>> +++ b/arch/powerpc/kernel/mce_power.c
>> @@ -27,6 +27,25 @@
>>  #include <asm/mmu.h>
>>  #include <asm/mce.h>
>>  #include <asm/machdep.h>
>> +#include <asm/pgtable.h>
>> +#include <asm/pte-walk.h>
>> +#include <asm/sstep.h>
>> +
>> +static unsigned long addr_to_pfn(struct mm_struct *mm, unsigned long addr)
>> +{
>> +     pte_t *ptep;
>> +     unsigned long flags;
>> +
>> +     local_irq_save(flags);
>> +     if (mm == current->mm)
>> +             ptep = find_current_mm_pte(mm->pgd, addr, NULL, NULL);
>> +     else
>> +             ptep = find_init_mm_pte(addr, NULL);
>> +     local_irq_restore(flags);
>> +     if (!ptep)
>> +             return ULONG_MAX;
>> +     return pte_pfn(*ptep);
>
> I think you need to check that it's still cacheable memory here?
> !pte_speical && pfn <= highest_memmap_pfn?
>

find_*pte will return a NULL PTE, so we do have a check there. !pte_special is a
good check to have, I'll add it


>
>> +}
>>
>>  static void flush_tlb_206(unsigned int num_sets, unsigned int action)
>>  {
>> @@ -489,7 +508,8 @@ static int mce_handle_ierror(struct pt_regs *regs,
>>
>>  static int mce_handle_derror(struct pt_regs *regs,
>>               const struct mce_derror_table table[],
>> -             struct mce_error_info *mce_err, uint64_t *addr)
>> +             struct mce_error_info *mce_err, uint64_t *addr,
>> +             uint64_t *phys_addr)
>>  {
>>       uint64_t dsisr = regs->dsisr;
>>       int handled = 0;
>> @@ -555,7 +575,37 @@ static int mce_handle_derror(struct pt_regs *regs,
>>               mce_err->initiator = table[i].initiator;
>>               if (table[i].dar_valid)
>>                       *addr = regs->dar;
>> -
>> +             else if (mce_err->severity == MCE_SEV_ERROR_SYNC &&
>> +                             table[i].error_type == MCE_ERROR_TYPE_UE) {
>> +                     /*
>> +                      * Carefully look at the NIP to determine
>> +                      * the instruction to analyse. Reading the NIP
>> +                      * in real-mode is tricky and can lead to recursive
>> +                      * faults
>> +                      */
>
> What recursive faults? If you ensure NIP is cacheable memory, I guess you
> can get a recursive machine check from reading it, but that's probably
> tolerable.


Yep, just wanted to call it out here.

>
>> +                     int instr;
>> +                     struct mm_struct *mm;
>> +                     unsigned long nip = regs->nip;
>> +                     unsigned long pfn = 0, instr_addr;
>> +                     struct instruction_op op;
>> +                     struct pt_regs tmp = *regs;
>> +
>> +                     if (user_mode(regs))
>> +                             mm = current->mm;
>> +                     else
>> +                             mm = &init_mm;
>> +
>> +                     pfn = addr_to_pfn(mm, nip);
>> +                     if (pfn != ULONG_MAX) {
>> +                             instr_addr = (pfn << PAGE_SHIFT) + (nip & ~PAGE_MASK);
>> +                             instr = *(unsigned int *)(instr_addr);
>> +                             if (!analyse_instr(&op, &tmp, instr)) {
>> +                                     pfn = addr_to_pfn(mm, op.ea);
>> +                                     *addr = op.ea;
>> +                                     *phys_addr = pfn;
>> +                             }
>
> Instruction may no longer be a load/store at this point, right? Or
> instruction or page tables could have changed so this does not point to
> a valid pfn of cacheable memory. memory_failure() has some checks, but
> I wouldn't mind if you put some checks in here so you can enumerate all
> the ways this can go wrong :P

OK.. I'll add a comment or a warning to indicate the error, I suspect at this
point, it means we raced w.r.t pte entry or we had a bad NIP/EA. It could
also mean the opcode was not a load store.

>
> Hopefully after Paulus's instruction analyzer rework you'll be able to
> avoid the pt_regs on stack, but that's probably okay for a backport.
> MCEs have a lot of stack and don't use too much.
>

Yep, I kept it so that it could be backported, but I can change it in
a follow-up
patch

Thanks for the detailed review!

Balbir Singh.
