Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 8CB7068593
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 03:09:41 +1100 (EST)
Date: Mon, 7 Nov 2005 09:09:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Message-ID: <20051107160939.GD3839@smtp.west.cox.net>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131357857.27347.28.camel@baythorne.infradead.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 07, 2005 at 10:04:17AM +0000, David Woodhouse wrote:

> This fairly much obsoletes include/asm-ppc/pc_serial.h -- other machines
> with 8250 ports which are currently responsible for the mess in
> include/asm-ppc/serial.h itself should be converted to a platform_device
> of their own before they become supported in arch/powerpc.

That depends on what we're going to expect out of arch/powerpc/boot,
which I'm talking with Paul about.  But..

> --- /dev/null	2005-10-08 11:44:47.528646500 +0100
> +++ b/drivers/serial/8250_of.c	2005-11-07 09:51:22.000000000 +0000
> @@ -0,0 +1,197 @@
> +#include <linux/kernel.h>
[snip]
> +#if 0
> +#define DBG(fmt...) printk(KERN_DEBUG fmt)
> +#else
> +#define DBG(fmt...) do { } while (0)
> +#endif

pr_debug(), line wrap and a legal boilerplate
(arch/ppc/platforms/lopec.c has the smallest one our laywers could come
up with) ? :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
