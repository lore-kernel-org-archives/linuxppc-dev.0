Return-Path: <clifford@clifford.at>
Received: from phoenix.clifford.at (phoenix.clifford.at [88.198.7.52])
	by ozlabs.org (Postfix) with ESMTP id E3E25DDFD1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jul 2007 23:23:32 +1000 (EST)
Date: Sat, 7 Jul 2007 15:27:48 +0200
From: Clifford Wolf <clifford@clifford.at>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Mem-2-Mem DMA - Generalized API
Message-ID: <20070707132748.GB32740@clifford.at>
References: <20070624193932.GA11797@clifford.at>
	<20070625180110.GH20463@clifford.at>
	<20070704090554.GA30693@clifford.at>
	<200707071508.04143.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707071508.04143.arnd@arndb.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Thanks for your feedback. I will incorporate to my code and release a new
version of Tuesday when I'm back in the office..

On Sat, Jul 07, 2007 at 03:08:03PM +0200, Arnd Bergmann wrote:
> > +void dmatransfer_unregister_backend(struct dmatransfer_backend *backend)
> > +{
> > +	unsigned long irqflags;
> > +	write_lock_irqsave(&backend_list_lock, irqflags);
> > +	list_del(&backend->backend_list);
> > +	write_unlock_irqrestore(&backend_list_lock, irqflags);
> > +
> > +	// make sure all pending requests have finished before returning
> > +	down_write(&backend->unreg_sem);
> > +	up_write(&backend->unreg_sem);
> > +}
> 
> This usage of rw semaphores looks fishy. 

yep. do you have a better idea how to implement this easily?

> > +		if ((dmasr & (BIT(TE, 7) | BIT(EOCDI, 0))) != 0) {
> > +			if ((dmasr & BIT(TE, 7)) != 0) {
> > +				printk(KERN_ERR "MPC8349 DMA Transfer Error on DMA channel #%d.\n",
> > i); +				BUG();
> > +			} 
> 
> BUG() may be a little harsh here, especially since you are holding spinlocks.
> It would be better to try to recover here, unless you expect actual data
> corruption, in which case a full panic() might be more appropriate.

in this way dmatransfer() is designed to be used like memcpy(): you don't
try and check for errors afterwards, you only start a dmatransfer if you
know it is ok and can't fail.

This codepath triggeres if 'the impossible' happens: a dma transfer
actually fails. Since there is no datapath to communicate this error back
to the caller it is almost sure that we have lost data. I will change that
to use panic() instead.

yours,
 - clifford

-- 
Some languages are designed to solve a problem. Others are designed to
prove a point.
