Return-Path: <scottwood@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F7A02C0427
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 09:24:32 +1100 (EST)
Message-ID: <1386714253.10013.123.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc 8xx: Loading kernels over 8Mbytes without
 CONFIG_PIN_TLB
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 10 Dec 2013 16:24:13 -0600
In-Reply-To: <20131210112945.E4E311A2BF3@localhost.localdomain>
References: <20131210112945.E4E311A2BF3@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-12-10 at 12:29 +0100, Christophe Leroy wrote:
> Today, the only way to load kernels whose size is greater than 8Mbytes is to
> activate CONFIG_PIN_TLB. Otherwise, the physical memory initially mapped is
> limited to 8Mbytes. This patch adds the capability to select the size of initial
> memory between 8/16/24 Mbytes and this is regardless of whether CONFIG_PIN_TLB
> is active or not. It allows to load "big" kernels (for instance when activating
> CONFIG_LOCKDEP_SUPPORT) without having to activate CONFIG_PIN_TLB.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> diff -ur a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -980,6 +980,29 @@
>  config PIN_TLB
>  	bool "Pinned Kernel TLBs (860 ONLY)"
>  	depends on ADVANCED_OPTIONS && 8xx
> +
> +choice
> +	prompt "Initial Data Memory Mapped on 8xx"
> +	default 8xx_MAP_8M
> +	depends on ADVANCED_OPTIONS && 8xx
> +
> +config	8xx_INIT_MAP_8M
> +	bool "8 Mbytes"
> +
> +config	8xx_INIT_MAP_16M
> +	bool "16 Mbytes"
> +
> +config	8xx_INIT_MAP_24M
> +	bool "24 Mbytes"

Are you working with a loader that passes initial-mapped-area size in r7
as per ePAPR?  If so, we could rely on that at runtime.  If you're using
a non-ancient U-Boot, it should qualify here even if it's not fully
ePAPR compliant (it passes the value of the bootm_mapsize variable in
r7).

> -#ifdef CONFIG_PIN_TLB
> +#if defined (CONFIG_8xx_INIT_MAP_16M) || defined (CONFIG_8xx_INIT_MAP_24M)
>  	/* Map two more 8M kernel data pages.
>  	*/
> +#ifdef CONFIG_PIN_TLB
>  	addi	r10, r10, 0x0100
>  	mtspr	SPRN_MD_CTR, r10
> +#endif
>  
>  	lis	r8, KERNELBASE@h	/* Create vaddr for TLB */
>  	addis	r8, r8, 0x0080		/* Add 8M */
> @@ -858,15 +860,19 @@
>  	addis	r11, r11, 0x0080	/* Add 8M */
>  	mtspr	SPRN_MD_RPN, r11
>  
> +#ifdef CONFIG_8xx_INIT_MAP_24M
> +#ifdef CONFIG_PIN_TLB
>  	addi	r10, r10, 0x0100
>  	mtspr	SPRN_MD_CTR, r10
> +#endif

Are these ifdefs for CONFIG_PIN_TLB really needed?  It shouldn't harm
anything to use those entries even if they're not being pinned.
 
-Scott
