Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C4AD1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 17:53:57 +1100 (AEDT)
Message-ID: <1425884006.4636.234.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc64: use fixed lock token for !CONFIG_PPC_SPLPAR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 09 Mar 2015 17:53:26 +1100
In-Reply-To: <1425727183-30880-1-git-send-email-haokexin@gmail.com>
References: <1425727183-30880-1-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-03-07 at 19:19 +0800, Kevin Hao wrote:
> It makes no sense to use a variant lock token on a platform which
> doesn't support for shared-processor logical partitions. Actually we
> can eliminate a memory load by using a fixed lock token on these
> platforms.

Does this provide an actual measurable benefit ? I found that the lock
token was quite handy for debugging ...

Cheers,
Ben.

> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/include/asm/spinlock.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 4dbe072eecbe..d303cdad2519 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -30,7 +30,7 @@
>  
>  #define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
>  
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_PPC_SPLPAR
>  /* use 0x800000yy when locked, where yy == CPU number */
>  #ifdef __BIG_ENDIAN__
>  #define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
> @@ -187,9 +187,13 @@ extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
>  
>  #ifdef CONFIG_PPC64
>  #define __DO_SIGN_EXTEND	"extsw	%0,%0\n"
> -#define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
>  #else
>  #define __DO_SIGN_EXTEND
> +#endif
> +
> +#ifdef CONFIG_PPC_SPLPAR
> +#define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
> +#else
>  #define WRLOCK_TOKEN		(-1)
>  #endif
>  
