Return-Path: <B10812@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22311B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2012 12:08:29 +1000 (EST)
Received: from mail39-am1 (localhost [127.0.0.1])	by mail39-am1-R.bigfish.com
 (Postfix) with ESMTP id 360D7E0072	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 27 Apr 2012 02:08:22 +0000 (UTC)
Received: from AM1EHSMHS016.bigfish.com (unknown [10.3.201.243])	by
 mail39-am1.bigfish.com (Postfix) with ESMTP id 20D13400045	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2012 02:08:20 +0000 (UTC)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH][2/3][RFC] TDM Framework
Date: Fri, 27 Apr 2012 02:07:59 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D0C49A7@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1331384221-29661-1-git-send-email-poonam.aggrwal@freescale.com>
 <4F95F523.50400@freescale.com>
In-Reply-To: <4F95F523.50400@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, April 24, 2012 6:05 AM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev@lists.ozlabs.org; Singh Sandeep-B37400
> Subject: Re: [PATCH][2/3][RFC] TDM Framework
>=20
Thanks Scott for the comments, we will incorporate them and send the next v=
ersion.

Regards
Poonam
> On 03/10/2012 06:57 AM, Poonam Aggrwal wrote:
> > diff --git a/drivers/Kconfig b/drivers/Kconfig index ad6c1eb..25f7f5b
> > 100644
> > --- a/drivers/Kconfig
> > +++ b/drivers/Kconfig
> > @@ -130,4 +130,5 @@ source "drivers/virt/Kconfig"
> >
> >  source "drivers/net/dpa/NetCommSw/Kconfig"
> >
> > +source "drivers/tdm/Kconfig"
> >  endmenu
>=20
> When posting patches to this list, please ensure that they are based on
> an upstream Linux kernel and not a Freescale BSP kernel.
Sure, but this was RFC patch set where the primary intention was to get des=
ign level comments.
But we will send the updated patches rebased on upstream head.
>=20
> > +if TDM
> > +
> > +config TDM_DEBUG_CORE
> > +	bool "TDM Core debugging messages"
> > +	help
> > +	  Say Y here if you want the TDM core to produce a bunch of debug
> > +	  messages to the system log.  Select this if you are having a
> > +	  problem with TDM support and want to see more of what is going
> on.
> > +
> > +endif # TDM
>=20
> Please use the normal kernel mechanisms for controlling debug messages.
>=20
okay
> > diff --git a/drivers/tdm/tdm-core.c b/drivers/tdm/tdm-core.c new file
> > mode 100644 index 0000000..cdda260
> > --- /dev/null
> > +++ b/drivers/tdm/tdm-core.c
> > @@ -0,0 +1,1146 @@
> > +/* driver/tdm/tdm-core.c
> > + *
> > + * Copyright (C) 2012 Freescale Semiconductor, Inc, All rights
> reserved.
> > + *
> > + * TDM core is the interface between TDM clients and TDM devices.
> > + * It is also intended to serve as an interface for line controld
> > + * devices later on.
> > + *
> > + * Author:Hemant Agrawal <hemant@freescale.com>
> > + *	Rajesh Gumasta <rajesh.gumasta@freescale.com>
> > + *
> > + * Modified by Sandeep Kr Singh <sandeep@freescale.com>
> > + *		Poonam Aggarwal <poonam.aggarwal@freescale.com>
> > + * 1. Added framework based initialization of device.
> > + * 2. All the init/run time configuration is now done by framework.
> > + * 3. Added channel level operations.
> > + *
> > + * This program is free software; you can redistribute  it and/or
> > +modify it
> > + * under  the terms of  the GNU General  Public License as published
> > +by the
> > + * Free Software Foundation;  either version 2 of the  License, or
> > +(at your
> > + * option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > +but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the  GNU General Public License
> > +along
> > + * with this program; if not, write  to the Free Software Foundation,
> > +Inc.,
> > + * 675 Mass Ave, Cambridge, MA 02139, USA.
> > + */
> > +
> > +/* if read write debug required */
> > +#undef TDM_CORE_DEBUG
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/slab.h>
> > +#include <linux/tdm.h>
> > +#include <linux/init.h>
> > +#include <linux/idr.h>
> > +#include <linux/mutex.h>
> > +#include <linux/completion.h>
> > +#include <linux/hardirq.h>
> > +#include <linux/irqflags.h>
> > +#include <linux/list.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/io.h>
> > +#include "device/tdm_fsl.h"
>=20
> What is a reference to tdm_fsl.h doing in the presumably hardware-
> independent tdm-core.c?
Need to check that, ideally this include should not be required
>=20
> > +static DEFINE_MUTEX(tdm_core_lock);
> > +static DEFINE_IDR(tdm_adapter_idr);
> > +/* List of TDM adapters registered with TDM framework */
> > +LIST_HEAD(adapter_list);
> > +
> > +/* List of TDM clients registered with TDM framework */
> > +LIST_HEAD(driver_list);
> > +
> > +/* In case the previous data is not fetched by the client driver, the
> > + * de-interleaving function will  discard the old data and rewrite
> > +the
> > + * new data */
> > +static int use_latest_tdm_data =3D 1;
>=20
> Describe when one would want to change this, and provide a better way to
> change it (e.g. module parameter or sysfs knob).
>=20
Ok, description can be added.
Will also explore the sysfs knob option.                                   =
                                                                           =
                                                                           =
 =20
> /*
>  * Linux kernel
>  * multi-line comment style
>  * is like this.
>  */
>=20
Sure
> > +/* this tasklet is created for each adapter instance */ static void
> > +tdm_data_tasklet_fn(unsigned long);
> > +
> > +/* tries to match client driver with the adapter */ static int
> > +tdm_device_match(struct tdm_driver *driver, struct tdm_adapter *adap)
> > +{
> > +	/* match on an id table if there is one */
> > +	if (driver->id_table && driver->id_table->name[0]) {
> > +		if (!(strcmp(driver->id_table->name, adap->name)))
> > +			return (int)driver->id_table;
> > +	}
> > +	return TDM_E_OK;
> > +}
>=20
> s/TDM_E_OK/0/g
>=20
ok
> > +static int tdm_attach_driver_adap(struct tdm_driver *driver,
> > +					struct tdm_adapter *adap)
> > +{
> > +	/* if driver is already attached to any other adapter, return*/
> > +	if (driver->adapter && (driver->adapter !=3D adap))
> > +		return TDM_E_OK;
>=20
> Why can't one driver service multiple adapters?  How would multiple
> drivers service one adapter?  Are there sub-devices that need individual
> controlling?
>=20
Driver is here client driver which would be using=20
> > +	driver->adapter =3D adap;
> > +
> > +	if (driver->attach_adapter) {
> > +		if (driver->attach_adapter(adap) < 0)
> > +			/* We ignore the return code; if it fails, too bad */
> > +			pr_err("attach_adapter failed for driver [%s]\n",
> > +				driver->name);
>=20
> Why ignore errors?
This will be fixed.

>=20
> > +/* Detach client driver and adapter */ static int
> > +tdm_detach_driver_adap(struct tdm_driver *driver,
> > +					struct tdm_adapter *adap)
> > +{
> > +	int res =3D TDM_E_OK;
> > +
> > +	if (!driver->adapter || (driver->adapter !=3D adap))
> > +		return TDM_E_OK;
>=20
> Shouldn't this be an error?
Will check this.

>=20
> > +	if (!driver->detach_adapter)
> > +		return TDM_E_OK;
> > +
> > +	adap->drv_count--;
>=20
> If the driver doesn't have a detach_adapter method, you skip decrementing
> the count and leave the tasklet lying around?
>=20
This has been fixed in later version of the patch which we made for FSL BSP=
.
Will fix this here also.
> > +/* TDM adapter Registration/De-registration with TDM framework */
> > +
> > +static int tdm_register_adapter(struct tdm_adapter *adap) {
> > +	int res =3D TDM_E_OK;
> > +	struct tdm_driver *driver, *next;
> > +
> > +	if (!adap) {
> > +		pr_err("%s:Invalid handle\n", __func__);
> > +		return -EINVAL;
> > +	}
>=20
> Pointers aren't handles.  The caller should not be passing NULL, and it
> would be more useful to crash and get a backtrace if it does.  It's not
> realistic to check every pointer for being NULL when there's no
> legitimate reason it could be NULL, and it doesn't help you if you have
> some other bad value besides NULL.
Okay, we will check this.
>=20
> > +	mutex_init(&adap->adap_lock);
> > +	INIT_LIST_HEAD(&adap->myports);
> > +	spin_lock_init(&adap->portlist_lock);
> > +
> > +	adap->drv_count =3D 0;
> > +	adap->tasklet_conf =3D 0;
> > +
> > +	list_add_tail(&adap->list, &adapter_list);
> > +
> > +	/* initialization of driver by framework in default configuration
> */
> > +	init_config_adapter(adap);
> > +
> > +	/* Notify drivers */
> > +	pr_info("adapter [%s] registered\n", adap->name);
>=20
> This is too noisy.  You haven't even gotten a match yet.
>=20
It is telling that these adapters have registered to the framework.
> > +/*
> > + * tdm_add_adapter - declare tdm adapter, use dynamic device number
>=20
> Why are there device numbers at all?
>=20
> I suspect there's a fair bit of copy and paste going on of another
> subsystem's quirks (i2c?).  I don't see any mention in the copyright
> block of this code having been derived from anything else, though...
>=20
When we initially started, we took i2c as an example. But later not much co=
uld be used as-is.
But yes some initial stuff is from i2c. Will update it in copyright section=
.
> > +
> > +
> > +/**
> > + * tdm_del_adapter - unregister TDM adapter
> > + * @adap: the adapter being unregistered
> > + *
> > + * This unregisters an TDM adapter which was previously registered
> > + * by @tdm_add_adapter.
> > + */
> > +int tdm_del_adapter(struct tdm_adapter *adap) {
> > +	int res =3D TDM_E_OK;
> > +	struct tdm_adapter *found;
> > +	struct tdm_driver *driver, *next;
> > +
> > +	if (!adap) {
> > +		pr_err("%s:Invalid handle\n", __func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* First make sure that this adapter was ever added */
> > +	mutex_lock(&tdm_core_lock);
> > +	found =3D idr_find(&tdm_adapter_idr, adap->id);
> > +	mutex_unlock(&tdm_core_lock);
> > +	if (found !=3D adap) {
> > +		pr_err("tdm-core: attempting to delete unregistered "
> > +			 "adapter [%s]\n", adap->name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*disable and kill the data processing tasklet */
> > +	if (adap->tasklet_conf) {
> > +		tasklet_disable(&adap->tdm_data_tasklet);
> > +		tasklet_kill(&adap->tdm_data_tasklet);
> > +		adap->tasklet_conf =3D 0;
> > +	}
> > +
> > +	/* Detach any active ports. This can't fail, thus we do not
> > +	   checking the returned value. */
> > +	mutex_lock(&tdm_core_lock);
> > +	list_for_each_entry_safe(driver, next, &driver_list, list) {
> > +		if (tdm_device_match(driver, adap)) {
> > +			tdm_detach_driver_adap(driver, adap);
> > +			pr_info(
> > +			"Driver(ID=3D%d) is detached from Adapter %s(ID =3D %d)\n",
> > +				 driver->id, adap->name, adap->id);
> > +		}
> > +	}
> > +	mutex_unlock(&tdm_core_lock);
> > +
> > +	mutex_lock(&tdm_core_lock);
> > +	idr_remove(&tdm_adapter_idr, adap->id);
> > +	mutex_unlock(&tdm_core_lock);
>=20
> Why are you dropping the lock then reacquiring it?
>=20
Mistake, will fix it.
> > +/* TDM Client Drivers Registration/De-registration Functions */ int
> > +tdm_register_driver(struct tdm_driver *driver) {
> > +	int res =3D TDM_E_OK;
> > +	struct tdm_adapter *adap, *next;
> > +
> > +	list_add_tail(&driver->list, &driver_list);
> > +
> > +	mutex_lock(&tdm_core_lock);
> > +	/* Walk the adapters that are already present */
> > +	list_for_each_entry_safe(adap, next, &adapter_list, list) {
> > +		if (tdm_device_match(driver, adap)) {
> > +			res =3D tdm_attach_driver_adap(driver, adap);
> > +			pr_info("TDM Driver(ID=3D%d)is attached with Adapter"
> > +				"%s(ID =3D %d) drv_count=3D%d", driver->id,
> > +				adap->name, adap->id, adap->drv_count);
> > +		break;
> > +		}
> > +	}
>=20
> Indentation.
>=20
> > +	mutex_unlock(&tdm_core_lock);
> > +
> > +	return res;
> > +}
> > +EXPORT_SYMBOL(tdm_register_driver);
> > +
> > +/*
> > + * tdm_unregister_driver - unregister TDM client driver from TDM
> > +framework
> > + * @driver: the driver being unregistered  */ void
> > +tdm_unregister_driver(struct tdm_driver *driver) {
> > +	if (!driver) {
> > +		pr_err("%s:Invalid handle\n", __func__);
> > +		return;
> > +	}
> > +       /* A driver can register to only one adapter,
> > +	* so no need to browse the list */
>=20
> Whitespace.
>=20
> > +	mutex_lock(&tdm_core_lock);
> > +	tdm_detach_driver_adap(driver, driver->adapter);
> > +	mutex_unlock(&tdm_core_lock);
> > +
> > +	list_del(&driver->list);
> > +
> > +	pr_debug("tdm-core: driver [%s] unregistered\n", driver->name); }
> > +EXPORT_SYMBOL(tdm_unregister_driver);
> > +
> > +/* TDM Framework init and exit */
> > +static int __init tdm_init(void)
> > +{
> > +	pr_info("%s\n", __func__);
> > +	return TDM_E_OK;
> > +}
> > +
> > +static void __exit tdm_exit(void)
> > +{
> > +	pr_info("%s\n", __func__);
> > +	return;
> > +}
>=20
> Don't spam the console just because the driver got loaded or unloaded (at
> this point you haven't even found the hardware).
>=20
Ok

> > +/* We must initialize early, because some subsystems register tdm
> > +drivers
> > + * in subsys_initcall() code, but are linked (and initialized) before
> tdm.
> > + */
> > +postcore_initcall(tdm_init);
> > +module_exit(tdm_exit);
>=20
> tdm_init doesn't do anything, so why does it need to run early?
>=20
> > +/* Port Level APIs of TDM Framework */ unsigned int
> > +tdm_port_open(struct tdm_driver *driver, void **h_port)
>=20
> Why is the return unsigned int?  You're returning negative numbers.
>=20
> Also consider having the return be a pointer, and use PTR_ERR/ERR_PTR --
> or at least put a proper type on h_port (what is the "h_"?).
>=20
> > +{
> > +	struct tdm_port *port;
> > +	struct tdm_adapter *adap;
> > +	unsigned long		flags;
> > +	int res =3D TDM_E_OK;
> > +
> > +	if (driver =3D=3D NULL) {
> > +		pr_err("driver NULL\n");
> > +		return -ENODEV;
> > +	}
> > +	if (driver->adapter =3D=3D NULL) {
> > +		pr_err("adapter NULL\n");
> > +		return -ENODEV;
> > +	}
>=20
> Either make these pr_debug (or remove them), or make the message more
> specific.
>=20
> > +	adap =3D tdm_get_adapter(driver->adapter->id);
> > +	if (!adap)
> > +		return -ENODEV;
> > +
> > +	/* This creates an anonymous tdm_port, which may later be
> > +	 * pointed to some slot.
> > +	 *
> > +	 */
> > +	port =3D kzalloc(sizeof(*port), GFP_KERNEL);
> > +	if (!port) {
> > +		res =3D -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	init_waitqueue_head(&port->ch_wait_queue);
> > +
> > +
> > +	port->rx_max_frames =3D NUM_SAMPLES_PER_FRAME;
> > +	port->port_cfg.port_mode =3D e_TDM_PORT_CHANNELIZED;
> > +
> > +	port->in_use =3D 1;
>=20
> When would a port have in_use be false, other than this brief window
> where nothing else should be looking at it?
>=20
> > +	list_for_each_entry_safe(channel, temp, &port->mychannels, list) {
> > +	if (channel)
> > +		if (channel->in_use) {
> > +			pr_err("%s: Cannot close port. Channel in use\n",
> > +								__func__);
> > +			res =3D -ENXIO;
> > +			goto out;
> > +			}
> > +	}
>=20
> Broken indentation.
>=20
> > +unsigned int tdm_channel_read(void *h_port, void *h_channel,
> > +				void *p_data, u16 *size)
> > +{
> > +	struct tdm_port *port;
> > +	struct tdm_channel *channel;
> > +	struct tdm_bd *rx_bd;
> > +	unsigned long flags;
> > +	int i, res =3D TDM_E_OK;
> > +	unsigned short *buf, *buf1;
> > +	port =3D (struct tdm_port *)h_port;
> > +	channel =3D (struct tdm_channel *)h_channel;
>=20
> Unnecessary casts.
>=20
> > +	if ((port && channel) =3D=3D 0) { /* invalid handle*/
>=20
> This is an odd construct -- how about "if (!port || !channel)"?
>=20
> > +		pr_err("%s:Invalid Handle\n", __func__);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (!port->in_use)
> > +		return -EIO;
> > +	if (!channel->p_ch_data || !channel->in_use)
> > +		return -EIO;
> > +
> > +	spin_lock_irqsave(&channel->p_ch_data->rx_channel_lock, flags);
>=20
> Shouldn't you test whether it's in use after you get the lock?
>=20
> > +	rx_bd =3D channel->p_ch_data->rx_out_data;
> > +
> > +	if (rx_bd->flag) {
> > +		*size =3D rx_bd->length;
> > +		buf =3D (u16 *) p_data;
> > +		buf1 =3D (u16 *)rx_bd->p_data;
> > +		for (i =3D 0; i < NUM_SAMPLES_PER_FRAME; i++)
> > +			buf[i] =3D buf1[i];
> > +		rx_bd->flag =3D 0;
> > +		rx_bd->offset =3D 0;
> > +		channel->p_ch_data->rx_out_data =3D (rx_bd->wrap) ?
> > +				channel->p_ch_data->rx_data_fifo : rx_bd + 1;
> > +
> > +	} else {
> > +		spin_unlock_irqrestore(&channel->p_ch_data->rx_channel_lock,
> > +						flags);
> > +		pr_info("No Data Available");
> > +		return -EAGAIN;
> > +	}
>=20
> That pr_info() is inappropriate.  This driver appears to be overly chatty
> in general (and with quite vague messages) -- or is this debug stuff that
> will be removed in a non-RFC patch?
>=20
> > +unsigned int tdm_port_get_stats(void *h_port, struct tdm_port_stats
> > +*portStat) {
> > +	struct tdm_port *port;
> > +	int port_num;
> > +	port =3D (struct tdm_port *)h_port;
> > +
> > +	if (port =3D=3D NULL || portStat =3D=3D NULL) { /* invalid handle*/
> > +		pr_err("Invalid Handle");
> > +		return -ENXIO;
> > +	}
> > +	port_num =3D  port->port_id;
> > +
> > +	memcpy(portStat, &port->port_stat, sizeof(struct tdm_port_stats));
> > +
> > +	pr_info("TDM Port %d Get Stats", port_num);
> > +
> > +	return TDM_E_OK;
> > +}
> > +EXPORT_SYMBOL(tdm_port_get_stats);
> > +
> > +/* Data handling functions */
> > +
> > +static int tdm_data_rx_deinterleave(struct tdm_adapter *adap) {
> > +	struct tdm_port *port, *next;
> > +	struct tdm_channel *channel, *temp;
> > +	struct tdm_bd	*ch_bd;
> > +
> > +	int i, buf_size, ch_data_len;
> > +	u16 *input_tdm_buffer;
> > +	u16 *pcm_buffer;
> > +	int slot_width;
> > +	int frame_ch_data_size;
> > +	bool ch_data;
> > +	int bytes_in_fifo_per_frame;
> > +	int bytes_slot_offset;
> > +
> > +	ch_data_len =3D NUM_SAMPLES_PER_FRAME;
> > +	frame_ch_data_size =3D NUM_SAMPLES_PER_FRAME;
> > +	ch_data =3D 0;
> > +
> > +	if (!adap) { /* invalid handle*/
> > +		pr_err("%s: Invalid Handle\n", __func__);
> > +		return -ENXIO;
> > +	}
> > +
> > +	slot_width =3D adap->adapt_cfg.slot_width;
> > +	buf_size =3D tdm_adap_recv(adap, (void **)&input_tdm_buffer);
> > +	if (buf_size <=3D 0 || !input_tdm_buffer)
> > +		return -EINVAL;
> > +
> > +	bytes_in_fifo_per_frame =3D buf_size/frame_ch_data_size;
> > +	bytes_slot_offset =3D bytes_in_fifo_per_frame/slot_width;
> > +
> > +	/* de-interleaving for all ports*/
> > +	list_for_each_entry_safe(port, next, &adap->myports, list) {
> > +
> > +		/* if the port is not open */
> > +		if (!port->in_use)
> > +			continue;
> > +
> > +		list_for_each_entry_safe(channel, temp, &port->mychannels,
> > +							list) {
> > +		/* if the channel is not open */
> > +		if (!channel->in_use || !channel->p_ch_data)
> > +			continue;
> > +		ch_bd =3D channel->p_ch_data->rx_in_data;
> > +		spin_lock(&channel->p_ch_data->rx_channel_lock);
> > +			/*if old data is to be discarded */
> > +		if (use_latest_tdm_data)
> > +			if (ch_bd->flag) {
> > +				ch_bd->flag =3D 0;
> > +				ch_bd->offset =3D 0;
> > +				if (ch_bd =3D=3D channel->p_ch_data->rx_out_data)
> > +					channel->p_ch_data->rx_out_data =3D
> > +						ch_bd->wrap ?
> > +						channel->p_ch_data->rx_data_fifo
> > +						: ch_bd+1;
> > +					port->port_stat.rx_pkt_drop_count++;
> > +				}
> > +			/* if the bd is empty */
> > +			if (!ch_bd->flag) {
> > +				if (ch_bd->offset =3D=3D 0)
> > +					ch_bd->length =3D port->rx_max_frames;
> > +
> > +				pcm_buffer =3D ch_bd->p_data + ch_bd->offset;
> > +				/* De-interleaving the data */
> > +				for (i =3D 0; i < ch_data_len; i++) {
> > +					pcm_buffer[i]
> > +					=3D input_tdm_buffer[i*bytes_slot_offset +
> > +						channel->ch_id];
> > +				}
> > +				ch_bd->offset +=3D ch_data_len * slot_width;
> > +
> > +				if (ch_bd->offset >=3D
> > +					(ch_bd->length - frame_ch_data_size)*
> > +						(adap->adapt_cfg.slot_width)) {
> > +					ch_bd->flag =3D 1;
> > +					ch_bd->offset =3D 0;
> > +					channel->p_ch_data->rx_in_data =3D
> > +						ch_bd->wrap ?
> > +						channel->p_ch_data->rx_data_fifo
> > +						: ch_bd+1;
> > +					ch_data =3D 1;
> > +				}
> > +			} else {
> > +				port->port_stat.rx_pkt_drop_count++;
> > +			}
> > +		spin_unlock(&channel->p_ch_data->rx_channel_lock);
> > +		}
>=20
> Broken indentation.  Spaces around operators.
>=20
> > +int tdm_channel_close(u16 chanid, u16 ch_width, struct tdm_port *port,
> > +				struct tdm_channel *h_channel)
> > +{
> > +	struct tdm_channel *channel;
> > +	unsigned long		flags;
> > +	int res =3D TDM_E_OK;
> > +	channel =3D h_channel;
> > +
> > +	if (!(port && channel)) {
> > +		pr_err("%s: Invalid handle\n", __func__);
> > +		res =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (ch_width !=3D 1) {
> > +		pr_err("%s: Mode not supported\n", __func__);
> > +		res =3D -EINVAL;
> > +		goto out;
> > +	}
>=20
> close() seems an odd time to be checking for supported channel width,
> especially since you don't use that variable anywhere else in this
> function.
>=20
> > +#ifndef _LINUX_TDM_H
> > +#define _LINUX_TDM_H
> > +
> > +#ifdef __KERNEL__
>=20
> Is this supposed to be a userspace header ever?  If TDM exposes a
> userspace interface, it needs to be documented.
>=20
> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/device.h>	/* for struct device */
> > +#include <linux/sched.h>	/* for completion */
> > +#include <linux/mutex.h>
> > +#include <linux/interrupt.h>
> > +
> > +#define CHANNEL_8BIT_LIN	0	/* 8 bit linear */
> > +#define CHANNEL_8BIT_ULAW	1	/* 8 bit Mu-law */
> > +#define CHANNEL_8BIT_ALAW	2	/* 8 bit A-law */
> > +#define CHANNEL_16BIT_LIN	3	/* 16 bit Linear */
> > +
> > +#define NUM_CHANNELS		16
> > +#define NUM_SAMPLES_PER_MS	8		/* 8 samples per milli sec per
> > +						 channel. Req for voice data */
> > +#define NUM_MS			10
> > +#define NUM_SAMPLES_PER_FRAME	(NUM_MS * NUM_SAMPLES_PER_MS) /*
> Number of
> > +						samples for 1 client buffer */
> > +#define NUM_OF_TDM_BUF		3
>=20
> These need proper namespacing -- plus, should all of these really be
> hardcoded like this?  Is this standard stuff that will always be the
> same?
>=20
> > +/* General options */
> > +
> > +struct tdm_adapt_algorithm;
> > +struct tdm_adapter;
> > +struct tdm_port;
> > +struct tdm_driver;
> > +
> > +/* Align addr on a size boundary - adjust address up if needed */
> > +/* returns min value greater than size which is multiple of alignment
> > +*/ static inline int ALIGN_SIZE(u64 size, u32 alignment) {
> > +	return (size + alignment - 1) & (~(alignment - 1)); }
>=20
> Use the already existing ALIGN().
>=20
> > +/**
> > + * struct tdm_driver - represent an TDM device driver
> > + * @class: What kind of tdm device we instantiate (for detect)
> > + * @id:Driver id
> > + * @name: Name of the driver
> > + * @attach_adapter: Callback for device addition (for legacy drivers)
> > + * @detach_adapter: Callback for device removal (for legacy drivers)
> > + * @probe: Callback for device binding
> > + * @remove: Callback for device unbinding
> > + * @shutdown: Callback for device shutdown
> > + * @suspend: Callback for device suspend
> > + * @resume: Callback for device resume
> > + * @command: Callback for sending commands to device
> > + * @id_table: List of TDM devices supported by this driver
> > + * @list: List of drivers created (for tdm-core use only)  */ struct
> > +tdm_driver {
> > +	unsigned int class;
> > +	unsigned int id;
> > +	char name[TDM_NAME_SIZE];
> > +
> > +	int (*attach_adapter)(struct tdm_adapter *);
> > +	int (*detach_adapter)(struct tdm_adapter *);
> > +
> > +	/* Standard driver model interfaces */
> > +	int (*probe)(const struct tdm_device_id *);
> > +	int (*remove)(void);
> > +
> > +	/* driver model interfaces that don't relate to enumeration */
> > +	void (*shutdown)(void);
> > +	int (*suspend)(pm_message_t mesg);
> > +	int (*resume)(void);
> > +
> > +	/* a ioctl like command that can be used to perform specific
> functions
> > +	 * with the device.
> > +	 */
> > +	int (*command)(unsigned int cmd, void *arg);
>=20
> Please describe what semantics you expect for the non-standard functions.
>=20
> Where are the "ioctl like commands" defined?  When would they be used?
> I don't see it used in this patchset.
>=20
> > +/* struct tdm_channel- represent a TDM channel for a port */ struct
> > +tdm_channel {
> > +	u16 ch_id;			/* logical channel number */
> > +	struct list_head list;		/* list of channels in a port*/
> > +	struct tdm_port *port;		/* port for this channel */
> > +	u16 in_use;			/* channel is enabled? */
> > +	struct tdm_ch_cfg ch_cfg;	/* channel configuration */
> > +	struct tdm_ch_data *p_ch_data;	/* data storage space for
> channel */
> > +};
>=20
> Why are ch_id and especially in_use u16?
>=20
> > +/* tdm_adapt_algorithm is for accessing the routines of device */
> > +struct tdm_adapt_algorithm {
> > +	u32 (*tdm_read)(struct tdm_adapter *, u16 **);
> > +	u32 (*tdm_get_write_buf)(struct tdm_adapter *, u16 **);
> > +	u32 (*tdm_write)(struct tdm_adapter *, void * , unsigned int len);
> > +	int (*tdm_enable)(struct tdm_adapter *);
> > +	int (*tdm_disable)(struct tdm_adapter *); };
> >
>=20
> Provide parameter names and document the semantics you're expecting.
>=20
> > +/* tdm_adapter_mode is to define in mode of the device */ enum
> > +tdm_adapter_mode {
> > +	e_TDM_ADAPTER_MODE_NONE =3D 0x00,
> > +	e_TDM_ADAPTER_MODE_T1 =3D 0x01,
> > +	e_TDM_ADAPTER_MODE_E1 =3D 0x02,
> > +	e_TDM_ADAPTER_MODE_T1_RAW =3D 0x10,
> > +	e_TDM_ADAPTER_MODE_E1_RAW =3D 0x20,
> > +};
> > +
> > +/* tdm_port_mode defines the mode in which the port is configured to
> > +operate
> > + * It can be channelized/full/fractional.
> > + */
> > +enum tdm_port_mode {
> > +	e_TDM_PORT_CHANNELIZED =3D 0	/* Channelized mode */
> > +	, e_TDM_PORT_FULL =3D 1		/* Full mode */
> > +	, e_TDM_PORT_FRACTIONAL =3D 2	/* Fractional mode */
> > +};
> > +
> > +/* tdm_process_mode used for testing the tdm device in normal mode or
> > +internal
> > + * loopback or external loopback
> > + */
> > +enum tdm_process_mode {
> > +	e_TDM_PROCESS_NORMAL =3D 0	/* Normal mode */
> > +	, e_TDM_PROCESS_INT_LPB =3D 1	/* Internal loop mode */
> > +	, e_TDM_PROCESS_EXT_LPB =3D 2	/* External Loopback mode */
> > +};
>=20
> Commas go at the end of lines, not the beginning.
>=20
> No hungarian notation -- drop the "e_".
>=20
> > +/* TDM configuration parameters */
> > +struct fsl_tdm_adapt_cfg {
> > +	u8 num_ch;		/* Number of channels in this adpater */
> > +	u8 ch_size_type;		/* reciever/transmit channel
> > +						size for all channels */
> > +	u8 slot_width;		/* 1 or 2 Is defined by channel type */
> > +	u8 frame_len;		/* Length of frame in samples */
>=20
> Is u8 really appropriate here?  Maybe int?
>=20
> What does "type" mean in "ch_size_type"?
>=20
> > +	u8 adap_mode;			/* 0=3DNone, 1=3D T1, 2=3D T1-FULL, 3=3DE1,
> > +						4 =3D E1-FULL */
>=20
> Use #defines or an enum.
>=20
> > +	int max_num_ports;		/* Not Used: Max Number of ports that
> > +					can be created on this adapter */
>=20
> If it's not used, why is it here?
>=20
> > +/*
> > + * tdm_adapter is the structure used to identify a physical tdm
> > +device along
> > + * with the access algorithms necessary to access it.
> > + */
> > +struct tdm_adapter {
> > +	struct module *owner;	/* owner of the adapter module */
> > +	unsigned int id;	/* Adapter Id */
>=20
> What does the id mean?  Why do we need an arbitrary numberspace?
>=20
> > +	unsigned int class;	/* classes to allow probing for */
>=20
> What sort of values would go here?
>=20
> > +	unsigned int drv_count;	/* Number of drivers associated with the
> > +				 adapter */
> > +
> > +	const struct tdm_adapt_algorithm *algo;	/* the algorithm to
> access the
> > +						 adapter*/
> > +
> > +	char name[TDM_NAME_SIZE];	/* Name of Adapter */
> > +	struct mutex adap_lock;
> > +	struct device *parent;		/*Not Used*/
>=20
> Why is the parent device not used?
>=20
> > +	struct tasklet_struct tdm_data_tasklet;	/* tasklet handle to
> perform
> > +						 data processing*/
> > +	int tasklet_conf;	/* flag for tasklet configuration */
> > +	int tdm_rx_flag;
>=20
> What does "tdm_rx_flag" indicate?  What about "tasklet_conf"?
>=20
> > +	struct list_head myports;	/* list of ports, created on this
> > +					 adapter */
> > +	struct list_head list;
>=20
> If you've got more than one list, it's probably a bad idea for any of
> them to be simply called "list".
>=20
> > +	spinlock_t portlist_lock;	/* Spin Lock for port_list */
>=20
> Comments should add new information, not just restate what the code
> already said.
>=20
> > +static inline void *tdm_get_adapdata(const struct tdm_adapter *dev) {
> > +	return dev->data;
> > +}
> > +
> > +static inline void tdm_set_adapdata(struct tdm_adapter *dev, void
> > +*data) {
> > +	dev->data =3D data;
> > +}
>=20
> Is this really needed?
>=20
> > +
> > +/* functions exported by tdm.o */
> > +
> > +extern int tdm_add_adapter(struct tdm_adapter *); extern int
> > +tdm_del_adapter(struct tdm_adapter *); extern int
> > +tdm_register_driver(struct tdm_driver *); extern void
> > +tdm_del_driver(struct tdm_driver *); extern void
> > +tdm_unregister_driver(struct tdm_driver *); extern void
> > +init_config_adapter(struct tdm_adapter *);
> > +
> > +extern unsigned int tdm_port_open(struct tdm_driver *, void **);
> > +extern unsigned int tdm_port_close(void *); extern unsigned int
> > +tdm_port_ioctl(void *, unsigned int, unsigned long); extern unsigned
> > +int tdm_channel_read(void *, void *, void *, u16 *); extern unsigned
> > +int tdm_channel_write(void *, void * , void *, u16); extern unsigned
> > +int tdm_port_poll(void *, unsigned int);
> > +
> > +extern int tdm_channel_open(u16, u16, struct tdm_port *, void **);
> > +extern int tdm_channel_close(u16, u16, struct tdm_port *,
> > +						struct tdm_channel *);
>=20
> Please provide parameter names with prototypes.
>=20
> The "extern" is unnecessary.
>=20
> > +static inline int tdm_add_driver(struct tdm_driver *driver) {
> > +	return tdm_register_driver(driver);
> > +}
>=20
> What is the semantic difference between tdm_add_driver() and
> tdm_register_driver()?  Why do they both exist?
>=20
> -Scott
