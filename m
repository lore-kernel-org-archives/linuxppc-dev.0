Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7jXQ5myJzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 15:29:58 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g202so237914pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 22:29:58 -0700 (PDT)
Subject: Re: [PATCH kernel 05/15] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
 <87popnitt9.fsf@concordia.ellerman.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ff83db64-2d77-81db-3228-0e814ee6194e@ozlabs.ru>
Date: Tue, 9 Aug 2016 15:29:52 +1000
MIME-Version: 1.0
In-Reply-To: <87popnitt9.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/08/16 17:00, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> In some situations the userspace memory context may live longer than
>> the userspace process itself so if we need to do proper memory context
>> cleanup, we better cache @mm and use it later when the process is gone
>> (@current or @current->mm are NULL).
>>
>> This changes mm_iommu_xxx API to receive mm_struct instead of using one
>> from @current.
>>
>> This is needed by the following patch to do proper cleanup in time.
>> This depends on "powerpc/powernv/ioda: Fix endianness when reading TCEs"
>> to do proper cleanup via tce_iommu_clear() patch.
>>
>> To keep API consistent, this replaces mm_context_t with mm_struct;
>> we stick to mm_struct as mm_iommu_adjust_locked_vm() helper needs
>> access to &mm->mmap_sem.
>>
>> This should cause no behavioral change.
> 
> Is this a theoretical bug, or do we hit it in practice?

Actual bug.

> 
> In other words, should I merge this as a fix for 4.8, or can it wait for
> 4.9 with the rest of the series?

Assuming this does not have "rb" or "ab" from anyone familiar with IOMMU on
powernv, this has to wait :-/

> 
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/include/asm/mmu_context.h | 20 +++++++------
>>  arch/powerpc/kernel/setup-common.c     |  2 +-
>>  arch/powerpc/mm/mmu_context_book3s64.c |  4 +--
>>  arch/powerpc/mm/mmu_context_iommu.c    | 54 ++++++++++++++--------------------
> 
>>  drivers/vfio/vfio_iommu_spapr_tce.c    | 41 ++++++++++++++++----------
> 
> I'd need an ACK from Alex for that part.



-- 
Alexey
