Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id BC398B70A3
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Dec 2010 06:08:42 +1100 (EST)
Received: by pvf33 with SMTP id 33so2113464pvf.15
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2010 11:08:40 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 23 Dec 2010 12:08:38 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH RESEND 2] mpc52xx: gpt: include fs.h
Message-ID: <20101223190838.GE20384@angua.secretlab.ca>
References: <1293032575-16241-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293032575-16241-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 22, 2010 at 04:42:55PM +0100, Wolfram Sang wrote:
> Fix build errors like these (from a randconfig and my defconfig for a custom board):
> 
> src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:549: error: dereferencing pointer to incomplete type: 1 errors in 1 logs
> src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:636: error: implicit declaration of function 'nonseekable_open': 1 errors in 1 logs
> src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:657: error: variable 'mpc52xx_wdt_fops' has initializer but incomplete type: 1 errors in 1 logs
> src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:658: error: excess elements in struct initializer: 1 errors in 1 logs
> src/arch/powerpc/platforms/52xx/mpc52xx_gpt.c:658: error: unknown field 'owner' specified in initializer: 1 errors in 1 logs
> ...
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Applied, thanks.

Sorry for the delay.  I got severely snowed under this fall and have
only come up for air now.

g.

> ---
> 
> rc7 is out and we still have this build-failure. Please apply.
> 
>  arch/powerpc/platforms/52xx/mpc52xx_gpt.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> index fea833e..e0d703c 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> @@ -63,6 +63,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> +#include <linux/fs.h>
>  #include <linux/watchdog.h>
>  #include <linux/miscdevice.h>
>  #include <linux/uaccess.h>
> -- 
> 1.7.2.3
> 
