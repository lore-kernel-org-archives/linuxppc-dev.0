Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0394E1A1C0D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:50:36 +1000 (AEST)
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 776DE1402B7
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 04:50:35 +1000 (AEST)
Received: by igk11 with SMTP id 11so74862376igk.1
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 11:50:33 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1437646871-3195-5-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
 <1437646871-3195-5-git-send-email-mpe@ellerman.id.au>
Date: Mon, 27 Jul 2015 11:50:33 -0700
Message-ID: <CAGXu5j+z+RPTgSYudnHTxObDs=fT5YE7mJB8=ZKC27GDQApmVg@mail.gmail.com>
Subject: Re: [PATCH 05/11] powerpc: Rework syscall_get_arguments() so there is
 only one loop
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
> Currently syscall_get_arguments() has two loops, one for compat and one
> for regular tasks. In prepartion for the next patch, which changes which
> registers we use, switch it to only have one loop, so we only have one
> place to update.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/powerpc/include/asm/syscall.h | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index cabe90133e69..403e2303fe18 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -64,19 +64,16 @@ static inline void syscall_get_arguments(struct task_struct *task,
>                                          unsigned int i, unsigned int n,
>                                          unsigned long *args)
>  {
> +       unsigned long mask = -1UL;
> +
>         BUG_ON(i + n > 6);
> -#ifdef CONFIG_PPC64
> -       if (test_tsk_thread_flag(task, TIF_32BIT)) {
> -               /*
> -                * Zero-extend 32-bit argument values.  The high bits are
> -                * garbage ignored by the actual syscall dispatch.
> -                */
> -               while (n-- > 0)
> -                       args[n] = (u32) regs->gpr[3 + i + n];
> -               return;
> -       }
> +
> +#ifdef CONFIG_COMPAT
> +       if (test_tsk_thread_flag(task, TIF_32BIT))
> +               mask = 0xffffffff;
>  #endif
> -       memcpy(args, &regs->gpr[3 + i], n * sizeof(args[0]));
> +       while (n--)
> +               args[n] = regs->gpr[3 + i + n] & mask;
>  }
>
>  static inline void syscall_set_arguments(struct task_struct *task,
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
