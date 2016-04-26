Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvD7225m7zDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 16:42:54 +1000 (AEST)
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qvD715NKzz9rxl
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2016 16:42:53 +1000 (AEST)
Received: by mail-pa0-x22b.google.com with SMTP id zm5so3283363pac.0
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2016 23:42:53 -0700 (PDT)
Subject: Re: [PATCH] powerpc: disable sparse for lib/xor_vmx.c
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
References: <1461646737-500-1-git-send-email-dja@axtens.net>
Cc: andrew.donnellan@au1.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571F0DE7.5080904@gmail.com>
Date: Tue, 26 Apr 2016 16:42:47 +1000
MIME-Version: 1.0
In-Reply-To: <1461646737-500-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 26/04/16 14:58, Daniel Axtens wrote:
> Sparse doesn't seem to be passing -maltivec around properly, leading
> to lots of errors:
> 
> .../include/altivec.h:34:2: error: Use the "-maltivec" flag to enable PowerPC AltiVec support
> arch/powerpc/lib/xor_vmx.c:27:16: error: Expected ; at end of declaration
> arch/powerpc/lib/xor_vmx.c:27:16: error: got signed
> arch/powerpc/lib/xor_vmx.c:60:9: error: No right hand side of '*'-expression
> arch/powerpc/lib/xor_vmx.c:60:9: error: Expected ; at end of statement
> arch/powerpc/lib/xor_vmx.c:60:9: error: got v1_in
> ...
> arch/powerpc/lib/xor_vmx.c:87:9: error: too many errors
> 
> Disable sparse checking for xor_vmx.c.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/lib/xor_vmx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/lib/xor_vmx.c b/arch/powerpc/lib/xor_vmx.c
> index 07f49f1568e5..eccf37db9512 100644
> --- a/arch/powerpc/lib/xor_vmx.c
> +++ b/arch/powerpc/lib/xor_vmx.c
> @@ -17,6 +17,16 @@
>   *
>   * Author: Anton Blanchard <anton@au.ibm.com>
>   */
> +
> +/*
> + * Sparse (as at v0.5.0) gets very, very confused by this file.
> + * Just disable it.
> + */
> +#ifdef __CHECKER__
> +#undef __CHECKER__
> +#warning "Sparse checking disabled for this file"
> +#endif
> +
>  #include <altivec.h>
>  

Isn't it better to do this

#if !defined(__CHECKER__)
#include <altivec.h>
#else
#define vec_xor(a, b) a ^ b
#endif

This will probably let to sparse check the rest of the file. I've not checked it, just recommending it.
See how it goes

>  #include <linux/preempt.h>
> 
