Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279B606A327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=A9JUTUHq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b5+YSp4z;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tunWwSU+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=r6R8KcJN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDRLt2qPFz2yDc;
	Tue, 27 Oct 2026 21:19:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793096390;
	cv=none; b=e6yG3SE37KmxTmoVQ9WqxIRYlNm3OhmdkbsDmHATif7sAVvYXqqD2wikaqnYTdZlR3NRMVtKULw4uSHjfJTUPR0RyyVr0KizwhpSs56t3D7pH63EeYbijTT/WmCOQ+EyhceUPD709k8Hh7GRG/ZmXIbRrIIgbb39UPVSnwqhvNgMcgu5suhjJZBaPHBnexShO+wuKQ32CL7LC3LXT9/JoyTmDlLWZrnwOOMY8tPa53RUFxJB9XR07fylFRlku0CDSQTw5phxs/6wyolsP4nBCZBXI4oobhJmv6KRUvf4vnNMmXe7Vj307ijsMJhdPclEluP7CxgqfOKnXWOCyEFvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793096390; c=relaxed/relaxed;
	bh=IJyKLm11OKZ6eURA0CICtxmo8ADsEiyPCzboZYdf9FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPw8aTa4TmFvxnz5QkE8XMskHnE3TJ58L/N+LiUnl9zqxFcgQmS4p9ol2irPQzaMYMvuFVxoYWaqlgQ4A7jyc79IvnhgZy7SgJ/PyAwga97QGqu45hscplriCI7dCzdL0XJRPUWw3RgaYSttUyQagN9o2t8sggyfq5jsNzWFTcRieM/CpECArS86sfRJTPNz9EKmrZFpNQSevCIHWtjRmqRUQDDI2mkIVcJZjLGnYB0Z0MYtwUxm31CKv13Z0eOp2OfxDbIhTcKV6WqElK73xNELJFIieWzEAPk7fb4ZxtGLUOAoxqZG5hH1D6wOi9k+b1wAaSV9prshR+lqgbea1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=A9JUTUHq; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b5+YSp4z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tunWwSU+; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=r6R8KcJN; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=A9JUTUHq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b5+YSp4z;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tunWwSU+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=r6R8KcJN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDRLr5mvGz2xjh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 21:19:48 +1100 (AEDT)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4C491F854;
	Tue, 27 Oct 2026 10:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793096384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJyKLm11OKZ6eURA0CICtxmo8ADsEiyPCzboZYdf9FA=;
	b=A9JUTUHq9cHJV24C/NEdWbxQhdD09XBaK+slhoUXpq45KaoA6g9NuJpWQcR6BdWVoa+4/b
	W5U3WwcG7zacyJnzl8KZ38B+51bggevOluXtI30XZTuaxFDRBqF43l/o26ylYK/hYo6/gL
	dbVJIaTU+sGYcTrRV0barUdIJ16kdzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793096384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJyKLm11OKZ6eURA0CICtxmo8ADsEiyPCzboZYdf9FA=;
	b=b5+YSp4zOW5waQLFRNJ3QGpjD5ZFxygGHK/5eOiNepehBtsQCI3BrUPsSGRaj8BrHLSgDv
	RkuFhNVmeQKLGIDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tunWwSU+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=r6R8KcJN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793096383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJyKLm11OKZ6eURA0CICtxmo8ADsEiyPCzboZYdf9FA=;
	b=tunWwSU+JZk0w1zCyaKf+Tk5gNxPNtBAOhbnFoVo+LI3TnI4NqhuCgZkzdQa0bAq9W1z7j
	1eR88R5sHauImm1ZstwJG6mDwKns/SSXVmDExLeJt0tERdfzkAUXiEtEFMat3S7LCBANk/
	2FR92xB1j+nk+dCrCZSKe8TWbjc3wBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793096383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJyKLm11OKZ6eURA0CICtxmo8ADsEiyPCzboZYdf9FA=;
	b=r6R8KcJNvGqcSCau5SxUaoq+e6t4JCZ1xjDM7dIm7tqruAEwnUZFkCcHU62Fhyb6jciXr+
	sUTYLhtreIFarJCg==
Date: Tue, 27 Oct 2026 11:19:42 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] powerpc/syscall: Return the preset value of
 skipped syscalls
Message-ID: <auB6vjNg3w5LPVwb@kunlun.suse.cz>
References: <20261023180735.853655-1-renzo@cs.unibo.it>
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
In-Reply-To: <20261023180735.853655-1-renzo@cs.unibo.it>
X-Spamd-Result: default: False [-6.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	RDNS_NONE(1.00)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.984];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org,redhat.com,strace.io,alpha.franken.de,linux-foundation.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D4C491F854
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Fri, Oct 23, 2026 at 08:07:32PM +0200, Renzo Davoli wrote:
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
> Cc: stable@vger.kernel.org # v7.3
> Assisted-by: claude-opus-5-5
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> ---
> How this was found and tested: QEMU pseries (TCG, -cpu power9), ppc64le
> guest config, v7.3-rc6 (7b63ef2d55f2), with a small reproducer
> (ppc_skip_repro.c, available on request) which
> 
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
> Changes in v2:
> - Rebased on current mainline (734bef548a96), which now contains
>   commit 66236558dfac ("powerpc/syscall: Avoid atomic
>   test_and_clear_thread_flag on fast path").  That commit folded the
>   TIF_SYSCALL_RET check into the skip condition, so the v1 hunk in
>   system_call_exception() no longer applied.  The resulting code is the
>   same as with v1.
> - Link to v1:
>   https://lore.kernel.org/lkml/20261018151539.440213-1-renzo@cs.unibo.it
> 
>  arch/powerpc/include/asm/syscall.h     |  6 ------
>  arch/powerpc/include/asm/thread_info.h |  1 -
>  arch/powerpc/kernel/syscall.c          | 13 ++++++++-----
>  3 files changed, 8 insertions(+), 12 deletions(-)
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
> index 8529827d697f..52ceff4ef41b 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,11 +18,14 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>  	long ret;
>  	syscall_fn f;
>  
> -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
> -			test_thread_flag(TIF_SYSCALL_RET))) {
> -		clear_thread_flag(TIF_SYSCALL_RET);
> -		return syscall_get_error(current, regs);
> -	}
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

This does two things that should be addressed separately:

 - eliminating the TIF_SYSCALL_RET flag

The previous refactor aimed at removing this flag. If the kernel still
builds when it's removed removing the flag and the branch that tests it
is merely dead code eliminaation unless there is something creative
going on somewhere.

 - replacing syscall_get_error() with regs->gpr[3]

This is a very dubious change. If this does fix something this is likely
papering over some place that sets the return value incorrectly.
Instead of this change the place where the incorrect setting of the
return value happens should be fixed.

Thanks

Michal

