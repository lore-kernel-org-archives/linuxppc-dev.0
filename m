Return-Path: <mita@fixstars.com>
Received: from mail.fixstars.com (smtp.fixstars.com [202.131.199.70])
	by ozlabs.org (Postfix) with ESMTP id 68882DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 00:35:51 +1000 (EST)
Date: Thu, 21 Jun 2007 23:07:31 +0900
From: Akinobu Mita <mita@fixstars.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [Cbe-oss-dev] [patch 1/5] cell: pmi remove support for mutiple
	devices.
Message-ID: <20070621140731.GA24496@ps3linux.grid.fixstars.com>
References: <20070621130944.083f8fa5@localhost>
	<20070621131644.03a8ec31@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070621131644.03a8ec31@localhost>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Index: linux/arch/powerpc/sysdev/pmi.c
> ===================================================================
> --- linux.orig/arch/powerpc/sysdev/pmi.c
> +++ linux/arch/powerpc/sysdev/pmi.c
> @@ -48,15 +48,13 @@ struct pmi_data {
>  	struct work_struct	work;
>  };
>  
> +static struct pmi_data *data;
>  

[...]

> @@ -129,9 +124,14 @@ static int pmi_of_probe(struct of_device
>  			const struct of_device_id *match)
>  {
>  	struct device_node *np = dev->node;
> -	struct pmi_data *data;
>  	int rc;
>  
> +	if (data) {
> +		printk(KERN_ERR "pmi: driver has already been initialized.\n");
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
>  	data = kzalloc(sizeof(struct pmi_data), GFP_KERNEL);
>  	if (!data) {
>  		printk(KERN_ERR "pmi: could not allocate memory.\n");
> @@ -154,7 +154,6 @@ static int pmi_of_probe(struct of_device
>  
>  	INIT_WORK(&data->work, pmi_notify_handlers);
>  
> -	dev->dev.driver_data = data;
>  	data->dev = dev;
>  
>  	data->irq = irq_of_parse_and_map(np, 0);
> @@ -164,7 +163,7 @@ static int pmi_of_probe(struct of_device
>  		goto error_cleanup_iomap;
>  	}
>  
> -	rc = request_irq(data->irq, pmi_irq_handler, 0, "pmi", data);
> +	rc = request_irq(data->irq, pmi_irq_handler, 0, "pmi", NULL);
>  	if (rc) {
>  		printk(KERN_ERR "pmi: can't request IRQ %d: returned %d\n",
>  				data->irq, rc);
> @@ -187,11 +186,8 @@ out:
>  
>  static int pmi_of_remove(struct of_device *dev)
>  {
> -	struct pmi_data *data;
>  	struct pmi_handler *handler, *tmp;
>  
> -	data = dev->dev.driver_data;
> -
>  	free_irq(data->irq, data);
>  	iounmap(data->pmi_reg);
>  
> @@ -202,7 +198,7 @@ static int pmi_of_remove(struct of_devic
>  
>  	spin_unlock(&data->handler_spinlock);
>  
> -	kfree(dev->dev.driver_data);
> +	kfree(data);

Shouldn't it set data = NULL here?

I guess we will get "pmi: driver has already been initialized" message
and -EBUSY on reloading pmi driver.

>  
>  	return 0;
>  }
