Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Ltwd3SYFzF1Sh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 20:13:19 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 2/4] drivers/base: utilize device tree info to shutdown
 devices
Date: Thu, 05 Jul 2018 12:11:49 +0200
Message-ID: <2108146.dv4EAOf6IP@aspire.rjw.lan>
In-Reply-To: <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, July 3, 2018 8:50:40 AM CEST Pingfan Liu wrote:
> commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> places an assumption of supplier<-consumer order on the process of probe.
> But it turns out to break down the parent <- child order in some scene.
> E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> have been probed. Then comes the bridge's module, which enables extra
> feature(such as hotplug) on this bridge. This will break the
> parent<-children order and cause failure when "kexec -e" in some scenario.
> 
> The detailed description of the scenario:
> An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
> match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
> to some issue. For this case, the bridge is moved after its children in
> devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
> write back buffer in flight due to the former shutdown of the bridge which
> clears the BusMaster bit.
> 
> It is a little hard to impose both "parent<-child" and "supplier<-consumer"
> order on devices_kset. Take the following scene:
> step0: before a consumer's probing, (note child_a is supplier of consumer_a)
>   [ consumer-X, child_a, ...., child_z] [... consumer_a, ..., consumer_z, ...] supplier-X
>                                          ^^^^^^^^^^ affected range ^^^^^^^^^^
> step1: when probing, moving consumer-X after supplier-X
>   [ child_a, ...., child_z] [.... consumer_a, ..., consumer_z, ...] supplier-X, consumer-X
> step2: the children of consumer-X should be re-ordered to maintain the seq
>   [... consumer_a, ..., consumer_z, ....] supplier-X  [consumer-X, child_a, ...., child_z]
> step3: the consumer_a should be re-ordered to maintain the seq
>   [... consumer_z, ...] supplier-X [ consumer-X, child_a, consumer_a ..., child_z]
> 
> It requires two nested recursion to drain out all out-of-order item in
> "affected range". To avoid such complicated code, this patch suggests
> to utilize the info in device tree, instead of using the order of
> devices_kset during shutdown. It iterates the device tree, and firstly
> shutdown a device's children and consumers. After this patch, the buggy
> commit is hollow and left to clean.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  drivers/base/core.c    | 48 +++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/device.h |  1 +
>  2 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a48868f..684b994 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1446,6 +1446,7 @@ void device_initialize(struct device *dev)
>  	INIT_LIST_HEAD(&dev->links.consumers);
>  	INIT_LIST_HEAD(&dev->links.suppliers);
>  	dev->links.status = DL_DEV_NO_DRIVER;
> +	dev->shutdown = false;
>  }
>  EXPORT_SYMBOL_GPL(device_initialize);
>  
> @@ -2811,7 +2812,6 @@ static void __device_shutdown(struct device *dev)
>  	 * lock is to be held
>  	 */
>  	parent = get_device(dev->parent);
> -	get_device(dev);

Why is the get_/put_device() not needed any more?

>  	/*
>  	 * Make sure the device is off the kset list, in the
>  	 * event that dev->*->shutdown() doesn't remove it.
> @@ -2842,23 +2842,60 @@ static void __device_shutdown(struct device *dev)
>  			dev_info(dev, "shutdown\n");
>  		dev->driver->shutdown(dev);
>  	}
> -
> +	dev->shutdown = true;
>  	device_unlock(dev);
>  	if (parent)
>  		device_unlock(parent);
>  
> -	put_device(dev);
>  	put_device(parent);
>  	spin_lock(&devices_kset->list_lock);
>  }
>  
> +/* shutdown dev's children and consumer firstly, then itself */
> +static int device_for_each_child_shutdown(struct device *dev)

Confusing name.

What about device_shutdown_subordinate()?

> +{
> +	struct klist_iter i;
> +	struct device *child;
> +	struct device_link *link;
> +
> +	/* already shutdown, then skip this sub tree */
> +	if (dev->shutdown)
> +		return 0;
> +
> +	if (!dev->p)
> +		goto check_consumers;
> +
> +	/* there is breakage of lock in __device_shutdown(), and the redundant
> +	 * ref++ on srcu protected consumer is harmless since shutdown is not
> +	 * hot path.
> +	 */
> +	get_device(dev);
> +
> +	klist_iter_init(&dev->p->klist_children, &i);
> +	while ((child = next_device(&i)))
> +		device_for_each_child_shutdown(child);

Why don't you use device_for_each_child() here?

> +	klist_iter_exit(&i);
> +
> +check_consumers:
> +	list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
> +		if (!link->consumer->shutdown)
> +			device_for_each_child_shutdown(link->consumer);
> +	}
> +
> +	__device_shutdown(dev);
> +	put_device(dev);

Possible reference counter imbalance AFAICS.

> +	return 0;
> +}

Well, instead of doing this dance, we might as well walk dpm_list here as it
is in the right order.

Of course, that would require dpm_list to be available for CONFIG_PM unset,
but it may be a better approach long term.

> +
>  /**
>   * device_shutdown - call ->shutdown() on each device to shutdown.
>   */
>  void device_shutdown(void)
>  {
>  	struct device *dev;
> +	int idx;
>  
> +	idx = device_links_read_lock();
>  	spin_lock(&devices_kset->list_lock);
>  	/*
>  	 * Walk the devices list backward, shutting down each in turn.
> @@ -2866,11 +2903,12 @@ void device_shutdown(void)
>  	 * devices offline, even as the system is shutting down.
>  	 */
>  	while (!list_empty(&devices_kset->list)) {
> -		dev = list_entry(devices_kset->list.prev, struct device,
> +		dev = list_entry(devices_kset->list.next, struct device,
>  				kobj.entry);
> -		__device_shutdown(dev);
> +		device_for_each_child_shutdown(dev);
>  	}
>  	spin_unlock(&devices_kset->list_lock);
> +	device_links_read_unlock(idx);
>  }
>  
>  /*
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 055a69d..8a0f784 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1003,6 +1003,7 @@ struct device {
>  	bool			offline:1;
>  	bool			of_node_reused:1;
>  	bool			dma_32bit_limit:1;
> +	bool			shutdown:1; /* one direction: false->true */
>  };
>  
>  static inline struct device *kobj_to_dev(struct kobject *kobj)
> 

If the device_kset_move_last() in really_probe() is the only problem,
I'd rather try to fix that one in the first place.

Why is it needed?

Thanks,
Rafael
