Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B49B01A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 20:40:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 19:40:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EA6693578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 20:40:32 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t199eNAs45351164
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 20:40:32 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t199dw0n011089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 20:39:58 +1100
Message-ID: <54D8805D.5060207@linux.vnet.ibm.com>
Date: Mon, 09 Feb 2015 15:09:41 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powernv: Add OPAL soft-poweroff routine
References: <1422600188-27488-1-git-send-email-joel@jms.id.au>
In-Reply-To: <1422600188-27488-1-git-send-email-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Cc: jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/30/2015 12:13 PM, Joel Stanley wrote:
> Register a notifier for a OPAL message indicating that the machine
> should prepare itself for a graceful power off.
> 
> OPAL will tell us if the power off is a reboot or shutdown, but for now
> we perform the same orderly_poweroff action.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>   - combine the reboot and off cases, as they are the same code
> 
>  arch/powerpc/include/asm/opal.h             |  2 +-
>  arch/powerpc/platforms/powernv/Makefile     |  2 +-
>  arch/powerpc/platforms/powernv/opal-power.c | 66 +++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/opal-power.c
> 
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index ca2dd45..cdf32c0 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -250,7 +250,7 @@ enum OpalMessageType {
>  					 */
>  	OPAL_MSG_MEM_ERR,
>  	OPAL_MSG_EPOW,
> -	OPAL_MSG_SHUTDOWN,
> +	OPAL_MSG_SHUTDOWN,		/* params[0] = 1 reboot, 0 shutdown */
>  	OPAL_MSG_HMI_EVT,
>  	OPAL_MSG_TYPE_MAX,
>  };
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index f241acc..6f3c5d3 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -1,7 +1,7 @@
>  obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
> -obj-y			+= opal-msglog.o opal-hmi.o
> +obj-y			+= opal-msglog.o opal-hmi.o opal-power.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
> diff --git a/arch/powerpc/platforms/powernv/opal-power.c b/arch/powerpc/platforms/powernv/opal-power.c
> new file mode 100644
> index 0000000..bbc1054
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-power.c
> @@ -0,0 +1,66 @@
> +/*
> + * PowerNV OPAL power control for graceful shutdown handling
> + *
> + * Copyright 2015 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/reboot.h>
> +#include <linux/notifier.h>
> +
> +#include <asm/opal.h>
> +#include <asm/machdep.h>
> +
> +#define SOFT_OFF 0x00
> +#define SOFT_REBOOT 0x01

Better move these macros to opal.h as its coming from OPAL API?
Also I think its to merge this code and Anshumans' EPOW driver and create single
event file.

-Vasant
