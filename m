Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 477E0DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 09:33:01 +1100 (EST)
Subject: Re: [PATCH] sungem: fix suspend regression due to NAPI changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1194889547.4456.4.camel@johannes.berg>
References: <1194889547.4456.4.camel@johannes.berg>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 09:32:46 +1100
Message-Id: <1194906766.18185.79.camel@pasglop>
Mime-Version: 1.0
Cc: netdev <netdev@vger.kernel.org>,
	Stephen Hemminger <shemminger@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-11-12 at 18:45 +0100, Johannes Berg wrote:
> Commit bea3348e (the NAPI changes) made sungem unconditionally enable
> NAPI when resuming and unconditionally disable when suspending, this,
> however, makes napi_disable() hang when suspending when the interface
> was taken down before suspend because taking the interface down also
> disables NAPI. This patch makes touching the napi struct in
> suspend/resume code paths depend on having the interface up, thereby
> fixing the hang on suspend.
> 
> The patch also moves the napi_disable() in gem_close() under the lock so
> that the NAPI state is always modified atomically together with the
> "opened" variable.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Thanks for fixing that !

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> ---
>  drivers/net/sungem.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> --- everything.orig/drivers/net/sungem.c	2007-11-12 18:22:49.948748047 +0100
> +++ everything/drivers/net/sungem.c	2007-11-12 18:24:30.708748481 +0100
> @@ -2333,10 +2333,10 @@ static int gem_close(struct net_device *
>  {
>  	struct gem *gp = dev->priv;
>  
> -	napi_disable(&gp->napi);
> -
>  	mutex_lock(&gp->pm_mutex);
>  
> +	napi_disable(&gp->napi);
> +
>  	gp->opened = 0;
>  	if (!gp->asleep)
>  		gem_do_stop(dev, 0);
> @@ -2355,8 +2355,6 @@ static int gem_suspend(struct pci_dev *p
>  
>  	mutex_lock(&gp->pm_mutex);
>  
> -	napi_disable(&gp->napi);
> -
>  	printk(KERN_INFO "%s: suspending, WakeOnLan %s\n",
>  	       dev->name,
>  	       (gp->wake_on_lan && gp->opened) ? "enabled" : "disabled");
> @@ -2370,6 +2368,8 @@ static int gem_suspend(struct pci_dev *p
>  
>  	/* If the driver is opened, we stop the MAC */
>  	if (gp->opened) {
> +		napi_disable(&gp->napi);
> +
>  		/* Stop traffic, mark us closed */
>  		netif_device_detach(dev);
>  
> @@ -2460,6 +2460,7 @@ static int gem_resume(struct pci_dev *pd
>  		/* Re-attach net device */
>  		netif_device_attach(dev);
>  
> +		napi_enable(&gp->napi);
>  	}
>  
>  	spin_lock_irqsave(&gp->lock, flags);
> @@ -2479,8 +2480,6 @@ static int gem_resume(struct pci_dev *pd
>  	spin_unlock(&gp->tx_lock);
>  	spin_unlock_irqrestore(&gp->lock, flags);
>  
> -	napi_enable(&gp->napi);
> -
>  	mutex_unlock(&gp->pm_mutex);
>  
>  	return 0;
> 
