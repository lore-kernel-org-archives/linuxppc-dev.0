Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTNQ566wKzDvvW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 01:41:01 +1100 (AEDT)
Message-ID: <1480516844.21746.66.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: yanjiang.jin@windriver.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jinyanjiang@gmail.com
Date: Wed, 30 Nov 2016 08:40:44 -0600
In-Reply-To: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
References: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc: cputime: fix a compile warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-21 at 12:56 +0800, yanjiang.jin@windriver.com wrote:
> From: Yanjiang Jin <yanjiang.jin@windriver.com>
> 
> This patch is to avoid the below warning:
> 
> kernel/sched/cpuacct.c:298:25: warning:
> format '%lld' expects argument of type 'long long int',
> but argument 4 has type 'long unsigned int' [-Wformat=]
> 
> Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
> ---
>  arch/powerpc/include/asm/cputime.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/cputime.h
> b/arch/powerpc/include/asm/cputime.h
> index 4f60db0..4423e97 100644
> --- a/arch/powerpc/include/asm/cputime.h
> +++ b/arch/powerpc/include/asm/cputime.h
> @@ -228,7 +228,8 @@ static inline cputime_t clock_t_to_cputime(const
> unsigned long clk)
>  	return (__force cputime_t) ct;
>  }
>  
> -#define cputime64_to_clock_t(ct)	cputime_to_clock_t((cputime_t)(ct))
> +#define cputime64_to_clock_t(ct)	\
> +	(__force u64)(cputime_to_clock_t((cputime_t)(ct)))

Why is __force needed?

-Scott
