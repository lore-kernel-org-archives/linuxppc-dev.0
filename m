Return-Path: <linuxppc-dev+bounces-21965-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAB6CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 10:12:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVk5S43RPz2ybQ;
	Wed, 03 Jun 2026 20:12:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780481532;
	cv=none; b=MhLoH/P8ZnFmIF11Ncqi1+LnVrUtS3y0VsyuNAz26bkK84Auv/2wcay8s7R1lrrVTABFS+fEjmMMySGIeIoidueW1gKGwvH6DT2d90DBnWK40ht5kIGYnCA0CU6XZPWm43H2qve/UndJnDfCbCzmabc63FYRdPmDR/OXyD7+Fcjxc4/kB5oXUOrIRFGy7+yUZ+EpND9DYafh7HhuCylh1ok20xM7jmg4XgyTXnpjDk4jQAVtOEfZdg9vqlZXPEy2hJuqO6dGLX7AGvZaKpbQpaDFTodUinaGei1BV9VSYqKsmOT5Yma9IhkGpktJkYTJn+MwXqJeE3iVb6XKFqJZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780481532; c=relaxed/relaxed;
	bh=GJm322gPuQfTwo1jcz0N68dPOIxhXt9XqKhOnmKExww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjqAfrdWLOMFQwgaTUDOV/1r7yjrEcpnQlzlIBhw1biePLBtq9NW+F1fZHDKu13/K+fYEtSJPzQm+xrvP9cX3TWTBzZPeYa9Tv4+TjTdIYUO+DspO6MKUWI51kaY1UmiTAj2/0ok2PbtRZu6rdVmO0k1hzEMeh0G1qfxO/K7iukphcX1AM73KkM2hu8PpNctX8Z1CD85SO/7zCopDfjm2ANdtQlD8gIw499OQFFc6OJ09C5FPkncYS+mN3EFHYWSYJpdPduYB9BPTay9Y2rqftf+gU70ZD5ygofsY9+g+RvIhso9LWGlEhi3Hgjlh60Tpt46uE/z/h5UkrKYZLFatA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=YD6xz+z2; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=YD6xz+z2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVk5L3k8Tz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 20:12:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GJm322gPuQfTwo1jcz0N68dPOIxhXt9XqKhOnmKExww=; b=YD6xz+z2/DhAQvKzOSbxegjeTZ
	MfQq2Dj/qZ3ZHMdrimh3O1jWL1v9g2tXaLKMpusB/Ek6W0TEG8SeKQsIC3jh//ENHmYBsSQiLTJGu
	DKNiCQIMxf9Rs2Bo+alfxktZmR4DpQKcpFAjQeMelxPYfpvj3JwLb8mbDeQl2LFxNoTaYoCyHK6Ct
	R1v3COBXXoT0VI+tYKDBsQyTMgU+Dgp/tFc1T0BGRa5zsBQ7N7nJTySjeAC769mCzetGxvoLzliD+
	Tkjy4wJuMNguJilKaq8z+qP+9qd6DAFffpEzUsHLUUrNa/l1K1Q2Zyk85OxG7UooXQpyJ2qNCuUlZ
	z0TBuAmw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUiZp-00000003fL5-0Qek;
	Wed, 03 Jun 2026 10:11:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 49C33300642; Wed, 03 Jun 2026 12:11:55 +0200 (CEST)
Date: Wed, 3 Jun 2026 12:11:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, tglx@kernel.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	venkat88@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH] powerpc/entry: Disable interrupts before irqentry_exit
Message-ID: <20260603101155.GV3493090@noisy.programming.kicks-ass.net>
References: <20260603095521.198267-1-sshegde@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603095521.198267-1-sshegde@linux.ibm.com>

On Wed, Jun 03, 2026 at 03:25:21PM +0530, Shrikanth Hegde wrote:
> Venkat reported a panic on powerpc-next tree where GENERIC_ENTRY has
> been enabled.
> 
> kernel BUG at kernel/sched/core.c:7512!
> NIP  preempt_schedule_irq+0x44/0x118
> LR   dynamic_irqentry_exit_cond_resched+0x40/0x1a4
> Call Trace:
>  dynamic_irqentry_exit_cond_resched+0x40/0x1a4
>  do_page_fault+0xc0/0x104
>  data_access_common_virt+0x210/0x220
> 
> This happens since __do_page_fault ends up enabling the interrupts and
> it could take significant time such that need_resched could be set. This
> leads to schedule call in irqentry_exit leading to the bug.
> 
> There are many such irq handlers which enables the interrupts.
> Fix it by disabling the irq before calling irqentry_exit. The same
> pattern exists today in interrupt_exit_kernel_prepare.
> 
> While there, make those BUG_ON into WARN_ON. Interrupt is disabled right
> after so it is not that severe. This will still help to catch the
> offending callsites.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
> 
> This applies on top on powerpc/next tree.
> base: 6ed60999d33d '("powerpc: Remove unused functions")'
> 
>  arch/powerpc/include/asm/entry-common.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index de5601282755..7da373a56813 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -253,16 +253,17 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>  static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
> -		BUG_ON(regs_is_unrecoverable(regs));
> -		BUG_ON(regs_irqs_disabled(regs));
> +		WARN_ON(regs_is_unrecoverable(regs));
> +		WARN_ON(regs_irqs_disabled(regs));

So while you will indeed disable IRQs righ below. This checks the IRQ
state of regs, not the current state.

What you are allowing through it a *userspace* state that has IRQs
disabled. That is an invalid state.

>  		/*
>  		 * We don't need to restore AMR on the way back to userspace for KUAP.
>  		 * AMR can only have been unlocked if we interrupted the kernel.
>  		 */
>  		kuap_assert_locked();
> -
> -		local_irq_disable();
>  	}
> +
> +	/* irqentry_exit expects to be called with interrupts disabled */
> +	local_irq_disable();
>  }
>  
>  static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
> -- 
> 2.47.3
> 

