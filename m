Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 000FDDDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 12:16:37 +1100 (EST)
Date: Tue, 18 Dec 2007 17:10:50 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 1/3] ps3: vuart: fix error path locking
Message-Id: <20071218171050.5bf220fa.akpm@linux-foundation.org>
In-Reply-To: <4760922C.2060908@am.sony.com>
References: <20071213003028.676998182@mvista.com>
	<4760922C.2060908@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 12 Dec 2007 18:00:12 -0800
Geoff Levand <geoffrey.levand@am.sony.com> wrote:

> > This stray down would cause a permanent sleep which doesn't seem correct. 
> > The other uses of this semaphore appear fairly mutex like it's even initialized
> > with init_MUTEX() ..  So here a patch for removing this one down().
> > 
> > Signed-off-by: Daniel Walker <dwalker@mvista.com>
> > 
> > ---
> >  drivers/ps3/ps3-vuart.c |    1 -
> >  1 file changed, 1 deletion(-)
> 
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> 
> Looks, good. 

Looks bad to me.

> Andrew, Please apply.

The current code:

	if (result) {
		dev_dbg(&dev->core, "%s:%d: drv->probe failed\n",
			__func__, __LINE__);
		down(&vuart_bus_priv.probe_mutex);
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

is correct.  Although not exactly a thing of beauty.
