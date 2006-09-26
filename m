Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0739567B74
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 15:11:25 +1000 (EST)
Date: Tue, 26 Sep 2006 00:10:41 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/7] [POWERPC] The two vio HVC backends clash
Message-ID: <20060926001041.4c708613@pb15>
In-Reply-To: <20060926133548.43afd711.sfr@canb.auug.org.au>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Sep 2006 13:35:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
> index 4747729..ea36201 100644
> --- a/drivers/char/hvc_iseries.c
> +++ b/drivers/char/hvc_iseries.c
> @@ -29,6 +29,7 @@ #include <linux/console.h>
>  #include <asm/hvconsole.h>
>  #include <asm/vio.h>
>  #include <asm/prom.h>
> +#include <asm/firmware.h>
>  #include <asm/iseries/vio.h>
>  #include <asm/iseries/hv_call.h>
>  #include <asm/iseries/hv_lp_config.h>
> @@ -493,6 +494,9 @@ static int hvc_vio_init(void)
>  	atomic_t wait_flag;
>  	int rc;
>  
> +	if (!firmware_has_feature(FW_FEATURE_ISERIES))
> +		return -EIO;
> +

Shouldn't this be -ENODEV?


-Olof
