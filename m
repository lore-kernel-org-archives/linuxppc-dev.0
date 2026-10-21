Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE2606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=INY9OjIx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8gbd3x40z2xM9;
	Wed, 21 Oct 2026 18:17:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792567069;
	cv=none; b=CrdZB356ZiKclMgapgIeyCaqkRc0fez3z4bGtnbFpF2J3TgCqIY0ftVSWys0GSOzYve8JM6jf+ClvdhBkHU83e68nIaUFY4eXKtJ03hOP4DjKcjQQuA8J2NEabgWhiXNxtAo0GcW9/1i5I54UA4shF0NOSKpy3sxCjuc6LrDSoSK13++5ZSU56IGiYswWsda9bk2elWfT+lSZ5rQ/G19weej1+N4LlTyuZ6RUM0GrbbAw114L/ezxOVlags/wEDJr1UHjea9PBoFZMAnPrgnHpbuy5D2j5OgKRJFwAfSwcvs1EQIjoaKhy1YMEwifPLpOqa8Oda/dXECezzG/BGM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792567069; c=relaxed/relaxed;
	bh=dNHkp3TMA906yoOavuetpAdxfHJXR2U43F8kVqwiTi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ6CWksYikHkD9o6WMIFLWmhPvN9dgCovN/yGaP2jL9CLAeEfHcwnKBu2uV7YxrhytRfXhr+sNMw0pZZJcm2aptIAFzE2hyBRS/UyuqJCWIwEYxORUlMtQJ2k1Op6ZZPGvTOtrf240XiMFS9t2u39kdqZEOr0JbniYOGqniR5KKiMGNmYe5GochWrZMCOXKMLY8WVwlL7xWkpwDPm7A1Kl6UWZdqK2ohuFJYnmU7VJpmejmrKmW+vqeMJcqHQzA0/zFzKs9GzEnndwNj//McB0fmoPPoq4PTiBKLmBIk0Dqs3O+xAxEg5E1/3T3RB9nZuzOBKpRELesuyX3BpZ3D+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=INY9OjIx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=INY9OjIx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8gbc00ghz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 18:17:47 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so392290a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792567065; x=1793171865; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNHkp3TMA906yoOavuetpAdxfHJXR2U43F8kVqwiTi8=;
        b=INY9OjIxxt7WD5IOrEQ/KWxYNDOw9e14I23jfzMFfubhDVYJm+ETzDEITHkTxiAkdb
         G7Qel6aS+Iktn6UuXEKlR8bBhXmdH1u3+ka9fOHv7f0xK8eKedNA/I2lhe3KshWEr1vw
         F2jhQhS8xxkx+0irGZV9ktAuVemdfeMq2L8L8mvLoBariTQsNyCdrNoS2Lzo5Gdxgj4W
         QRvvSuMsY/p+VRBas5E86lQ2K4KSDLyLEMXY1LoWFuqvfl3Xb7645uc0PzSBGST+qOJx
         A5OY3ENG82/WLch4NqG++3jQA9nJWUz+QOshbrDMeJ8Naftes2LPNpMkR/NBBIixaMKT
         9ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567065; x=1793171865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dNHkp3TMA906yoOavuetpAdxfHJXR2U43F8kVqwiTi8=;
        b=Hp4jXnilgqaazjgDcdvaCSb02MQl/oQlsMmTSQekRYmXrMq9GMhns+AHm0UsAcb2Ea
         geez+R4H2YBCBw5L6TLNUL33JEBXtkEZHall+VLbhYYV2wC6n+XjeA2aesfbhRwYAL2e
         Np/QKSxFdnlDsH9bx6gVjeXeE+jxUxSP6zs7AbJ24xEaG+bFD1lqYHKLQ1NSjnFR7WiD
         qYCtv44oY8qqt/63NtTSerHONsktSPYfSz11NdxKjZMLjQWqNvr46qdo9ShVenE2D1uQ
         CH+nEvU53if14+1SQ9rCnf2EVk7Rg3fPEtQrZlkYyeLzG9siXAF64ii0gMQsNUfbQZYP
         Ws1w==
X-Forwarded-Encrypted: i=1; AKwUvBz5CHpyjCoa8Cqi2Mam9sHhUTbKSsW1yeAMjs985c6fzKYL6WKGhzRfcMsaqyJAwSPCID29+60HdVXfLVA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI3lgC0+d4QN83xMaC2KX77oIUPeZ723BiJAwP8kwlzDe1svSoZ
	uD93bjUC+xA3qMq58Zai97BsYJ5ut33wvzeYNqJyfZAMzRvFt+NvCBSVO7LNfw==
X-Gm-Gg: AYBFou0AP4CtKH67poTMH2FLamNMqllytmj+mbWPRX/XpTvsxjHzeOywGltY5oo+TFu
	gy6SZkV90YF7IE73/DHN6ib3az+GTdUllcA/RjHDEn/H58u96KxxYKLBWXm66coVDcNKtZClT67
	wFFqZwbKGLDAGgCpzc/83Ytunlqfg9iql9dAIcrH2fvRHo+nOFb2/M5XftDhyo0IMgli6IQy4Ut
	Ba8lpyxBjkwSHmMHlNOYPv1Dk8oq6M2sTR10sV2YQWWdsJB3lAlXTbm7WhkVP2bhPCQpPfsesZz
	I6A8SPRtH+x8RDOy7PVujk6DN7nbYEk7wMYR2YaVOy7nCMPtq43dQWn3jBmVTYmHRdlJn84GBio
	z8psl+KzvYgV2jU0rYlB1V74eEgQqYb4WKizaLLNmZQA3gjjjb1UOXXOxY8/4/uAr2tSzJGGzSy
	YdDG7qL5ZV4zFZNEaFqiSpu9NctnimXpmyS084w8UH2OPxWCzsyaNeVuLl2ASde8+G+KDfy9h2L
	5DyFrtkZXtQJ3fifFdqfLzUPJyZtl7x7dO7PPvZ9YS1ltD1rPaqM/L7VC6xKf/LoXoTNGk/BT68
	eKuX6SZBg1LeADpylW1krd67
X-Received: by 2002:a17:90b:2886:b0:3ab:188b:c5bf with SMTP id 98e67ed59e1d1-3ad86f4519bmr1005499a91.18.1792567065115;
        Wed, 21 Oct 2026 00:17:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7fb165a2sm3270457a91.0.2026.10.21.00.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:17:44 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:47:36 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Davide Berardi <berardi.dav@gmail.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Oleg Nesterov <oleg@redhat.com>, "Dmitry V . Levin" <ldv@strace.io>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] powerpc/syscall: Return the preset value of skipped
 syscalls
Message-ID: <athm2nYVnq6vYBY3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261018151539.440213-1-renzo@cs.unibo.it>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261018151539.440213-1-renzo@cs.unibo.it>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 18, 2026 at 05:15:33PM +0200, Renzo Davoli wrote:
> From: Davide Berardi <berardi.dav@gmail.com>
> 
> When ptrace or seccomp skip a system call, the return value they set in
> regs->gpr[3] gets lost or the tracer is affected, since two recent
> changes:
> 
> 1. Commit 05c033db7e9a ("entry, treewide: Make
>    syscall_enter_from_user_mode[_work]() indicate syscall execution")
>    made system_call_exception() return syscall_get_error() for a skipped
>    system call.  syscall_get_error() is 0 for any non-error value, so a
>    success value set by a tracer at a PTRACE_EVENT_SECCOMP stop (e.g.
>    with PTRACE_POKEUSER), or by a SECCOMP_RET_USER_NOTIF listener, is
>    replaced with 0.
> 
> 2. Commit 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for
>    seccomp and ptrace") made syscall_set_return_value() set
>    TIF_SYSCALL_RET with set_thread_flag(), i.e. on current rather than on
>    the task passed in.  When the caller is a tracer, as in
>    PTRACE_SET_SYSCALL_INFO with op == PTRACE_SYSCALL_INFO_EXIT, the flag
>    ends up on the tracer, and the next system call of the tracer is
>    silently not executed.  Setting it on the right task would not be
>    enough either: at a syscall-exit stop the flag would then skip the
>    next system call of the tracee.
> 
> TIF_SYSCALL_RET is not needed anymore: after the change described in 1.
> the generic entry code tells whether ptrace or seccomp skipped the
> system call, and every in-kernel caller of syscall_set_return_value() on
> the syscall entry path (SECCOMP_RET_ERRNO, SECCOMP_RET_TRACE without a
> tracer, SECCOMP_RET_USER_NOTIF) also makes it return false.  A user
> calling syscall(-1) without tracer or seccomp still gets -ENOSYS.
> 
> Remove the flag and return regs->gpr[3] for a skipped system call, as
> done before the conversion to GENERIC_ENTRY.  The syscall exit path
> already converts a negative error value to the "sc" ABI, and
> syscall_set_return_value() keeps CR0.SO in sync for positive error
> values.
> 
> Fixes: 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for seccomp and ptrace")
> Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
> Cc: Michal Suchánek <msuchanek@suse.de>
> Cc: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Assisted-by: claude-opus-5-5
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> ---
> How this was found and tested: QEMU pseries (TCG, -cpu power9), ppc64le
> guest config, v7.3-rc6 (7b63ef2d55f2), with a small reproducer
> (ppc_skip_repro.c, available on request) which
> 
Hey,
Can you share the reproducer?

Regards,
Mukesh
>  - sets the getpid() return value at a syscall-exit stop with
>    PTRACE_SET_SYSCALL_INFO, then makes a syscall in the tracer;
>  - skips getpid() at a PTRACE_EVENT_SECCOMP stop with PTRACE_POKEUSER
>    (r0 = -1, r3/CR0.SO = return value), with both "sc" and "scv 0".
> 
>                                              v7.3-rc6      with this patch
>   tracer syscall after SET_SYSCALL_INFO      returns 0     correct
>   skipped syscall, success value, sc/scv     returns 0     correct
>   skipped syscall, error value, sc/scv       correct       correct
>   selftests/ptrace set_syscall_info test    FAIL          pass
>   selftests/seccomp/seccomp_bpf              11 failures   all pass (*)
> 
>   failing in v7.3-rc6: user_notification_{basic,child_pid_ns,
>   sibling_pid_ns,fault_recv,addfd,addfd_rlimit,sync,fifo,wait_killable},
>   TRACE_syscall.seccomp.syscall_faked, plus the timing-only one below.
> 
> (*) user_notification_wait_killable_after_reply (100000 notifications
>     with a 1 ms itimer) can hit the 30 s harness timeout under emulation,
>     with and without this patch.
> 
> Build-tested with W=1: ppc64le guest config, ppc64_defconfig (BE),
> pmac32_defconfig.
> 
>  arch/powerpc/include/asm/syscall.h     |  6 ------
>  arch/powerpc/include/asm/thread_info.h |  1 -
>  arch/powerpc/kernel/syscall.c          | 15 ++++++++-------
>  3 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 32be22b995cc..4b3c52ed6e9d 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -98,12 +98,6 @@ static inline void syscall_set_return_value(struct task_struct *task,
>  			regs->gpr[3] = val;
>  		}
>  	}
> -	/*
> -	 * Mark that a return value has been explicitly set by seccomp or
> -	 * ptrace so that system_call_exception() can skip the syscall
> -	 * unconditionally, even when the user requested syscall(-1).
> -	 */
> -	set_thread_flag(TIF_SYSCALL_RET);
>  }
>  
>  static inline void syscall_get_arguments(struct task_struct *task,
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 1e069a2e7ce8..0487e94d3416 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -120,7 +120,6 @@ void arch_setup_new_exec(void);
>  #endif
>  #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
>  #define TIF_32BIT		20	/* 32 bit binary */
> -#define TIF_SYSCALL_RET		21	/* syscall error value set */
>  
>  /* as above, but as bit values */
>  #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index fbefe1927b10..52ceff4ef41b 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,13 +18,14 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>  	long ret;
>  	syscall_fn f;
>  
> -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
> -		clear_thread_flag(TIF_SYSCALL_RET);
> -		return syscall_get_error(current, regs);
> -	}
> -
> -	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
> -		return syscall_get_error(current, regs);
> +	/*
> +	 * If ptrace or seccomp decided to skip the syscall, regs->gpr[3] holds
> +	 * the return value they set (or the unmodified first argument, e.g.
> +	 * for PTRACE_SYSEMU). Return it as is, the exit path takes care of
> +	 * the error encoding for the "sc" ABI.
> +	 */
> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
> +		return regs->gpr[3];
>  
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
> -- 
> 2.55.0
> 

