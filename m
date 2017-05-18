Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTHhM3m7PzDqbx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 03:08:34 +1000 (AEST)
Date: Fri, 19 May 2017 03:08:23 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, npiggin@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Tweak copy selection parameter in
 __copy_tofrom_user_power7()
Message-ID: <20170519030823.08966186@kryten>
In-Reply-To: <20170512035810.15070-1-andrew@aj.id.au>
References: <20170512035810.15070-1-andrew@aj.id.au>
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

Hi Andrew,

> Experiments with the netperf benchmark indicated that the size
> selecting VMX-based copies in __copy_tofrom_user_power7() was
> suboptimal on POWER8. Measurements showed that parity was in the
> neighbourhood of 3328 bytes, rather than greater than 4096. The
> change gives a 1.5-2.0% improvement in performance for 4096-byte
> buffers, reducing the relative time spent in
> __copy_tofrom_user_power7() from approximately 7% to approximately 5%
> in the TCP_RR benchmark.

Nice work! All our context switch optimisations we've made over
the last year has likely moved the break even point for this.

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  arch/powerpc/lib/copyuser_power7.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/copyuser_power7.S
> b/arch/powerpc/lib/copyuser_power7.S index a24b4039352c..706b7cc19846
> 100644 --- a/arch/powerpc/lib/copyuser_power7.S
> +++ b/arch/powerpc/lib/copyuser_power7.S
> @@ -82,14 +82,14 @@
>  _GLOBAL(__copy_tofrom_user_power7)
>  #ifdef CONFIG_ALTIVEC
>  	cmpldi	r5,16
> -	cmpldi	cr1,r5,4096
> +	cmpldi	cr1,r5,3328
>  
>  	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
>  	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
>  	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
>  
>  	blt	.Lshort_copy
> -	bgt	cr1,.Lvmx_copy
> +	bge	cr1,.Lvmx_copy
>  #else
>  	cmpldi	r5,16
>  
