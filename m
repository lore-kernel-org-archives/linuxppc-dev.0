Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C74411A0E00
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 07:27:33 +1100 (AEDT)
Message-ID: <1422736026.6200.14.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: bail out early when flushing TLB page
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arseny Solokha <asolokha@kb.kras.ru>
Date: Sun, 01 Feb 2015 07:27:06 +1100
In-Reply-To: <1422619707-30864-1-git-send-email-asolokha@kb.kras.ru>
References: <1422619707-30864-1-git-send-email-asolokha@kb.kras.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-01-30 at 19:08 +0700, Arseny Solokha wrote:
> MMU_NO_CONTEXT is conditionally defined as 0 or (unsigned int)-1. However,
> in __flush_tlb_page() a corresponding variable is only tested for open
> coded 0, which can cause NULL pointer dereference if `mm' argument was
> legitimately passed as such.
> 
> Bail out early in case the first argument is NULL, thus eliminate confusion
> between different values of MMU_NO_CONTEXT and avoid disabling and then
> re-enabling preemption unnecessarily.

So the comment above isn't quite right... we don't *test* it for open
coded 0, we test it for MMU_NO_CONTEXT, however we *set* it to 0 for
NULL mm.

This is actually correct... on all except 8xx :-) 0 *is* the PID of the
kernel context, and NULL mm usually means kernel context.

However, it's correct that this function will not deal properly with a
NULL mm for other reasons. It must only be called for user contexts.

Instead of just returning, I would WARN_ON, because if it's ever called
for a kernel page, then it will not do what's expected and that will
need fixing. Just a silent return isn't right.

This is different from returning on MMU_NO_CONTEXT, in this case, we
know there's no active TLB entries for the process, and thus nothing to
flush.

Cheers,
Ben.

> Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
> ---
>  arch/powerpc/mm/tlb_nohash.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
> index f38ea4d..ab0616b 100644
> --- a/arch/powerpc/mm/tlb_nohash.c
> +++ b/arch/powerpc/mm/tlb_nohash.c
> @@ -284,8 +284,11 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
>  	struct cpumask *cpu_mask;
>  	unsigned int pid;
>  
> +	if (unlikely(!mm))
> +		return;
> +
>  	preempt_disable();
> -	pid = mm ? mm->context.id : 0

Here we test mm, if we pass NULL, that means the kernel mm which has PID
0, which is not MMU_NO_CONTEXT
> ;
> +	pid = mm->context.id;
>  	if (unlikely(pid == MMU_NO_CONTEXT))
>  		goto bail;
>  	cpu_mask = mm_cpumask(mm);
