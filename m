Return-Path: <David.Daney@caviumnetworks.com>
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id 831FD1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 04:57:43 +1100 (EST)
Message-ID: <4D41B213.4070606@caviumnetworks.com>
Date: Thu, 27 Jan 2011 09:57:39 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Coly Li <bosong.ly@taobao.com>
Subject: Re: [PATCH 2/7] PowerPC: add unlikely() to BUG_ON()
References: <1296130356-29896-1-git-send-email-bosong.ly@taobao.com>
	<1296130356-29896-3-git-send-email-bosong.ly@taobao.com>
In-Reply-To: <1296130356-29896-3-git-send-email-bosong.ly@taobao.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Wang Cong <xiyou.wangcong@gmail.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Yong Zhang <yong.zhang0@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Why not also CC the PPC maintainers as well?  I am not certain, but I 
think they may be reached at:

linuxppc-dev@lists.ozlabs.org


On 01/27/2011 04:12 AM, Coly Li wrote:
> Current BUG_ON() arch/powerpc/include/asm/bug.h does not use unlikely(),
> in order to get better branch predict result, source code may have to call
> BUG_ON() with unlikely() explicitly. This is not a suggested method
> to use BUG_ON().
>
> This patch adds unlikely() inside BUG_ON implementation on PPC
> code, callers can use BUG_ON without explicit unlikely() now.
>
> I don't have any PPC hardware to compile and test this fix, any feedback
> of this patch is welcome.
>
> Signed-off-by: Coly Li<bosong.ly@taobao.com>
> Cc: Jeremy Fitzhardinge<jeremy@goop.org>
> Cc: David Daney<ddaney@caviumnetworks.com>
> Cc: Wang Cong<xiyou.wangcong@gmail.com>
> Cc: Yong Zhang<yong.zhang0@gmail.com>
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index 065c590..10889a6 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -2,6 +2,7 @@
>   #define _ASM_POWERPC_BUG_H
>   #ifdef __KERNEL__
>
> +#include<linux/compiler.h>
>   #include<asm/asm-compat.h>
>
>   /*
> @@ -71,7 +72,7 @@
>   	unreachable();						\
>   } while (0)
>
> -#define BUG_ON(x) do {						\
> +#define __BUG_ON(x) do {					\
>   	if (__builtin_constant_p(x)) {				\
>   		if (x)						\
>   			BUG();					\
> @@ -85,6 +86,8 @@
>   	}							\
>   } while (0)
>
> +#define BUG_ON(x) __BUG_ON(unlikely(x))
> +

This is the same type of frobbing you were trying to do to MIPS.

I will let the powerpc maintainers weigh in on it, but my opinion is 
that, as with MIPS, BUG_ON() is expanded to a single machine 
instruction, and this unlikely() business will not change the generated 
code in any useful way.  It is thus gratuitous code churn and 
complexification.

David Daney

>   #define __WARN_TAINT(taint) do {				\
>   	__asm__ __volatile__(					\
>   		"1:	twi 31,0,0\n"				\
