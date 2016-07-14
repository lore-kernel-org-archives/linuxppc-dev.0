Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqvGH6VCDzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 21:52:53 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g202so4728757pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 04:52:53 -0700 (PDT)
Subject: Re: [PATCH kernel] powerpc/mm/iommu: Put pages on process exit
To: Balbir Singh <bsingharora@gmail.com>
References: <1468473379-36602-1-git-send-email-aik@ozlabs.ru>
 <CAKTCnzkff8GDP3ZZOEETkVC4sYEnrN6z0B2aLvc3mbF-UViJKg@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Gibson <david@gibson.dropbear.id.au>, Nick Piggin <npiggin@kernel.dk>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1af23846-c25c-6791-9224-82a4b1cfb496@ozlabs.ru>
Date: Thu, 14 Jul 2016 21:52:43 +1000
MIME-Version: 1.0
In-Reply-To: <CAKTCnzkff8GDP3ZZOEETkVC4sYEnrN6z0B2aLvc3mbF-UViJKg@mail.gmail.com>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/07/16 20:12, Balbir Singh wrote:
> On Thu, Jul 14, 2016 at 3:16 PM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>> At the moment VFIO IOMMU SPAPR v2 driver pins all guest RAM pages when
>> the userspace starts using VFIO. When the userspace process finishes,
>> all the pinned pages need to be put; this is done as a part of
>> the userspace memory context (MM) destruction which happens on
>> the very last mmdrop().
>>
>> This approach has a problem that a MM of the userspace process
>> may live longer than the userspace process itself as kernel threads
>> usually execute on a MM of a userspace process which was runnning
>> on a CPU where the kernel thread was scheduled to. If this happened,
>> the MM remains referenced until this exact kernel thread wakes up again
>> and releases the very last reference to the MM, on an idle system this
>> can take even hours.
>>
>> This fixes the issue by moving mm_iommu_cleanup() (the helper which puts
>> pages) from destroy_context() (called on the last mmdrop()) to
>> the arch-specific arch_exit_mmap() hook (called on the last mmput()).
>> mmdrop() decrements the mm->mm_count which is a total reference number;
>> mmput() decrements the mm->mm_users which is a number of user spaces and
>> this is actually the counter we want to watch for here.
>>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> Cc: Nick Piggin <npiggin@kernel.dk>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/include/asm/mmu_context.h | 3 +++
>>  arch/powerpc/mm/mmu_context_book3s64.c | 4 ----
>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
>> index 9d2cd0c..24b590d 100644
>> --- a/arch/powerpc/include/asm/mmu_context.h
>> +++ b/arch/powerpc/include/asm/mmu_context.h
>> @@ -138,6 +138,9 @@ static inline void arch_dup_mmap(struct mm_struct *oldmm,
>>
>>  static inline void arch_exit_mmap(struct mm_struct *mm)
>>  {
>> +#ifdef CONFIG_SPAPR_TCE_IOMMU
>> +       mm_iommu_cleanup(&mm->context);
>> +#endif
>>  }
>>
> 
> The assumption is that all necessary tear down has happened. Earlier
> we were doing the teardown
> on the last mm ref drop, do we have any dependence on that? I don't
> think so, but just checking
> 
> Does qemu dotce_iommu_register_pages on exit()/atexit() or do we rely
> on the exit path to do the teardown?

QEMU does call unregister when a memory region is deleted. Handling it in
arch_exit_mmap() is for the case when a QEMU process just dies for whatever
reason.

> Can we please remove the #ifdef CONFIG_SPAPR_TCE_IOMMU here and have a version
> of mm_iommu_cleanup that handles it


That would be a change unrelated to the fix. And I just do not see the
point in this - mm_iommu_cleanup() is declared in the very same header.


> Basically do
> 
> #ifdef CONFIG_SPAPR_TCE_IOMMU
> extern void mm_iommu_cleanup(void *ptr)
> #else
> static inline mm_iommu_cleanup(void *ptr) {}
> #endif
> 
> Otherwise looks good
> 
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Thanks!


-- 
Alexey
