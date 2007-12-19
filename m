Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 94A3BDDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 14:29:58 +1100 (EST)
Message-ID: <47688A5A.1090902@am.sony.com>
Date: Tue, 18 Dec 2007 19:04:58 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] ps3: vuart: fix error path locking
References: <20071213003028.676998182@mvista.com>	<4760922C.2060908@am.sony.com>
	<20071218171050.5bf220fa.akpm@linux-foundation.org>
In-Reply-To: <20071218171050.5bf220fa.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dwalker@mvista.com, matthias.kaehlcke@gmail.com,
	linux-kernel@vger.kernel.org, linux@bohmer.net,
	linuxppc-dev@ozlabs.org, mingo@elte.hu, kjwinchester@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/18/2007 05:10 PM, Andrew Morton wrote:
> On Wed, 12 Dec 2007 18:00:12 -0800
> Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> 
>> > This stray down would cause a permanent sleep which doesn't seem correct. 
>> > The other uses of this semaphore appear fairly mutex like it's even initialized
>> > with init_MUTEX() ..  So here a patch for removing this one down().
>> > 
>> > Signed-off-by: Daniel Walker <dwalker@mvista.com>
>> > 
>> > ---
>> >  drivers/ps3/ps3-vuart.c |    1 -
>> >  1 file changed, 1 deletion(-)
>> 
>> 
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> 
>> 
>> Looks, good. 
> 
> Looks bad to me.

Hi Andrew,

Unfortunately there wasn't enough context in the patch to see
that there is a down() earlier in the routine, and that the patch
does indeed remove an incorrectly placed down().  Here is the
entire routine, marked with what the patch removes.

static int ps3_vuart_probe(struct ps3_system_bus_device *dev)
{
	int result;
	struct ps3_vuart_port_driver *drv;
	struct ps3_vuart_port_priv *priv = NULL;

	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);

	drv = ps3_system_bus_dev_to_vuart_drv(dev);

	dev_dbg(&dev->core, "%s:%d: (%s)\n", __func__, __LINE__,
		drv->core.core.name);

	BUG_ON(!drv);

	if (dev->port_number >= PORT_COUNT) {
		BUG();
		return -EINVAL;
	}

	down(&vuart_bus_priv.probe_mutex);

	result = ps3_vuart_bus_interrupt_get();

	if (result)
		goto fail_setup_interrupt;

	if (vuart_bus_priv.devices[dev->port_number]) {
		dev_dbg(&dev->core, "%s:%d: port busy (%d)\n", __func__,
			__LINE__, dev->port_number);
		result = -EBUSY;
		goto fail_busy;
	}

	vuart_bus_priv.devices[dev->port_number] = dev;

	/* Setup dev->driver_priv. */

	dev->driver_priv = kzalloc(sizeof(struct ps3_vuart_port_priv),
		GFP_KERNEL);

	if (!dev->driver_priv) {
		result = -ENOMEM;
		goto fail_dev_malloc;
	}

	priv = to_port_priv(dev);

	INIT_LIST_HEAD(&priv->tx_list.head);
	spin_lock_init(&priv->tx_list.lock);

	INIT_LIST_HEAD(&priv->rx_list.head);
	spin_lock_init(&priv->rx_list.lock);

	INIT_WORK(&priv->rx_list.work.work, NULL);
	priv->rx_list.work.trigger = 0;
	priv->rx_list.work.dev = dev;

	/* clear stale pending interrupts */

	ps3_vuart_clear_rx_bytes(dev, 0);

	ps3_vuart_set_interrupt_mask(dev, INTERRUPT_MASK_RX);

	ps3_vuart_set_triggers(dev, 1, 1);

	if (drv->probe)
		result = drv->probe(dev);
	else {
		result = 0;
		dev_info(&dev->core, "%s:%d: no probe method\n", __func__,
			__LINE__);
	}

	if (result) {
		dev_dbg(&dev->core, "%s:%d: drv->probe failed\n",
			__func__, __LINE__);
removed >>>>>>	down(&vuart_bus_priv.probe_mutex); <<<<<<<<<<<
		goto fail_probe;
	}

	up(&vuart_bus_priv.probe_mutex);

	return result;

fail_probe:
	ps3_vuart_set_interrupt_mask(dev, 0);
	kfree(dev->driver_priv);
	dev->driver_priv = NULL;
fail_dev_malloc:
	vuart_bus_priv.devices[dev->port_number] = NULL;
fail_busy:
	ps3_vuart_bus_interrupt_put();
fail_setup_interrupt:
	up(&vuart_bus_priv.probe_mutex);
	dev_dbg(&dev->core, "%s:%d: failed\n", __func__, __LINE__);
	return result;
}

Thanks for taking the time to scrutinize.

-Geoff
