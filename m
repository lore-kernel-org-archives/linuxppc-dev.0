Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 092241A0FF5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:48:29 +1000 (AEST)
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com
 [IPv6:2607:f8b0:4001:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6F23414018C
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 04:48:28 +1000 (AEST)
Received: by iggf3 with SMTP id f3so89621922igg.1
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 11:48:26 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1437646871-3195-3-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
 <1437646871-3195-3-git-send-email-mpe@ellerman.id.au>
Date: Mon, 27 Jul 2015 11:48:25 -0700
Message-ID: <CAGXu5jLshbSoyc-tieJPRE8i78BaJ_ZQZrrZAtuzQ1rwR=qyfA@mail.gmail.com>
Subject: Re: [PATCH 03/11] powerpc: Drop unused syscall_get_error()
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
> syscall_get_error() is unused, and never has been.
>
> It's also probably wrong, as it negates r3 before returning it, but that
> depends on what the caller is expecting.
>
> It also doesn't deal with compat, and doesn't deal with TIF_NOERROR.
>
> Although we could fix those, until it has a caller and it's clear what
> semantics the caller wants it's just untested code. So drop it.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/powerpc/include/asm/syscall.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index ff21b7a2f0cc..c6239dabcfb1 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -34,12 +34,6 @@ static inline void syscall_rollback(struct task_struct *task,
>         regs->gpr[3] = regs->orig_gpr3;
>  }
>
> -static inline long syscall_get_error(struct task_struct *task,
> -                                    struct pt_regs *regs)
> -{
> -       return (regs->ccr & 0x10000000) ? -regs->gpr[3] : 0;
> -}
> -
>  static inline long syscall_get_return_value(struct task_struct *task,
>                                             struct pt_regs *regs)
>  {
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
