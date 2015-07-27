Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CF561A1BCA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 04:49:54 +1000 (AEST)
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com
 [IPv6:2607:f8b0:4001:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A45921402B9
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 04:49:53 +1000 (AEST)
Received: by igr7 with SMTP id 7so85042213igr.0
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2015 11:49:52 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1437646871-3195-4-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
 <1437646871-3195-4-git-send-email-mpe@ellerman.id.au>
Date: Mon, 27 Jul 2015 11:49:51 -0700
Message-ID: <CAGXu5j+FA0KvJPr46QeJYzPpKYdNhzqnpa4kn5D_Mk2Hm=FTrA@mail.gmail.com>
Subject: Re: [PATCH 04/11] powerpc: Don't negate error in
 syscall_set_return_value()
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
> Currently the only caller of syscall_set_return_value() is seccomp
> filter, which is not enabled on powerpc.
>
> This means we have not noticed that our implementation of
> syscall_set_return_value() negates error, even though the value passed
> in is already negative.
>
> So remove the negation in syscall_set_return_value(), and expect the
> caller to do it like all other implementations do.
>
> Also add a comment about the ccr handling.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/powerpc/include/asm/syscall.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index c6239dabcfb1..cabe90133e69 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -44,9 +44,15 @@ static inline void syscall_set_return_value(struct task_struct *task,
>                                             struct pt_regs *regs,
>                                             int error, long val)
>  {
> +       /*
> +        * In the general case it's not obvious that we must deal with CCR
> +        * here, as the syscall exit path will also do that for us. However
> +        * there are some places, eg. the signal code, which check ccr to
> +        * decide if the value in r3 is actually an error.
> +        */
>         if (error) {
>                 regs->ccr |= 0x10000000L;
> -               regs->gpr[3] = -error;
> +               regs->gpr[3] = error;
>         } else {
>                 regs->ccr &= ~0x10000000L;
>                 regs->gpr[3] = val;
> --
> 2.1.0
>



-- 
Kees Cook
Chrome OS Security
