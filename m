Return-Path: <linuxppc-dev+bounces-24859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0AAC53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 08:04:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7rhg07zYz2yhD;
	Mon, 27 Jul 2026 18:04:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785139442;
	cv=none; b=JJpDqvtMMDtOzBBtcsmzJflKpPR3NYDpp2briDppi3qsevCTn7TI3SKxpIjXy86ONtsh7ZoC9SO9BTLsO8PWXI9KivmBr26RwLnApBfccTC3hp2jn3LjSbkDOYhFKWOb4lHPmNbjxWXfmNk6JWRQ8xZeGWU4JFs6FwzQd01L27e2CCknVwE909pZiEfHfow09tp7pHgNU8OTl5MybCy4rPIs4mOMzKpfLezkp8Pm2+SEQtEc4TrVWwyGKrBTGPqFJQX3HJe1EPshRuXXS+6OZ5yOxSMyryAEji4YCGY0VNdt6KG6YqtPJpcjiyFEXYnR8HhQFhjXFBz6AJF3zTyUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785139442; c=relaxed/relaxed;
	bh=TRg52oR5I5wH6dLeFOtB/eCeIY5KF1ZRQ/blSMqcQhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZumRUAL4mWtdUIpN2B1t6TxRQDY8qnEHJHI0/C0jwYi0byC3BA8z3VDhG+GuUOrgeAJXBAadRk1BEU/+PRSRMI5rj0waauid5TYSGjPfTkRcRMHLaNTytGIdKb/CByAj3+z18gfE4aWfs+A4NmFqPJr752YF4I2SIYjzf5oM35YLWmEpx/2Bir+vHVNkNbCCuyODRV77rrINCl9o+VLe6DGAf0652HlErodS9RTpScQ4tgO1BRACm0AyolUBsZNh7CWzMENCofgdn9PiYBRTNCUeCROFb/c2ai2LxF8/w6o3KjhzpjVdbN+4Hy27o04uI6mnjfWNQP/iKVBNe1Vnzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=X1+0gxNE; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0yndCrPk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f8rKwVXk; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=owAeFPdx; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=X1+0gxNE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0yndCrPk;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f8rKwVXk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=owAeFPdx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7rhd3s2hz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 18:04:01 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 219EE4228;
	Mon, 27 Jul 2026 08:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785139433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRg52oR5I5wH6dLeFOtB/eCeIY5KF1ZRQ/blSMqcQhE=;
	b=X1+0gxNEnD9zPvj4fEDoQUZIX1IOa5woXrdGDK/YpVrsH6uzpWPtisIEkN6u/KbdZ64rcD
	3qOqmSr9UqXSdiLZQW9hJ/tMxhu+ATLt/cnkfo4mQAkih/lPKLJbMtADHNNTw55Kllt0D9
	WUtV46uBX3gKkX62d3xtCP0HLhSNbg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785139433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRg52oR5I5wH6dLeFOtB/eCeIY5KF1ZRQ/blSMqcQhE=;
	b=0yndCrPkvxtZmOjDaz/I6S63dXY6SFOyiOcDAFBiBwiGEbmb+cLnNwUnTRy1o0tgq4lYqn
	Cz1W9xzL+sN4btAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f8rKwVXk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=owAeFPdx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785139429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRg52oR5I5wH6dLeFOtB/eCeIY5KF1ZRQ/blSMqcQhE=;
	b=f8rKwVXkurTyCB3NTBALpWGMmFO3VgEbICCrcTP0pe2D4HQRJLN7kHOK4GYeEXAdwIr51D
	4/d8ffSXjO5pKos6Mwf6+gl4C+oXkEYE6BnszXGcSulH+lgGXa0vJJ3RqEO66jGizXpDwG
	CWy70OFHlJO7//kaImmGqEeydDikYEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785139429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRg52oR5I5wH6dLeFOtB/eCeIY5KF1ZRQ/blSMqcQhE=;
	b=owAeFPdxPgEfYai6c30OkFOK933UAkitlzvTyK+vhxOL5kbN3U2docZamxuReAr0121ymx
	krFCCyYzGAeYo6Bw==
Date: Mon, 27 Jul 2026 10:03:48 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: oleg@redhat.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, mchauras@linux.ibm.com,
	sshegde@linux.ibm.com, segher@kernel.crashing.org, thuth@redhat.com,
	kees@kernel.org, ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] powerpc/syscall: Fix syscall skip handling for
 seccomp and ptrace
Message-ID: <amcQ5N42Svm7oE7j@kunlun.suse.cz>
References: <20260714075935.1830145-1-mkchauras@gmail.com>
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
In-Reply-To: <20260714075935.1830145-1-mkchauras@gmail.com>
X-Spamd-Result: default: False [2.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,kernel.crashing.org,arm.com,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 219EE4228
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action

Hello,

this should be probably adjusted to match

https://lore.kernel.org/linuxppc-dev/20260723194809.4046600-1-mkchauras@gmail.com/

Thanks

Michal

On Tue, Jul 14, 2026 at 01:29:35PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
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
> Tested-by: Michal Suchánek <msuchanek@suse.de>
> Reviewed-by: Michal Suchánek <msuchanek@suse.de>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> v4 -> v5:
>  - Fixed build failure where BITS macro is not available
> v3 -> v4:
>  - Use syscall_get_error (Michal)
> v2 -> v3:
>  - Last fix is not working for -1 syscall. Fixed that with this.
> v2: https://lore.kernel.org/all/20260629182946.419552-1-mkchauras@gmail.com
> 
> v1 -> v2:
>  - Fix issues in the previous fix (Michal)
> v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com
> 
> 
>  arch/powerpc/include/asm/ptrace.h      | 23 ++++++++++++++++++++++-
>  arch/powerpc/include/asm/syscall.h     |  6 ++++++
>  arch/powerpc/include/uapi/asm/ptrace.h |  6 ++++--
>  arch/powerpc/kernel/ptrace/ptrace.c    |  2 ++
>  arch/powerpc/kernel/syscall.c          | 18 ++++++++++++++++++
>  5 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index fdeb97421785..363a89787f1c 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -19,6 +19,7 @@
>  #ifndef _ASM_POWERPC_PTRACE_H
>  #define _ASM_POWERPC_PTRACE_H
>  
> +#include <linux/bits.h>
>  #include <linux/err.h>
>  #include <uapi/asm/ptrace.h>
>  #include <asm/asm-const.h>
> @@ -54,8 +55,9 @@ struct pt_regs
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
> @@ -233,6 +235,25 @@ static inline unsigned long frame_pointer(struct pt_regs *regs)
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
> index a9da2af6efa8..a43d3a9428cc 100644
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
> +		return syscall_get_error(current, regs);
> +
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
>  			/* Unsupported scv vector */
> -- 
> 2.55.0
> 

