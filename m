Return-Path: <ndesaulniers@google.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bjdk3ZWxzF3HN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 03:47:22 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id i190-v6so4734122pgc.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 10:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180914040649.1794-1-joel@jms.id.au>
 <20180914040649.1794-3-joel@jms.id.au>
In-Reply-To: <20180914040649.1794-3-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 14 Sep 2018 10:47:08 -0700
Message-ID: <CAKwvOdmKvxmh+Vb1UcUzOsYOsK6gjn7v62X=SpwuhimBhdM7ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] powerpc/boot: Fix crt0.S syntax for clang
To: joel@jms.id.au
Cc: linuxppc-dev@lists.ozlabs.org, anton@ozlabs.org
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
> Clang's assembler does not like the syntax of the cmpdi:
>
>  arch/powerpc/boot/crt0.S:168:22: error: unexpected modifier on variable reference
>          cmpdi   12,RELACOUNT@l
>                               ^
>  arch/powerpc/boot/crt0.S:168:11: error: unknown operand
>          cmpdi   12,RELACOUNT@l
>                    ^
> Enclosing RELACOUNT in () makes it is happy. Tested with GCC 8 and Clang
> 8 (trunk).
>
> Reported to clang as https://bugs.llvm.org/show_bug.cgi?id=38945
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2: Fix for !powerpc64 too, add bug link to commit message
> ---
>  arch/powerpc/boot/crt0.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
> index dcf2f15e6797..e453e011d7e7 100644
> --- a/arch/powerpc/boot/crt0.S
> +++ b/arch/powerpc/boot/crt0.S
> @@ -80,7 +80,7 @@ p_base:       mflr    r10             /* r10 now points to runtime addr of p_base */
>         lwz     r9,4(r12)       /* get RELA pointer in r9 */
>         b       12f
>  11:    addis   r8,r8,(-RELACOUNT)@ha
> -       cmpwi   r8,RELACOUNT@l
> +       cmpwi   r8,(RELACOUNT)@l
>         bne     12f
>         lwz     r0,4(r12)       /* get RELACOUNT value in r0 */
>  12:    addi    r12,r12,8
> @@ -165,7 +165,7 @@ p_base:     mflr    r10             /* r10 now points to runtime addr of p_base */
>         ld      r13,8(r11)       /* get RELA pointer in r13 */
>         b       11f
>  10:    addis   r12,r12,(-RELACOUNT)@ha
> -       cmpdi   r12,RELACOUNT@l
> +       cmpdi   r12,(RELACOUNT)@l

Yep, as we can see above, when RELACOUNT is negated, it's wrapped in
parens.  It's important for Clang's assembler to match GAS eventually,
but for now, this change simply cononicalizes all of the the
references to RELACOUNT in this source file.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>         bne     11f
>         ld      r8,8(r11)       /* get RELACOUNT value in r8 */
>  11:    addi    r11,r11,16
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
