Return-Path: <B37400@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA4E32C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 23:22:56 +1000 (EST)
Received: from mail119-am1 (localhost [127.0.0.1])	by
 mail119-am1-R.bigfish.com (Postfix) with ESMTP id D13584009B	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 13:22:49 +0000 (UTC)
Received: from AM1EHSMHS004.bigfish.com (unknown [10.3.201.232])	by
 mail119-am1.bigfish.com (Postfix) with ESMTP id 42E0F4A005C	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 13:22:47 +0000 (UTC)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [2/3][PATCH][upstream] TDM Framework
Date: Tue, 24 Jul 2012 13:22:44 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E50ED27@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <CAOZdJXVnEUEQesyG52pL_jerGDrmJLxdfBNFrj_xvhPs=ue4DA@mail.gmail.com>
In-Reply-To: <CAOZdJXVnEUEQesyG52pL_jerGDrmJLxdfBNFrj_xvhPs=ue4DA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Timur,

Thanks for your comments, please find response inline.

Regards,
Sandeep


-----Original Message-----
From: Tabi Timur-B04825=20
Sent: Monday, July 23, 2012 10:03 PM
To: Singh Sandeep-B37400
Cc: linuxppc-dev@lists.ozlabs.org; Singh Sandeep-B37400; Aggrwal Poonam-B10=
812
Subject: Re: [2/3][PATCH][upstream] TDM Framework

On Mon, Jul 23, 2012 at 5:49 AM,  <b37400@freescale.com> wrote:
> From: Sandeep Singh <Sandeep@freescale.com>

Please fix your git configuration so that the From: line in your
emails contains your full name.   This patch was sent with this From:
line:

From: <b37400@freescale.com>

It should say:

From: Sandeep Singh <sandeep@freescale.com>

Three more things:

1) You don't need to add [upstream] to patches that are posted upstream.

2) This patch needs to be CC'd to linux-kernel@vger.kernel.org and devel@dr=
iverdev.osuosl.org.

3) I'm concerned that there is no "struct device" anywhere in this framewor=
k.  I think that's a serious omission, and you need to figure out where you=
 can put this.

 [Sandeep] 1) & 2) Ok, Will take care. 3)Ok, will check.


> diff --git a/drivers/tdm/tdm-core.c b/drivers/tdm/tdm-core.c new file=20
> mode 100644 index 0000000..9973b6b
> --- /dev/null
> +++ b/drivers/tdm/tdm-core.c
> @@ -0,0 +1,1082 @@
> +/* driver/tdm/tdm-core.c
> + *
> + * Copyright (C) 2012 Freescale Semiconductor, Inc, All rights reserved.

I've been seeing this copyright messages a lot recently, and I don't unders=
tand why.  This message is incorrectly formatted.  The "(C)" is redundant, =
and the phrase "All rights reserved." is wrong.  This patch is licensed und=
er the GPL, so we are NOT reserving all rights, we are actually giving up s=
ome rights.

Please change this to:

Copyright 2012 Freescale Semiconductor, Inc.

 [Sandeep] Will correct this.


> + *
> + * TDM core is the interface between TDM clients and TDM devices.
> + * It is also intended to serve as an interface for line controlled
> + * devices later on.
> + *
> + * Author:Hemant Agrawal <hemant@freescale.com>
> + *     Rajesh Gumasta <rajesh.gumasta@freescale.com>

If these two are the authors, why are they not on the signed-off-by lines?
[Sandeep] Will add them to signoff.

> + *
> + * Modified by Sandeep Kr Singh <sandeep@freescale.com>
> + *             Poonam Aggarwal <poonam.aggarwal@freescale.com>

Do not add "modified" by lines to the code.  That's why we have a git histo=
ry.
[Sandeep] Ok.


> + * 1. Added framework based initialization of device.
> + * 2. All the init/run time configuration is now done by framework.
> + * 3. Added channel level operations.
> + * 4. Added sysfs knob to configure use_latest_tdm_data at runtime.

Again, this is not information that belongs in the source file.
[Sandeep] OK

> + *
> + * Note that some parts of this code may have been derived from i2c subs=
ystem.
> + *
> + * This program is free software; you can redistribute  it and/or=20
> + modify it
> + * under  the terms of  the GNU General  Public License as published=20
> + by the
> + * Free Software Foundation;  either version 2 of the  License, or=20
> + (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,=20
> + but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the  GNU General Public License=20
> + along
> + * with this program; if not, write  to the Free Software Foundation,=20
> + Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/tdm.h>
> +#include <linux/init.h>
> +#include <linux/idr.h>
> +#include <linux/mutex.h>
> +#include <linux/completion.h>
> +#include <linux/hardirq.h>
> +#include <linux/irqflags.h>
> +#include <linux/list.h>
> +#include <linux/uaccess.h>
> +#include <linux/io.h>

Are you sure you need all of these header files?
[Sandeep] Will check.

> +
> +
> +static DEFINE_MUTEX(tdm_core_lock);
> +static DEFINE_IDR(tdm_adapter_idr);
> +/* List of TDM adapters registered with TDM framework */=20
> +LIST_HEAD(adapter_list);
> +
> +/* List of TDM clients registered with TDM framework */=20
> +LIST_HEAD(driver_list);
> +
> +/* In case the previous data is not fetched by the client driver, the
> + * de-interleaving function will  discard the old data and rewrite=20
> +the
> + * new data */

Proper multi-line comment format is like this:
[Sandeep] Ok.

/*
 * In case the previous data is not fetched by the client driver, the
 * de-interleaving function will  discard the old data and rewrite the
 * new data.
 */

> +static int use_latest_tdm_data =3D 1;
> +
> +/* Data structures required for sysfs */ static struct tdm_sysfs attr=20
> +=3D {
> +       .attr.name =3D "use_latest_data",
> +       .attr.mode =3D 0664,
> +       .cmd_type =3D TDM_LATEST_DATA,
> +};
> +
> +static struct attribute *tdm_attr[] =3D {
> +       &attr.attr,
> +       NULL
> +};
> +
> +const struct sysfs_ops tdm_ops =3D {
> +       .show =3D tdm_show_sysfs,
> +       .store =3D tdm_store_sysfs,
> +};
> +
> +static struct kobj_type tdm_type =3D {
> +       .sysfs_ops =3D &tdm_ops,
> +       .default_attrs =3D tdm_attr,
> +};

Why are some of these 'const' and some aren't?  They should all be 'const'
[Sandeep] Ok.

> +
> +/* tries to match client driver with the adapter */ static int=20
> +tdm_device_match(struct tdm_driver *driver, struct tdm_adapter *adap)=20
> +{
> +       /* match on an id table if there is one */
> +       if (driver->id_table && driver->id_table->name[0]) {
> +               if (!(strcmp(driver->id_table->name, adap->name)))
> +                       return (int)driver->id_table;
> +       }


> +       return TDM_E_OK;

Get rid of TDM_E_OK.  It's the only error code that you've defined, and it'=
s set to 0.  That doesn't mean anything.
[Sandeep] Ok

> +}
> +
> +static int tdm_attach_driver_adap(struct tdm_driver *driver,
> +               struct tdm_adapter *adap) {
> +       int ret =3D TDM_E_OK;
> +       /* if driver is already attached to any other adapter, return*/
> +       if (driver->adapter && (driver->adapter !=3D adap))
> +               return ret;
> +
> +       driver->adapter =3D adap;
> +
> +       if (driver->attach_adapter) {
> +               ret =3D driver->attach_adapter(adap);
> +               if (ret < 0) {
> +                       pr_err("attach_adapter failed for driver [%s] err=
:%d\n"
> +                                       , driver->name, ret);
> +                       return ret;
> +               }
> +       }
> +       adap->drv_count++;
> +
> +       if (!adap->tasklet_conf) {
> +               tdm_sysfs_init();
> +               tasklet_init(&adap->tdm_data_tasklet, tdm_data_tasklet_fn=
,
> +                               (unsigned long)adap);
> +               adap->tasklet_conf =3D 1;
> +       }
> +
> +       return ret;

If 'ret' can only be 0, then just return 0.

       return 0;
[Sandeep] Ok, will change.


> +/* tdm_adap_send - issue a TDM write
> + * @adap: Handle to TDM device
> + * @buf: Data that will be written to the TDM device
> + * @count: How many bytes to write
> + *
> + * Returns negative errno, or else the number of bytes written.

"Returns negative error number, or else the number of bytes written."

You're typing this on a full keyboard, not a smart phone.  Please don't use=
 abbreviations unnecessarily.
[Sandeep] Ok, will rectify.

> + */
> +int tdm_adap_send(struct tdm_adapter *adap, void **buf, int count) {
> +       int res;
> +
> +       if (adap->algo->tdm_write)
> +               res =3D adap->algo->tdm_write(adap, buf, count);

Why does tdm_write() return a u32?  And shouldn't 'res' also be a u32, to m=
ake tdm_write()?
[Sandeep] tdm_write() returns number of bytes written. You are right, 'res'=
 should be declared as u32


> +/* Port Level APIs of TDM Framework */ int tdm_port_open(struct=20
> +tdm_driver *driver, struct tdm_port **h_port) {
> +       struct tdm_port *port;
> +       struct tdm_adapter *adap;
> +       unsigned long           flags;
> +       int res =3D TDM_E_OK;
> +
> +       adap =3D tdm_get_adapter(driver->adapter->id);
> +       if (!adap)
> +               return -ENODEV;
> +
> +       /* This creates an anonymous tdm_port, which may later be
> +        * pointed to some slot.
> +        *
> +        */
> +       port =3D kzalloc(sizeof(*port), GFP_KERNEL);
> +       if (!port) {
> +               res =3D -ENOMEM;
> +               goto out;
> +       }

Just return here.  You don't need to "goto out".  And I think you forgot to=
 call tdm_put_adapter(), although it might be easier if you call kzalloc() =
first, and then tdm_get_adapter().
[Sandeep] Ok.

> +
> +       port->rx_max_frames =3D NUM_SAMPLES_PER_FRAME;
> +       port->port_cfg.port_mode =3D TDM_PORT_CHANNELIZED;
> +
> +       snprintf(driver->name, TDM_NAME_SIZE, "tdm-dev");
> +       port->driver =3D driver;
> +       port->adapter =3D adap;
> +
> +       spin_lock_irqsave(&adap->portlist_lock, flags);
> +       list_add_tail(&port->list, &adap->myports);
> +       spin_unlock_irqrestore(&adap->portlist_lock, flags);

Are you sure you need to disable interrupts?  That seems excessive.
[Sandeep] Will check once.


> +int tdm_channel_read(struct tdm_port *h_port, struct tdm_channel *h_chan=
nel,
> +               void *p_data, u16 *size) {
> +       struct tdm_channel *channel;
> +       struct tdm_bd *rx_bd;
> +       unsigned long flags;
> +       int i, res =3D TDM_E_OK;
> +       unsigned short *buf, *buf1;
> +       channel =3D h_channel;
> +
> +       if (!channel->p_ch_data || !channel->in_use)
> +               return -EIO;
> +
> +       spin_lock_irqsave(&channel->p_ch_data->rx_channel_lock, flags);
> +       rx_bd =3D channel->p_ch_data->rx_out_data;
> +
> +       if (rx_bd->flag) {
> +               *size =3D rx_bd->length;
> +               buf =3D (u16 *) p_data;
> +               buf1 =3D (u16 *)rx_bd->p_data;
> +               for (i =3D 0; i < NUM_SAMPLES_PER_FRAME; i++)
> +                       buf[i] =3D buf1[i];

Use memcpy() instead.
[Sandeep] Ok



> +int tdm_channel_write(struct tdm_port *h_port, struct tdm_channel *h_cha=
nnel,
> +               void *p_data, u16 size) {
> +       struct tdm_port *port;
> +       struct tdm_channel *channel;
> +       struct tdm_bd *tx_bd;
> +       unsigned long flags;
> +       int err =3D TDM_E_OK;
> +       port =3D h_port;
> +       channel =3D h_channel;
> +#ifdef DEBUG
> +       bool data_flag =3D 0;
> +#endif
> +
> +       if (p_data =3D=3D NULL) { /* invalid data*/
> +               pr_err("Invalid Data");
> +               return -EFAULT;
> +       }

EFAULT is for invalid memory access.  I think you mean EINVAL here.
[Sandeep] Right. Will correct.

> +
> +       if (!channel->p_ch_data || !channel->in_use)
> +               return -EIO;
> +
> +       spin_lock_irqsave(&channel->p_ch_data->tx_channel_lock, flags);
> +       tx_bd =3D channel->p_ch_data->tx_in_data;
> +
> +       if (!tx_bd->flag) {
> +               tx_bd->length =3D size;
> +               memcpy(tx_bd->p_data, p_data,
> +                               size * port->adapter->adapt_cfg.slot_widt=
h);
> +               tx_bd->flag =3D 1;
> +               tx_bd->offset =3D 0;
> +               channel->p_ch_data->tx_in_data =3D (tx_bd->wrap) ?
> +                       channel->p_ch_data->tx_data_fifo : tx_bd+1;
> +               port->port_stat.tx_pkt_count++; #ifdef DEBUG
> +               data_flag =3D 1;
> +#endif
> +       } else {
> +               spin_unlock_irqrestore(&channel->p_ch_data->tx_channel_lo=
ck,
> +                               flags);
> +               port->port_stat.tx_pkt_drop_count++;
> +               pr_err("E_NO_MEMORY -Failed Transmit");

Please review ALL of your error messages, and make sure that have a proper =
prefix ("tdm: ") and all look the same.  Don't use __func__ in any of them,=
 and make sure the error messages are clear, English text.
[Sandeep] Ok.

> +               return -ENOMEM;

I'm not sure ENOMEM is appropriate here.
[Sandeep] Will check.

> +       }
> +       spin_unlock_irqrestore(&channel->p_ch_data->tx_channel_lock,=20
> + flags);
> +
> +#ifdef DEBUG
> +       if (data_flag) {
> +               int k;
> +               pr_info("\nTX port:%d - Write - Port TX-%d\n",
> +                               port->port_id, size);
> +               for (k =3D 0; k < size; k++)
> +                       pr_info("%x", p_data[k]);
> +               pr_info("\n");
> +       }
> +#endif
> +       return err;
> +}
> +EXPORT_SYMBOL(tdm_channel_write);
> +
> +/* Driver Function for select and poll. Based on Channel, it sleeps=20
> +on
> + * waitqueue */
> +int tdm_ch_poll(struct tdm_channel *h_channel, unsigned int=20
> +wait_time) {
> +       struct tdm_channel *channel;
> +       unsigned long timeout =3D msecs_to_jiffies(wait_time);
> +       channel =3D h_channel;
> +
> +       if (!channel->p_ch_data || !channel->in_use)
> +               return -EIO;
> +
> +       if (channel->p_ch_data->rx_out_data->flag) {
> +               pr_debug("Data Available");
> +               return TDM_E_OK;
> +       }
> +       if (timeout) {
> +              =20
> + wait_event_interruptible_timeout(channel->ch_wait_queue,

It'd be more efficient if you did this:

       if (wait_time) {
               unsigned long timeout =3D msecs_to_jiffies(wait_time);

               wait_event_interruptible_timeout(channel->ch_wait_queue,

[Sandeep] Ok.

> +                               channel->p_ch_data->rx_out_data->flag,
> +                               timeout);
> +
> +               if (channel->p_ch_data->rx_out_data->flag) {
> +                       pr_debug("Data Available");
> +                       return TDM_E_OK;
> +               }
> +       }
> +       return -EAGAIN;
> +}
> +EXPORT_SYMBOL(tdm_ch_poll);
> +
> +unsigned int tdm_port_get_stats(struct tdm_port *h_port,
> +               struct tdm_port_stats *portStat)

Do not use CamelCase in variable names.
[Sandeep] Ok, will modify.



> diff --git a/include/linux/tdm.h b/include/linux/tdm.h new file mode=20
> 100644 index 0000000..a2f9628
> --- /dev/null
> +++ b/include/linux/tdm.h
> @@ -0,0 +1,338 @@
> +/* include/linux/tdm.h
> + *
> + * Copyright (C) 2012 Freescale Semiconductor, Inc, All rights reserved.
> + *
> + * tdm.h - definitions for the tdm-device framework interface
> + *
> + * Author:Hemant Agrawal <hemant@freescale.com>
> + *     Rajesh Gumasta <rajesh.gumasta@freescale.com>
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
> +#include <linux/device.h>      /* for struct device */
> +#include <linux/sched.h>       /* for completion */
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/sysfs.h>
> +
> +#define TDM_LATEST_DATA                1
> +#define CHANNEL_8BIT_LIN       0       /* 8 bit linear */
> +#define CHANNEL_8BIT_ULAW      1       /* 8 bit Mu-law */
> +#define CHANNEL_8BIT_ALAW      2       /* 8 bit A-law */
> +#define CHANNEL_16BIT_LIN      3       /* 16 bit Linear */
> +
> +/*
> + * Default adapter configuration. All the TDM adapters registered=20
> +with
> + * framework will be configured with following default configuration.
> + */
> +#define NUM_CHANNELS   16
> +
> +/* Default configuration for typical voice data sample. These=20
> +parameters
> + * will generally not be required to be changed for voice type applicati=
ons.
> + */
> +#define NUM_SAMPLES_PER_MS     8       /* 8 samples per milli sec per
> +                                        channel. Req for voice data */
> +#define NUM_MS                 10
> +#define NUM_SAMPLES_PER_FRAME  (NUM_MS * NUM_SAMPLES_PER_MS) /* Number o=
f
> +                                               samples for 1 client buff=
er */
> +#define NUM_OF_TDM_BUF         3
> +
> +/* General options */
> +
> +struct tdm_adapt_algorithm;
> +struct tdm_adapter;
> +struct tdm_port;
> +struct tdm_driver;

I don't think you need "struct tdm_driver;"
[Sandeep] Right. Will remove.


> +/* tdm_adapter_mode is to define in mode of the device */ enum=20
> +tdm_adapter_mode {
> +       TDM_ADAPTER_MODE_NONE =3D 0x00,
> +       TDM_ADAPTER_MODE_T1 =3D 0x01,
> +       TDM_ADAPTER_MODE_E1 =3D 0x02,
> +       TDM_ADAPTER_MODE_T1_RAW =3D 0x10,
> +       TDM_ADAPTER_MODE_E1_RAW =3D 0x20,

Where did these numbers come from?
[Sandeep] This is not related to any bit definition, just enum values.

--
Timur Tabi
Linux kernel developer at Freescale
