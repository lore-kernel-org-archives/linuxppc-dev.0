Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BDEF1A0295
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 04:21:59 +1000 (AEST)
Received: by ykdt18 with SMTP id t18so50248155ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 11:21:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1442988302.31273.81.camel@neuling.org>
References: <1442988302.31273.81.camel@neuling.org>
Date: Wed, 23 Sep 2015 21:21:57 +0300
Message-ID: <CAOJe8K3x56V1PNjo=TNMthqbPV1q_tKNBK6QvT=yCofR=qyt3g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/vdso: Avoid link stack corruption in
 __get_datapage()
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, benh <benh@kernel.crashing.org>,
 Aaron Sawdey <sawdey@us.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Steve Munroe <sjmunroe@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/23/15, Michael Neuling <mikey@neuling.org> wrote:
> The 32 and 64 bit variants of __get_datapage() use a "bcl; mflr" to
> determine the loaded address of the VDSO. The current version of these
> attempt to use the special bcl variant which avoids pushing to the
> link stack.
>
> Unfortunately it uses bcl+8 rather than the required bcl+4. Hence the
> current code results in link stack corruption and the resulting
> performance degradation (due to branch mis-prediction).
>
> This patch moves us to bcl+4 by moving __kernel_datapage_offset
> out of __get_datapage().
>
> With this patch, running the below benchmark we get a bump in
> performance on POWER8 for gettimeofday() (which uses
> __get_datapage()).
>
> 64bit gets ~4% improvement:
>   Without patch:
>     # ./tb
>     time = 0.180321
>   With patch:
>     # ./tb
>     time = 0.187408
>
> 32bit gets ~9% improvement:
>   Without patch:
>     # ./tb
>     time = 0.276551
>   With patch:
>     # ./tb
>     time = 0.252767

I've got the following results on POWER7 64bit
without the patch:
# ./tb
time = 0.263337
# ./tb
time = 0.251273
# ./tb
time = 0.258453
# ./tb
time = 0.260189

with the patch:
# ./tb
time = 0.241517
# ./tb
time = 0.241973
# ./tb
time = 0.239365
# ./tb
time = 0.240109



>
> Testcase tb.c (stolen from Anton)
>   /* gcc -O2 tb.c -o tb */
>   #include <sys/time.h>
>   #include <stdio.h>
>
>   int main()
>   {
> 	  int i;
>
> 	  struct timeval tv_start, tv_end;
>
> 	  gettimeofday(&tv_start, NULL);
>
> 	  for(i = 0; i < 10000000; i++) {
> 		  gettimeofday(&tv_end, NULL);
> 	  }
>
> 	  printf("time = %.6f\n", tv_end.tv_sec - tv_start.tv_sec + (tv_end.tv_usec
> - tv_start.tv_usec) * 1e-6);
>
> 	  return 0;
>   }
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reported-by: Aaron Sawdey <sawdey@us.ibm.com>
>
> diff --git a/arch/powerpc/kernel/vdso32/datapage.S
> b/arch/powerpc/kernel/vdso32/datapage.S
> index dc21e89..59cf5f4 100644
> --- a/arch/powerpc/kernel/vdso32/datapage.S
> +++ b/arch/powerpc/kernel/vdso32/datapage.S
> @@ -16,6 +16,10 @@
>  #include <asm/vdso.h>
>
>  	.text
> +	.global	__kernel_datapage_offset;
> +__kernel_datapage_offset:
> +	.long	0
> +
>  V_FUNCTION_BEGIN(__get_datapage)
>    .cfi_startproc
>  	/* We don't want that exposed or overridable as we want other objects
> @@ -27,13 +31,11 @@ V_FUNCTION_BEGIN(__get_datapage)
>  	mflr	r0
>    .cfi_register lr,r0
>
> -	bcl	20,31,1f
> -	.global	__kernel_datapage_offset;
> -__kernel_datapage_offset:
> -	.long	0
> -1:
> +	bcl	20,31,data_page_branch
> +data_page_branch:
>  	mflr	r3
>  	mtlr	r0
> +	addi	r3, r3, __kernel_datapage_offset-data_page_branch
>  	lwz	r0,0(r3)
>  	add	r3,r0,r3
>  	blr
> diff --git a/arch/powerpc/kernel/vdso64/datapage.S
> b/arch/powerpc/kernel/vdso64/datapage.S
> index 79796de..2f01c4a 100644
> --- a/arch/powerpc/kernel/vdso64/datapage.S
> +++ b/arch/powerpc/kernel/vdso64/datapage.S
> @@ -16,6 +16,10 @@
>  #include <asm/vdso.h>
>
>  	.text
> +.global	__kernel_datapage_offset;
> +__kernel_datapage_offset:
> +	.long	0
> +
>  V_FUNCTION_BEGIN(__get_datapage)
>    .cfi_startproc
>  	/* We don't want that exposed or overridable as we want other objects
> @@ -27,13 +31,11 @@ V_FUNCTION_BEGIN(__get_datapage)
>  	mflr	r0
>    .cfi_register lr,r0
>
> -	bcl	20,31,1f
> -	.global	__kernel_datapage_offset;
> -__kernel_datapage_offset:
> -	.long	0
> -1:
> +	bcl	20,31,data_page_branch
> +data_page_branch:
>  	mflr	r3
>  	mtlr	r0
> +	addi	r3, r3, __kernel_datapage_offset-data_page_branch
>  	lwz	r0,0(r3)
>  	add	r3,r0,r3
>  	blr
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
