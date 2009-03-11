Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8BCCDE1E6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 15:10:51 +1100 (EST)
Subject: Re: [PATCH] eHEA: Don't do memory allocation under lock if not
	necessary
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
In-Reply-To: <20090309163628.2570.8408.stgit@warthog.procyon.org.uk>
References: <20090309163628.2570.8408.stgit@warthog.procyon.org.uk>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 15:10:41 +1100
Message-Id: <1236744641.7086.40.camel@pasglop>
Mime-Version: 1.0
Cc: tklein@de.ibm.com, linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	themann@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-09 at 16:36 +0000, David Howells wrote:
> In ehea_probe_adapter() the initial memory allocation and initialisation does
> not need to be done with the ehea_fw_handles.lock semaphore held.  Doing so
> extends the amount of time the lock is held unnecessarily.

Can you resend with netdev on CC ?

Cheers,
Ben.

> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  drivers/net/ehea/ehea_main.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
> index dfe9226..34480ae 100644
> --- a/drivers/net/ehea/ehea_main.c
> +++ b/drivers/net/ehea/ehea_main.c
> @@ -3370,18 +3370,19 @@ static int __devinit ehea_probe_adapter(struct of_device *dev,
>  		ehea_error("Invalid ibmebus device probed");
>  		return -EINVAL;
>  	}
> -	mutex_lock(&ehea_fw_handles.lock);
>  
>  	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
>  	if (!adapter) {
> -		ret = -ENOMEM;
>  		dev_err(&dev->dev, "no mem for ehea_adapter\n");
> -		goto out;
> +		return -ENOMEM;
>  	}
>  
> -	list_add(&adapter->list, &adapter_list);
> -
>  	adapter->ofdev = dev;
> +	adapter->pd = EHEA_PD_ID;
> +
> +	mutex_lock(&ehea_fw_handles.lock);
> +
> +	list_add(&adapter->list, &adapter_list);
>  
>  	adapter_handle = of_get_property(dev->node, "ibm,hea-handle",
>  					 NULL);
> @@ -3395,8 +3396,6 @@ static int __devinit ehea_probe_adapter(struct of_device *dev,
>  		goto out_free_ad;
>  	}
>  
> -	adapter->pd = EHEA_PD_ID;
> -
>  	dev->dev.driver_data = adapter;
>  
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
