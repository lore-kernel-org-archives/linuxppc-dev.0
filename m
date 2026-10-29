Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C46606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=VucilZ4b
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFmwV4Jl5z30FB;
	Fri, 30 Oct 2026 01:35:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793284506;
	cv=none; b=ZppAeoU/gsatube3uoc5I6kDkeF95Sfi8U8vX6kX+zFtLYoltdhIHRDFI7AuGFQTADzmlr/7/sURkgtS5lAg4aIM8oEdjBjbVMR8gv1eZ0xnFB0lraYaydt1/iv7y7UGmH+pYZLjrS1KhamocWGaETePIT8EDx26oZhJr67YYYRe76VZ6SMFkFM3h9Hmk7QWMsv/x/Ym2qVRBGnYwjNf1VkfnzHSb+7wEsEWDXP3axQI2CLc85vJ8iMgvDH0tr0oZG2Pw7FgLJXngZKz5En5AkA8P078oJ0Tm1OFPd31CuOcY7vxw3OTBZP8/+8ttKYNYe2ex55qFJYQ7LekxUZAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793284506; c=relaxed/relaxed;
	bh=UcsMop639s7djhtUDJ8XkO0CoqAAaqDHDg0ZJlQPuqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvo/DujbHKqW4bk73NZzCk902k1lYyZdSO08Hq8LO6CIhgXFttvlI9vJ/Nfvc9hvF7+dm4LabSQkzU3F55oJb5r/v9Vll7FGLF2+WZsIqatttoNv2xgozZRq6MUzQbCKhfVhaEiX5oHyMHeo0W6IRLQbLypbtlqkX77d+vhV4F2xEs4KsnmdIpetuX2mlhNsQ/EKFdcdEmLVl+zx/J6V+8VFLiXOHIYpsWghW9SdHHFfNk9bkwNUUkyTpUkYbSepeCSBQs0eP83YiZoKsYa3S8vaEZ2gaO8rR/CKcVM72JRoz+bPLchUCXv3K5H60ehhZiiKzDdpxO+S3DdigsNopQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=VucilZ4b; dkim-atps=neutral; spf=pass (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=VucilZ4b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFmwQ2MQrz3048
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 01:34:59 +1100 (AEDT)
Received: from cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id D66421C006E;
	Thu, 29 Oct 2026 15:34:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1793284491;
	bh=OJBr8ktrL05qExyJXBS5Qe8L5jHeJF4KPZCQjWdB0bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VucilZ4b0ZM05mqPZvjoJUVYvw+5fKoXiD+JpM2NzELfc8wpUQM29JUveNtm6vwyQ
	 9PMGhX/ZY1ZlFDYfp8fXL0KP07wVKTIiYFxF3VL7IITEiTtUE6AFAYzwkSNnni+172
	 BBQFgfilaPCwmqQIQALNvTugNz1dNTLA9SPgsFfo=
Date: Thu, 29 Oct 2026 15:34:48 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] powerpc/syscall: Return the preset value of
 skipped syscalls
Message-ID: <auNZiOi_tj6ssGZr@cs.unibo.it>
References: <20261023180735.853655-1-renzo@cs.unibo.it>
 <auB6vjNg3w5LPVwb@kunlun.suse.cz>
 <auLyYd9-6WwwzPgz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <auLyYd9-6WwwzPgz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mukesh,

  thanks. I think we agree on the diagnosis: as your comment says,
the return value has already been stored in regs, so the problem is
only that system_call_exception() returns syscall_get_error(), which
is 0 for any non-error value.

To Michal's point: there is no place setting the value incorrectly;
r3 holds the right value, it is syscall_get_error() that cannot
report a successful one.

I like your variant: syscall_get_error() ?: regs->gpr[3] leaves the
error path exactly as it is today and only changes the success path.
I retested it with the ptrace set_syscall_info selftest and
ppc_skip_repro.c (see
https://lore.kernel.org/lkml/ato6Tq0aKdqqdqyJ@cs.unibo.it/)
and it behaves the same as my v2.

I will send a v3 rebased on current mainline, split in two:
 1/2 remove TIF_SYSCALL_RET (Fixes: 69cb2be898be), as suggested by
     Michal
 2/2 return the preset value of a skipped syscall (Fixes: 05c033db7e9a)
     using your expression.

Would you like a Suggested-by for the return expression?

renzo

On Thu, Oct 29, 2026 at 12:48:42PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Oct 27, 2026 at 11:19:42AM +0100, Michal Suchánek wrote:
> > Hello,
> > 
> > On Fri, Oct 23, 2026 at 08:07:32PM +0200, Renzo Davoli wrote:
> > > When ptrace or seccomp skip a system call, the return value they set in
> > > regs->gpr[3] gets lost or the tracer is affected, since two recent
> > > changes:
> > > 
> > > 1. Commit 05c033db7e9a ("entry, treewide: Make
> > >    syscall_enter_from_user_mode[_work]() indicate syscall execution")
> > >    made system_call_exception() return syscall_get_error() for a skipped
> > >    system call.  syscall_get_error() is 0 for any non-error value, so a
> > >    success value set by a tracer at a PTRACE_EVENT_SECCOMP stop (e.g.
> > >    with PTRACE_POKEUSER), or by a SECCOMP_RET_USER_NOTIF listener, is
> > >    replaced with 0.
> > > 
> > > 2. Commit 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for
> > >    seccomp and ptrace") made syscall_set_return_value() set
> > >    TIF_SYSCALL_RET with set_thread_flag(), i.e. on current rather than on
> > >    the task passed in.  When the caller is a tracer, as in
> > >    PTRACE_SET_SYSCALL_INFO with op == PTRACE_SYSCALL_INFO_EXIT, the flag
> > >    ends up on the tracer, and the next system call of the tracer is
> > >    silently not executed.  Setting it on the right task would not be
> > >    enough either: at a syscall-exit stop the flag would then skip the
> > >    next system call of the tracee.
> > > 
> > > TIF_SYSCALL_RET is not needed anymore: after the change described in 1.
> > > the generic entry code tells whether ptrace or seccomp skipped the
> > > system call, and every in-kernel caller of syscall_set_return_value() on
> > > the syscall entry path (SECCOMP_RET_ERRNO, SECCOMP_RET_TRACE without a
> > > tracer, SECCOMP_RET_USER_NOTIF) also makes it return false.  A user
> > > calling syscall(-1) without tracer or seccomp still gets -ENOSYS.
> > > 
> > > Remove the flag and return regs->gpr[3] for a skipped system call, as
> > > done before the conversion to GENERIC_ENTRY.  The syscall exit path
> > > already converts a negative error value to the "sc" ABI, and
> > > syscall_set_return_value() keeps CR0.SO in sync for positive error
> > > values.
> > > 
> > > Fixes: 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for seccomp and ptrace")
> > > Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
> > > Cc: Michal Suchánek <msuchanek@suse.de>
> > > Cc: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > > Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> > > Cc: Thomas Gleixner <tglx@kernel.org>
> > > Cc: stable@vger.kernel.org # v7.3
> > > Assisted-by: claude-opus-5-5
> > > Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> > > ---
> > > How this was found and tested: QEMU pseries (TCG, -cpu power9), ppc64le
> > > guest config, v7.3-rc6 (7b63ef2d55f2), with a small reproducer
> > > (ppc_skip_repro.c, available on request) which
> > > 
> > >  - sets the getpid() return value at a syscall-exit stop with
> > >    PTRACE_SET_SYSCALL_INFO, then makes a syscall in the tracer;
> > >  - skips getpid() at a PTRACE_EVENT_SECCOMP stop with PTRACE_POKEUSER
> > >    (r0 = -1, r3/CR0.SO = return value), with both "sc" and "scv 0".
> > > 
> > >                                              v7.3-rc6      with this patch
> > >   tracer syscall after SET_SYSCALL_INFO      returns 0     correct
> > >   skipped syscall, success value, sc/scv     returns 0     correct
> > >   skipped syscall, error value, sc/scv       correct       correct
> > >   selftests/ptrace set_syscall_info test    FAIL          pass
> > >   selftests/seccomp/seccomp_bpf              11 failures   all pass (*)
> > > 
> > >   failing in v7.3-rc6: user_notification_{basic,child_pid_ns,
> > >   sibling_pid_ns,fault_recv,addfd,addfd_rlimit,sync,fifo,wait_killable},
> > >   TRACE_syscall.seccomp.syscall_faked, plus the timing-only one below.
> > > 
> > > (*) user_notification_wait_killable_after_reply (100000 notifications
> > >     with a 1 ms itimer) can hit the 30 s harness timeout under emulation,
> > >     with and without this patch.
> > > 
> > > Build-tested with W=1: ppc64le guest config, ppc64_defconfig (BE),
> > > pmac32_defconfig.
> > > 
> > > Changes in v2:
> > > - Rebased on current mainline (734bef548a96), which now contains
> > >   commit 66236558dfac ("powerpc/syscall: Avoid atomic
> > >   test_and_clear_thread_flag on fast path").  That commit folded the
> > >   TIF_SYSCALL_RET check into the skip condition, so the v1 hunk in
> > >   system_call_exception() no longer applied.  The resulting code is the
> > >   same as with v1.
> > > - Link to v1:
> > >   https://lore.kernel.org/lkml/20261018151539.440213-1-renzo@cs.unibo.it
> > > 
> > >  arch/powerpc/include/asm/syscall.h     |  6 ------
> > >  arch/powerpc/include/asm/thread_info.h |  1 -
> > >  arch/powerpc/kernel/syscall.c          | 13 ++++++++-----
> > >  3 files changed, 8 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> > > index 32be22b995cc..4b3c52ed6e9d 100644
> > > --- a/arch/powerpc/include/asm/syscall.h
> > > +++ b/arch/powerpc/include/asm/syscall.h
> > > @@ -98,12 +98,6 @@ static inline void syscall_set_return_value(struct task_struct *task,
> > >  			regs->gpr[3] = val;
> > >  		}
> > >  	}
> > > -	/*
> > > -	 * Mark that a return value has been explicitly set by seccomp or
> > > -	 * ptrace so that system_call_exception() can skip the syscall
> > > -	 * unconditionally, even when the user requested syscall(-1).
> > > -	 */
> > > -	set_thread_flag(TIF_SYSCALL_RET);
> > >  }
> > >  
> > >  static inline void syscall_get_arguments(struct task_struct *task,
> > > diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> > > index 1e069a2e7ce8..0487e94d3416 100644
> > > --- a/arch/powerpc/include/asm/thread_info.h
> > > +++ b/arch/powerpc/include/asm/thread_info.h
> > > @@ -120,7 +120,6 @@ void arch_setup_new_exec(void);
> > >  #endif
> > >  #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
> > >  #define TIF_32BIT		20	/* 32 bit binary */
> > > -#define TIF_SYSCALL_RET		21	/* syscall error value set */
> > >  
> > >  /* as above, but as bit values */
> > >  #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
> > > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > > index 8529827d697f..52ceff4ef41b 100644
> > > --- a/arch/powerpc/kernel/syscall.c
> > > +++ b/arch/powerpc/kernel/syscall.c
> > > @@ -18,11 +18,14 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > >  	long ret;
> > >  	syscall_fn f;
> > >  
> > > -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
> > > -			test_thread_flag(TIF_SYSCALL_RET))) {
> > > -		clear_thread_flag(TIF_SYSCALL_RET);
> > > -		return syscall_get_error(current, regs);
> > > -	}
> > > +	/*
> > > +	 * If ptrace or seccomp decided to skip the syscall, regs->gpr[3] holds
> > > +	 * the return value they set (or the unmodified first argument, e.g.
> > > +	 * for PTRACE_SYSEMU). Return it as is, the exit path takes care of
> > > +	 * the error encoding for the "sc" ABI.
> > > +	 */
> > > +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
> > > +		return regs->gpr[3];
> > >  
> > >  	if (unlikely(r0 >= NR_syscalls)) {
> > >  		if (unlikely(trap_is_unsupported_scv(regs))) {
> > 
> > This does two things that should be addressed separately:
> > 
> >  - eliminating the TIF_SYSCALL_RET flag
> > 
> > The previous refactor aimed at removing this flag. If the kernel still
> > builds when it's removed removing the flag and the branch that tests it
> > is merely dead code eliminaation unless there is something creative
> > going on somewhere.
> > 
> >  - replacing syscall_get_error() with regs->gpr[3]
> > 
> > This is a very dubious change. If this does fix something this is likely
> > papering over some place that sets the return value incorrectly.
> > Instead of this change the place where the incorrect setting of the
> > return value happens should be fixed.
> > 
> > Thanks
> > 
> > Michal
> 
> I agree with Michal here.
> 
> what do you think about this diff
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
> index 4df3f4b5bd56..f4f35314a901 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -110,7 +110,6 @@ void arch_setup_new_exec(void);
>  #endif
>  #define TIF_POLLING_NRFLAG	22	/* true if poll_idle() is polling TIF_NEED_RESCHED */
>  #define TIF_32BIT		23	/* 32 bit binary */
> -#define TIF_SYSCALL_RET		24	/* syscall error value set */
>  
>  /* as above, but as bit values */
>  #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index fbefe1927b10..ec81046e9eb5 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -19,13 +19,17 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>  	syscall_fn f;
>  
>  	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
> -		clear_thread_flag(TIF_SYSCALL_RET);
> -		return syscall_get_error(current, regs);
> +		/*
> +		 * The syscall was skipped by seccomp or ptrace, which have
> +		 * already stored the result in the user ABI form via
> +		 * syscall_set_return_value(). Hand it back in the form
> +		 * syscall_exit_prepare() expects: -errno on failure, else the
> +		 * value in r3. Using syscall_get_error() alone would drop a
> +		 * successful value, e.g. from SECCOMP_USER_NOTIF.
> +		 */
> +		return syscall_get_error(current, regs) ?: regs->gpr[3];
>  	}
>  
> -	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
> -		return syscall_get_error(current, regs);
> -
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
>  			/* Unsupported scv vector */
> 
> 
> 
> Regards,
> Mukesh

