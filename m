Return-Path: <osstklei@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D49ADDF68
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 01:19:37 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m8FFIcAJ476926
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Sep 2008 15:18:38 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8FFIcmU1175744
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Sep 2008 17:18:38 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8FFIYOr008602
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Sep 2008 17:18:35 +0200
Message-ID: <48CE7CC3.8040902@de.ibm.com>
Date: Mon, 15 Sep 2008 17:18:27 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Sebastien Dugue <sebastien.dugue@bull.net>, jeff@garzik.org
Subject: Re: [PATCH 2/2] ehea: fix mutex and spinlock use
References: <1221140080-9853-1-git-send-email-sebastien.dugue@bull.net>
	<1221140080-9853-3-git-send-email-sebastien.dugue@bull.net>
In-Reply-To: <1221140080-9853-3-git-send-email-sebastien.dugue@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, tinytim@us.ibm.com, themann@de.ibm.com,
	netdev@vger.kernel.org, hering2@de.ibm.com,
	linux-kernel@vger.kernel.org, jean-pierre.dion@bull.net,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, gilles.carry@ext.bull.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

NACK!

I regret but this patch is wrong. It is not sufficient to only lock
the replacement of an old list with a new list. Building up those
lists is a 3-step process:

1. Count the number of entries a list will contain and allocate mem
2. Fill the list
3. Replace old list with updated list

It's obvious that the contents of the list may not change during this
procedure. That means that not only the list build-up procedure must
be locked. It must be assured that no function that modifies the list's
content can be called while another list update is in progress.

Jeff, please revert this patch.

Thanks
Thomas



Sebastien Dugue wrote:
>   Looks like to me that the ehea_fw_handles.lock mutex and the
> ehea_bcmc_regs.lock spinlock are taken much longer than necessary and could
> as well be pushed inside the functions that need them
> (ehea_update_firmware_handles() and ehea_update_bcmc_registrations())
> rather than at each callsite.
> 
> Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
> ---
>  drivers/net/ehea/ehea_main.c |   26 ++++----------------------
>  1 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
> index b70c531..c765ec6 100644
> --- a/drivers/net/ehea/ehea_main.c
> +++ b/drivers/net/ehea/ehea_main.c
> @@ -219,9 +219,11 @@ static void ehea_update_firmware_handles(void)
>  	}
>  
>  out_update:
> +	mutex_lock(&ehea_fw_handles.lock);
>  	kfree(ehea_fw_handles.arr);
>  	ehea_fw_handles.arr = arr;
>  	ehea_fw_handles.num_entries = i;
> +	mutex_unlock(&ehea_fw_handles.lock);
>  }
>  
>  static void ehea_update_bcmc_registrations(void)
> @@ -293,9 +295,11 @@ static void ehea_update_bcmc_registrations(void)
>  	}
>  
>  out_update:
> +	spin_lock(&ehea_bcmc_regs.lock);
>  	kfree(ehea_bcmc_regs.arr);
>  	ehea_bcmc_regs.arr = arr;
>  	ehea_bcmc_regs.num_entries = i;
> +	spin_unlock(&ehea_bcmc_regs.lock);
>  }
>  
>  static struct net_device_stats *ehea_get_stats(struct net_device *dev)
> @@ -1770,8 +1774,6 @@ static int ehea_set_mac_addr(struct net_device *dev, void *sa)
>  
>  	memcpy(dev->dev_addr, mac_addr->sa_data, dev->addr_len);
>  
> -	spin_lock(&ehea_bcmc_regs.lock);
> -
>  	/* Deregister old MAC in pHYP */
>  	if (port->state == EHEA_PORT_UP) {
>  		ret = ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
> @@ -1792,7 +1794,6 @@ static int ehea_set_mac_addr(struct net_device *dev, void *sa)
>  
>  out_upregs:
>  	ehea_update_bcmc_registrations();
> -	spin_unlock(&ehea_bcmc_regs.lock);
>  out_free:
>  	kfree(cb0);
>  out:
> @@ -1954,8 +1955,6 @@ static void ehea_set_multicast_list(struct net_device *dev)
>  	}
>  	ehea_promiscuous(dev, 0);
>  
> -	spin_lock(&ehea_bcmc_regs.lock);
> -
>  	if (dev->flags & IFF_ALLMULTI) {
>  		ehea_allmulti(dev, 1);
>  		goto out;
> @@ -1985,7 +1984,6 @@ static void ehea_set_multicast_list(struct net_device *dev)
>  	}
>  out:
>  	ehea_update_bcmc_registrations();
> -	spin_unlock(&ehea_bcmc_regs.lock);
>  	return;
>  }
>  
> @@ -2466,8 +2464,6 @@ static int ehea_up(struct net_device *dev)
>  	if (port->state == EHEA_PORT_UP)
>  		return 0;
>  
> -	mutex_lock(&ehea_fw_handles.lock);
> -
>  	ret = ehea_port_res_setup(port, port->num_def_qps,
>  				  port->num_add_tx_qps);
>  	if (ret) {
> @@ -2504,8 +2500,6 @@ static int ehea_up(struct net_device *dev)
>  		}
>  	}
>  
> -	spin_lock(&ehea_bcmc_regs.lock);
> -
>  	ret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
>  	if (ret) {
>  		ret = -EIO;
> @@ -2527,10 +2521,8 @@ out:
>  		ehea_info("Failed starting %s. ret=%i", dev->name, ret);
>  
>  	ehea_update_bcmc_registrations();
> -	spin_unlock(&ehea_bcmc_regs.lock);
>  
>  	ehea_update_firmware_handles();
> -	mutex_unlock(&ehea_fw_handles.lock);
>  
>  	return ret;
>  }
> @@ -2580,9 +2572,6 @@ static int ehea_down(struct net_device *dev)
>  	if (port->state == EHEA_PORT_DOWN)
>  		return 0;
>  
> -	mutex_lock(&ehea_fw_handles.lock);
> -
> -	spin_lock(&ehea_bcmc_regs.lock);
>  	ehea_drop_multicast_list(dev);
>  	ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
>  
> @@ -2591,7 +2580,6 @@ static int ehea_down(struct net_device *dev)
>  	port->state = EHEA_PORT_DOWN;
>  
>  	ehea_update_bcmc_registrations();
> -	spin_unlock(&ehea_bcmc_regs.lock);
>  
>  	ret = ehea_clean_all_portres(port);
>  	if (ret)
> @@ -2599,7 +2587,6 @@ static int ehea_down(struct net_device *dev)
>  			  dev->name, ret);
>  
>  	ehea_update_firmware_handles();
> -	mutex_unlock(&ehea_fw_handles.lock);
>  
>  	return ret;
>  }
> @@ -3378,7 +3365,6 @@ static int __devinit ehea_probe_adapter(struct of_device *dev,
>  		ehea_error("Invalid ibmebus device probed");
>  		return -EINVAL;
>  	}
> -	mutex_lock(&ehea_fw_handles.lock);
>  
>  	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
>  	if (!adapter) {
> @@ -3462,7 +3448,6 @@ out_free_ad:
>  
>  out:
>  	ehea_update_firmware_handles();
> -	mutex_unlock(&ehea_fw_handles.lock);
>  	return ret;
>  }
>  
> @@ -3481,8 +3466,6 @@ static int __devexit ehea_remove(struct of_device *dev)
>  
>  	flush_scheduled_work();
>  
> -	mutex_lock(&ehea_fw_handles.lock);
> -
>  	ibmebus_free_irq(adapter->neq->attr.ist1, adapter);
>  	tasklet_kill(&adapter->neq_tasklet);
>  
> @@ -3492,7 +3475,6 @@ static int __devexit ehea_remove(struct of_device *dev)
>  	kfree(adapter);
>  
>  	ehea_update_firmware_handles();
> -	mutex_unlock(&ehea_fw_handles.lock);
>  
>  	return 0;
>  }
