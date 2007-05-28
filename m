Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B3D6CDDF90
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 03:41:41 +1000 (EST)
Message-ID: <465B14B2.2020804@ru.mvista.com>
Date: Mon, 28 May 2007 21:43:14 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: automatically select QE options
References: <1173732027723-git-send-email-timur@freescale.com>
In-Reply-To: <1173732027723-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Timur Tabi wrote:

> Change the Kconfig files so that the Freescale QE options are automatically
> selected if a QE device is selected.  Previously, you'd need to manually
> select UCC_FAST if you want any "fast" UCC devices, such as Gigabit Ethernet.
> Now, the QE Gigabit Ethernet option is always available if the device has a
> QE, and UCC_FAST is automatically enabled.  A side-effect is that the
> "QE Options" menu no longer exists.

> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index d9400ef..b92a4e6 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2272,11 +2272,12 @@ config GFAR_NAPI
>  	depends on GIANFAR
>  
>  config UCC_GETH
> -	tristate "Freescale QE UCC GETH"
> -	depends on QUICC_ENGINE && UCC_FAST
> +	tristate "Freescale QE Gigabit Ethernet"
> +	depends on QUICC_ENGINE
> +	select UCC_FAST

    Grr... this causes menuconfig to complain on non-PPC archs:

drivers/net/Kconfig:2278:warning: 'select' used by config symbol 'UCC_GETH' 
refer to undefined symbol 'UCC_FAST'

WBR, Sergei
