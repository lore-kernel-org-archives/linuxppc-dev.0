Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D84A21A1BC9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:52:46 +1000 (AEST)
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com
 [IPv6:2607:f8b0:4001:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2686D1402C0
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 04:52:46 +1000 (AEST)
Received: by iggf3 with SMTP id f3so89783029igg.1
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 11:52:44 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1437646871-3195-6-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
 <1437646871-3195-6-git-send-email-mpe@ellerman.id.au>
Date: Mon, 27 Jul 2015 11:52:44 -0700
Message-ID: <CAGXu5j+1gf5hXf-Cv2g6zUvb3tUiqNi=bYJARp9T-6LojN-ySQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] powerpc: Use orig_gpr3 in syscall_get_arguments()
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
> Currently syscall_get_arguments() is used by syscall tracepoints, and
> collect_syscall() which is used in some debugging as well as
> /proc/pid/syscall.
>
> The current implementation just copies regs->gpr[3 .. 5] out, which is
> fine for all the current use cases.
>
> When we enable seccomp filter, that will also start using
> syscall_get_arguments(). However for seccomp filter we want to use r3
> as the return value of the syscall, and orig_gpr3 as the first
> parameter. This will allow seccomp to modify the return value in r3.
>
> To support this we need to modify syscall_get_arguments() to return
> orig_gpr3 instead of r3. This is safe for all uses because orig_gpr3
> always contains the r3 value that was passed to the syscall. We store it
> in the syscall entry path and never modify it.
>
> Update syscall_set_arguments() while we're here, even though it's never
> used.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/powerpc/include/asm/syscall.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 403e2303fe18..8d79a87c0511 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -64,7 +64,7 @@ static inline void syscall_get_arguments(struct task_struct *task,
>                                          unsigned int i, unsigned int n,
>                                          unsigned long *args)
>  {
> -       unsigned long mask = -1UL;
> +       unsigned long val, mask = -1UL;
>
>         BUG_ON(i + n > 6);
>
> @@ -72,8 +72,14 @@ static inline void syscall_get_arguments(struct task_struct *task,
>         if (test_tsk_thread_flag(task, TIF_32BIT))
>                 mask = 0xffffffff;
>  #endif
> -       while (n--)
> -               args[n] = regs->gpr[3 + i + n] & mask;
> +       while (n--) {
> +               if (n == 0 && i == 0)
> +                       val = regs->orig_gpr3;
> +               else
> +                       val = regs->gpr[3 + i + n];
> +
> +               args[n] = val & mask;
> +       }
>  }
>
>  static inline void syscall_set_arguments(struct task_struct *task,
> @@ -83,6 +89,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  {
>         BUG_ON(i + n > 6);
>         memcpy(&regs->gpr[3 + i], args, n * sizeof(args[0]));
> +
> +       /* Also copy the first argument into orig_gpr3 */
> +       if (i == 0 && n > 0)
> +               regs->orig_gpr3 = args[0];
>  }
>
>  static inline int syscall_get_arch(void)
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
