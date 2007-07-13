Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF881DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 22:45:25 +1000 (EST)
Date: Fri, 13 Jul 2007 14:45:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Enable SPU switch notification to detect currently
	active SPU tasks.
Message-ID: <20070713124502.GA26544@lst.de>
References: <1184283940.16584.5.camel@bnelson60.rchland.ibm.com>
	<20070713101233.GA12426@lst.de>
	<1184330090.6059.219.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1184330090.6059.219.camel@localhost.localdomain>
Cc: Philippe Elie <phil.el@wanadoo.fr>, linuxppc <linuxppc-dev@ozlabs.org>,
	Bob Nelson <rrnelson@linux.vnet.ibm.com>,
	oprofile <oprofile-list@lists.sourceforge.net>,
	Andrew Morton <akpm@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 13, 2007 at 10:34:50PM +1000, Benjamin Herrenschmidt wrote:
> 
> > > +		if (unlikely(test_bit(SPU_SCHED_NOTIFY_ACTIVE,
> > > +				      &ctx->sched_flags))) {
> > > +			clear_bit(SPU_SCHED_NOTIFY_ACTIVE, &ctx->sched_flags);
> > 
> > this should use test_and_clear_bit
> 
> This also looks like an abuse of atomics to effectively implement a lock
> or did I miss something ?

not really.  We set a flag on the context to make sure some action is
performed when it comes through spu_run the next time.  It's not exactly
elegant, but cleaning this up will have to wait for the grand spu_run
rewrite.
