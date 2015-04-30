Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0121.outbound.protection.outlook.com [65.55.169.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 217591A0365
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 13:36:27 +1000 (AEST)
Message-ID: <1430364971.16357.154.camel@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: p1025twr: add module conditional to fix
 QE-uart issue
From: Scott Wood <scottwood@freescale.com>
To: Pengbo Li <Pengbo.Li@freescale.com>
Date: Wed, 29 Apr 2015 22:36:11 -0500
In-Reply-To: <1430362610-35564-1-git-send-email-Pengbo.Li@freescale.com>
References: <1430362610-35564-1-git-send-email-Pengbo.Li@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-30 at 10:56 +0800, Pengbo Li wrote:
> From: Xie Xiaobo <X.Xie@freescale.com>
> 
> A ioport setting was needed when used the QE uart function on TWR-P1025.
> Added a conditional definition to avoid missing this setting when the
> QE-uart driver was bulit to a module.

s/was bulit to/is built as/

> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> Change-Id: I95b40c760335ce5fa7a27a94287dbef28219b5fa
> Reviewed-on: http://git.am.freescale.net:8181/6643
> Tested-by: Review Code-CDREVIEW <CDREVIEW@freescale.com>
> Reviewed-by: Yang Li <LeoLi@freescale.com>
> Reviewed-by: Thomas Trefny <Tom.Trefny@freescale.com>
> Reviewed-on: http://git.am.freescale.net:8181/12045
> Reviewed-by: Jose Rivera <German.Rivera@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/twr_p102x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
> index 1eadb6d..069e19b 100644
> --- a/arch/powerpc/platforms/85xx/twr_p102x.c
> +++ b/arch/powerpc/platforms/85xx/twr_p102x.c
> @@ -101,7 +101,7 @@ static void __init twr_p1025_setup_arch(void)
>  					MPC85xx_PMUXCR_QE(12));
>  			iounmap(guts);
>  
> -#if defined(CONFIG_SERIAL_QE)
> +#if defined(CONFIG_SERIAL_QE) || defined(CONFIG_SERIAL_QE_MODULE)
>  			/* On P1025TWR board, the UCC7 acted as UART port.
>  			 * However, The UCC7's CTS pin is low level in default,
>  			 * it will impact the transmission in full duplex

How about using IS_ENABLED here?

Don't you need an equivalent change to
"#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)"
?

Do we really need the ifdefs at all?  What's the harm in setting up the
pins if those things aren't built into the kernel?  Power consumption?
Is it a likely use case?

-Scott
