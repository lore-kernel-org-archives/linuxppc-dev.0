Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 731DA67A41
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 10:03:31 +1000 (EST)
Subject: Re: pmf_register_irq_client gives sleep with locks held warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1149793098.11525.34.camel@johannes>
References: <1149020341.5128.7.camel@johannes>
	<1149123574.15446.15.camel@localhost.localdomain>
	<1149793098.11525.34.camel@johannes>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 10:03:04 +1000
Message-Id: <1149897784.12687.87.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-08 at 20:58 +0200, Johannes Berg wrote:
> On Thu, 2006-06-01 at 10:59 +1000, Benjamin Herrenschmidt wrote:
> 
> > This fixes request_irq() potentially called from atomic context.
> > [...]
> 
> Sorry, almost forgot about this.
> 
> I don't think your patch is right, it seems to me that now
> pmf_unregister_irq_client races against pmf_do_irq: what happens when an
> interrupt comes in right in the middle of the list_del()?

Yeah, possibly... too late for 2.6.17 tho.

> By the way, what do I do when like this I change a patch? Do I rely on
> your Signed-off-by and simply put mine instead (like I did now)?

You add yours.

> Anyway, here's a changed patch that illustrates my point. I've tested it
> and it works and as expected fixes the problem :)

Too late :)

Cheers,
Ben.

> ---
> This fixes request_irq() being called with interrupts disabled in the
> powermac platform function code when registering the first irq client
> for a given platform function.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> 
> --- a/arch/powerpc/platforms/powermac/pfunc_core.c
> +++ b/arch/powerpc/platforms/powermac/pfunc_core.c
> @@ -11,6 +11,7 @@ #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/spinlock.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  
>  #include <asm/semaphore.h>
>  #include <asm/prom.h>
> @@ -546,6 +547,7 @@ struct pmf_device {
>  
>  static LIST_HEAD(pmf_devices);
>  static spinlock_t pmf_lock = SPIN_LOCK_UNLOCKED;
> +static DEFINE_MUTEX(pmf_irq_mutex);
>  
>  static void pmf_release_device(struct kref *kref)
>  {
> @@ -864,16 +866,25 @@ int pmf_register_irq_client(struct devic
>  
>  	spin_lock_irqsave(&pmf_lock, flags);
>  	func = __pmf_find_function(target, name, PMF_FLAGS_INT_GEN);
> -	if (func == NULL) {
> -		spin_unlock_irqrestore(&pmf_lock, flags);
> +	if (func)
> +		func = pmf_get_function(func);
> +	spin_unlock_irqrestore(&pmf_lock, flags);
> +	if (func == NULL)
>  		return -ENODEV;
> -	}
> +
> +	/* guard against manipulations of list */
> +	mutex_lock(&pmf_irq_mutex);
>  	if (list_empty(&func->irq_clients))
>  		func->dev->handlers->irq_enable(func);
> +
> +	/* guard against pmf_do_irq while changing list */
> +	spin_lock_irqsave(&pmf_lock, flags);
>  	list_add(&client->link, &func->irq_clients);
> -	client->func = func;
>  	spin_unlock_irqrestore(&pmf_lock, flags);
>  
> +	client->func = func;
> +	mutex_unlock(&pmf_irq_mutex);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pmf_register_irq_client);
> @@ -885,12 +896,19 @@ void pmf_unregister_irq_client(struct pm
>  
>  	BUG_ON(func == NULL);
>  
> -	spin_lock_irqsave(&pmf_lock, flags);
> +	/* guard against manipulations of list */
> +	mutex_lock(&pmf_irq_mutex);
>  	client->func = NULL;
> +
> +	/* guard against pmf_do_irq while changing list */
> +	spin_lock_irqsave(&pmf_lock, flags);
>  	list_del(&client->link);
> +	spin_unlock_irqrestore(&pmf_lock, flags);
> +
>  	if (list_empty(&func->irq_clients))
>  		func->dev->handlers->irq_disable(func);
> -	spin_unlock_irqrestore(&pmf_lock, flags);
> +	mutex_unlock(&pmf_irq_mutex);
> +	pmf_put_function(func);
>  }
>  EXPORT_SYMBOL_GPL(pmf_unregister_irq_client);
>  
> 
