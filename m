Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x233.google.com (mail-wg0-x233.google.com
 [IPv6:2a00:1450:400c:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCD401A2B37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 19:52:16 +1100 (AEDT)
Received: by wgbcc7 with SMTP id cc7so139972204wgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 01:52:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 23 Mar 2015 09:52:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] mm: Introducing arch_remap hook
Message-ID: <20150323085209.GA28965@gmail.com>
References: <cover.1426866405.git.ldufour@linux.vnet.ibm.com>
 <503499aae380db1c4673f146bcba6ad095021257.1426866405.git.ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <503499aae380db1c4673f146bcba6ad095021257.1426866405.git.ldufour@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 user-mode-linux-user@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> Some architecture would like to be triggered when a memory area is moved
> through the mremap system call.
> 
> This patch is introducing a new arch_remap mm hook which is placed in the
> path of mremap, and is called before the old area is unmapped (and the
> arch_unmap hook is called).
> 
> To no break the build, this patch adds the empty hook definition to the
> architectures that were not using the generic hook's definition.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/mmu_context.h      | 6 ++++++
>  arch/um/include/asm/mmu_context.h        | 5 +++++
>  arch/unicore32/include/asm/mmu_context.h | 6 ++++++
>  arch/x86/include/asm/mmu_context.h       | 6 ++++++
>  include/asm-generic/mm_hooks.h           | 6 ++++++
>  mm/mremap.c                              | 9 +++++++--
>  6 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
> index 8fb3802f8fad..ddd861a490ba 100644
> --- a/arch/s390/include/asm/mmu_context.h
> +++ b/arch/s390/include/asm/mmu_context.h
> @@ -131,4 +131,10 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
>  {
>  }
>  
> +static inline void arch_remap(struct mm_struct *mm,
> +			      unsigned long old_start, unsigned long old_end,
> +			      unsigned long new_start, unsigned long new_end)
> +{
> +}
> +
>  #endif /* __S390_MMU_CONTEXT_H */
> diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
> index 941527e507f7..f499b017c1f9 100644
> --- a/arch/um/include/asm/mmu_context.h
> +++ b/arch/um/include/asm/mmu_context.h
> @@ -27,6 +27,11 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
>  				     struct vm_area_struct *vma)
>  {
>  }
> +static inline void arch_remap(struct mm_struct *mm,
> +			      unsigned long old_start, unsigned long old_end,
> +			      unsigned long new_start, unsigned long new_end)
> +{
> +}
>  /*
>   * end asm-generic/mm_hooks.h functions
>   */
> diff --git a/arch/unicore32/include/asm/mmu_context.h b/arch/unicore32/include/asm/mmu_context.h
> index 1cb5220afaf9..39a0a553172e 100644
> --- a/arch/unicore32/include/asm/mmu_context.h
> +++ b/arch/unicore32/include/asm/mmu_context.h
> @@ -97,4 +97,10 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
>  {
>  }
>  
> +static inline void arch_remap(struct mm_struct *mm,
> +			      unsigned long old_start, unsigned long old_end,
> +			      unsigned long new_start, unsigned long new_end)
> +{
> +}
> +
>  #endif
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 883f6b933fa4..75cb71f4be1e 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -172,4 +172,10 @@ static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
>  		mpx_notify_unmap(mm, vma, start, end);
>  }
>  
> +static inline void arch_remap(struct mm_struct *mm,
> +			      unsigned long old_start, unsigned long old_end,
> +			      unsigned long new_start, unsigned long new_end)
> +{
> +}
> +
>  #endif /* _ASM_X86_MMU_CONTEXT_H */

So instead of spreading these empty prototypes around mmu_context.h 
files, why not add something like this to the PPC definition:

 #define __HAVE_ARCH_REMAP

and define the empty prototype for everyone else? It's a bit like how 
the __HAVE_ARCH_PTEP_* namespace works.

That should shrink this patch considerably.

Thanks,

	Ingo
