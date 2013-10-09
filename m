Return-Path: <computersforpeace@gmail.com>
Received: from mail-ie0-x230.google.com (mail-ie0-x230.google.com
 [IPv6:2607:f8b0:4001:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7247B2C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 06:29:39 +1100 (EST)
Received: by mail-ie0-f176.google.com with SMTP id ar20so2798064iec.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Oct 2013 12:29:35 -0700 (PDT)
Date: Wed, 9 Oct 2013 12:29:31 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [v1] powerpc/mpc512x: silence build warning upon disabled DIU
Message-ID: <20131009192931.GC23337@ld-irv-0074.broadcom.com>
References: <1380295718-10700-1-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380295718-10700-1-git-send-email-gsi@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

(Please keep me on the CC list, as I'm not subscribed)

On Fri, Sep 27, 2013 at 05:28:38PM +0200, Gerhard Sittig wrote:
> a disabled Kconfig option results in a reference to a not implemented
> routine when the IS_ENABLED() macro is used for both conditional
> implementation of the routine as well as a C language source code test
> at the call site -- the "if (0) func();" construct only gets eliminated
> later by the optimizer, while the compiler already has emitted its
> warning about "func()" being undeclared
> 
> provide an empty implementation for the mpc512x_setup_diu() and
> mpc512x_init_diu() routines in case of the disabled option, to avoid the
> compiler warning which is considered fatal and breaks compilation
> 
> the bug appeared with commit 2abbbb63c90ab55ca3f054772c2e5ba7df810c48
> "powerpc/mpc512x: move common code to shared.c file", how to reproduce:
> 
>   make mpc512x_defconfig
>   echo CONFIG_FB_FSL_DIU=n >> .config && make olddefconfig
>   make
> 
>     CC      arch/powerpc/platforms/512x/mpc512x_shared.o
>   .../arch/powerpc/platforms/512x/mpc512x_shared.c: In function 'mpc512x_init_early':
>   .../arch/powerpc/platforms/512x/mpc512x_shared.c:456:3: error: implicit declaration of function 'mpc512x_init_diu' [-Werror=implicit-function-declaration]
>   .../arch/powerpc/platforms/512x/mpc512x_shared.c: In function 'mpc512x_setup_arch':
>   .../arch/powerpc/platforms/512x/mpc512x_shared.c:469:3: error: implicit declaration of function 'mpc512x_setup_diu' [-Werror=implicit-function-declaration]
>   cc1: all warnings being treated as errors
>   make[4]: *** [arch/powerpc/platforms/512x/mpc512x_shared.o] Error 1

I just ran across this same compile issue, and I have a few thoughts
below.

> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> CC: <stable@vger.kernel.org> # v3.11
> 
> ---
> arch/powerpc/platforms/512x/mpc512x_shared.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
> index a82a41b..1a7b1d0 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -303,6 +303,9 @@ void __init mpc512x_setup_diu(void)
>  	diu_ops.release_bootmem		= mpc512x_release_bootmem;
>  }
>  
> +#else
> +void __init mpc512x_setup_diu(void) { /* EMPTY */ }
> +void __init mpc512x_init_diu(void) { /* EMPTY */ }
>  #endif
>  
>  void __init mpc512x_init_IRQ(void)

I see an alternative solution:

Can't almost all of the code in mpc512x_shared.c be declared 'static'?
Then, you can get the real benefit of IS_ENABLED() by removing the

    #if IS_ENABLED(CONFIG_FB_FSL_DIU)

from around all the DIU code, and it will automatically be removed by
the compiler when it is not used.

I think the current patch is necessary for immediate use, and it can be
sent to stable. But I might suggest a follow-up patch or 2 that makes
the functions static and kills the #ifdef entirely.

Thanks,
Brian
