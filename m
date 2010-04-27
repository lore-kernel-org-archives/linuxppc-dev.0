Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39B8BB7D41
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 16:39:40 +1000 (EST)
Subject: Re: [PATCH] booke_wdt: Fix build (unconstify watchdog_info)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@mvista.com>
In-Reply-To: <20100426174358.GA16889@oksana.dev.rtsoft.ru>
References: <20100426174358.GA16889@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 16:37:00 +1000
Message-ID: <1272350220.24542.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-04-26 at 21:43 +0400, Anton Vorontsov wrote:
> commit 42747d712de56cf2087b702d2ad90af114c53138 ("[WATCHDOG]
> watchdog_info constify") introduced the following build failure:
> 
>    CC      booke_wdt.o
>  booke_wdt.c: In function 'booke_wdt_init':
>  booke_wdt.c:220: error: assignment of read-only variable 'ident'
> 
> Fix this by removing 'const' qualifier from watchdog_info struct.

Should this go via powerpc.git ? If yes, I'll send to Linus asap.

Cheers,
Ben.

> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
>  drivers/watchdog/booke_wdt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-
> 
> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 500d383..801ead1 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -121,7 +121,7 @@ static ssize_t booke_wdt_write(struct file *file, const char __user *buf,
>  	return count;
>  }
>  
> -static const struct watchdog_info ident = {
> +static struct watchdog_info ident = {
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity = "PowerPC Book-E Watchdog",
>  };
