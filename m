Return-Path: <SRS0=3GPV=CK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9222BC433E6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 12:02:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0166D206EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 12:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="E17/BDja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0166D206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bgm0N1vFxzDqYq
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 22:02:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bgly34DzSzDqXt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2020 22:00:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=E17/BDja; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bgly111gqz9sVS;
 Tue,  1 Sep 2020 22:00:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1598961626;
 bh=bNF75aZajY8dqH+S8STH5rR/AlZdtT5JXvFy8iAsGMo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=E17/BDja+BGxSe7whyBgQehfG9HYsbuS0N2b54qlT+T+cAB2KLGOtAxvb2OGmXrJA
 bQthxgUNnHzp89QxLQQSNbrAwruCWESMzbhoRX5MjYqIdlS0OzA7TZ5ghxvom32cqH
 nNAKwDeHIiQzirC92lmv6+7QMv0TEFTnqrQr4bGJ7XPvz9xuTp+rfsdQNeaA4qEPxN
 m/yr7Odq5uA4LxkxOZ5RkVFmkUaTt3fxyUix1Y2acOTlY09WsqhDpqGJtmna8Vmr1q
 BNj5ShKytxaGa3uyCI9wd1wZir0Dt1ZRWrQhpejLoWhQPRsYGYE4GkQPBxfdNU9ha0
 Kq0RR7TEYO5PA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] powerpc/64s/radix: Fix mm_cpumask trimming race vs
 kthread_use_mm
In-Reply-To: <20200828100022.1099682-5-npiggin@gmail.com>
References: <20200828100022.1099682-1-npiggin@gmail.com>
 <20200828100022.1099682-5-npiggin@gmail.com>
Date: Tue, 01 Sep 2020 22:00:20 +1000
Message-ID: <87pn751zcb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Commit 0cef77c7798a7 ("powerpc/64s/radix: flush remote CPUs out of
> single-threaded mm_cpumask") added a mechanism to trim the mm_cpumask of
> a process under certain conditions. One of the assumptions is that
> mm_users would not be incremented via a reference outside the process
> context with mmget_not_zero() then go on to kthread_use_mm() via that
> reference.
>
> That invariant was broken by io_uring code (see previous sparc64 fix),
> but I'll point Fixes: to the original powerpc commit because we are
> changing that assumption going forward, so this will make backports
> match up.
>
> Fix this by no longer relying on that assumption, but by having each CPU
> check the mm is not being used, and clearing their own bit from the mask
> if it's okay. This fix relies on commit 38cf307c1f20 ("mm: fix
> kthread_use_mm() vs TLB invalidate") to disable irqs over the mm switch,
> and ARCH_WANT_IRQS_OFF_ACTIVATE_MM to be enabled.

You could use:

Depends-on: 38cf307c1f20 ("mm: fix kthread_use_mm() vs TLB invalidate")

> Fixes: 0cef77c7798a7 ("powerpc/64s/radix: flush remote CPUs out of single-threaded mm_cpumask")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/tlb.h       | 13 -------------
>  arch/powerpc/mm/book3s64/radix_tlb.c | 23 ++++++++++++++++-------
>  2 files changed, 16 insertions(+), 20 deletions(-)

One minor nit below if you're respinning anyway.

You know this stuff better than me, but I still reviewed it and it seems
good to me.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> index fbc6f3002f23..d97f061fecac 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -66,19 +66,6 @@ static inline int mm_is_thread_local(struct mm_struct *mm)
>  		return false;
>  	return cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm));
>  }
> -static inline void mm_reset_thread_local(struct mm_struct *mm)
> -{
> -	WARN_ON(atomic_read(&mm->context.copros) > 0);
> -	/*
> -	 * It's possible for mm_access to take a reference on mm_users to
> -	 * access the remote mm from another thread, but it's not allowed
> -	 * to set mm_cpumask, so mm_users may be > 1 here.
> -	 */
> -	WARN_ON(current->mm != mm);
> -	atomic_set(&mm->context.active_cpus, 1);
> -	cpumask_clear(mm_cpumask(mm));
> -	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
> -}
>  #else /* CONFIG_PPC_BOOK3S_64 */
>  static inline int mm_is_thread_local(struct mm_struct *mm)
>  {
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
> index 0d233763441f..a421a0e3f930 100644
> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> @@ -645,19 +645,29 @@ static void do_exit_flush_lazy_tlb(void *arg)
>  	struct mm_struct *mm = arg;
>  	unsigned long pid = mm->context.id;
>  
> +	/*
> +	 * A kthread could have done a mmget_not_zero() after the flushing CPU
> +	 * checked mm_users == 1, and be in the process of kthread_use_mm when
                                ^
                                in mm_is_singlethreaded()

Adding that reference would help join the dots for a new reader I think.

cheers

> +	 * interrupted here. In that case, current->mm will be set to mm,
> +	 * because kthread_use_mm() setting ->mm and switching to the mm is
> +	 * done with interrupts off.
> +	 */
>  	if (current->mm == mm)
> -		return; /* Local CPU */
> +		goto out_flush;
>  
>  	if (current->active_mm == mm) {
> -		/*
> -		 * Must be a kernel thread because sender is single-threaded.
> -		 */
> -		BUG_ON(current->mm);
> +		WARN_ON_ONCE(current->mm != NULL);
> +		/* Is a kernel thread and is using mm as the lazy tlb */
>  		mmgrab(&init_mm);
> -		switch_mm(mm, &init_mm, current);
>  		current->active_mm = &init_mm;
> +		switch_mm_irqs_off(mm, &init_mm, current);
>  		mmdrop(mm);
>  	}
> +
> +	atomic_dec(&mm->context.active_cpus);
> +	cpumask_clear_cpu(smp_processor_id(), mm_cpumask(mm));
> +
> +out_flush:
>  	_tlbiel_pid(pid, RIC_FLUSH_ALL);
>  }
>  
> @@ -672,7 +682,6 @@ static void exit_flush_lazy_tlbs(struct mm_struct *mm)
>  	 */
>  	smp_call_function_many(mm_cpumask(mm), do_exit_flush_lazy_tlb,
>  				(void *)mm, 1);
> -	mm_reset_thread_local(mm);
>  }
>  
>  void radix__flush_tlb_mm(struct mm_struct *mm)
