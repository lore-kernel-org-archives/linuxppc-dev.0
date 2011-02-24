Return-Path: <a.p.zijlstra@chello.nl>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B06CFB710A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Feb 2011 08:06:43 +1100 (EST)
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PsiOW-0005oR-NT
	for linuxppc-dev@lists.ozlabs.org; Thu, 24 Feb 2011 21:06:41 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219]
	helo=dyad.programming.kicks-ass.net)
	by canuck.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1PsiOV-0006sA-0m
	for linuxppc-dev@lists.ozlabs.org; Thu, 24 Feb 2011 21:06:39 +0000
Subject: Re: PowerPC BUG: using smp_processor_id() in preemptible code
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Hugh Dickins <hughd@google.com>
In-Reply-To: <alpine.LSU.2.00.1102241216420.1708@sister.anvils>
References: <alpine.LSU.2.00.1012291413360.22939@sister.anvils>
	<1293705910.17779.60.camel@pasglop>
	<alpine.LSU.2.00.1102241216420.1708@sister.anvils>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Feb 2011 22:07:55 +0100
Message-ID: <1298581675.5226.840.camel@laptop>
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-02-24 at 12:47 -0800, Hugh Dickins wrote:

Lovely problem :-), benh mentioned it on IRC, but I never got around to
finding the email thread, thanks for the CC.

> What would be better for 2.6.38 and 2.6.37-stable?  Moving that call to
> vunmap_page_range back under vb->lock, or the partial-Peter-patch below?
> And then what should be done for 2.6.39?

I think you'll also need the arch/powerpc/kernel/process.c changes that
cause context switches to flush the tlb_batch queues.

> --- 2.6.38-rc5/arch/powerpc/mm/tlb_hash64.c     2010-02-24 10:52:17.000000000 -0800
> +++ linux/arch/powerpc/mm/tlb_hash64.c  2011-02-15 23:27:21.000000000 -0800
> @@ -38,13 +38,11 @@ DEFINE_PER_CPU(struct ppc64_tlb_batch, p
>   * neesd to be flushed. This function will either perform the flush
>   * immediately or will batch it up if the current CPU has an active
>   * batch on it.
> - *
> - * Must be called from within some kind of spinlock/non-preempt region...
>   */
>  void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
>                      pte_t *ptep, unsigned long pte, int huge)
>  {
> -       struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
> +       struct ppc64_tlb_batch *batch = &get_cpu_var(ppc64_tlb_batch);
>         unsigned long vsid, vaddr;
>         unsigned int psize;
>         int ssize;
> @@ -99,6 +97,7 @@ void hpte_need_flush(struct mm_struct *m
>          */
>         if (!batch->active) {
>                 flush_hash_page(vaddr, rpte, psize, ssize, 0);
> +               put_cpu_var(ppc64_tlb_batch);
>                 return;
>         }
>  
> @@ -127,6 +126,7 @@ void hpte_need_flush(struct mm_struct *m
>         batch->index = ++i;
>         if (i >= PPC64_TLB_BATCH_NR)
>                 __flush_tlb_pending(batch);
> +       put_cpu_var(ppc64_tlb_batch);
>  }
>  
>  /* 
