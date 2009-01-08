Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7866DE311
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:37:17 +1100 (EST)
Date: Thu, 8 Jan 2009 12:36:19 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/4] hvc_console: do not set low_latency
Message-ID: <20090108123619.3543719f@lxorguk.ukuu.org.uk>
In-Reply-To: <hvc-console-29-3-1@bga.com>
References: <hvc-console-29-3@bga.com>
	<hvc-console-29-3-1@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Joe Peterson <joe@skyrush.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> v2.6.16-rc1 via 33f0f88f1c51ae5c2d593d26960c760ea154c2e2
>     [PATCH] TTY layer buffering revamp
> 
> added this new api.

No - tty_flip_buffer_push is from 2.1.66 and with the same constraints
from the day it was added.


> Having the flag set for purely polled drivers will save delaying
> the work when receiving input for 1 jiffie.
> 
> 
> Index: work.git/drivers/char/hvc_console.c
> ===================================================================
> --- work.git.orig/drivers/char/hvc_console.c	2009-01-08 03:01:24.000000000 -0600
> +++ work.git/drivers/char/hvc_console.c	2009-01-08 03:01:51.000000000 -0600
> @@ -318,7 +318,8 @@ static int hvc_open(struct tty_struct *t
>  	} /* else count == 0 */
>  
>  	tty->driver_data = hp;
> -	tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
> +	if (!hp->irq_requested)
> +		tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
>  
>  	hp->tty = tty;

Looks good to me
