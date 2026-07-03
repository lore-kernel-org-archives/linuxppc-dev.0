Return-Path: <linuxppc-dev+bounces-23469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8DC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 08:36:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs6Yd0JjWz2xd2;
	Fri, 03 Jul 2026 18:36:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783067812;
	cv=none; b=fY5yyooT+SyfPEyq2tFa2xpPd4pQtWMQ1m5F7RfEiERiDMudN+x3o2kaGUccKEQf8Fc1AWp7uHzvcWLrOdpQTlPy9Cb8PJNRSOHIGc9F+o1Ek40kItLf8UbszsXyAV9hJTgdPaUgKBFYeJ7L2zuaDnCC7N0mVCKM/0IpmazjUD3KlR3rxr0GMzUnhVDMztS39Utniwk4Iwoex/Im6Dd4W8x5nReXVGn6WWj2w371nGTZYH++M0JUYzeYXBk/vznXRxYHB4JILs+TijWriYXyAzwEGMbbqsRBswQe5CUlksnuSUQw2KHs+qOhEelznmYpl5WH3ZXCceMJg7fje/7D2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783067812; c=relaxed/relaxed;
	bh=hcyZzRkovit2jcvPPpFQfyWkrkepMmrBrCMN1uin2Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3KojLUJYL4RJZmIzbjLaumS8WLsvP7SM68tLH05r92GrxlU7VauM/aWR3Op58NVkiJC1BMtlv6EZ0Xf/UXlNjTPkbXXn5xadyZ9uqZinKlyAm//jRu386BxlLOS1bAWP0NgltM02sTVpxdXJEHbHWLnrVygj9a27gWrqnEJLoVCgrxHuW7NDzy+DQGvBVuCwSpRN5y+L6FYIw0CqIXaIWMqaQQFBtpyhShsz84OMcXIfbfUJGIraJiFKv5yN/c9J6VVEMpwSCsPAQajS56leU4xwxBRsllQvpB5ll7oY9x9/6kexf3BtodpTaY7zSR9efK1KdegmZuOle2e5HDQXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F4/yQUxF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F4/yQUxF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs6Yc0kftz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 18:36:51 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso454885a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783067809; x=1783672609; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcyZzRkovit2jcvPPpFQfyWkrkepMmrBrCMN1uin2Cw=;
        b=F4/yQUxFyrtNXBXMMIDJJiomlRGWdF8aO3EnQPT7ah2HUbEOHbckxnImSGuzjqQnwO
         ceYTnjGsnRD+mSpLbz6Ygrgpuuzp/Ik6RIYKFK1zWDfnGVnf8Lj0gs58poJTPqfbrjH5
         Yt9bnnTAxbQk2KJ2tVR+FlMjg2077kti2BDvX/Bvh3H4ZQg68dT1+Vq51vm6V0U79uxP
         Vj14Du/7ldpYHwOSH2lW5H6kIzTnygsU6WZ8x188hD0q7B0HyRs/yTw4RvBqt86JGtyU
         3W7gsIuojlwjV8+RHE2dSZqQdVoYBD85hRt6vrgPNc3sy/LxuZHUXT3dQN6+DfpVlNHW
         URrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783067809; x=1783672609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcyZzRkovit2jcvPPpFQfyWkrkepMmrBrCMN1uin2Cw=;
        b=b9PASoctm7ZyDrRUBaprNqFUrJi5X+xvpK5OGglae30j7qzuysc6uE5AiFVutd6Xn9
         yMg8MdAEFa8FnXYM4L4J+L1+7+32sKm4zlFXemqNtqvUtYWeSvo8MEFIlZkUZ0zqLMZp
         6HnOkbkXK92twQlJ4iNr0XDJhIiM/+Bvwr2BSZ/U22i2GMExcXA3PTT7mOKvudeUnPtB
         8FmTOxfBB5+F/emnb9zCv0l4OGPuOmtGTjC4ZZD+5HyuUdjXFAd0jGmbfGuN1N0yv4ep
         ZX9nBWonU6cw8xnTxqsnVyF7GeN+zipu3evl2a0wf13E/+5XKCeoeTnZOMrYakCpl3Ee
         6Ytw==
X-Forwarded-Encrypted: i=1; AHgh+RquE1jpB/2DT89nT+8y/H+KTiLm+3L5/+E1Q62NY4dJESsggkPTF594ZaFb48UIZjqACv4FUKV+JJYRkYU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxf7bnghHy2dLeVnvwBAIFJg6RIGIc4TkfB4hTouyu7A3Gh1KV2
	iWdv9W/uxFDm6W+4oj6LTQtrDP2N0aOx21E0gfAi1I0QhiG7j5nOB1lz
X-Gm-Gg: AfdE7cmGYOvyZPRCqr05dOEhgklHZ5Rawm2eMUwLbYDM1z/icKqe5L78qrnUecAA8Nv
	/HhWhRxYRVLpdcUfJLm7zAYXcj7vIeqf8k3Hm+fKjEU85YF4qUcg7lVpaJRKPIloxm9EhrFjWlh
	DQXVfm5PXmfPJwroSASc3mkrkGohGStu7YE3fip6POlyXi72PDJ0p8juPvPBL9xwQfIpux00Za/
	Uw/VUANyt3DwpKiGuZf47S5x3ZlxlXdsrEJ1MExqi/gcT3p6UugBuWLD9Y8Mn9x1j7v+q32yhQi
	CQVYhOfBK8IxQWTfWJD4QpIBhnAE2tNBPHwu1RkF0g/qkLrhrXUHqyHhkpoQqulWCi3NDFhHknc
	aC2IEFsbTaDkoSER3FUD+BLiCC97RrYjx3bd0PBsWm4xNC2Tzn0oojQ9aJhoK3Y7H/Zc2kk7DLK
	YgBm5yqwg7b+H+4JlgRzxOEUHnpYAbx10PWdcSDmWtedyJt8p6R4nNAUIVSWmcdqf7SzhQXB4=
X-Received: by 2002:a17:90b:2888:b0:35f:bb17:39f with SMTP id 98e67ed59e1d1-38112066822mr4224408a91.1.1783067809196;
        Fri, 03 Jul 2026 01:36:49 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc38e5fsm17729879eec.29.2026.07.03.01.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:36:48 -0700 (PDT)
Date: Fri, 3 Jul 2026 14:06:41 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: oleg@redhat.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, sshegde@linux.ibm.com, 
	mchauras@linux.ibm.com, thuth@redhat.com, segher@kernel.crashing.org, 
	ryan.roberts@arm.com, ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] powerpc/syscall: Fix syscall skip handling for
 seccomp and ptrace
Message-ID: <akd0foBWjSxm374I@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260703081100.1681924-1-mkchauras@gmail.com>
 <akdz6O-p9tdr1irz@kunlun.suse.cz>
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
In-Reply-To: <akdz6O-p9tdr1irz@kunlun.suse.cz>

On Fri, Jul 03, 2026 at 10:33:44AM +0200, Michal Suchánek wrote:
> On Fri, Jul 03, 2026 at 01:41:00PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
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
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> > v2 -> v3:
> >  - Last fix is not working for -1 syscall. Fixed that with this.
> > v2: https://lore.kernel.org/all/20260629182946.419552-1-mkchauras@gmail.com
> > 
> > v1 -> v2:
> >  - Fix issues in the previous fix (Michal)
> > v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com
> > 
> >  arch/powerpc/include/asm/ptrace.h      | 22 +++++++++++++++++++++-
> >  arch/powerpc/include/asm/syscall.h     |  6 ++++++
> >  arch/powerpc/include/uapi/asm/ptrace.h |  6 ++++--
> >  arch/powerpc/kernel/ptrace/ptrace.c    |  2 ++
> >  arch/powerpc/kernel/syscall.c          | 18 ++++++++++++++++++
> >  5 files changed, 51 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> > index fdeb97421785..1a53d5cfa8db 100644
> > --- a/arch/powerpc/include/asm/ptrace.h
> > +++ b/arch/powerpc/include/asm/ptrace.h
> > @@ -54,8 +54,9 @@ struct pt_regs
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
> > @@ -233,6 +234,25 @@ static inline unsigned long frame_pointer(struct pt_regs *regs)
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
> > index a9da2af6efa8..c7458aae199d 100644
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
> > +		return regs->gpr[3];
> 
> Hello,
> 
> shouldn't this use the getter to correctly decode the value for both scv
> and non-scv case?
> 
> Thanks
> 
> Michal
> 
Oh yeah,
Correct. Lemme fix that.

Regards,
Mukesh
> > +
> >  	if (unlikely(r0 >= NR_syscalls)) {
> >  		if (unlikely(trap_is_unsupported_scv(regs))) {
> >  			/* Unsupported scv vector */
> > -- 
> > 2.55.0
> > 

