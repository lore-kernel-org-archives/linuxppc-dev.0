Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id E71B7DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 06:28:01 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] windfarm: fix windfarm thread freezer interaction
Date: Tue, 23 Oct 2007 22:17:35 +0200
References: <1193142822.7733.3.camel@johannes.berg>
In-Reply-To: <1193142822.7733.3.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200710232217.35951.rjw@sisk.pl>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday, 23 October 2007 14:33, Johannes Berg wrote:
> When I fixed the windfarm freezer interaction first in commit
> 1ed2ddf380e19dafeec2150ca709ef7f4a67cd21, an earlier patch than the one
> I came up with after comments was committed. This has come back to haunt
> us now because commit d5d8c5976d6adeddb8208c240460411e2198b393 changed
> the freezer to no long send signals. Fix it by removing the windfarm
> thread's signal logic and restoring the original try_to_freeze().
> 
> We could simply revert 1ed2ddf380e19dafeec2150ca709ef7f4a67cd21 now
> but I feel that the assertion that no signal is delivered to the
> windfarm thread needs not be there.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/macintosh/windfarm_core.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> --- linux-2.6-git.orig/drivers/macintosh/windfarm_core.c	2007-10-23 14:23:02.406437623 +0200
> +++ linux-2.6-git/drivers/macintosh/windfarm_core.c	2007-10-23 14:25:28.745447695 +0200
> @@ -94,7 +94,9 @@ static int wf_thread_func(void *data)
>  	DBG("wf: thread started\n");
>  
>  	set_freezable();
> -	while(!kthread_should_stop()) {
> +	while (!kthread_should_stop()) {
> +		try_to_freeze();
> +
>  		if (time_after_eq(jiffies, next)) {
>  			wf_notify(WF_EVENT_TICK, NULL);
>  			if (wf_overtemp) {
> @@ -116,12 +118,6 @@ static int wf_thread_func(void *data)
>  		delay = next - jiffies;
>  		if (delay <= HZ)
>  			schedule_timeout_interruptible(delay);
> -
> -		/* there should be no non-suspend signal, but oh well */
> -		if (signal_pending(current) && !try_to_freeze()) {
> -			printk(KERN_WARNING "windfarm: thread got sigl !\n");
> -			break;
> -		}
>  	}
>  
>  	DBG("wf: thread stopped\n");
> 
> 
> 
> 
