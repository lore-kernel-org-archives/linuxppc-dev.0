Return-Path: <ndesaulniers@google.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BjsG34g5zF3X5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 03:57:21 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id l63-v6so4739824pga.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 10:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-5-joel@jms.id.au>
In-Reply-To: <20180914040649.1794-5-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 14 Sep 2018 10:57:08 -0700
Message-ID: <CAKwvOd=-22J2=QvCTOAxkWw-WV8C4VY6Yvx91Rif5STmiXMtMg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] powerpc: Fix duplicate const clang warning in user
 access code
To: joel@jms.id.au
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, anton@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2018 at 9:07 PM Joel Stanley <joel@jms.id.au> wrote:
>
> From: Anton Blanchard <anton@samba.org>
>
> This re-applies b91c1e3e7a6f which was reverted in f2ca80905929
> d466f6c5cac1 f84ed59a612d (powerpc/sparse: Constify the address pointer
> ...").
>
> We see a large number of duplicate const errors in the user access
> code when building with llvm/clang:
>
>   include/linux/pagemap.h:576:8: warning: duplicate 'const' declaration specifier
>       [-Wduplicate-decl-specifier]
>         ret = __get_user(c, uaddr);
>
> The problem is we are doing const __typeof__(*(ptr)), which will hit the
> warning if ptr is marked const.
>
> Removing const does not seem to have any effect on GCC code generation.

I wouldn't expect it to for a local variable with such localized
usage.  I myself am quite liberal in applying `const` to everything,
so I will try to fix this in Clang as well, but this should silence
the warning for users of older versions of Clang and results in no
functional change.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> If we don't want to apply this, other options are suppressing the
> warning, or wait for a fix to land in clang
> (https://github.com/ClangBuiltLinux/linux/issues/52).
> ---
>  arch/powerpc/include/asm/uaccess.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index bac225bb7f64..15bea9a0f260 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -260,7 +260,7 @@ do {                                                                \
>  ({                                                             \
>         long __gu_err;                                          \
>         __long_type(*(ptr)) __gu_val;                           \
> -       const __typeof__(*(ptr)) __user *__gu_addr = (ptr);     \
> +       __typeof__(*(ptr)) __user *__gu_addr = (ptr);   \
>         __chk_user_ptr(ptr);                                    \
>         if (!is_kernel_addr((unsigned long)__gu_addr))          \
>                 might_fault();                                  \
> @@ -274,7 +274,7 @@ do {                                                                \
>  ({                                                                     \
>         long __gu_err = -EFAULT;                                        \
>         __long_type(*(ptr)) __gu_val = 0;                               \
> -       const __typeof__(*(ptr)) __user *__gu_addr = (ptr);             \
> +       __typeof__(*(ptr)) __user *__gu_addr = (ptr);           \
>         might_fault();                                                  \
>         if (access_ok(VERIFY_READ, __gu_addr, (size))) {                \
>                 barrier_nospec();                                       \
> @@ -288,7 +288,7 @@ do {                                                                \
>  ({                                                             \
>         long __gu_err;                                          \
>         __long_type(*(ptr)) __gu_val;                           \
> -       const __typeof__(*(ptr)) __user *__gu_addr = (ptr);     \
> +       __typeof__(*(ptr)) __user *__gu_addr = (ptr);   \
>         __chk_user_ptr(ptr);                                    \
>         barrier_nospec();                                       \
>         __get_user_size(__gu_val, __gu_addr, (size), __gu_err); \
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
