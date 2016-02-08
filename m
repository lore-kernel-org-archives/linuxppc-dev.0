Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A9FE1A0190
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 16:54:32 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 7 Feb 2016 22:54:31 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BEF983E40044
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Feb 2016 22:54:28 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u185sSx617039360
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Feb 2016 22:54:28 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u185sSwG023523
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Feb 2016 22:54:28 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fix Multi hit ERAT cause by recent THP update
In-Reply-To: <20160205214718.GA88280@black.fi.intel.com>
References: <1454695900-9282-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160205214718.GA88280@black.fi.intel.com>
Date: Mon, 08 Feb 2016 11:24:23 +0530
Message-ID: <874mdj21dc.fsf@linux.vnet.ibm.com>
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

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> On Fri, Feb 05, 2016 at 11:41:40PM +0530, Aneesh Kumar K.V wrote:
>> With ppc64 we use the deposted pgtable_t to store the hash pte slot
>> information. We should not withdraw the deposited pgtable_t without
>> marking the pmd none. This ensure that low level hash fault handling
>> will skip this huge pte and we will handle them at upper levels. We
>> do take page table lock there and we can serialize against a parallel
>> THP split there. Hence mark the pte none (ie, remove __PAGE_USER) before
>> splitting the huge pmd.
>> 
>> Also make sure we wait for irq disable section in other cpus to finish
>> before flipping a huge pte entry with a regular pmd entry. Code paths
>> like find_linux_pte_or_hugepte depend on irq disable to get
>> a stable pte_t pointer. A parallel thp split need to make sure we
>> don't convert a pmd pte to a regular pmd entry without waiting for the
>> irq disable section to finish.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Cc list is too short. At least akpm@ and linux-mm@ should be there.
> Probably numa balancing folks.

Will add them in the next iteration.

>
> Have you tested it with CONFIG_NUMA_BALANCING disabled?


yes.


>
> I would expect some additional changes in this area would be required.
> pmd_protnone() is always zero without numa balancing compiled in and
> therefore I don't see where we will get this serialization agians ptl on
> fault side.


I am not really depending on the pmd_protnone definition here. The thing
that I am depending with respect to the core code is that after taking
ptl, all the code path should check for pmd using pmd_same. If found not
matching they should force a retry. All code path within pmd_trans_huge()
check seem to do so. 

>
>> ---
>>  arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++++
>>  arch/powerpc/mm/pgtable_64.c                 | 36 +++++++++++++++++++++++++++-
>>  include/asm-generic/pgtable.h                |  8 +++++++
>>  mm/huge_memory.c                             |  1 +
>>  4 files changed, 48 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index 8d1c41d28318..0415856941e0 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -281,6 +281,10 @@ extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
>>  extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  			    pmd_t *pmdp);
>>  
>> +#define __HAVE_ARCH_PMDP_HUGE_SPLITTING_FLUSH
>> +extern void pmdp_huge_splitting_flush(struct vm_area_struct *vma,
>> +				      unsigned long address, pmd_t *pmdp);
>
> I don't really like the name, but cannot think of anything better.


same here. I will keep this as it is for now. ?


>
>> +
>>  #define pmd_move_must_withdraw pmd_move_must_withdraw
>>  struct spinlock;
>>  static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
>> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
>> index 3124a20d0fab..d80a23a92f95 100644
>> --- a/arch/powerpc/mm/pgtable_64.c
>> +++ b/arch/powerpc/mm/pgtable_64.c
>> @@ -646,6 +646,31 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>>  	return pgtable;
>>  }

-aneesh
