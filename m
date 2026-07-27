Return-Path: <linuxppc-dev+bounces-24861-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2949EC53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 08:53:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7snj20BWz2yhD;
	Mon, 27 Jul 2026 18:53:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785142409;
	cv=none; b=QYu2K7q0nOmLZERfys4wOdyvXVtDP7hKG16WWs1GbxOVrMlvi/9GGonb3gTrRuJVutEHGAr95BzkZ0Ktp2Wc/L861WHHwapykC45KKpRQrfdmm1xRylQxQsaBTcsAAdEZLyhZQIrEHVnb7gqQZLTYLduKuijLH583bIGdt9l7VJdxBWQHnTWKtRkxZ7OwZg0gY3wGXpV8nTthXoMhu5LDgW+69dHDTNXgPc7CdPpBduHVFw5XDopQjFFj6Y3WajMB8IcFH/flYlX3nDlbBeRX2YuKqWvSEKRkNcr9o8YKXdjHHDMb69ttejj7qXHsVhh/+J62TB/0d2y2fW6M/1l7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785142409; c=relaxed/relaxed;
	bh=7dMFEoF91A93RkH7H1rBOpobi2kQnvVchlTgD43NN+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+ftmKBjdf/SkaDTRR7xNccyD+hNY8IFp5yZVK+krLs9vYLDL9SrWLvjAOxMwrcKuR4MvWcQwPN0yiMk1z8DClkDahSK611W47hNJmOS45nP+1wqchi2hRj1SWzFKFNeVjHyR5H8qoSz8ALbjB4hjGvIic/yERqlzV4K67s4ijI6D59nJqgmLqal+6gyiiVebd5mIuNRi9jyPOzRVbopRv8JSXV9ZCgEiDC3j9niNAgg8umtjXqhraEH0caxOx1+ZFz9NtcOl8HrJTeX6Z0l/KiCnLnI6X2eQXWisLJoGaCyC30JcJv9fD0Bo+BrN/lp7JSb5iu8QPFSs3W/1aO0jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mezhAQRX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mezhAQRX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7sng6CnHz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 18:53:27 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2307033a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785142405; x=1785747205; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7dMFEoF91A93RkH7H1rBOpobi2kQnvVchlTgD43NN+Q=;
        b=mezhAQRXOsYUd8thHDYNHYnPNx/AghZcBYv6jmdtfwAJJ+g1GVfdaV7RQvQKmYx6dM
         Ir163mvxq7wuptBrg0683dl/7OA/ZcchB3uzbkW2SKqIFvUoqoWVD2QIMibMRqu0pZ1P
         EiKWX6E3a6JxTVR2IctANVWDcCz+fwQms3jKp5T9qAH2VdycUmWYEioLMH+2WL1YNElV
         8p66jKf4Wt844guHUgF4TZVhi1PSjVMyNO0Ggw2uFLp1p8SQebigCnvMryBgRO6o865Y
         kNhIcE3LnNdYA91k3jbWLMh8p5Hg5mH863+Q2+s84J2/SICR5hiRCyIAYp8hpUIrrRxR
         anlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785142405; x=1785747205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7dMFEoF91A93RkH7H1rBOpobi2kQnvVchlTgD43NN+Q=;
        b=TwJwyvtZXr/+TL4az3jO4AdksyCJRhOlWpIG/GJscJi96nHczfMivRsJnLBdD4ketY
         6Hxg9pSH4zq4y/Mc0XJvG3ZffE4wRjbQUnaDwC4vqWyl02QiDkciX5jzursz0w/5s0M4
         V6unzziVk4HcdbwhLJ/5ZAVjVYLj9k9RqewPTIi3leI1Zu9osSJ/zNsztxLq1HZEYg5E
         dEW42f9Pv+arLBnnUXhQTbpT9W4xfjWAPphv9KAyKh9uCKramMg3arvsqfBEgPXFy/E8
         dmq21G0Ku/nZZQGSamtigUyIs7tM2x0EzXspJ/9bf0hTw5LeTdUBO6mBa6CpqkiMbht4
         PsDg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0TBn5cWsIcgpVyWN2YP2SjUaOZBig6E+5oOLfcIIt3YzrMorNubSb0QsuhgjJQ28PL0VChbrF1EjYX7k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw/WsP3Nkr7Prg2bdOuITla1oX0T+V6eYTMO6ruPxLjo8eUNQoW
	A8iVtAvYf1avx9yztzs84DP/1pTZnWU9vZmdmXxr7RNHh826/DLie5TI
X-Gm-Gg: AR+sD11UzY7Uu77NKsGS38Mfbbk3gU+zyLmNpYutS+rpdybsZ8z0SXTRo2sgUa7Ptih
	XBZlq2cYYPi9gVDrgCVgTIBYuF+EjDs3/XLN0e/c1ZLe3cbkgY0uxk42Suef/7TKhnYptn+LipM
	6fXtWgsS5cVP8Db0QeiCSQIz2MZJcTRSZNlYU15J61C4OVoGRerbc3yIOW0BVwVvVIhsraQC3yL
	zHcz7BWQ3p6Yl+zFzJvbc5HRbjojMYeaUqx2A5F4i+WCHLIpYB3qSYBe2tQTUxhU4oXGjdmB5zV
	LoQ/q+Y5Tqt2XzXI0vLXh5lkBtrIDcxZ8J1rxEGFB6bS7QJGDyYHygsgHmoWjJbxd8ZE0od/Xv8
	8ha6YfgIwejsHU0DxlOAgqm+uCvIsv6gFmVKmrx1BPRPpEle8ntlFOAmfCmIfAEqWdl1kJXXYDs
	9jeXp3g/F0Xbkj4E8npH0Xc1dTlkCjJem8rAnY5VPUvHHpuQ==
X-Received: by 2002:a17:90b:1d84:b0:38d:c0f9:30be with SMTP id 98e67ed59e1d1-38f297805a1mr7163331a91.38.1785142404666;
        Mon, 27 Jul 2026 01:53:24 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2951eb8dsm2752840a91.13.2026.07.27.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:53:24 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:23:17 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: oleg@redhat.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, mchauras@linux.ibm.com, 
	sshegde@linux.ibm.com, segher@kernel.crashing.org, thuth@redhat.com, kees@kernel.org, 
	ryan.roberts@arm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] powerpc/syscall: Fix syscall skip handling for
 seccomp and ptrace
Message-ID: <amccXKnzrfNl7GjH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260714075935.1830145-1-mkchauras@gmail.com>
 <amcQ5N42Svm7oE7j@kunlun.suse.cz>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amcQ5N42Svm7oE7j@kunlun.suse.cz>

On Mon, Jul 27, 2026 at 10:03:48AM +0200, Michal Suchánek wrote:
> Hello,
> 
> this should be probably adjusted to match
> 
> https://lore.kernel.org/linuxppc-dev/20260723194809.4046600-1-mkchauras@gmail.com/
> 
> Thanks
> 
> Michal
> 
Hey Michal,

Yeah, i am working towards this.

Regards,
Mukesh
> On Tue, Jul 14, 2026 at 01:29:35PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > After enabling GENERIC_ENTRY on PowerPC, syscall_enter_from_user_mode()
> > returns -1 as a sentinel to signal that seccomp or ptrace has intercepted
> > the syscall and already set a return value via syscall_set_return_value().
> > system_call_exception() was not handling this sentinel, and since -1UL
> > is >= NR_syscalls, the code fell into the out-of-range path and returned
> > -ENOSYS, overwriting the errno already placed in regs->gpr[3].
> > 
> > The naive fix of checking r0 == -1L before the NR_syscalls bounds check
> > is ambiguous: a user legitimately calling syscall(-1) also produces r0 ==
> > -1L, and a tracer intercepting such a call would have its injected return
> > value silently discarded.
> > 
> > Fix this properly by introducing regs->entry_flags, a kernel-internal
> > field in struct pt_regs (consuming one slot of the existing __pt_regs_pad
> > so the ABI is preserved), with SYSCALL_ENTRY_RET_SET as an out-of-band
> > flag. syscall_set_return_value() sets this flag whenever seccomp or ptrace
> > injects a return value. system_call_exception() zeros entry_flags before
> > calling syscall_enter_from_user_mode(), then checks and clears the flag
> > afterwards: if set, it returns regs->gpr[3] directly regardless of what
> > syscall number the user originally requested.
> > 
> > This handles all seccomp actions correctly:
> > 
> >   - SECCOMP_RET_ERRNO, SECCOMP_RET_TRACE (no tracer), SECCOMP_RET_USER_NOTIF:
> >     all call syscall_set_return_value(), flag is set, injected value returned.
> >   - SECCOMP_RET_TRAP, SECCOMP_RET_KILL: call syscall_rollback() and deliver
> >     a signal; flag is not set, but the process is dying so the return value
> >     is irrelevant.
> > 
> > The fix covers both ppc32 and ppc64 with no #ifdefs.
> > 
> > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
> > Tested-by: Michal Suchánek <msuchanek@suse.de>
> > Reviewed-by: Michal Suchánek <msuchanek@suse.de>
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> > v4 -> v5:
> >  - Fixed build failure where BITS macro is not available
> > v3 -> v4:
> >  - Use syscall_get_error (Michal)
> > v2 -> v3:
> >  - Last fix is not working for -1 syscall. Fixed that with this.
> > v2: https://lore.kernel.org/all/20260629182946.419552-1-mkchauras@gmail.com
> > 
> > v1 -> v2:
> >  - Fix issues in the previous fix (Michal)
> > v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com
> > 
> > 
> >  arch/powerpc/include/asm/ptrace.h      | 23 ++++++++++++++++++++++-
> >  arch/powerpc/include/asm/syscall.h     |  6 ++++++
> >  arch/powerpc/include/uapi/asm/ptrace.h |  6 ++++--
> >  arch/powerpc/kernel/ptrace/ptrace.c    |  2 ++
> >  arch/powerpc/kernel/syscall.c          | 18 ++++++++++++++++++
> >  5 files changed, 52 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> > index fdeb97421785..363a89787f1c 100644
> > --- a/arch/powerpc/include/asm/ptrace.h
> > +++ b/arch/powerpc/include/asm/ptrace.h
> > @@ -19,6 +19,7 @@
> >  #ifndef _ASM_POWERPC_PTRACE_H
> >  #define _ASM_POWERPC_PTRACE_H
> >  
> > +#include <linux/bits.h>
> >  #include <linux/err.h>
> >  #include <uapi/asm/ptrace.h>
> >  #include <asm/asm-const.h>
> > @@ -54,8 +55,9 @@ struct pt_regs
> >  			};
> >  			unsigned long result;
> >  			unsigned long exit_flags;
> > +			unsigned long entry_flags;
> >  			/* Maintain 16 byte interrupt stack alignment */
> > -			unsigned long __pt_regs_pad[3];
> > +			unsigned long __pt_regs_pad[2];
> >  		};
> >  	};
> >  #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_KUAP)
> > @@ -233,6 +235,25 @@ static inline unsigned long frame_pointer(struct pt_regs *regs)
> >  #define current_pt_regs() \
> >  	((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
> >  
> > +/*
> > + * SYSCALL_ENTRY_RET_SET: seccomp or ptrace called syscall_set_return_value()
> > + * and wants the syscall skipped; regs->gpr[3] already holds the return value.
> > + */
> > +#define SYSCALL_ENTRY_RET_SET	BIT(0)
> > +
> > +static inline void set_syscall_entry_ret(struct pt_regs *regs)
> > +{
> > +	regs->entry_flags |= SYSCALL_ENTRY_RET_SET;
> > +}
> > +
> > +static inline bool test_and_clear_syscall_entry_ret(struct pt_regs *regs)
> > +{
> > +	bool set = !!(regs->entry_flags & SYSCALL_ENTRY_RET_SET);
> > +
> > +	regs->entry_flags &= ~SYSCALL_ENTRY_RET_SET;
> > +	return set;
> > +}
> > +
> >  /*
> >   * The 4 low bits (0xf) are available as flags to overload the trap word,
> >   * because interrupt vectors have minimum alignment of 0x10. TRAP_FLAGS_MASK
> > diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> > index 834fcc4f7b54..9ae79326abe3 100644
> > --- a/arch/powerpc/include/asm/syscall.h
> > +++ b/arch/powerpc/include/asm/syscall.h
> > @@ -98,6 +98,12 @@ static inline void syscall_set_return_value(struct task_struct *task,
> >  			regs->gpr[3] = val;
> >  		}
> >  	}
> > +	/*
> > +	 * Mark that a return value has been explicitly set by seccomp or
> > +	 * ptrace so that system_call_exception() can skip the syscall
> > +	 * unconditionally, even when the user requested syscall(-1).
> > +	 */
> > +	set_syscall_entry_ret(regs);
> >  }
> >  
> >  static inline void syscall_get_arguments(struct task_struct *task,
> > diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> > index a393b7f2760a..2f2a43414fe6 100644
> > --- a/arch/powerpc/include/uapi/asm/ptrace.h
> > +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> > @@ -56,7 +56,8 @@ struct pt_regs
> >  	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
> >  	unsigned long result;		/* Result of a system call */
> >  	unsigned long exit_flags;	/* System call exit flags */
> > -	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
> > +	unsigned long entry_flags;	/* System call entry flags */
> > +	unsigned long __pt_regs_pad[2];	/* Maintain 16 byte interrupt stack alignment */
> >  };
> >  
> >  #endif /* __ASSEMBLER__ */
> > @@ -117,7 +118,8 @@ struct pt_regs
> >  #define PT_DSISR 42
> >  #define PT_RESULT 43
> >  #define PT_EXIT_FLAGS 44
> > -#define PT_PAD 47 /* 3 times */
> > +#define PT_ENTRY_FLAGS 45
> > +#define PT_PAD 46 /* 2 times */
> >  #define PT_DSCR 48
> >  #define PT_REGS_COUNT 48
> >  
> > diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> > index 316d4f5ead8e..440d00690cf2 100644
> > --- a/arch/powerpc/kernel/ptrace/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> > @@ -235,6 +235,8 @@ void __init pt_regs_check(void)
> >  		     offsetof(struct user_pt_regs, dsisr));
> >  	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
> >  		     offsetof(struct user_pt_regs, result));
> > +	BUILD_BUG_ON(offsetof(struct pt_regs, entry_flags) !=
> > +		     offsetof(struct user_pt_regs, entry_flags));
> >  
> >  	BUILD_BUG_ON(sizeof(struct user_pt_regs) > sizeof(struct pt_regs));
> >  
> > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > index a9da2af6efa8..a43d3a9428cc 100644
> > --- a/arch/powerpc/kernel/syscall.c
> > +++ b/arch/powerpc/kernel/syscall.c
> > @@ -19,9 +19,27 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> >  	long ret;
> >  	syscall_fn f;
> >  
> > +	/*
> > +	 * Zero entry_flags before syscall_enter_from_user_mode() so that
> > +	 * syscall_set_return_value() can set SYSCALL_ENTRY_RET_SET as an
> > +	 * unambiguous out-of-band signal.  The field is not initialised by
> > +	 * the entry assembly.
> > +	 */
> > +	regs->entry_flags = 0;
> >  	add_random_kstack_offset();
> >  	r0 = syscall_enter_from_user_mode(regs, r0);
> >  
> > +	/*
> > +	 * Seccomp or ptrace may have set a return value and requested that
> > +	 * the syscall be skipped. syscall_set_return_value() sets
> > +	 * SYSCALL_ENTRY_RET_SET in regs->entry_flags as an
> > +	 * unambiguous out-of-band signal. This avoids the ambiguity of
> > +	 * using r0 == -1 as the skip sentinel when the user themselves
> > +	 * called syscall(-1).
> > +	 */
> > +	if (unlikely(test_and_clear_syscall_entry_ret(regs)))
> > +		return syscall_get_error(current, regs);
> > +
> >  	if (unlikely(r0 >= NR_syscalls)) {
> >  		if (unlikely(trap_is_unsupported_scv(regs))) {
> >  			/* Unsupported scv vector */
> > -- 
> > 2.55.0
> > 

