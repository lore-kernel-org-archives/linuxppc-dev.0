Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E4B9A2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 18:20:03 +1000 (EST)
Message-ID: <1341908398.2561.15.camel@pasglop>
Subject: Re: [PATCH 1/1] powerpc: add "memory" attribute for mfmsr()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 10 Jul 2012 18:19:58 +1000
In-Reply-To: <1341907153-20516-1-git-send-email-tiejun.chen@windriver.com>
References: <1341907153-20516-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-07-10 at 15:59 +0800, Tiejun Chen wrote:
> Add "memory" attribute in inline assembly language as a compiler
> barrier to make sure 4.6.x GCC don't reorder mfmsr().

Out of curiosity, did you see a case where it was re-ordered
improperly ?

Cheers,
Ben.

> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/include/asm/reg.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 559da19..578e5a0 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1016,7 +1016,8 @@
>  /* Macros for setting and retrieving special purpose registers */
>  #ifndef __ASSEMBLY__
>  #define mfmsr()		({unsigned long rval; \
> -			asm volatile("mfmsr %0" : "=r" (rval)); rval;})
> +			asm volatile("mfmsr %0" : "=r" (rval) : \
> +						: "memory"); rval;})
>  #ifdef CONFIG_PPC_BOOK3S_64
>  #define __mtmsrd(v, l)	asm volatile("mtmsrd %0," __stringify(l) \
>  				     : : "r" (v) : "memory")
