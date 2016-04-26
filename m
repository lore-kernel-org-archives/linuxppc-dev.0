Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvctT6DtJzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 08:18:25 +1000 (AEST)
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qvctT24STz9t6S
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2016 08:18:25 +1000 (AEST)
Received: by mail-pa0-x234.google.com with SMTP id r5so11741974pag.1
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2016 15:18:25 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] powerpc: rework sparse for lib/xor_vmx.c
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
References: <1461678549-12330-1-git-send-email-dja@axtens.net>
Cc: andrew.donnellan@au1.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571FE923.7070904@gmail.com>
Date: Wed, 27 Apr 2016 08:18:11 +1000
MIME-Version: 1.0
In-Reply-To: <1461678549-12330-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 26/04/16 23:49, Daniel Axtens wrote:
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
> Only include the altivec.h header for non-__CHECKER__ builds.
> For builds with __CHECKER__, make up some stubs instead, as
> suggested by Balbir. (The vector size of 16 is arbitrary.)
> 
> Suggested-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
> This version works, which is - embarassingly - an improvement over
> v1. I should test things better, sorry.
> ---
>  arch/powerpc/lib/xor_vmx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/lib/xor_vmx.c b/arch/powerpc/lib/xor_vmx.c
> index 07f49f1568e5..f9de69a04e88 100644
> --- a/arch/powerpc/lib/xor_vmx.c
> +++ b/arch/powerpc/lib/xor_vmx.c
> @@ -17,7 +17,17 @@
>   *
>   * Author: Anton Blanchard <anton@au.ibm.com>
>   */
> +
> +/*
> + * Sparse (as at v0.5.0) gets very, very confused by this file.
> + * Make it a bit simpler for it.
> + */
> +#if !defined(__CHECKER__)
>  #include <altivec.h>
> +#else
> +#define vec_xor(a, b) a ^ b
> +#define vector __attribute__((vector_size(16)))
> +#endif
>  
>  #include <linux/preempt.h>
>  #include <linux/export.h>
> 

Yes, this worked for me

Tested-by: Balbir Singh <bsingharora@gmail.com>
