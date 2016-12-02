Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVLQs1Yl7zDvkq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 15:15:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: yanjiang.jin@windriver.com, benh@kernel.crashing.org, paulus@samba.org,
 oss@buserror.net
Cc: linuxppc-dev@lists.ozlabs.org, yanjiang.jin@windriver.com,
 linux-kernel@vger.kernel.org, jinyanjiang@gmail.com
Subject: Re: [PATCH] powerpc: cputime: fix a compile warning
In-Reply-To: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
References: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
Date: Fri, 02 Dec 2016 15:15:00 +1100
Message-ID: <874m2n7yrf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

yanjiang.jin@windriver.com writes:

> diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
> index 4f60db0..4423e97 100644
> --- a/arch/powerpc/include/asm/cputime.h
> +++ b/arch/powerpc/include/asm/cputime.h
> @@ -228,7 +228,8 @@ static inline cputime_t clock_t_to_cputime(const unsigned long clk)
>  	return (__force cputime_t) ct;
>  }
>  
> -#define cputime64_to_clock_t(ct)	cputime_to_clock_t((cputime_t)(ct))
> +#define cputime64_to_clock_t(ct)	\
> +	(__force u64)(cputime_to_clock_t((cputime_t)(ct)))

Given the name of the function is "cputime64 to clock_t", surely we
should be returning a clock_t ?

cheers
