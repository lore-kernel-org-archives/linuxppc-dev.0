Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20CD967B1B
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 15:31:17 +1000 (EST)
Subject: Re: [PATCH] use msleep() for RTAS delays
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Rose <johnrose@austin.ibm.com>
In-Reply-To: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 15:31:06 +1000
Message-Id: <1149139866.28307.32.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-31 at 14:32 -0500, John Rose wrote:
> The current use of udelay() for RTAS extended delay conditions can
> result in CPU soft lockups.  The use of msleep() won't tie up the CPU.

What about putting this whole thing in a helper ? There is a few more
things I've seen floating around implementing the exact same logic (for
example Jake's MSI patches).

We could either do something like

for (;;) {
	rc = rtas_call(...);
	if (!rtas_check_busy(rc))
		break;
}

Or something inside rtas_call

rtas_call_waitbusy(...);

Ben.

> Signed-off-by: John Rose <johnrose@austin.ibm.com>
> 
> ---
> 
> Thanks-
> John
> 
> diff -puN arch/powerpc/kernel/rtas.c~msleep_rtas arch/powerpc/kernel/rtas.c
> --- 2_6_linus/arch/powerpc/kernel/rtas.c~msleep_rtas	2006-05-31 14:07:51.000000000 -0500
> +++ 2_6_linus-johnrose/arch/powerpc/kernel/rtas.c	2006-05-31 14:10:09.000000000 -0500
> @@ -447,10 +447,10 @@ int rtas_set_power_level(int powerdomain
>  	while (1) {
>  		rc = rtas_call(token, 2, 2, setlevel, powerdomain, level);
>  		if (rc == RTAS_BUSY)
> -			udelay(1);
> +			msleep(1);
>  		else if (rtas_is_extended_busy(rc)) {
>  			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> +			msleep(wait_time);
>  		} else
>  			break;
>  	}
> @@ -472,10 +472,10 @@ int rtas_get_sensor(int sensor, int inde
>  	while (1) {
>  		rc = rtas_call(token, 2, 2, state, sensor, index);
>  		if (rc == RTAS_BUSY)
> -			udelay(1);
> +			msleep(1);
>  		else if (rtas_is_extended_busy(rc)) {
>  			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> +			msleep(wait_time);
>  		} else
>  			break;
>  	}
> @@ -497,12 +497,11 @@ int rtas_set_indicator(int indicator, in
>  	while (1) {
>  		rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
>  		if (rc == RTAS_BUSY)
> -			udelay(1);
> +			msleep(1);
>  		else if (rtas_is_extended_busy(rc)) {
>  			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> -		}
> -		else
> +			msleep(wait_time);
> +		} else
>  			break;
>  	}
>  
> diff -puN arch/powerpc/kernel/rtas_flash.c~msleep_rtas arch/powerpc/kernel/rtas_flash.c
> --- 2_6_linus/arch/powerpc/kernel/rtas_flash.c~msleep_rtas	2006-05-31 14:10:47.000000000 -0500
> +++ 2_6_linus-johnrose/arch/powerpc/kernel/rtas_flash.c	2006-05-31 14:19:30.000000000 -0500
> @@ -16,7 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/proc_fs.h>
> -#include <asm/delay.h>
> +#include <linux/delay.h>
>  #include <asm/uaccess.h>
>  #include <asm/rtas.h>
>  #include <asm/abs_addr.h>
> @@ -372,10 +372,10 @@ static void manage_flash(struct rtas_man
>  		rc = rtas_call(rtas_token("ibm,manage-flash-image"), 1, 
>  			       1, NULL, args_buf->op);
>  		if (rc == RTAS_RC_BUSY)
> -			udelay(1);
> +			msleep(1);
>  		else if (rtas_is_extended_busy(rc)) {
>  			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> +			msleep(wait_time);
>  		} else
>  			break;
>  	}
> @@ -465,10 +465,10 @@ static void validate_flash(struct rtas_v
>  		spin_unlock(&rtas_data_buf_lock);
>  			
>  		if (rc == RTAS_RC_BUSY)
> -			udelay(1);
> +			msleep(1);
>  		else if (rtas_is_extended_busy(rc)) {
>  			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> +			msleep(wait_time);
>  		} else
>  			break;
>  	}
> 
> _
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
