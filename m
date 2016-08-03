Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s482Z6VcKzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 20:10:14 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g202so14403105pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 03:10:14 -0700 (PDT)
Date: Wed, 3 Aug 2016 20:10:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alex Williamson
 <alex.williamson@redhat.com>, Paul Mackerras <paulus@samba.org>, David
 Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 05/15] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
Message-ID: <20160803201003.64773d4c@roar.ozlabs.ibm.com>
In-Reply-To: <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-6-git-send-email-aik@ozlabs.ru>
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

On Wed,  3 Aug 2016 18:40:46 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

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
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

I still have some questions about the use of mm in the driver, but
those aren't issues introduced by this patch, so as it is I think
the bug fix of this and the next patch is good.
