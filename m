Return-Path: <keescook@google.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B67D1A2AD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 02:39:03 +1000 (AEST)
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com
 [IPv6:2607:f8b0:4001:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D3E73140281
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2015 02:39:02 +1000 (AEST)
Received: by ioii16 with SMTP id i16so59349289ioi.0
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2015 09:39:01 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1438235808-6438-1-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-9-git-send-email-mpe@ellerman.id.au>
 <1438235808-6438-1-git-send-email-mpe@ellerman.id.au>
Date: Thu, 30 Jul 2015 09:39:00 -0700
Message-ID: <CAGXu5jLkWM4kYJursWv8xspD50bOaLbt4O9=XyT1s3b-tUOeQw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/kernel: Enable seccomp filter
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 29, 2015 at 10:56 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> This commit enables seccomp filter on powerpc, now that we have all the
> necessary pieces in place.
>
> To support seccomp's desire to modify the syscall return value under
> some circumstances, we use a different ABI to the ptrace ABI. That is we
> use r3 as the syscall return value, and orig_gpr3 is the first syscall
> parameter.
>
> This means the seccomp code, or a ptracer via SECCOMP_RET_TRACE, will
> see -ENOSYS preloaded in r3. This is identical to the behaviour on x86,
> and allows seccomp or the ptracer to either leave the -ENOSYS or change
> it to something else, as well as rejecting or not the syscall by
> modifying r0.
>
> If seccomp does not reject the syscall, we restore the register state to
> match what ptrace and audit expect, ie. r3 is the first syscall
> parameter again. We do this restore using orig_gpr3, which may have been
> modified by seccomp, which allows seccomp to modify the first syscall
> paramater and allow the syscall to proceed.
>
> We need to #ifdef the the additional handling of r3 for seccomp, so move
> it all out of line.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/powerpc/Kconfig         |  1 +
>  arch/powerpc/kernel/ptrace.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
>
> v2: The previous version didn't compile for CONFIG_SECCOMP=n. To fix it up I
>     moved the logic out of line and #ifdef'ed that. It gets inlined by the compiler
>     so the end result is the same.
>
>     Kees I kept your Reviewed-by on the basis that the interesting logic is the
>     same, hope that's OK by you.

Totally fine. Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
