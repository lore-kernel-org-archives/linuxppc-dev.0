Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9DAE6140080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 05:39:39 +1000 (EST)
Message-ID: <1397590755.20280.250.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] fsl/corenet_generic: add a particular
 initialization for platform
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 15 Apr 2014 14:39:15 -0500
In-Reply-To: <1397541229-34383-1-git-send-email-dongsheng.wang@freescale.com>
References: <1397541229-34383-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, haokexin@gmail.com, prabhakar@freescale.com,
 jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-15 at 13:53 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Corenet_generic is a generic platform initialization. Those based on
> the corenet_generic board maybe need a particular initialize to
> enable/set some IP-Blocks. So add "Fix Generic Initialization" to solve
> this kind of special cases.

I still don't understand what you mean by "fix".  What are you fixing,
or what is fixed?

There is no need for adding an infrastructure layer here.  Just add a
new piece of code for t104x diu, and have it be called by an appropriate
initfunc.

> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> *v2*
>  1/ Split DIU code.
>  2/ make fix.c as a independent driver.
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index c17aae8..fce2341 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -269,6 +269,17 @@ config CORENET_GENERIC
>  	  The following boards are supported for both 32bit and 64bit kernel:
>  	    P5020 DS and P5040 DS
>  
> +config FIX_GENERIC_PLATFORM_INIT
> +	bool "Fix Generic Initialization"
> +	depends on CORENET_GENERIC

Why does this depend on CORENET_GENERIC?

> +	default y

No.

-Scott
