Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 72F42DDEEE
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 05:31:17 +1100 (EST)
Date: Thu, 22 Jan 2009 21:31:15 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/10] sdhci: Add support for bus-specific IO memory
	accessors
Message-ID: <20090122183115.GA27961@oksana.dev.rtsoft.ru>
References: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
	<20090122020019.GB11492@oksana.dev.rtsoft.ru>
	<200901221255.49724.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200901221255.49724.arnd@arndb.de>
Cc: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org,
	Liu Dave <DaveLiu@freescale.com>,
	Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linuxppc-dev@ozlabs.org, Konjin Lai <Konjin.Lai@freescale.com>,
	Ben Dooks <ben-linux@fluff.org>, Pierre Ossman <drzeus-sdhci@drzeus.cx>,
	Xie Xiaobo <X.Xie@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2009 at 12:55:48PM +0100, Arnd Bergmann wrote:
> On Thursday 22 January 2009, Anton Vorontsov wrote:
> > +       /*
> > +        * These accessors duplicate sdhci_ops, but there are two reasons for
> > +        * this:
> > +        * 1. sdhci_ops are const, so the sdhci driver won't able to assign
> > +        *    default ops;
> 
> You could assign the pointer to a const default_sdhci_ops structure,
> which IMHO would be cleaner than copying the function pointers
> separately.

This won't work because ops also specify non-memory accessors ops
(i.e. enable_dma, set_clock, ...), so we can't just assign
default_ops ptr.

> > +        * 2. Using host->X instead of host->ops->X saves us one dereference.
> > +        *    This can be useful in PIO mode. (Though the benefit of this
> > +        *    is negligibly small).
> > +        */
> 
> I doubt that this is even measurable.

Yeah, I didn't even bother w/ measuring. ;-)

> If it was, you could still use a copy of that structure, like
> 
> struct sdhci_host {
> 	...
> 	struct sdhci_ops ops; /* not struct sdhci_ops *ops */
> 	...
> };
> 
> and do an assignment of the structure, like
> 
> static void assign_ops(struct sdhci_host *host, struct sdhci_ops *ops)
> {
> 	host->ops = *ops;
> }

This will work. Pierre, what do you think? That way drivers
will call this routine instead of "host->ops = driver_ops_ptr".

The other option would be to remove const from the ops. Or implement
another non-const ops struct (struct sdhci_io_ops?).

In any way, the type-checked variant will be even longer to type:

host->mem_ops->writel(val, host->ioaddr + reg);
host->ops.writel(val, host->ioaddr + reg);
host->writel(val, host->ioaddr + reg);


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
