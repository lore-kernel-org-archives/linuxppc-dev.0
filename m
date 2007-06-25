Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BB944DDDF8
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 01:40:53 +1000 (EST)
Date: Mon, 25 Jun 2007 10:50:08 -0500
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org, linuxppc-dev@ozlabs.org,
	Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] pcmcia: CompactFlash driver for PA Semi Electra boards
Message-ID: <20070625155008.GA5217@lixom.net>
References: <20070625010311.GA31355@lixom.net>
	<20070625055636.GB1057@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070625055636.GB1057@infradead.org>
From: olof@lixom.net (Olof Johansson)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 25, 2007 at 06:56:36AM +0100, Christoph Hellwig wrote:
> > +static int bus_notify(struct notifier_block *nb, unsigned long action,
> > +		      void *data)
> > +{
> > +	struct device *dev = data;
> > +
> > +	printk("bus notify called\n");
> > +
> > +	/* We are only intereted in device addition */
> > +	if (action != BUS_NOTIFY_ADD_DEVICE)
> > +		return 0;
> > +
> > +	/* We use the direct ops for localbus */
> > +	dev->archdata.dma_ops = &dma_direct_ops;
> > +
> > +	return 0;
> > +}
> 
> Sorry for not coming back to you after the last posting of the patch,
> but I still really this bit of the code.  We don't set dma ops from
> a driver anywhere else in the tree, so I'd really prefer if you could
> handle this in architecture code somewhere.  Especially as dma_direct_ops
> and the pcmcia_bug_type shouldn't really be something exported to users.
> 
> Also this code is unlogic if not buggy.  Just because you have one
> electra bridge it doesn't mean all pcmcia is driven by it.  In fact I'm
> pretty sure there are cardbus/pcmcia bridges that can be plugged into
> plain pci slots.

Yeah, all good points. Also, I obviously missed to take out the debug
printk. I'll post an updated patch separately.


Thanks!

-Olof
