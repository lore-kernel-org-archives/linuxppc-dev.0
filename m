Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22d.google.com (mail-wi0-x22d.google.com
 [IPv6:2a00:1450:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 321D41A0961
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 23:11:28 +1100 (AEDT)
Received: by wixw10 with SMTP id w10so35607729wix.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 05:11:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 25 Mar 2015 13:11:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc/mm: Tracking vDSO remap
Message-ID: <20150325121118.GA2542@gmail.com>
References: <20150323085209.GA28965@gmail.com>
 <cover.1427280806.git.ldufour@linux.vnet.ibm.com>
 <25152b76585716dc635945c3455ab9b49e645f6d.1427280806.git.ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25152b76585716dc635945c3455ab9b49e645f6d.1427280806.git.ldufour@linux.vnet.ibm.com>
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

> Some processes (CRIU) are moving the vDSO area using the mremap system
> call. As a consequence the kernel reference to the vDSO base address is
> no more valid and the signal return frame built once the vDSO has been
> moved is not pointing to the new sigreturn address.
> 
> This patch handles vDSO remapping and unmapping.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 36 +++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 73382eba02dc..be5dca3f7826 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -8,7 +8,6 @@
>  #include <linux/spinlock.h>
>  #include <asm/mmu.h>	
>  #include <asm/cputable.h>
> -#include <asm-generic/mm_hooks.h>
>  #include <asm/cputhreads.h>
>  
>  /*
> @@ -109,5 +108,40 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
>  #endif
>  }
>  
> +static inline void arch_dup_mmap(struct mm_struct *oldmm,
> +				 struct mm_struct *mm)
> +{
> +}
> +
> +static inline void arch_exit_mmap(struct mm_struct *mm)
> +{
> +}
> +
> +static inline void arch_unmap(struct mm_struct *mm,
> +			struct vm_area_struct *vma,
> +			unsigned long start, unsigned long end)
> +{
> +	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
> +		mm->context.vdso_base = 0;
> +}
> +
> +static inline void arch_bprm_mm_init(struct mm_struct *mm,
> +				     struct vm_area_struct *vma)
> +{
> +}
> +
> +#define __HAVE_ARCH_REMAP
> +static inline void arch_remap(struct mm_struct *mm,
> +			      unsigned long old_start, unsigned long old_end,
> +			      unsigned long new_start, unsigned long new_end)
> +{
> +	/*
> +	 * mremap don't allow moving multiple vma so we can limit the check
> +	 * to old_start == vdso_base.

s/mremap don't allow moving multiple vma
  mremap() doesn't allow moving multiple vmas

right?

Thanks,

	Ingo
