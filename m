Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Hkp4hyfzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 17:00:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 05/15] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
In-Reply-To: <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
Date: Fri, 05 Aug 2016 17:00:34 +1000
Message-ID: <87popnitt9.fsf@concordia.ellerman.id.au>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> In some situations the userspace memory context may live longer than
> the userspace process itself so if we need to do proper memory context
> cleanup, we better cache @mm and use it later when the process is gone
> (@current or @current->mm are NULL).
>
> This changes mm_iommu_xxx API to receive mm_struct instead of using one
> from @current.
>
> This is needed by the following patch to do proper cleanup in time.
> This depends on "powerpc/powernv/ioda: Fix endianness when reading TCEs"
> to do proper cleanup via tce_iommu_clear() patch.
>
> To keep API consistent, this replaces mm_context_t with mm_struct;
> we stick to mm_struct as mm_iommu_adjust_locked_vm() helper needs
> access to &mm->mmap_sem.
>
> This should cause no behavioral change.

Is this a theoretical bug, or do we hit it in practice?

In other words, should I merge this as a fix for 4.8, or can it wait for
4.9 with the rest of the series?

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 20 +++++++------
>  arch/powerpc/kernel/setup-common.c     |  2 +-
>  arch/powerpc/mm/mmu_context_book3s64.c |  4 +--
>  arch/powerpc/mm/mmu_context_iommu.c    | 54 ++++++++++++++--------------------

>  drivers/vfio/vfio_iommu_spapr_tce.c    | 41 ++++++++++++++++----------

I'd need an ACK from Alex for that part.

cheers
