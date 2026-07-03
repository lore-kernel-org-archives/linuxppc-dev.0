Return-Path: <linuxppc-dev+bounces-23468-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0217AC43602
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 08:33:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs6V63QYKz2xd2;
	Fri, 03 Jul 2026 18:33:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783067630;
	cv=none; b=WOXl4dhW/M/kouj4/j5X65wBD5BL2SUyrxKluUcUbkDv0d+IQL8Ue7zuDpd4pUY+5GcmvhfwfQcCj624lWnFFZISHMcvm8GFtF6u1pEcSQQQXc2kczYDzfK6iqfIu9J1ht3fAa1sjoQ7MMGl3u2aKzuu5r8Z3D/P8TdziqQLpQKPc0vm3AAHpZRvwn+wgdMWeR+WB6pqEzX4DBf/9MUtcW2AcN++jOM61nau1L3/N4OiSbP0i9pOe73ry+camB2J6sDx3hRL8kii4L1oiaunJYOwY3sIz7VbS9gz6j1cBgYxU9d4RqbcAG9hegPAcp0E0HhQ65yN8UzbaZFut3rvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783067630; c=relaxed/relaxed;
	bh=h6tVvsq7PZfQ2Z7zOzGxyNR+k3LOEQuv382qTiNMq2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FX3n6ujf7dayRMfOYO6PScvwmrCQgG3r0ziW/u7WB2mKi2Fo/zST4NqMXkOL//HlGPf6ED9PLwNuFzzxfBpUAIJjTy6v1xXYV4/tDYMdzXw6GH4IKeQShjZeRWO8MNvat5TjfQuVPq2Isb86SzZtMCFgGTf20+HOKA398XWKPB/kQkt/tmt0R7yqqKPDnd9DngiUEcbOHGDMTyrK1TVHjDkKB4VlNOQvXowE+3lPwTPrgZjaBxNOD8+woT2CiGI9cE9U2KfKZxYYUF9OIjCNhO7UYtF/9DVu0c6k7iv9H03tAwafok+BmrBzBbcLlva57RkjBaQZch+KUmPhrHM3wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs6V550L8z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 18:33:49 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 864E074812;
	Fri,  3 Jul 2026 08:33:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Date: Fri, 3 Jul 2026 10:33:44 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: oleg@redhat.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, sshegde@linux.ibm.com,
	mchauras@linux.ibm.com, thuth@redhat.com,
	segher@kernel.crashing.org, ryan.roberts@arm.com,
	ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] powerpc/syscall: Fix syscall skip handling for
 seccomp and ptrace
Message-ID: <akdz6O-p9tdr1irz@kunlun.suse.cz>
References: <20260703081100.1681924-1-mkchauras@gmail.com>
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
In-Reply-To: <20260703081100.1681924-1-mkchauras@gmail.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 864E074812
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[]

On Fri, Jul 03, 2026 at 01:41:00PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> After enabling GENERIC_ENTRY on PowerPC, syscall_enter_from_user_mode()
> returns -1 as a sentinel to signal that seccomp or ptrace has intercepted
> the syscall and already set a return value via syscall_set_return_value().
> system_call_exception() was not handling this sentinel, and since -1UL
> is >= NR_syscalls, the code fell into the out-of-range path and returned
> -ENOSYS, overwriting the errno already placed in regs->gpr[3].
> 
> The naive fix of checking r0 == -1L before the NR_syscalls bounds check
> is ambiguous: a user legitimately calling syscall(-1) also produces r0 ==
> -1L, and a tracer intercepting such a call would have its injected return
> value silently discarded.
> 
> Fix this properly by introducing regs->entry_flags, a kernel-internal
> field in struct pt_regs (consuming one slot of the existing __pt_regs_pad
> so the ABI is preserved), with SYSCALL_ENTRY_RET_SET as an out-of-band
> flag. syscall_set_return_value() sets this flag whenever seccomp or ptrace
> injects a return value. system_call_exception() zeros entry_flags before
> calling syscall_enter_from_user_mode(), then checks and clears the flag
> afterwards: if set, it returns regs->gpr[3] directly regardless of what
> syscall number the user originally requested.
> 
> This handles all seccomp actions correctly:
> 
>   - SECCOMP_RET_ERRNO, SECCOMP_RET_TRACE (no tracer), SECCOMP_RET_USER_NOTIF:
>     all call syscall_set_return_value(), flag is set, injected value returned.
>   - SECCOMP_RET_TRAP, SECCOMP_RET_KILL: call syscall_rollback() and deliver
>     a signal; flag is not set, but the process is dying so the return value
>     is irrelevant.
> 
> The fix covers both ppc32 and ppc64 with no #ifdefs.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> v2 -> v3:
>  - Last fix is not working for -1 syscall. Fixed that with this.
> v2: https://lore.kernel.org/all/20260629182946.419552-1-mkchauras@gmail.com
> 
> v1 -> v2:
>  - Fix issues in the previous fix (Michal)
> v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com
> 
>  arch/powerpc/include/asm/ptrace.h      | 22 +++++++++++++++++++++-
>  arch/powerpc/include/asm/syscall.h     |  6 ++++++
>  arch/powerpc/include/uapi/asm/ptrace.h |  6 ++++--
>  arch/powerpc/kernel/ptrace/ptrace.c    |  2 ++
>  arch/powerpc/kernel/syscall.c          | 18 ++++++++++++++++++
>  5 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index fdeb97421785..1a53d5cfa8db 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -54,8 +54,9 @@ struct pt_regs
>  			};
>  			unsigned long result;
>  			unsigned long exit_flags;
> +			unsigned long entry_flags;
>  			/* Maintain 16 byte interrupt stack alignment */
> -			unsigned long __pt_regs_pad[3];
> +			unsigned long __pt_regs_pad[2];
>  		};
>  	};
>  #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_KUAP)
> @@ -233,6 +234,25 @@ static inline unsigned long frame_pointer(struct pt_regs *regs)
>  #define current_pt_regs() \
>  	((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
>  
> +/*
> + * SYSCALL_ENTRY_RET_SET: seccomp or ptrace called syscall_set_return_value()
> + * and wants the syscall skipped; regs->gpr[3] already holds the return value.
> + */
> +#define SYSCALL_ENTRY_RET_SET	BIT(0)
> +
> +static inline void set_syscall_entry_ret(struct pt_regs *regs)
> +{
> +	regs->entry_flags |= SYSCALL_ENTRY_RET_SET;
> +}
> +
> +static inline bool test_and_clear_syscall_entry_ret(struct pt_regs *regs)
> +{
> +	bool set = !!(regs->entry_flags & SYSCALL_ENTRY_RET_SET);
> +
> +	regs->entry_flags &= ~SYSCALL_ENTRY_RET_SET;
> +	return set;
> +}
> +
>  /*
>   * The 4 low bits (0xf) are available as flags to overload the trap word,
>   * because interrupt vectors have minimum alignment of 0x10. TRAP_FLAGS_MASK
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 834fcc4f7b54..9ae79326abe3 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -98,6 +98,12 @@ static inline void syscall_set_return_value(struct task_struct *task,
>  			regs->gpr[3] = val;
>  		}
>  	}
> +	/*
> +	 * Mark that a return value has been explicitly set by seccomp or
> +	 * ptrace so that system_call_exception() can skip the syscall
> +	 * unconditionally, even when the user requested syscall(-1).
> +	 */
> +	set_syscall_entry_ret(regs);
>  }
>  
>  static inline void syscall_get_arguments(struct task_struct *task,
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index a393b7f2760a..2f2a43414fe6 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -56,7 +56,8 @@ struct pt_regs
>  	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
>  	unsigned long result;		/* Result of a system call */
>  	unsigned long exit_flags;	/* System call exit flags */
> -	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
> +	unsigned long entry_flags;	/* System call entry flags */
> +	unsigned long __pt_regs_pad[2];	/* Maintain 16 byte interrupt stack alignment */
>  };
>  
>  #endif /* __ASSEMBLER__ */
> @@ -117,7 +118,8 @@ struct pt_regs
>  #define PT_DSISR 42
>  #define PT_RESULT 43
>  #define PT_EXIT_FLAGS 44
> -#define PT_PAD 47 /* 3 times */
> +#define PT_ENTRY_FLAGS 45
> +#define PT_PAD 46 /* 2 times */
>  #define PT_DSCR 48
>  #define PT_REGS_COUNT 48
>  
> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> index 316d4f5ead8e..440d00690cf2 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> @@ -235,6 +235,8 @@ void __init pt_regs_check(void)
>  		     offsetof(struct user_pt_regs, dsisr));
>  	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
>  		     offsetof(struct user_pt_regs, result));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, entry_flags) !=
> +		     offsetof(struct user_pt_regs, entry_flags));
>  
>  	BUILD_BUG_ON(sizeof(struct user_pt_regs) > sizeof(struct pt_regs));
>  
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index a9da2af6efa8..c7458aae199d 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -19,9 +19,27 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>  	long ret;
>  	syscall_fn f;
>  
> +	/*
> +	 * Zero entry_flags before syscall_enter_from_user_mode() so that
> +	 * syscall_set_return_value() can set SYSCALL_ENTRY_RET_SET as an
> +	 * unambiguous out-of-band signal.  The field is not initialised by
> +	 * the entry assembly.
> +	 */
> +	regs->entry_flags = 0;
>  	add_random_kstack_offset();
>  	r0 = syscall_enter_from_user_mode(regs, r0);
>  
> +	/*
> +	 * Seccomp or ptrace may have set a return value and requested that
> +	 * the syscall be skipped. syscall_set_return_value() sets
> +	 * SYSCALL_ENTRY_RET_SET in regs->entry_flags as an
> +	 * unambiguous out-of-band signal. This avoids the ambiguity of
> +	 * using r0 == -1 as the skip sentinel when the user themselves
> +	 * called syscall(-1).
> +	 */
> +	if (unlikely(test_and_clear_syscall_entry_ret(regs)))
> +		return regs->gpr[3];

Hello,

shouldn't this use the getter to correctly decode the value for both scv
and non-scv case?

Thanks

Michal

> +
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
>  			/* Unsupported scv vector */
> -- 
> 2.55.0
> 

