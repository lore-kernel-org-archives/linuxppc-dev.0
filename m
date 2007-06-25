Return-Path: <SRS0+7cfff2985c2512d6f44d+1401+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 256A8DDEC8
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 15:56:43 +1000 (EST)
Date: Mon, 25 Jun 2007 06:56:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pcmcia: CompactFlash driver for PA Semi Electra boards
Message-ID: <20070625055636.GB1057@infradead.org>
References: <20070625010311.GA31355@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070625010311.GA31355@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static int bus_notify(struct notifier_block *nb, unsigned long action,
> +		      void *data)
> +{
> +	struct device *dev = data;
> +
> +	printk("bus notify called\n");
> +
> +	/* We are only intereted in device addition */
> +	if (action != BUS_NOTIFY_ADD_DEVICE)
> +		return 0;
> +
> +	/* We use the direct ops for localbus */
> +	dev->archdata.dma_ops = &dma_direct_ops;
> +
> +	return 0;
> +}

Sorry for not coming back to you after the last posting of the patch,
but I still really this bit of the code.  We don't set dma ops from
a driver anywhere else in the tree, so I'd really prefer if you could
handle this in architecture code somewhere.  Especially as dma_direct_ops
and the pcmcia_bug_type shouldn't really be something exported to users.

Also this code is unlogic if not buggy.  Just because you have one
electra bridge it doesn't mean all pcmcia is driven by it.  In fact I'm
pretty sure there are cardbus/pcmcia bridges that can be plugged into
plain pci slots.
