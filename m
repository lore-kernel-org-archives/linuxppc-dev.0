Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CE881A06F8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 07:25:18 +1000 (EST)
Message-ID: <1401485104.6603.221.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: Add T4240RDB board support
From: Scott Wood <scottwood@freescale.com>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Date: Fri, 30 May 2014 16:25:04 -0500
In-Reply-To: <1401264681-30058-1-git-send-email-Chunhe.Lan@freescale.com>
References: <1401264681-30058-1-git-send-email-Chunhe.Lan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-05-28 at 16:11 +0800, Chunhe Lan wrote:
> @@ -125,6 +127,9 @@ CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_EDAC=y
>  CONFIG_EDAC_MM_EDAC=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_DS1374=y
> +CONFIG_RTC_DRV_CMOS=y
>  CONFIG_DMADEVICES=y
>  CONFIG_FSL_DMA=y
>  CONFIG_EXT2_FS=y

This conflicts with http://patchwork.ozlabs.org/patch/353243/ and you
shouldn't need CONFIG_RTC_DRV_CMOS.

> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index c17aae8..6f279ce 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -265,7 +265,7 @@ config CORENET_GENERIC
>  	  For 32bit kernel, the following boards are supported:
>  	    P2041 RDB, P3041 DS and P4080 DS
>  	  For 64bit kernel, the following boards are supported:
> -	    T4240 QDS and B4 QDS
> +	    T4240 QDS, T4240 RDB and B4 QDS

T4240QDS/RDB

> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index 8e4b1e1..2f50526 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -119,6 +119,7 @@ static const char * const boards[] __initconst = {
>  	"fsl,P5020DS",
>  	"fsl,P5040DS",
>  	"fsl,T4240QDS",
> +	"fsl,T4240RDB",
>  	"fsl,B4860QDS",
>  	"fsl,B4420QDS",
>  	"fsl,B4220QDS",

What about hv_boards?

-Scott
