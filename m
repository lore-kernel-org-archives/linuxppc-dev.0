Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB61D679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 08:07:25 +1000 (EST)
Subject: Re: [PATCH] fix windfarm core thread wrt. signal handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1151432266.4289.6.camel@localhost>
References: <1150847482.16662.13.camel@johannes>
	<1150956123.3633.23.camel@localhost.localdomain>
	<200606221303.19860.rjw@sisk.pl> <1150974836.16258.29.camel@johannes>
	<1150976092.16258.33.camel@johannes>
	<1151394268.2350.61.camel@localhost.localdomain>
	<1151432266.4289.6.camel@localhost>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 08:07:06 +1000
Message-Id: <1151446026.2350.76.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-27 at 20:17 +0200, Johannes Berg wrote:
> This patch removes the signal_pending() from the windfarm core thread
> loop as it isn't necessary and messes up when there actually *is* a
> signal pending because we should enter the freezer.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
> index ab3faa7..c05a838 100644
> --- a/drivers/macintosh/windfarm_core.c
> +++ b/drivers/macintosh/windfarm_core.c
> @@ -116,12 +116,6 @@ static int wf_thread_func(void *data)
>  		delay = next - jiffies;
>  		if (delay <= HZ)
>  			schedule_timeout_interruptible(delay);
> -
> -		/* there should be no signal, but oh well */
> -		if (signal_pending(current)) {
> -			printk(KERN_WARNING "windfarm: thread got sigl !\n");
> -			break;
> -		}
>  	}
>  
>  	DBG("wf: thread stopped\n");
> 
