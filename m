Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 694252C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 09:01:58 +1100 (EST)
Message-ID: <50A171CE.8080600@freescale.com>
Date: Mon, 12 Nov 2012 16:01:50 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] drivers/virt: fix dependency on FSL booke hv management
 driver
References: <1352757003-3070-1-git-send-email-scottwood@freescale.com>
In-Reply-To: <1352757003-3070-1-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> If built on non-booke, the build will fail looking for MSR_GS as reported here:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-November/101944.html
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Timur Tabi <timur@freescale.com>
> ---
> Timur, I thought we were going to get rid of that MSR_GS check...

I posted a fix back in May, and I sent Kumar a few reminders over the past
six months.  You'll have to ask him why he never applied it.

http://marc.info/?l=linux-kernel&m=133728200626957&w=4

> 
>  drivers/virt/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 2dcdbc9..db5b9e6 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -14,7 +14,7 @@ if VIRT_DRIVERS
>  
>  config FSL_HV_MANAGER
>  	tristate "Freescale hypervisor management driver"
> -	depends on FSL_SOC
> +	depends on FSL_SOC_BOOKE
>  	help
>            The Freescale hypervisor management driver provides several services
>  	  to drivers and applications related to the Freescale hypervisor:
> 


-- 
Timur Tabi
Linux kernel developer at Freescale
