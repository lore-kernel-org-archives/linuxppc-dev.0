Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F2CF2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 08:34:06 +1000 (EST)
Message-ID: <1379975638.24959.47.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] powerpc/85xx: introduce corenet_generic machine
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 23 Sep 2013 17:33:58 -0500
In-Reply-To: <1379835750-23999-2-git-send-email-haokexin@gmail.com>
References: <1379835750-23999-1-git-send-email-haokexin@gmail.com>
 <1379835750-23999-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-09-22 at 15:42 +0800, Kevin Hao wrote:
> In the current kernel, the board files for p2041rdb, p3041ds, p4080ds,
> p5020ds, p5040ds, t4240qds and b4qds are almost the same except the
> machine name. So this introduces a cornet_generic machine to support
> all these boards to avoid the code duplication.
> 
> With these changes the file corenet_ds.h becomes useless. Just delete
> it.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> v2:
>   - Fix the typo in subject.
>   - Fold the original patch 2 into this one.
>   - Change the machine name from "CORENET GENERIC" to "CORENET Generic".

CoreNet shouldn't be allcaps either.

> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index de2eb93..3bee943 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -228,6 +228,7 @@ config P2041_RDB
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the P2041 RDB board
>  
> @@ -241,6 +242,7 @@ config P3041_DS
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the P3041 DS board
>  
> @@ -254,6 +256,7 @@ config P4080_DS
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
>  	select PPC_EPAPR_HV_PIC
> +	select CORENET_GENERIC
>  	help
>  	  This option enables support for the P4080 DS board

As discussed earlier, I'd prefer if this were combined into one kconfig
option.  The help text can list boards that are known to work with it.

-Scott
