Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6CF1C2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 18:43:35 +1000 (EST)
Message-ID: <51652629.9030905@windriver.com>
Date: Wed, 10 Apr 2013 16:43:21 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH] powerpc: add a missing label in resume_kernel
References: <1365582684-11136-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1365582684-11136-1-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/10/2013 04:31 PM, Kevin Hao wrote:
> A label 0 was missed in the patch a9c4e541 (powerpc/kprobe: Complete
> kprobe and migrate exception frame). This will cause the kernel
> branch to an undetermined address if there really has a conflict when
> updating the thread flags.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Acked-By: Tiejun Chen <tiejun.chen@windriver.com>


> Cc: stable@vger.kernel.org
> ---
>   arch/powerpc/kernel/entry_64.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 256c5bf..ab079ed 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -657,7 +657,7 @@ resume_kernel:
>   	/* Clear _TIF_EMULATE_STACK_STORE flag */
>   	lis	r11,_TIF_EMULATE_STACK_STORE@h
>   	addi	r5,r9,TI_FLAGS
> -	ldarx	r4,0,r5
> +0:	ldarx	r4,0,r5
>   	andc	r4,r4,r11
>   	stdcx.	r4,0,r5
>   	bne-	0b
>
