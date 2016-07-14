Return-Path: <bsingharora@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqs1w3cK0zDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 20:12:04 +1000 (AEST)
Received: by mail-yw0-x243.google.com with SMTP id i12so4638141ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 03:12:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1468473379-36602-1-git-send-email-aik@ozlabs.ru>
References: <1468473379-36602-1-git-send-email-aik@ozlabs.ru>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 14 Jul 2016 20:12:00 +1000
Message-ID: <CAKTCnzkff8GDP3ZZOEETkVC4sYEnrN6z0B2aLvc3mbF-UViJKg@mail.gmail.com>
Subject: Re: [PATCH kernel] powerpc/mm/iommu: Put pages on process exit
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nick Piggin <npiggin@kernel.dk>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 14, 2016 at 3:16 PM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> At the moment VFIO IOMMU SPAPR v2 driver pins all guest RAM pages when
> the userspace starts using VFIO. When the userspace process finishes,
> all the pinned pages need to be put; this is done as a part of
> the userspace memory context (MM) destruction which happens on
> the very last mmdrop().
>
> This approach has a problem that a MM of the userspace process
> may live longer than the userspace process itself as kernel threads
> usually execute on a MM of a userspace process which was runnning
> on a CPU where the kernel thread was scheduled to. If this happened,
> the MM remains referenced until this exact kernel thread wakes up again
> and releases the very last reference to the MM, on an idle system this
> can take even hours.
>
> This fixes the issue by moving mm_iommu_cleanup() (the helper which puts
> pages) from destroy_context() (called on the last mmdrop()) to
> the arch-specific arch_exit_mmap() hook (called on the last mmput()).
> mmdrop() decrements the mm->mm_count which is a total reference number;
> mmput() decrements the mm->mm_users which is a number of user spaces and
> this is actually the counter we want to watch for here.
>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Nick Piggin <npiggin@kernel.dk>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 3 +++
>  arch/powerpc/mm/mmu_context_book3s64.c | 4 ----
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 9d2cd0c..24b590d 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -138,6 +138,9 @@ static inline void arch_dup_mmap(struct mm_struct *oldmm,
>
>  static inline void arch_exit_mmap(struct mm_struct *mm)
>  {
> +#ifdef CONFIG_SPAPR_TCE_IOMMU
> +       mm_iommu_cleanup(&mm->context);
> +#endif
>  }
>

The assumption is that all necessary tear down has happened. Earlier
we were doing the teardown
on the last mm ref drop, do we have any dependence on that? I don't
think so, but just checking

Does qemu dotce_iommu_register_pages on exit()/atexit() or do we rely
on the exit path to do the teardown?

Can we please remove the #ifdef CONFIG_SPAPR_TCE_IOMMU here and have a version
of mm_iommu_cleanup that handles it

Basically do

#ifdef CONFIG_SPAPR_TCE_IOMMU
extern void mm_iommu_cleanup(void *ptr)
#else
static inline mm_iommu_cleanup(void *ptr) {}
#endif

Otherwise looks good

Acked-by: Balbir Singh <bsingharora@gmail.com>
