Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [70.86.134.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5CDBB6EF7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 18:07:32 +1000 (EST)
Date: Fri, 6 Aug 2010 03:02:27 -0500
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: inline ppc64_runlatch_off
Message-ID: <20100806080227.GA17423@lixom.net>
References: <20100806045315.GR29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100806045315.GR29316@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 06, 2010 at 02:53:15PM +1000, Anton Blanchard wrote:
> 
> I'm sick of seeing ppc64_runlatch_off in our profiles, so inline the
> heavily used part of it into the callers. To avoid a mess of circular includes
> I didn't add it as an inline function.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: powerpc.git/arch/powerpc/include/asm/reg.h
> ===================================================================
> --- powerpc.git.orig/arch/powerpc/include/asm/reg.h	2010-08-04 19:55:38.910793475 +1000
> +++ powerpc.git/arch/powerpc/include/asm/reg.h	2010-08-04 20:20:19.490751850 +1000
> @@ -951,7 +951,14 @@
>  #ifdef CONFIG_PPC64
>  
>  extern void ppc64_runlatch_on(void);
> -extern void ppc64_runlatch_off(void);
> +extern void __ppc64_runlatch_off(void);
> +
> +#define ppc64_runlatch_off()					\
> +	do {							\
> +		if (cpu_has_feature(CPU_FTR_CTRL) &&		\
> +		    test_thread_flag(TIF_RUNLATCH))		\
> +			__ppc64_runlatch_off();			\
> +	} while (0);

No semicolon here.


-Olof
