Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 994AD1A1D8D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:53:35 +1000 (AEST)
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com
 [IPv6:2607:f8b0:4001:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0E67C1402C0
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 04:53:35 +1000 (AEST)
Received: by igk11 with SMTP id 11so74977703igk.1
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 11:53:33 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1437646871-3195-7-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
 <1437646871-3195-7-git-send-email-mpe@ellerman.id.au>
Date: Mon, 27 Jul 2015 11:53:33 -0700
Message-ID: <CAGXu5jKmMno=vHZC3ydxXKH-nfFBL=oEviHh+73UKmEx2oa3bQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] powerpc: Change syscall_get_nr() to return int
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
> The documentation for syscall_get_nr() in asm-generic says:
>
>  Note this returns int even on 64-bit machines. Only 32 bits of
>  system call number can be meaningful. If the actual arch value
>  is 64 bits, this truncates to 32 bits so 0xffffffff means -1.
>
> However our implementation was never updated to reflect this.
>
> Generally it's not important, but there is once case where it matters.
>
> For seccomp filter with SECCOMP_RET_TRACE, the tracer will set
> regs->gpr[0] to -1 to reject the syscall. When the task is a compat
> task, this means we end up with 0xffffffff in r0 because ptrace will
> zero extend the 32-bit value.
>
> If syscall_get_nr() returns an unsigned long, then a 64-bit kernel will
> see a positive value in r0 and will incorrectly allow the syscall
> through seccomp.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/powerpc/include/asm/syscall.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 8d79a87c0511..ab9f3f0a8637 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -22,10 +22,15 @@
>  extern const unsigned long sys_call_table[];
>  #endif /* CONFIG_FTRACE_SYSCALLS */
>
> -static inline long syscall_get_nr(struct task_struct *task,
> -                                 struct pt_regs *regs)
> +static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
>  {
> -       return TRAP(regs) == 0xc00 ? regs->gpr[0] : -1L;
> +       /*
> +        * Note that we are returning an int here. That means 0xffffffff, ie.
> +        * 32-bit negative 1, will be interpreted as -1 on a 64-bit kernel.
> +        * This is important for seccomp so that compat tasks can set r0 = -1
> +        * to reject the syscall.
> +        */
> +       return TRAP(regs) == 0xc00 ? regs->gpr[0] : -1;
>  }
>
>  static inline void syscall_rollback(struct task_struct *task,
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
