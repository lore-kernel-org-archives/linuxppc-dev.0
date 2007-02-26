Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36CB0DDF8D
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 02:54:56 +1100 (EST)
Subject: Re: [PATCH] powerpc: Remove some redunant isync instructions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: MOKUNO Masakazu <mokuno@sm.sony.co.jp>
In-Reply-To: <20070226171709.A2E8.MOKUNO@sm.sony.co.jp>
References: <20070226171709.A2E8.MOKUNO@sm.sony.co.jp>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 16:54:51 +0100
Message-Id: <1172505291.11949.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-26 at 17:21 +0900, MOKUNO Masakazu wrote:
> Remove some redundant isync instructions.
> 
> enable_64b_mode() already does an isync, so there is no need to do it again.
> 
> Signed-off-by: MOKUNO, Masakazu <mokuno@sm.sony.co.jp>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/head_64.S |    2 --
>  1 files changed, 2 deletions(-)
> 
> --- ps3-linux-dev.orig/arch/powerpc/kernel/head_64.S
> +++ ps3-linux-dev/arch/powerpc/kernel/head_64.S
> @@ -1555,7 +1555,6 @@ _GLOBAL(generic_secondary_smp_init)
>  	
>  	/* turn on 64-bit mode */
>  	bl	.enable_64b_mode
> -	isync
>  
>  	/* Set up a paca value for this processor. Since we have the
>  	 * physical cpu id in r24, we need to search the pacas to find
> @@ -1851,7 +1850,6 @@ __secondary_start_pmac_0:
>  _GLOBAL(pmac_secondary_start)
>  	/* turn on 64-bit mode */
>  	bl	.enable_64b_mode
> -	isync
>  
>  	/* Copy some CPU settings from CPU 0 */
>  	bl	.__restore_cpu_ppc970
> 
> --
> Masakazu MOKUNO
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
