Return-Path: <B37400@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A5302C008A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 23:00:59 +1000 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: RE: [2/3][PATCH][v2] TDM Framework
Date: Mon, 30 Jul 2012 13:00:32 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E511361@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727145136.GB6802@n2100.arm.linux.org.uk>
In-Reply-To: <20120727145136.GB6802@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for your comments.
Please find my response inline.

Regards,
Sandeep


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]=20
Sent: Friday, July 27, 2012 8:22 PM
To: Singh Sandeep-B37400
Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org; de=
vel@driverdev.osuosl.org; galak@kernel.crashing.org; linux-kernel@vger.kern=
el.org
Subject: Re: [2/3][PATCH][v2] TDM Framework

On Fri, Jul 27, 2012 at 07:35:38PM +0530, sandeep@freescale.com wrote:
> +static DEFINE_MUTEX(tdm_core_lock);
> +static DEFINE_IDR(tdm_adapter_idr);
> +/* List of TDM adapters registered with TDM framework */=20
> +LIST_HEAD(adapter_list);
> +
> +/* List of TDM clients registered with TDM framework */=20
> +LIST_HEAD(driver_list);

These two are far too generic to be public.  Have you checked your code wit=
h sparse?  I think not.
[Sandeep] Will changes the name to be more appropriate. Right, I haven't ch=
ecked with sparse.

> +
> +/*
> + * In case the previous data is not fetched by the client driver, the
> + * de-interleaving function will  discard the old data and rewrite=20
> +the
> + * new data
> + */
> +
> +static int use_latest_tdm_data =3D 1;
> +
> +/* Data structures required for sysfs */ static struct tdm_sysfs attr=20
> +=3D {
> +	.attr.name =3D "use_latest_data",
> +	.attr.mode =3D 0664,
> +	.cmd_type =3D TDM_LATEST_DATA,
> +};
> +
> +static struct attribute *tdm_attr[] =3D {
> +	&attr.attr,
> +	NULL
> +};
> +
> +const struct sysfs_ops tdm_ops =3D {
> +	.show =3D tdm_show_sysfs,
> +	.store =3D tdm_store_sysfs,
> +};

Again, lack of static.
[Sandeep] Ok

> +
> +static struct kobj_type tdm_type =3D {
> +	.sysfs_ops =3D &tdm_ops,
> +	.default_attrs =3D tdm_attr,
> +};
> +
> +/* tries to match client driver with the adapter */ static int=20
> +tdm_device_match(struct tdm_driver *driver, struct tdm_adapter *adap)=20
> +{
> +	/* match on an id table if there is one */
> +	if (driver->id_table && driver->id_table->name[0]) {
> +		if (!(strcmp(driver->id_table->name, adap->name)))
> +			return (int)driver->id_table;

Casting a pointer to 'int' is not a good thing to do.  Please fix this.
[Sandeep] Will fix this.

> +	}
> +	return 0;
> +}
> +
> +static int tdm_attach_driver_adap(struct tdm_driver *driver,
> +		struct tdm_adapter *adap)
> +{
> +	int ret =3D 0;
> +	/* if driver is already attached to any other adapter, return*/
> +	if (driver->adapter && (driver->adapter !=3D adap))

Additional parens not required.
[Sandeep] Ok

> +		return 0;
> +
> +	driver->adapter =3D adap;
> +
> +	if (driver->attach_adapter) {
> +		ret =3D driver->attach_adapter(adap);
> +		if (ret < 0) {
> +			pr_err("tdm: attach_adapter failed for driver [%s]"
> +					"err:%d\n", driver->name, ret);
> +			return ret;
> +		}
> +	}
> +	adap->drv_count++;
> +
> +	if (!adap->tasklet_conf) {
> +		tdm_sysfs_init();
> +		tasklet_init(&adap->tdm_data_tasklet, tdm_data_tasklet_fn,
> +				(unsigned long)adap);

Why not init this tasklet when the struct tdm_adapter is first created?
Why do you need to wait, and then have state tracking for this?
[Sandeep] Ok, will take care

> +		adap->tasklet_conf =3D 1;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Detach client driver and adapter */ static int=20
> +tdm_detach_driver_adap(struct tdm_driver *driver,
> +		struct tdm_adapter *adap)
> +{
> +	int res =3D 0;
> +
> +	if (!driver->adapter || (driver->adapter !=3D adap))

Additional parens not required.
[Sandeep] Ok.

> +		return 0;
> +
> +	adap->drv_count--;
> +
> +	/* If no more driver is registed with the adapter*/
> +	if (!adap->drv_count && adap->tasklet_conf) {
> +		tasklet_disable(&adap->tdm_data_tasklet);
> +		tasklet_kill(&adap->tdm_data_tasklet);
> +		adap->tasklet_conf =3D 0;
> +	}
> +
> +	if (driver->detach_adapter) {
> +		if (driver->detach_adapter(adap))
> +			pr_err("tdm: detach_adapter failed for driver [%s]\n",
> +					driver->name);
> +	}
> +
> +	driver->adapter =3D NULL;
> +	return res;
> +}
> +
> +/* TDM adapter Registration/De-registration with TDM framework */
> +
> +static int tdm_register_adapter(struct tdm_adapter *adap) {
> +	int res =3D 0;
> +	struct tdm_driver *driver, *next;
> +
> +	mutex_init(&adap->adap_lock);
> +	INIT_LIST_HEAD(&adap->myports);
> +	spin_lock_init(&adap->portlist_lock);
> +
> +	adap->drv_count =3D 0;
> +	adap->tasklet_conf =3D 0;
> +
> +	list_add_tail(&adap->list, &adapter_list);

What protects this list?
[Sandeep] Ok, will take care

> +
> +	/* initialization of driver by framework in default configuration */
> +	init_config_adapter(adap);
> +
> +	/* Notify drivers */
> +	pr_info("adapter [%s] registered\n", adap->name);
> +	mutex_lock(&tdm_core_lock);
> +	list_for_each_entry_safe(driver, next, &driver_list, list) {
> +		if (tdm_device_match(driver, adap)) {
> +			res =3D tdm_attach_driver_adap(driver, adap);
> +			if (res =3D=3D 0) {
> +				pr_info("tdm: Driver(ID=3D%d) is "
> +						"attached with Adapter %s(ID"
> +						" =3D %d)\n", driver->id,
> +						adap->name, adap->id);
> +			} else {
> +				pr_err("tdm: Driver(ID=3D%d) is unable "
> +						"to attach with Adapter %s(ID =3D %d)\n",
> +						driver->id, adap->name,
> +						adap->id);
> +			}
> +		}
> +	}
> +	mutex_unlock(&tdm_core_lock);
> +
> +	return res;
> +}
> +
> +/*
> + * tdm_add_adapter - declare tdm adapter, use dynamic device number
> + * @adapter: the adapter to add
> + * Context: can sleep
> + *
> + * This routine is used to declare a TDM adapter
> + * When this returns zero, a new device number will be allocated and=20
> +stored
> + * in adap->id, and the specified adapter became available for the clien=
ts.
> + * Otherwise, a negative error number value is returned.
> + */
> +int tdm_add_adapter(struct tdm_adapter *adapter) {
> +	int id, res =3D 0;
> +
> +retry:
> +	if (idr_pre_get(&tdm_adapter_idr, GFP_KERNEL) =3D=3D 0)
> +		return -ENOMEM;
> +
> +	mutex_lock(&tdm_core_lock);
> +	res =3D idr_get_new(&tdm_adapter_idr, adapter, &id);
> +	mutex_unlock(&tdm_core_lock);
> +
> +	if (res < 0) {
> +		if (res =3D=3D -EAGAIN)
> +			goto retry;
> +		return res;
> +	}
> +
> +	adapter->id =3D id;
> +	return tdm_register_adapter(adapter); }=20
> +EXPORT_SYMBOL(tdm_add_adapter);
> +
> +
> +/*
> + * tdm_del_adapter - unregister TDM adapter
> + * @adap: the adapter being unregistered
> + *
> + * This unregisters an TDM adapter which was previously registered
> + * by @tdm_add_adapter.
> + */
> +int tdm_del_adapter(struct tdm_adapter *adap) {
> +	int res =3D 0;
> +	struct tdm_adapter *found;
> +	struct tdm_driver *driver, *next;
> +
> +	/* First make sure that this adapter was ever added */
> +	mutex_lock(&tdm_core_lock);
> +	found =3D idr_find(&tdm_adapter_idr, adap->id);
> +	mutex_unlock(&tdm_core_lock);
> +	if (found !=3D adap) {
> +		pr_err("tdm: attempting to delete unregistered "
> +				"adapter [%s]\n", adap->name);
> +		return -EINVAL;
> +	}
> +
> +	/* disable and kill the data processing tasklet */
> +	if (adap->tasklet_conf) {
> +		tasklet_disable(&adap->tdm_data_tasklet);
> +		tasklet_kill(&adap->tdm_data_tasklet);
> +		adap->tasklet_conf =3D 0;
> +	}
> +
> +	/*
> +	 * Detach any active ports. This can't fail, thus we do not
> +	 * checking the returned value.
> +	 */
> +	mutex_lock(&tdm_core_lock);
> +	list_for_each_entry_safe(driver, next, &driver_list, list) {
> +		if (tdm_device_match(driver, adap)) {
> +			tdm_detach_driver_adap(driver, adap);
> +			pr_info(
> +					"Driver(ID=3D%d) is detached from Adapter %s(ID =3D %d)\n",
> +					driver->id, adap->name, adap->id);
> +		}
> +	}
> +	idr_remove(&tdm_adapter_idr, adap->id);
> +	mutex_unlock(&tdm_core_lock);
> +
> +	pr_debug("adapter [%s] unregistered\n", adap->name);
> +
> +	list_del(&adap->list);

What protects this delete?
[Sandeep] Ok, will take care

> +	/*
> +	 * Clear the device structure in case this adapter is ever going to be
> +	 * added again
> +	 */
> +	adap->parent =3D NULL;
> +
> +	return res;
> +}
> +EXPORT_SYMBOL(tdm_del_adapter);
> +
> +/* TDM Client Drivers Registration/De-registration Functions */ int=20
> +tdm_register_driver(struct tdm_driver *driver) {
> +	int res =3D 0;
> +	struct tdm_adapter *adap, *next;
> +
> +	list_add_tail(&driver->list, &driver_list);

What serializes this list?
[Sandeep] Ok, will take care

> +
> +	mutex_lock(&tdm_core_lock);
> +	/* Walk the adapters that are already present */
> +	list_for_each_entry_safe(adap, next, &adapter_list, list) {
> +		if (tdm_device_match(driver, adap)) {
> +			res =3D tdm_attach_driver_adap(driver, adap);
> +			if (res =3D=3D 0) {
> +				pr_info("TDM Driver(ID=3D%d)is attached with "
> +						"Adapter%s(ID =3D %d) drv_count=3D%d",
> +						driver->id, adap->name,
> +						adap->id, adap->drv_count);
> +			} else {
> +				pr_err("TDM Driver(ID=3D%d) unable to attach "
> +						"to Adapter%s(ID =3D %d) drv_count=3D%d",
> +						driver->id, adap->name,
> +						adap->id, adap->drv_count);
> +			}
> +			break;
> +		}
> +	}
> +	mutex_unlock(&tdm_core_lock);
> +
> +	return res;
> +}
> +EXPORT_SYMBOL(tdm_register_driver);
> +
> +/*
> + * tdm_unregister_driver - unregister TDM client driver from TDM=20
> +framework
> + * @driver: the driver being unregistered  */ void=20
> +tdm_unregister_driver(struct tdm_driver *driver) {
> +	/*
> +	 * A driver can register to only one adapter,
> +	 * so no need to browse the list
> +	 */
> +	mutex_lock(&tdm_core_lock);
> +	tdm_detach_driver_adap(driver, driver->adapter);
> +	mutex_unlock(&tdm_core_lock);
> +
> +	list_del(&driver->list);

What serializes this delete?
[Sandeep] Ok, will take care

> +
> +	pr_debug("tdm-core: driver [%s] unregistered\n", driver->name); }=20
> +EXPORT_SYMBOL(tdm_unregister_driver);
> +
> +/* Interface to the tdm device/adapter */
> +
> +/*
> + * tdm_adap_send - issue a TDM write
> + * @adap: Handle to TDM device
> + * @buf: Data that will be written to the TDM device
> + * @count: How many bytes to write
> + *
> + * Returns negative errno, or else the number of bytes written.
> + */
> +int tdm_adap_send(struct tdm_adapter *adap, void **buf, int count) {
> +	int res;
> +
> +	if (adap->algo->tdm_write)
> +		res =3D adap->algo->tdm_write(adap, buf, count);
> +	else {
> +		pr_err("TDM level write not supported\n");

Is there no associated struct device which could be used for these error me=
ssages?  What if you have more than one TDM device?  It would be useful to =
know which is producing errors.
[Sandeep] Since this is a framework, we do not have any struct device assoc=
iated. But we should work some way out to produce error messages which can =
be linked with specific adapter.

> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * If everything went ok (i.e. frame transmitted), return #bytes
> +	 * transmitted, else error code.
> +	 */
> +	return (res =3D=3D 1) ? count : res;
> +}
> +EXPORT_SYMBOL(tdm_adap_send);
> +
> +/*
> + * tdm_adap_recv - issue a TDM read
> + * @adap: Handle to TDM device
> + * @buf: Where to store data read from TDM device
> + *
> + * Returns negative errno, or else the number of bytes read.
> + */
> +int tdm_adap_recv(struct tdm_adapter *adap, void **buf) {
> +	int res;
> +
> +	if (adap->algo->tdm_read)
> +		res =3D adap->algo->tdm_read(adap, (u16 **)buf);
> +	else {
> +		pr_err("TDM level read not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +	/*
> +	 * If everything went ok (i.e. frame received), return #bytes
> +	 * transmitted, else error code.
> +	 */
> +	return res;
> +}
> +
> +/*
> + * tdm_adap_get_write_buf - get next write TDM device buffer
> + * @adap: Handle to TDM device
> + * @buf: pointer to TDM device buffer
> + *
> + * Returns negative errno, or else size of the write buffer.
> + */
> +int tdm_adap_get_write_buf(struct tdm_adapter *adap, void **buf) {
> +	int res;
> +
> +	if (adap->algo->tdm_get_write_buf) {
> +		res =3D adap->algo->tdm_get_write_buf(adap, (u16 **)buf);
> +	} else {
> +		pr_err("TDM level write buf get not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +	/*
> +	 * If everything went ok (i.e. 1 msg received), return #bytes
> +	 * transmitted, else error code.
> +	 */
> +	return res;
> +}
> +EXPORT_SYMBOL(tdm_adap_get_write_buf);
> +
> +int tdm_adap_enable(struct tdm_driver *drv) {
> +	int res;
> +	struct tdm_adapter *adap;
> +	adap =3D drv->adapter;

The above two lines can become one line.
[Sandeep] Sure.=20

> +
> +	if (adap->algo->tdm_enable) {
> +		res =3D adap->algo->tdm_enable(adap);
> +	} else {
> +		pr_err("TDM level enable not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +	return res;
> +}
> +EXPORT_SYMBOL(tdm_adap_enable);
> +
> +int tdm_adap_disable(struct tdm_driver *drv) {
> +	int res;
> +	struct tdm_adapter *adap;
> +	adap =3D drv->adapter;

Ditto.
[Sandeep] Ok.

> +
> +	if (adap->algo->tdm_disable) {
> +		res =3D adap->algo->tdm_disable(adap);
> +	} else {
> +		pr_err("TDM level enable not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +	return res;
> +}
> +EXPORT_SYMBOL(tdm_adap_disable);
> +
> +struct tdm_adapter *tdm_get_adapter(int id) {
> +	struct tdm_adapter *adapter;
> +
> +	mutex_lock(&tdm_core_lock);
> +	adapter =3D idr_find(&tdm_adapter_idr, id);
> +	if (adapter && !try_module_get(adapter->owner))
> +		adapter =3D NULL;
> +
> +	mutex_unlock(&tdm_core_lock);
> +
> +	return adapter;
> +}
> +EXPORT_SYMBOL(tdm_get_adapter);
> +
> +void tdm_put_adapter(struct tdm_adapter *adap) {
> +	module_put(adap->owner);
> +}
> +EXPORT_SYMBOL(tdm_put_adapter);
> +
> +
> +/* Port Level APIs of TDM Framework */ int tdm_port_open(struct=20
> +tdm_driver *driver, struct tdm_port **h_port) {
> +	struct tdm_port *port;
> +	struct tdm_adapter *adap;
> +	unsigned long flags;
> +	int res =3D 0;
> +
> +	/*
> +	 * This creates an anonymous tdm_port, which may later be
> +	 * pointed to some slot.
> +	 */
> +	port =3D kzalloc(sizeof(*port), GFP_KERNEL);
> +	if (!port) {
> +		res =3D -ENOMEM;
> +		return res;
> +	}
> +
> +	adap =3D tdm_get_adapter(driver->adapter->id);
> +	if (!adap)
> +		return -ENODEV;
> +
> +	port->rx_max_frames =3D NUM_SAMPLES_PER_FRAME;
> +	port->port_cfg.port_mode =3D TDM_PORT_CHANNELIZED;
> +
> +	snprintf(driver->name, TDM_NAME_SIZE, "tdm-dev");
> +	port->driver =3D driver;
> +	port->adapter =3D adap;
> +
> +	spin_lock_irqsave(&adap->portlist_lock, flags);
> +	list_add_tail(&port->list, &adap->myports);
> +	spin_unlock_irqrestore(&adap->portlist_lock, flags);
> +
> +	INIT_LIST_HEAD(&port->mychannels);
> +
> +	*h_port =3D port;
> +	return res;
> +
> +}
> +EXPORT_SYMBOL(tdm_port_open);
> +
> +int tdm_port_close(struct tdm_port *h_port) {
> +	struct tdm_adapter *adap;
> +	struct tdm_driver *driver;
> +	struct tdm_port *port;
> +	struct tdm_channel *temp, *channel;
> +	unsigned long flags;
> +	int res =3D 0;
> +	port =3D h_port;
> +
> +	driver =3D  port->driver;
> +
> +	list_for_each_entry_safe(channel, temp, &port->mychannels, list) {
> +		if (channel)
> +			if (channel->in_use) {

if (channel && channel->in_use) {

> +				pr_err("tdm: Cannot close port. Channel in"
> +						"use\n");

Don't wrap error messages.
[Sandeep] How to handle them, it exceeds 80 character limit.

> +				res =3D -ENXIO;
> +				goto out;
> +			}
> +	}
> +	adap =3D driver->adapter;
> +	tdm_put_adapter(adap);
> +
> +	spin_lock_irqsave(&adap->portlist_lock, flags);
> +	list_del(&port->list);
> +	spin_unlock_irqrestore(&adap->portlist_lock, flags);
> +
> +	if (port->p_port_data !=3D NULL) {
> +		int i;
> +		struct tdm_bd *ch_bd;
> +
> +		/*
> +		 * If the tdm is in channelised mode,
> +		 * de-allocate the channelised buffer
> +		 */
> +		ch_bd =3D &(port->p_port_data->rx_data_fifo[0]);
> +		for (i =3D 0; ch_bd && i < TDM_CH_RX_BD_RING_SIZE; i++) {
> +			ch_bd->flag =3D 0;
> +			ch_bd++;
> +		}
> +		ch_bd =3D &(port->p_port_data->tx_data_fifo[0]);
> +		for (i =3D 0; ch_bd && i < TDM_CH_TX_BD_RING_SIZE; i++) {
> +			ch_bd->flag =3D 0;
> +			ch_bd++;
> +		}
> +		kfree(port->p_port_data);
> +	}
> +	kfree(port);
> +	return res;
> +out:
> +	if (port)
> +		kfree(port->p_port_data);
> +	kfree(port);
> +	return res;
> +}
> +EXPORT_SYMBOL(tdm_port_close);
> +
> +int tdm_channel_read(struct tdm_port *h_port, struct tdm_channel *h_chan=
nel,
> +		void *p_data, u16 *size)
> +{
> +	struct tdm_channel *channel;
> +	struct tdm_bd *rx_bd;
> +	unsigned long flags;
> +	int res =3D 0;
> +	unsigned short *buf, *buf1;
> +	channel =3D h_channel;
> +
> +	if (!channel->p_ch_data || !channel->in_use)
> +		return -EIO;
> +
> +	spin_lock_irqsave(&channel->p_ch_data->rx_channel_lock, flags);
> +	rx_bd =3D channel->p_ch_data->rx_out_data;
> +
> +	if (rx_bd->flag) {
> +		*size =3D rx_bd->length;
> +		buf =3D (u16 *) p_data;
> +		buf1 =3D (u16 *)rx_bd->p_data;
> +		memcpy(buf1, buf, NUM_SAMPLES_PER_FRAME);
> +		rx_bd->flag =3D 0;
> +		rx_bd->offset =3D 0;
> +		channel->p_ch_data->rx_out_data =3D (rx_bd->wrap) ?
> +			channel->p_ch_data->rx_data_fifo : rx_bd + 1;
> +
> +	} else {
> +		spin_unlock_irqrestore(&channel->p_ch_data->rx_channel_lock,
> +				flags);
> +		pr_debug("No Data Available");
> +		return -EAGAIN;
> +	}
> +	spin_unlock_irqrestore(&channel->p_ch_data->rx_channel_lock, flags);
> +
> +	return res;
> +}
> +EXPORT_SYMBOL(tdm_channel_read);
> +
> +
> +int tdm_channel_write(struct tdm_port *h_port, struct tdm_channel *h_cha=
nnel,
> +		void *p_data, u16 size)
> +{
> +	struct tdm_port *port;
> +	struct tdm_channel *channel;
> +	struct tdm_bd *tx_bd;
> +	unsigned long flags;
> +	int err =3D 0;
> +	port =3D h_port;
> +	channel =3D h_channel;
> +#ifdef DEBUG
> +	bool data_flag =3D 0;
> +#endif
> +
> +	if (p_data =3D=3D NULL) { /* invalid data*/
> +		pr_err("tdm: Invalid Data");
> +		return -EINVAL;
> +	}
> +
> +	if (!channel->p_ch_data || !channel->in_use)
> +		return -EIO;
> +
> +	spin_lock_irqsave(&channel->p_ch_data->tx_channel_lock, flags);
> +	tx_bd =3D channel->p_ch_data->tx_in_data;
> +
> +	if (!tx_bd->flag) {
> +		tx_bd->length =3D size;
> +		memcpy(tx_bd->p_data, p_data,
> +				size * port->adapter->adapt_cfg.slot_width);
> +		tx_bd->flag =3D 1;
> +		tx_bd->offset =3D 0;
> +		channel->p_ch_data->tx_in_data =3D (tx_bd->wrap) ?
> +			channel->p_ch_data->tx_data_fifo : tx_bd+1;
> +		port->port_stat.tx_pkt_count++;
> +#ifdef DEBUG
> +		data_flag =3D 1;
> +#endif
> +	} else {
> +		spin_unlock_irqrestore(&channel->p_ch_data->tx_channel_lock,
> +				flags);
> +		port->port_stat.tx_pkt_drop_count++;
> +		pr_err("tdm: Transmit failed.");
> +		return -ENOMEM;
> +	}
> +	spin_unlock_irqrestore(&channel->p_ch_data->tx_channel_lock, flags);
> +
> +#ifdef	DEBUG
> +	if (data_flag) {
> +		int k;
> +		pr_info("\nTX port:%d - Write - Port TX-%d\n",
> +				port->port_id, size);
> +		for (k =3D 0; k < size; k++)
> +			pr_info("%x", p_data[k]);
> +		pr_info("\n");
> +	}
> +#endif
> +	return err;
> +}
> +EXPORT_SYMBOL(tdm_channel_write);
> +
> +/*
> + * Driver Function for select and poll. Based on Channel, it sleeps=20
> +on
> + * waitqueue
> + */
> +int tdm_ch_poll(struct tdm_channel *h_channel, unsigned int=20
> +wait_time) {
> +	struct tdm_channel *channel;
> +	channel =3D h_channel;
> +
> +	if (!channel->p_ch_data || !channel->in_use)
> +		return -EIO;
> +
> +	if (channel->p_ch_data->rx_out_data->flag) {
> +		pr_debug("Data Available");
> +		return 0;
> +	}
> +	if (wait_time) {
> +		unsigned long timeout =3D msecs_to_jiffies(wait_time);
> +
> +		wait_event_interruptible_timeout(channel->ch_wait_queue,
> +				channel->p_ch_data->rx_out_data->flag,
> +				timeout);
> +
> +		if (channel->p_ch_data->rx_out_data->flag) {
> +			pr_debug("Data Available");
> +			return 0;
> +		}
> +	}
> +	return -EAGAIN;

That is incorrect.  -EAGAIN is the wrong return code when
wait_event_interruptible_timeout() returns -ERESTARTSYS.
[Sandeep] Ok

> +}
> +EXPORT_SYMBOL(tdm_ch_poll);
> +
> +unsigned int tdm_port_get_stats(struct tdm_port *h_port,
> +		struct tdm_port_stats *portstat)
> +{
> +	struct tdm_port *port;
> +	int port_num;
> +	port =3D h_port;
> +
> +	if (port =3D=3D NULL || portstat =3D=3D NULL) { /* invalid handle */
> +		pr_err("tdm: Invalid Handle");
> +		return -ENXIO;
> +	}
> +	port_num =3D  port->port_id;
> +
> +	memcpy(portstat, &port->port_stat, sizeof(struct tdm_port_stats));
> +
> +	pr_info("TDM Port %d Get Stats", port_num);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tdm_port_get_stats);
> +
> +/* Data handling functions */
> +
> +static int tdm_data_rx_deinterleave(struct tdm_adapter *adap) {
> +	struct tdm_port *port, *next;
> +	struct tdm_channel *channel, *temp;
> +	struct tdm_bd	*ch_bd;
> +
> +	int i, buf_size, ch_data_len;
> +	u16 *input_tdm_buffer;
> +	u16 *pcm_buffer;
> +	int slot_width;
> +	int frame_ch_data_size;
> +	bool ch_data;
> +	int bytes_in_fifo_per_frame;
> +	int bytes_slot_offset;
> +
> +	ch_data_len =3D NUM_SAMPLES_PER_FRAME;
> +	frame_ch_data_size =3D NUM_SAMPLES_PER_FRAME;
> +	ch_data =3D 0;
> +
> +	slot_width =3D adap->adapt_cfg.slot_width;
> +	buf_size =3D tdm_adap_recv(adap, (void **)&input_tdm_buffer);
> +	if (buf_size <=3D 0 || !input_tdm_buffer)
> +		return -EINVAL;
> +
> +	bytes_in_fifo_per_frame =3D buf_size/frame_ch_data_size;

Spaces around /
[Sandeep] Ok.

> +	bytes_slot_offset =3D bytes_in_fifo_per_frame/slot_width;

Spaces around /
[Sandeep] Ok.

> +
> +	/* de-interleaving for all ports*/
> +	list_for_each_entry_safe(port, next, &adap->myports, list) {
> +
> +		list_for_each_entry_safe(channel, temp, &port->mychannels,
> +				list) {

Why do you need the _safe variants here?  I can't see anything in this code=
 which manipulates the lists.
[Sandeep] Will check.

> +			/* if the channel is not open */
> +			if (!channel->in_use || !channel->p_ch_data)
> +				continue;
> +			ch_bd =3D channel->p_ch_data->rx_in_data;
> +			spin_lock(&channel->p_ch_data->rx_channel_lock);
> +			/*if old data is to be discarded */
> +			if (use_latest_tdm_data && ch_bd->flag) {
> +				ch_bd->flag =3D 0;
> +				ch_bd->offset =3D 0;
> +				if (ch_bd =3D=3D channel->p_ch_data->rx_out_data)
> +					channel->p_ch_data->rx_out_data =3D
> +						ch_bd->wrap ?
> +						channel->p_ch_data->rx_data_fifo
> +						: ch_bd+1;
> +				port->port_stat.rx_pkt_drop_count++;
> +			}
> +			/* if the bd is empty */
> +			if (!ch_bd->flag) {
> +				if (ch_bd->offset =3D=3D 0)
> +					ch_bd->length =3D port->rx_max_frames;
> +
> +				pcm_buffer =3D ch_bd->p_data + ch_bd->offset;
> +				/* De-interleaving the data */
> +				for (i =3D 0; i < ch_data_len; i++) {
> +					pcm_buffer[i]
> +						=3D input_tdm_buffer[i*
> +						bytes_slot_offset +
> +						channel->ch_id];
> +				}
> +				ch_bd->offset +=3D ch_data_len * slot_width;
> +
> +				if (ch_bd->offset >=3D
> +						(ch_bd->length -
> +						frame_ch_data_size)*
> +						(adap->adapt_cfg.slot_width)) {
> +					ch_bd->flag =3D 1;
> +					ch_bd->offset =3D 0;
> +					channel->p_ch_data->rx_in_data =3D
> +						ch_bd->wrap ?
> +						channel->p_ch_data->rx_data_fifo
> +						: ch_bd+1;
> +					ch_data =3D 1;
> +					wake_up_interruptible
> +						(&channel->ch_wait_queue);
> +				}
> +			} else {
> +				port->port_stat.rx_pkt_drop_count++;
> +			}
> +			spin_unlock(&channel->p_ch_data->rx_channel_lock);
> +		}
> +
> +		if (ch_data) {
> +			/* Wake up the Port Data Poll event */
> +#ifdef	DEBUG
> +			pr_info("Port RX-%d-%d\n", channel->ch_id, ch_data_len);
> +			for (i =3D 0; i < ch_data_len; i++)
> +				pr_info("%x", pcm_buffer[i]);
> +			pr_info("\n");
> +#endif
> +			port->port_stat.rx_pkt_count++;
> +			ch_data =3D 0;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int tdm_data_tx_interleave(struct tdm_adapter *adap) {
> +	struct tdm_port *port, *next;
> +	struct tdm_channel *channel, *temp;
> +	struct tdm_bd	*ch_bd;
> +	int i, buf_size, ch_data_len =3D NUM_SAMPLES_PER_FRAME;
> +	bool last_data =3D 0;
> +	u16 *output_tdm_buffer;
> +	u16 *pcm_buffer;
> +	int frame_ch_data_size =3D NUM_SAMPLES_PER_FRAME;
> +	int bytes_in_fifo_per_frame;
> +	int bytes_slot_offset;
> +
> +#ifdef DEBUG
> +	u8	data_flag =3D 0;
> +#endif
> +
> +	buf_size =3D tdm_adap_get_write_buf(adap, (void **)&output_tdm_buffer);
> +	if (buf_size <=3D 0 || !output_tdm_buffer)
> +		return -EINVAL;
> +
> +	bytes_in_fifo_per_frame =3D buf_size/frame_ch_data_size;
> +	bytes_slot_offset =3D=20
> +bytes_in_fifo_per_frame/adap->adapt_cfg.slot_width;
> +
> +
> +	memset(output_tdm_buffer, 0, sizeof(buf_size));
> +
> +	list_for_each_entry_safe(port, next, &adap->myports, list) {
> +
> +		list_for_each_entry_safe(channel, temp, &port->mychannels,
> +				list) {

Why do you need the _safe variants here?  I can't see anything in this code=
 which manipulates the lists.
[Sandeep] Will check.

> +			pr_debug("TX-Tdm %d (slots-)", channel->ch_id);
> +
> +
> +			/* if the channel is open */
> +			if (!channel->in_use || !channel->p_ch_data)
> +				continue;
> +
> +			spin_lock(&channel->p_ch_data->tx_channel_lock);
> +			if (!channel->in_use || !channel->p_ch_data)
> +				continue;
> +			ch_bd =3D channel->p_ch_data->tx_out_data;
> +			if (ch_bd->flag) {
> +				pcm_buffer =3D (u16 *)((uint8_t *)ch_bd->p_data +
> +						ch_bd->offset);
> +				/* if the buffer has less frames than required*/

Space before */
[Sandeep] Ok

> +				if (frame_ch_data_size >=3D
> +						(ch_bd->length - ch_bd->offset/

Space before /
[Sandeep] Ok

> +						 adap->adapt_cfg.slot_width)) {
> +					ch_data_len =3D
> +						ch_bd->length - ch_bd->offset/

Space before /
[Sandeep] Ok

> +						adap->adapt_cfg.slot_width;

Wrong indentation.  If you're finding the 80 column limit is causing proble=
ms, you have too much code in this function (read Documentation/CodingStyle=
 again).
[Sandeep] Ok.

> +					last_data =3D 1;
> +				} else {
> +					ch_data_len =3D frame_ch_data_size;
> +				}
> +				/* Interleaving the data */
> +				for (i =3D 0; i < ch_data_len; i++) {
> +					/*
> +					 * TODO- need to be genric for any size
> +					 *  assignment
> +					 */
> +					output_tdm_buffer[channel->ch_id +
> +						bytes_slot_offset * i] =3D
> +						pcm_buffer[i];
> +				}
> +				/*
> +				 * If all the data of this buffer is
> +				 * transmitted
> +				 */
> +				if (last_data) {
> +					ch_bd->flag =3D 0;
> +					ch_bd->offset =3D 0;
> +					channel->p_ch_data->tx_out_data =3D
> +						ch_bd->wrap ?
> +						channel->p_ch_data->tx_data_fifo
> +						: ch_bd+1;

Spaces around +
[Sandeep] Ok

> +					port->port_stat.tx_pkt_conf_count++;
> +				} else {
> +					ch_bd->offset +=3D ch_data_len *
> +						(adap->adapt_cfg.slot_width);
> +				}
> +#ifdef	DEBUG
> +				data_flag =3D 1;
> +#endif
> +			}
> +			spin_unlock(&channel->p_ch_data->tx_channel_lock);
> +		}
> +	}
> +
> +#ifdef	DEBUG
> +	if (data_flag) {
> +		pr_info("TX-TDM Interleaved Data-\n");
> +		for (i =3D 0; i < 64; i++)
> +			pr_info("%x", output_tdm_buffer[i]);
> +		pr_info("\n");
> +	}
> +#endif
> +	return 0;
> +}
> +
> +/* Channel Level APIs of TDM Framework */ int tdm_channel_open(u16=20
> +chanid, u16 ch_width, struct tdm_port *port,
> +		struct tdm_channel **h_channel)
> +{
> +	struct tdm_channel *channel, *temp;
> +	unsigned long		flags;
> +	struct tdm_ch_data	*p_ch_data;
> +	int res =3D 0;
> +
> +	if (ch_width !=3D 1) {
> +		pr_err("tdm: Mode not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry_safe(channel, temp, &port->mychannels, list) {
> +		if (channel->ch_id =3D=3D chanid) {
> +			pr_err("tdm: Channel %d already open\n", chanid);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
> +	if (!channel) {
> +		res =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	init_waitqueue_head(&channel->ch_wait_queue);
> +	p_ch_data =3D kzalloc(sizeof(struct tdm_ch_data), GFP_KERNEL);
> +	if (!p_ch_data) {
> +		res =3D -ENOMEM;
> +		goto outdata;
> +	}
> +
> +	p_ch_data->rx_data_fifo[TDM_CH_RX_BD_RING_SIZE-1].wrap =3D 1;
> +	p_ch_data->tx_data_fifo[TDM_CH_TX_BD_RING_SIZE-1].wrap =3D 1;
> +
> +	p_ch_data->rx_in_data =3D p_ch_data->rx_data_fifo;
> +	p_ch_data->rx_out_data =3D p_ch_data->rx_data_fifo;
> +	p_ch_data->tx_in_data =3D p_ch_data->tx_data_fifo;
> +	p_ch_data->tx_out_data =3D p_ch_data->tx_data_fifo;
> +	spin_lock_init(&p_ch_data->rx_channel_lock);
> +	spin_lock_init(&p_ch_data->tx_channel_lock);
> +
> +	channel->p_ch_data =3D p_ch_data;
> +
> +	channel->ch_id =3D chanid;
> +	channel->ch_cfg.first_slot =3D chanid;
> +	channel->ch_cfg.num_slots =3D 1;	/*
> +					 * This is 1 for channelized mode and
> +					 * configurable for other modes
> +					 */
> +	channel->port =3D port;
> +	channel->in_use =3D 1;
> +
> +	spin_lock_irqsave(&port->ch_list_lock, flags);
> +	list_add_tail(&channel->list, &port->mychannels);
> +	spin_unlock_irqrestore(&port->ch_list_lock, flags);
> +
> +	*h_channel =3D channel;
> +
> +	return res;
> +
> +outdata:
> +	kfree(channel);
> +out:
> +	return res;
> +}
> +EXPORT_SYMBOL(tdm_channel_open);
> +
> +int tdm_sysfs_init(void)

static?
[Sandeep] Ok.

> +{
> +	struct kobject *tdm_kobj;
> +	int err =3D 1;
> +	tdm_kobj =3D kzalloc(sizeof(*tdm_kobj), GFP_KERNEL);
> +	if (tdm_kobj) {
> +		kobject_init(tdm_kobj, &tdm_type);
> +		if (kobject_add(tdm_kobj, NULL, "%s", "tdm")) {
> +			pr_err("tdm: Sysfs creation failed\n");
> +			kobject_put(tdm_kobj);
> +			err =3D -EINVAL;
> +			goto out;
> +		}
> +	} else {
> +		pr_err("tdm: Unable to allocate tdm_kobj\n");
> +		err =3D -ENOMEM;
> +		goto out;
> +	}

What if this function gets called multiple times?  It looks like
kobject_add() will fail due to name conflicts.

Also, what's the point of the above?  I looks like the kobject is never use=
d.
[Sandeep] Will check.

> +
> +out:
> +	return err;
> +}
> +
> +int tdm_channel_close(u16 chanid, u16 ch_width, struct tdm_port *port,
> +		struct tdm_channel *h_channel)
> +{
> +	struct tdm_channel *channel;
> +	unsigned long		flags;
> +	int res =3D 0;
> +	channel =3D h_channel;
> +
> +	spin_lock_irqsave(&port->ch_list_lock, flags);
> +	list_del(&channel->list);
> +	spin_unlock_irqrestore(&port->ch_list_lock, flags);
> +
> +	if (channel)
> +		kfree(channel->p_ch_data);
> +	kfree(channel);
> +	return res;
> +}
> +EXPORT_SYMBOL(tdm_channel_close);
> +
> +ssize_t tdm_show_sysfs(struct kobject *kobj,
> +		struct attribute *attr, char *buf)
> +{
> +	int retval =3D 0;
> +	struct tdm_sysfs *a =3D container_of(attr,
> +			struct tdm_sysfs, attr);
> +	switch (a->cmd_type) {
> +	case TDM_LATEST_DATA:
> +		pr_info("use_latest_tdm_data: %d\n", use_latest_tdm_data);
> +		break;
> +	default:
> +		pr_info("Invalid cmd_type value\n");
> +		return -EINVAL;
> +	}
> +	return retval;
> +}
> +
> +ssize_t tdm_store_sysfs(struct kobject *kobj,
> +		struct attribute *attr, const char *buf, size_t len) {
> +	struct tdm_sysfs *a =3D container_of(attr,
> +			struct tdm_sysfs, attr);
> +
> +	sscanf(buf, "%d", &a->data);
> +	use_latest_tdm_data =3D a->data;
> +	return strlen(buf);
> +}
> +
> +void init_config_adapter(struct tdm_adapter *adap) {
> +	struct fsl_tdm_adapt_cfg default_adapt_cfg =3D {
> +		.loopback =3D TDM_PROCESS_NORMAL,
> +		.num_ch =3D NUM_CHANNELS,
> +		.ch_size_type =3D CHANNEL_16BIT_LIN,
> +		.frame_len =3D NUM_SAMPLES_PER_FRAME,
> +		.num_frames =3D NUM_SAMPLES_PER_FRAME,
> +		.adap_mode =3D TDM_ADAPTER_MODE_NONE
> +	};
> +
> +	default_adapt_cfg.slot_width =3D default_adapt_cfg.ch_size_type/3 + 1;

Spaces around /
[Sandeep] Ok

> +
> +	memcpy(&adap->adapt_cfg, &default_adapt_cfg,
> +			sizeof(struct fsl_tdm_adapt_cfg));

If this is supposed to be a generic layer, why the fsl_ data in core code?
[Sandeep] It's because framework initializes adapter in a default configura=
tion and then passes it to the adapter.

> +
> +	return;
> +}
> +EXPORT_SYMBOL(init_config_adapter);
> +
> +void tdm_data_tasklet_fn(unsigned long data)

static?
[Sandeep] Ok

> +{
> +	struct tdm_adapter *adapter;
> +	adapter =3D (struct tdm_adapter *)data;
> +	if (adapter !=3D NULL) {
> +		tdm_data_tx_interleave(adapter);
> +		tdm_data_rx_deinterleave(adapter);
> +	}
> +}

A general comment: it is better to place functions before their first use w=
here possible.
[Sandeep] Alright.

> +
> +
> +MODULE_AUTHOR("Hemant Agrawal <hemant@freescale.com> and "
> +	"Rajesh Gumasta <rajesh.gumasta@freescale.com>");=20
> +MODULE_DESCRIPTION("TDM Driver Framework Core");=20
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mod_devicetable.h=20
> b/include/linux/mod_devicetable.h index 83ac071..573ac40 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -425,6 +425,17 @@ struct i2c_device_id {
>  			__attribute__((aligned(sizeof(kernel_ulong_t))));
>  };
> =20
> +/* tdm */
> +
> +#define TDM_NAME_SIZE   20
> +#define TDM_MODULE_PREFIX "tdm:"
> +
> +struct tdm_device_id {
> +	char name[TDM_NAME_SIZE];
> +	kernel_ulong_t driver_data      /* Data private to the driver */
> +			__attribute__((aligned(sizeof(kernel_ulong_t))));
> +};
> +
>  /* spi */
> =20
>  #define SPI_NAME_SIZE	32
> diff --git a/include/linux/tdm.h b/include/linux/tdm.h new file mode=20
> 100644 index 0000000..44cd8cf
> --- /dev/null
> +++ b/include/linux/tdm.h
> @@ -0,0 +1,389 @@
> +/* include/linux/tdm.h
> + *
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> + * tdm.h - definitions for the tdm-device framework interface
> + *
> + * Author:Hemant Agrawal <hemant@freescale.com>
> + *	Rajesh Gumasta <rajesh.gumasta@freescale.com>
> + *
> + * This program is free software; you can redistribute  it and/or=20
> +modify it
> + * under  the terms of  the GNU General  Public License as published=20
> +by the
> + * Free Software Foundation;  either version 2 of the  License, or=20
> +(at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,=20
> +but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the  GNU General Public License=20
> +along
> + * with this program; if not, write  to the Free Software Foundation,=20
> +Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +
> +#ifndef _LINUX_TDM_H
> +#define _LINUX_TDM_H
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/device.h>	/* for struct device */
> +#include <linux/sched.h>	/* for completion */
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/sysfs.h>
> +
> +#define TDM_LATEST_DATA		1
> +#define CHANNEL_8BIT_LIN	0	/* 8 bit linear */
> +#define CHANNEL_8BIT_ULAW	1	/* 8 bit Mu-law */
> +#define CHANNEL_8BIT_ALAW	2	/* 8 bit A-law */
> +#define CHANNEL_16BIT_LIN	3	/* 16 bit Linear */
> +
> +/*
> + * Default adapter configuration. All the TDM adapters registered=20
> +with
> + * framework will be configured with following default configuration.
> + */
> +#define NUM_CHANNELS	16
> +
> +/*
> + * Default configuration for typical voice data sample. These=20
> +parameters
> + * will generally not be required to be changed for voice type applicati=
ons.
> + */
> +
> +/* 8 samples per milli sec per channel. Req for voice data */
> +#define NUM_SAMPLES_PER_MS	8
> +#define NUM_MS			10
> +
> +/* Number of samples for 1 client buffer */
> +#define NUM_SAMPLES_PER_FRAME	(NUM_MS * NUM_SAMPLES_PER_MS)
> +#define NUM_OF_TDM_BUF		3
> +
> +/* General options */
> +
> +struct tdm_adapt_algorithm;
> +struct tdm_adapter;
> +struct tdm_port;
> +
> +
> +/*
> + * struct tdm_driver - represent an TDM device driver
> + * @class: What kind of tdm device we instantiate (for detect)
> + * @id:Driver id
> + * @name: Name of the driver
> + * @attach_adapter: Callback for device addition (for legacy drivers)
> + * @detach_adapter: Callback for device removal (for legacy drivers)
> + * @probe: Callback for device binding
> + * @remove: Callback for device unbinding
> + * @shutdown: Callback for device shutdown
> + * @suspend: Callback for device suspend
> + * @resume: Callback for device resume
> + * @command: Callback for sending commands to device
> + * @id_table: List of TDM devices supported by this driver
> + * @list: List of drivers created (for tdm-core use only)  */ struct=20
> +tdm_driver {
> +	unsigned int class;
> +	unsigned int id;
> +	char name[TDM_NAME_SIZE];
> +
> +	int (*attach_adapter)(struct tdm_adapter *);
> +	int (*detach_adapter)(struct tdm_adapter *);
> +
> +	/* Standard driver model interfaces */
> +	int (*probe)(const struct tdm_device_id *);
> +	int (*remove)(void);
> +
> +	/* driver model interfaces that don't relate to enumeration */
> +	void (*shutdown)(void);
> +	int (*suspend)(pm_message_t mesg);
> +	int (*resume)(void);

Far better to use the dev_pm_ops stuff now, don't propagate the old PM inte=
rfaces.
[Sandeep] Ok.

> +
> +	const struct tdm_device_id *id_table;
> +
> +	/* The associated adapter for this driver */
> +	struct tdm_adapter *adapter;
> +	struct list_head list;
> +};
> +
> +/*
> + * tdm per port statistics structure, used for providing and storing=20
> +tdm port
> + * statistics.
> + */
> +struct tdm_port_stats {
> +	unsigned int rx_pkt_count;	/* Rx frame count per channel */
> +	unsigned int rx_pkt_drop_count;	/*
> +					 * Rx drop count per channel to
> +					 * clean space for new buffer
> +					 */
> +	unsigned int tx_pkt_count;	/* Tx frame count per channel */
> +	unsigned int tx_pkt_conf_count;	/*
> +					 * Tx frame confirmation count per
> +					 * channel
> +					 */
> +	unsigned int tx_pkt_drop_count;	/*
> +					 * Tx drop count per channel due to
> +					 * queue full
> +					 */
> +};
> +
> +
> +/*
> + * tdm Buffer Descriptor, used for Creating Interleaved and=20
> +De-interleaved
> + * FIFOs
> + */
> +struct tdm_bd {
> +	unsigned char flag;		/* BD is full or empty */
> +	unsigned char wrap;		/* BD is last in the queue */
> +	unsigned short length;		/* Length of data in BD */
> +	/*TODO: use dyanmic memory */
> +	unsigned short p_data[NUM_SAMPLES_PER_FRAME];	/* Data Pointer */
> +	unsigned long offset;	/* Offset of the Data Pointer to be used */
> +};
> +
> +#define TDM_CH_RX_BD_RING_SIZE	3
> +#define TDM_CH_TX_BD_RING_SIZE	3
> +
> +/* tdm RX-TX Channelised Data */
> +struct tdm_port_data {
> +	struct tdm_bd rx_data_fifo[TDM_CH_RX_BD_RING_SIZE]; /*
> +							     * Rx Channel Data
> +							     * BD Ring
> +							     */
> +	struct tdm_bd *rx_in_data;	/*
> +					 * Current Channel Rx BD to be filled by
> +					 * de-interleave function
> +					 */
> +	struct tdm_bd *rx_out_data;	/*
> +					 * Current Channel Rx BD to be
> +					 * read by App
> +					 */
> +	struct tdm_bd tx_data_fifo[TDM_CH_TX_BD_RING_SIZE]; /*
> +							     * Tx Channel Data
> +							     *	BD Ring
> +							     */
> +	struct tdm_bd *tx_in_data;	/*
> +					 * Current Channel Tx BD to be
> +					 * filled by App
> +					 */
> +	struct tdm_bd *tx_out_data;	/*
> +					 * Current Channel Tx BD to be read by
> +					 * interleave function
> +					 */
> +	spinlock_t rx_channel_lock;	/* Spin Lock for Rx Channel */
> +	spinlock_t tx_channel_lock;	/* Spin Lock for Tx Channel */
> +};
> +
> +/* structure tdm_port_cfg - contains configuration params for a port=20
> +*/ struct tdm_port_cfg {
> +	unsigned short port_mode;
> +};
> +
> +/* struct tdm_port - represent an TDM ports for a device */ struct=20
> +tdm_port {
> +	unsigned short port_id;
> +	unsigned short in_use;	/* Port is enabled? */
> +	uint16_t rx_max_frames;	/*
> +				 * Received port frames before allowing
> +				 * read operation in Port Mode
> +				 */
> +
> +	struct tdm_port_stats port_stat; /*
> +					  * A structure parameter defining
> +					  * TDM port statistics.
> +					  */
> +	struct tdm_port_data *p_port_data;	/*
> +						 * a structure parameter
> +						 * defining tdm channelised data
> +						 */
> +
> +	struct tdm_driver *driver;	/* driver for this port */
> +	struct tdm_adapter *adapter;	/* adapter for this port */
> +	struct list_head list;		/* list of ports */
> +	struct list_head mychannels;	/* list of channels, on this port*/
> +	spinlock_t ch_list_lock;	/* Spin Lock for channel_list */
> +	struct tdm_port_cfg port_cfg;	/*
> +					 * A structure parameter defining
> +					 * TDM port configuration.
> +					 */
> +};
> +
> +/* tdm RX-TX Channelised Data */
> +struct tdm_ch_data {
> +	struct tdm_bd rx_data_fifo[TDM_CH_RX_BD_RING_SIZE]; /*
> +							     * Rx Port Data BD
> +							     * Ring
> +							     */
> +	struct tdm_bd *rx_in_data;	/*
> +					 * Current Port Rx BD to be filled by
> +					 * de-interleave function
> +					 */
> +	struct tdm_bd *rx_out_data; /* Current Port Rx BD to be read by App */
> +	struct tdm_bd tx_data_fifo[TDM_CH_TX_BD_RING_SIZE]; /*
> +							     * Tx Port Data BD
> +							     * Ring
> +							     */
> +	struct tdm_bd *tx_in_data;	/*
> +					 * Current Port Tx BD to be filled by
> +					 * App
> +					 */
> +	struct tdm_bd *tx_out_data;	/*
> +					 * Current Port Tx BD to be read by
> +					 * interleave function
> +					 */
> +	spinlock_t rx_channel_lock;	/* Spin Lock for Rx Port */
> +	spinlock_t tx_channel_lock;	/* Spin Lock for Tx Port */
> +};
> +
> +/* Channel config params */
> +struct tdm_ch_cfg {
> +	unsigned short num_slots;
> +	unsigned short first_slot;
> +};
> +
> +/* struct tdm_channel- represent a TDM channel for a port */ struct=20
> +tdm_channel {
> +	u16 ch_id;			/* logical channel number */
> +	struct list_head list;		/* list of channels in a port*/
> +	struct tdm_port *port;		/* port for this channel */
> +	u8 in_use;			/* channel is enabled? */
> +	struct tdm_ch_cfg ch_cfg;	/* channel configuration */
> +	struct tdm_ch_data *p_ch_data;	/* data storage space for channel */
> +	wait_queue_head_t ch_wait_queue;/* waitQueue for RX Channel Data */=20
> +};
> +
> +/* tdm_adapt_algorithm is for accessing the routines of device */=20
> +struct tdm_adapt_algorithm {
> +	int (*tdm_read)(struct tdm_adapter *, u16 **);
> +	int (*tdm_get_write_buf)(struct tdm_adapter *, u16 **);
> +	int (*tdm_write)(struct tdm_adapter *, void *, unsigned int len);
> +	int (*tdm_enable)(struct tdm_adapter *);
> +	int (*tdm_disable)(struct tdm_adapter *); };
> +
> +/* tdm_adapter_mode is to define in mode of the device */ enum=20
> +tdm_adapter_mode {
> +	TDM_ADAPTER_MODE_NONE =3D 0x00,
> +	TDM_ADAPTER_MODE_T1 =3D 0x01,
> +	TDM_ADAPTER_MODE_E1 =3D 0x02,
> +	TDM_ADAPTER_MODE_T1_RAW =3D 0x10,
> +	TDM_ADAPTER_MODE_E1_RAW =3D 0x20,
> +};
> +
> +/* tdm_port_mode defines the mode in which the port is configured to=20
> +operate
> + * It can be channelized/full/fractional.
> + */
> +enum tdm_port_mode {
> +	TDM_PORT_CHANNELIZED =3D 0,	/* Channelized mode */
> +	TDM_PORT_FULL =3D 1,		/* Full mode */
> +	TDM_PORT_FRACTIONAL =3D 2		/* Fractional mode */
> +};
> +
> +/* tdm_process_mode used for testing the tdm device in normal mode or=20
> +internal
> + * loopback or external loopback
> + */
> +enum tdm_process_mode {
> +	TDM_PROCESS_NORMAL =3D 0,		/* Normal mode */
> +	TDM_PROCESS_INT_LPB =3D 1,	/* Internal loop mode */
> +	TDM_PROCESS_EXT_LPB =3D 2		/* External Loopback mode */
> +};
> +
> +/* TDM configuration parameters */
> +struct fsl_tdm_adapt_cfg {
> +	u8 num_ch;		/* Number of channels in this adpater */
> +	u8 ch_size_type;	/*
> +				 * reciever/transmit channel
> +				 * size for all channels
> +				 */
> +	u8 slot_width;		/* 1 or 2 Is defined by channel type */
> +	u8 frame_len;		/* Length of frame in samples */
> +	u32 num_frames;
> +	u8 loopback;		/* loopback or normal */
> +	u8 adap_mode;		/*
> +				 * 0=3DNone, 1=3D T1, 2=3D T1-FULL, 3=3DE1,
> +				 * 4 =3D E1-FULL
> +				 */
> +	int max_timeslots;	/*
> +				 * Max Number of timeslots that are
> +				 * supported on this adapter
> +				 */
> +};
> +
> +/*
> + * tdm_adapter is the structure used to identify a physical tdm=20
> +device along
> + * with the access algorithms necessary to access it.
> + */
> +struct tdm_adapter {
> +	struct module *owner;	/* owner of the adapter module */
> +	unsigned int id;	/* Adapter Id */
> +	unsigned int drv_count;	/*
> +				 * Number of drivers associated with the
> +				 * adapter
> +				 */
> +	const struct tdm_adapt_algorithm *algo;	/*
> +						 * algorithm to access the
> +						 * adapter
> +						 */
> +
> +	char name[TDM_NAME_SIZE];	/* Name of Adapter */
> +	struct mutex adap_lock;
> +	struct device *parent;
> +
> +	struct tasklet_struct tdm_data_tasklet;	/*
> +						 * tasklet handle to perform
> +						 * data processing
> +						 */
> +	int tasklet_conf;	/* flag for tasklet configuration */
> +	int tdm_rx_flag;
> +
> +	struct list_head myports;	/*
> +					 * list of ports, created on this
> +					 * adapter
> +					 */
> +	struct list_head list;
> +	spinlock_t portlist_lock;
> +	void *data;
> +	struct fsl_tdm_adapt_cfg adapt_cfg;
> +};
> +
> +struct tdm_sysfs {
> +	struct attribute attr;
> +	int data;
> +	u32 cmd_type;
> +};
> +
> +/* functions exported by tdm.o */
> +
> +int tdm_add_adapter(struct tdm_adapter *adpater); int=20
> +tdm_del_adapter(struct tdm_adapter *adapter); int=20
> +tdm_register_driver(struct tdm_driver *driver); void=20
> +tdm_unregister_driver(struct tdm_driver *driver); void=20
> +init_config_adapter(struct tdm_adapter *adapter);
> +
> +int tdm_port_open(struct tdm_driver *driver, struct tdm_port=20
> +**h_port); int tdm_port_close(struct tdm_port *h_port); int=20
> +tdm_channel_read(struct tdm_port *h_port, struct tdm_channel *h_channel,
> +		void *p_data, u16 *size);
> +int tdm_channel_write(struct tdm_port *h_port, struct tdm_channel *h_cha=
nnel,
> +		void *p_data, u16 size);
> +int tdm_ch_poll(struct tdm_channel *h_channel, unsigned int=20
> +wait_time);
> +
> +int tdm_channel_open(u16 chanid, u16 ch_width, struct tdm_port *port,
> +		struct tdm_channel **h_channel);
> +int tdm_channel_close(u16 chanid, u16 ch_width, struct tdm_port *port,
> +		struct tdm_channel *h_channel);
> +/* this tasklet is created for each adapter instance */ void=20
> +tdm_data_tasklet_fn(unsigned long); int tdm_sysfs_init(void); ssize_t=20
> +tdm_show_sysfs(struct kobject *kobj,
> +		struct attribute *attr, char *buf); ssize_t tdm_store_sysfs(struct=20
> +kobject *kobj,
> +		struct attribute *attr, const char *buf, size_t len);
> +
> +struct tdm_adapter *tdm_get_adapter(int id); void=20
> +tdm_put_adapter(struct tdm_adapter *adap);
> +
> +#endif /* __KERNEL__ */
> +
> +#define TDM_E_OK 0
> --
> 1.5.6.5
>=20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
