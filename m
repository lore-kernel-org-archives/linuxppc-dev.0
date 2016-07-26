Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz7FR2vz0zDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:17:15 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rz7FR0QZpz9ssM
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jul 2016 16:17:14 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so13235953pfg.2
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jul 2016 23:17:14 -0700 (PDT)
Date: Tue, 26 Jul 2016 16:17:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/2] powerpc/64: Correct comment on LOAD_HANDLER()
Message-ID: <20160726161707.6a175d1d@roar.ozlabs.ibm.com>
In-Reply-To: <1469510970-11599-1-git-send-email-mpe@ellerman.id.au>
References: <1469510970-11599-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Jul 2016 15:29:29 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> The comment for LOAD_HANDLER() was wrong. The part about kdump has not
> been true since 1f6a93e4c35e ("powerpc: Make it possible to move the
> interrupt handlers away from the kernel").
> 
> Describe how it currently works, and combine the two separate comments
> into one.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Nick Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/include/asm/exception-64s.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h
> b/arch/powerpc/include/asm/exception-64s.h index
> 93ae809fe5ea..4ff3e2f16b5d 100644 ---
> a/arch/powerpc/include/asm/exception-64s.h +++
> b/arch/powerpc/include/asm/exception-64s.h @@ -84,12 +84,12 @@
>  
>  /*
>   * We're short on space and time in the exception prolog, so we can't
> - * use the normal SET_REG_IMMEDIATE macro. Normally we just need the
> - * low halfword of the address, but for Kdump we need the whole low
> - * word.
> + * use the normal LOAD_REG_IMMEDIATE macro to load the address of
> label.
> + * Instead we get the base of the kernel from paca->kernelbase and
> or in the low
> + * part of label. This requires that the label be within 64KB of
> kernelbase, and
> + * that kernelbase be 64K aligned.
>   */
>  #define LOAD_HANDLER(reg,
> label)					\
> -	/* Handlers must be within 64K of kbase, which must be 64k
> aligned */ \ ori	reg,reg,(label)-_stext;	/* virt addr
> of handler ... */ 
>  /* Exception register prefixes */
