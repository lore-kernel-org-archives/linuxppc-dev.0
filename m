Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 30C2068014
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 02:32:25 +1000 (EST)
Message-ID: <4523E214.5060404@freescale.com>
Date: Wed, 04 Oct 2006 11:32:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add of_platform_device_scan().
References: <20061003225659.GA11955@ld0162-tx32.am.freescale.net>
	<200610040118.09416.arnd@arndb.de>
In-Reply-To: <200610040118.09416.arnd@arndb.de>
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

Arnd Bergmann wrote:
> I think it would be much more helpful to have working probing of all
> SOC buses during bootup.

I agree; I avoided doing that for now because I was uneasy about 
duplicating device nodes for SOC devices covered under the non-OF 
platform bus via code in sysdev/fsl_soc.c.  It probably won't cause any 
real problems unless a single device matches drivers on both buses (in 
which case the of_device driver would probably be calling 
of_platform_device_scan() anyway), but still...

What I'd really like (long-term, of course) is if platform_device and 
of_device were merged, with device tree support (or at least a means of 
passing on properties that *could* come from a device tree without 
special glue code that knows about each property) in arch-neutral code; 
the mechanism for discovering devices ideally shouldn't depend on the 
CPU's instruction set.

> +	for (child = NULL; (child = of_get_next_child(root, child)); ) {
> +		if (strcmp(child->type, "spider") == 0) {
> +			ret = of_soc_device_create(child, NULL);
> +			if (ret)
> +				goto out3;
> +		}
> +	}

Why only spider?

-Scott
