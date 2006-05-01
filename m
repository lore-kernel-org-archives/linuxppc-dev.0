Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25F0667B3D
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 16:58:42 +1000 (EST)
Subject: Re: [PATCH] via-pmu: report powerbutton as proper input event
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1146251713.5019.4.camel@localhost>
References: <1146251713.5019.4.camel@localhost>
Content-Type: text/plain
Date: Mon, 01 May 2006 16:58:36 +1000
Message-Id: <1146466716.30710.39.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-04-28 at 21:15 +0200, Johannes Berg wrote:
> This patch adds an input device for the power button so that userspace gets
> notified about the user pressing it via the standard input layer.

Looks interesting. Waht about other buttons/events the PMU can report ?

> +#endif /* __VIA_PMU_EVENT_H */
> --- linux-2.6.orig/include/linux/input.h	2006-04-28 20:00:37.417288704 +0200
> +++ linux-2.6/include/linux/input.h	2006-04-28 20:00:48.157288704 +0200
> @@ -658,6 +658,7 @@ struct input_absinfo {
>  #define BUS_I2C			0x18
>  #define BUS_HOST		0x19
>  #define BUS_GSC			0x1A
> +#define BUS_PMU			0x20

Magic numbers... BAD BAD BAD ... Somebody needs to LART the input layer
people.
 

> @@ -2915,6 +2921,10 @@ static int __init init_pmu_led(void)
>  		if (pmu_led_init()) {
>  			printk(KERN_WARNING "via-pmu: LED failed to init\n");
>  		}
> +
> +		/* only on keylargo can the power button be on the pmu ... */
> +		if (pmu_event_init())
> +			printk(KERN_WARNING "via-pmu: couldn't add event device");
>  	}
>  
>  	return 0;

Do we need these here ? Why not an initcall self-contained in each
file ?

Ben.
