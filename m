Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9228A1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:48:04 +1000 (AEST)
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1185414018C
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 04:48:03 +1000 (AEST)
Received: by igbij6 with SMTP id ij6so84543963igb.1
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 11:48:01 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1437646871-3195-2-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
 <1437646871-3195-2-git-send-email-mpe@ellerman.id.au>
Date: Mon, 27 Jul 2015 11:48:01 -0700
Message-ID: <CAGXu5jKbzhn=MA7QEdYT1Eb8wU_HYAZ7bf2nCY7qJYFz8p8Y-Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] powerpc/kernel: Change the do_syscall_trace_enter()
 API
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 strosake@linux.vnet.ibm.com, bogdan.purcareata@freescale.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 23, 2015 at 3:21 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> The API for calling do_syscall_trace_enter() is currently sensible
> enough, it just returns the (modified) syscall number.
>
> However once we enable seccomp filter it will get more complicated. When
> seccomp filter runs, the seccomp kernel code (via SECCOMP_RET_ERRNO), or
> a ptracer (via SECCOMP_RET_TRACE), may reject the syscall and *may* or may
> *not* set a return value in r3.
>
> That means the assembler that calls do_syscall_trace_enter() can not
> blindly return ENOSYS, it needs to only return ENOSYS if a return value
> has not already been set.
>
> There is no way to implement that logic with the current API. So change
> the do_syscall_trace_enter() API to make it deal with the return code
> juggling, and the assembler can then just return whatever return code it
> is given.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/powerpc/kernel/entry_32.S |  4 ++++
>  arch/powerpc/kernel/entry_64.S | 23 ++++++++++++++------
>  arch/powerpc/kernel/ptrace.c   | 48 ++++++++++++++++++++++++++++++++----------
>  3 files changed, 58 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 67ecdf61f4e3..2405631e91a2 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -458,6 +458,10 @@ syscall_dotrace:
>         lwz     r7,GPR7(r1)
>         lwz     r8,GPR8(r1)
>         REST_NVGPRS(r1)
> +
> +       cmplwi  r0,NR_syscalls
> +       /* Return code is already in r3 thanks to do_syscall_trace_enter() */
> +       bge-    ret_from_syscall
>         b       syscall_dotrace_cont
>
>  syscall_exit_work:
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index ee15d3c62e26..a94f155db78e 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -151,8 +151,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>         CURRENT_THREAD_INFO(r11, r1)
>         ld      r10,TI_FLAGS(r11)
>         andi.   r11,r10,_TIF_SYSCALL_DOTRACE
> -       bne     syscall_dotrace
> -.Lsyscall_dotrace_cont:
> +       bne     syscall_dotrace         /* does not return */
>         cmpldi  0,r0,NR_syscalls
>         bge-    syscall_enosys
>
> @@ -246,22 +245,34 @@ syscall_dotrace:
>         bl      save_nvgprs
>         addi    r3,r1,STACK_FRAME_OVERHEAD
>         bl      do_syscall_trace_enter
> +
>         /*
> -        * Restore argument registers possibly just changed.
> -        * We use the return value of do_syscall_trace_enter
> -        * for the call number to look up in the table (r0).
> +        * We use the return value of do_syscall_trace_enter() as the syscall
> +        * number. If the syscall was rejected for any reason do_syscall_trace_enter()
> +        * returns an invalid syscall number and the test below against
> +        * NR_syscalls will fail.
>          */
>         mr      r0,r3
> +
> +       /* Restore argument registers just clobbered and/or possibly changed. */
>         ld      r3,GPR3(r1)
>         ld      r4,GPR4(r1)
>         ld      r5,GPR5(r1)
>         ld      r6,GPR6(r1)
>         ld      r7,GPR7(r1)
>         ld      r8,GPR8(r1)
> +
> +       /* Repopulate r9 and r10 for the system_call path */
>         addi    r9,r1,STACK_FRAME_OVERHEAD
>         CURRENT_THREAD_INFO(r10, r1)
>         ld      r10,TI_FLAGS(r10)
> -       b       .Lsyscall_dotrace_cont
> +
> +       cmpldi  r0,NR_syscalls
> +       blt+    system_call
> +
> +       /* Return code is already in r3 thanks to do_syscall_trace_enter() */
> +       b       .Lsyscall_exit
> +
>
>  syscall_enosys:
>         li      r3,-ENOSYS
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index f21897b42057..7484221bb3f8 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -1762,26 +1762,42 @@ long arch_ptrace(struct task_struct *child, long request,
>         return ret;
>  }
>
> -/*
> - * We must return the syscall number to actually look up in the table.
> - * This can be -1L to skip running any syscall at all.
> +/**
> + * do_syscall_trace_enter() - Do syscall tracing on kernel entry.
> + * @regs: the pt_regs of the task to trace (current)
> + *
> + * Performs various types of tracing on syscall entry. This includes seccomp,
> + * ptrace, syscall tracepoints and audit.
> + *
> + * The pt_regs are potentially visible to userspace via ptrace, so their
> + * contents is ABI.
> + *
> + * One or more of the tracers may modify the contents of pt_regs, in particular
> + * to modify arguments or even the syscall number itself.
> + *
> + * It's also possible that a tracer can choose to reject the system call. In
> + * that case this function will return an illegal syscall number, and will put
> + * an appropriate return value in regs->r3.
> + *
> + * Return: the (possibly changed) syscall number.
>   */
>  long do_syscall_trace_enter(struct pt_regs *regs)
>  {
> -       long ret = 0;
> +       bool abort = false;
>
>         user_exit();
>
>         secure_computing_strict(regs->gpr[0]);
>
> -       if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> -           tracehook_report_syscall_entry(regs))
> +       if (test_thread_flag(TIF_SYSCALL_TRACE)) {
>                 /*
> -                * Tracing decided this syscall should not happen.
> -                * We'll return a bogus call number to get an ENOSYS
> -                * error, but leave the original number in regs->gpr[0].
> +                * The tracer may decide to abort the syscall, if so tracehook
> +                * will return !0. Note that the tracer may also just change
> +                * regs->gpr[0] to an invalid syscall number, that is handled
> +                * below on the exit path.
>                  */
> -               ret = -1L;
> +               abort = tracehook_report_syscall_entry(regs) != 0;
> +       }
>
>         if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
>                 trace_sys_enter(regs, regs->gpr[0]);
> @@ -1798,7 +1814,17 @@ long do_syscall_trace_enter(struct pt_regs *regs)
>                                     regs->gpr[5] & 0xffffffff,
>                                     regs->gpr[6] & 0xffffffff);
>
> -       return ret ?: regs->gpr[0];
> +       if (abort || regs->gpr[0] >= NR_syscalls) {
> +               /*
> +                * If we are aborting explicitly, or if the syscall number is
> +                * now invalid, set the return value to -ENOSYS.
> +                */
> +               regs->gpr[3] = -ENOSYS;
> +               return -1;
> +       }
> +
> +       /* Return the possibly modified but valid syscall number */
> +       return regs->gpr[0];
>  }
>
>  void do_syscall_trace_leave(struct pt_regs *regs)
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
