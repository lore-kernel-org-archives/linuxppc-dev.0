Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id A368667B1F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 03:38:27 +1000 (EST)
Date: Thu, 7 Apr 2005 10:38:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Fillod Stephane <stephane.fillod@thomson.net>
Message-ID: <20050407173821.GQ3396@smtp.west.cox.net>
References: <1CFEB358338412458B21FAA0D78FE86D4F0D23@rennsmail02.eu.thmulti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0D23@rennsmail02.eu.thmulti.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 31, 2005 at 07:47:32PM +0200, Fillod Stephane wrote:

> When CPU has no (classic) FPU, and math emulation is disabled,
> fp instructions are not allowed in kernel mode.
[snip]
> --- linux/arch/ppc/kernel/misc.S	26 Mar 2005 03:28:36 -0000
> 1.1.1.2
> +++ linux/arch/ppc/kernel/misc.S	31 Mar 2005 16:33:25 -0000
> @@ -1096,7 +1096,8 @@
>   * and exceptions as if the cpu had performed the load or store.
>   */
>  
> -#if defined(CONFIG_4xx) || defined(CONFIG_E500)
> +#if !(defined(CONFIG_4xx) || defined(CONFIG_E500) ||
> defined(CONFIG_8xx)) ||  defined(CONFIG_MATH_EMULATION)
> +#if defined(CONFIG_4xx) || defined(CONFIG_E500)
>  _GLOBAL(cvt_fd)
>  	lfs	0,0(r3)
>  	stfd	0,0(r4)
> @@ -1125,6 +1126,7 @@
>  	stfd	0,-4(r5)
>  	blr
>  #endif
> +#endif

The problem here is, HEY! (classic) FP instrs in the kernel.  The
question is why?  Or rather, why are these four classic FP instrs
(lfs/lfd/stfd/stfs) being done on CONFIG_4xx || E500 when neither has
classic FP?  I think the problem here is that on !FPU
(which is 4xx||E500||8xx, or so), we need to rewrite these two
functions (yes, 8xx does emulate them if hit, but that's a tangent).

-- 
Tom Rini
http://gate.crashing.org/~trini/
