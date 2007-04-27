Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6BB63DE045
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 07:53:11 +1000 (EST)
Date: Fri, 27 Apr 2007 16:53:38 -0500
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powerpc: fix suspend states again
Message-ID: <20070427215338.GB17224@lixom.net>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177710095.3565.64.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177710095.3565.64.camel@johannes.berg>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,


On Fri, Apr 27, 2007 at 11:41:35PM +0200, Johannes Berg wrote:

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6/arch/powerpc/kernel/swsusp.c	2007-04-27 23:25:20.406021121 +0200
> @@ -0,0 +1,42 @@
> +/*
> + * Common powerpc suspend code for 32 and 64 bits
> + *
> + * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
> + *
> + * GPLv2
> + */

A regular GPL copyright blurb isn't that hard to paste in. :-)

> +#include <linux/sched.h>
> +#include <asm/suspend.h>
> +#include <asm/cputable.h>
> +#include <asm/system.h>
> +#include <asm/current.h>
> +#include <asm/mmu_context.h>
> +
> +#ifdef CONFIG_SPE
> +extern void enable_kernel_spe(void);
> +#endif

This should be added to asm-powerpc/system.h instead, and that should
be included here since that has the enable_kernel_altivec() and
enable_kernel_fp() definitions.


-Olof
