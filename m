Return-Path: <SRS0+9585c4e39412ddbfd682+1236+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77FC4DE0C4
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:44:00 +1100 (EST)
Date: Thu, 11 Jan 2007 19:43:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of
	do_mmap()
Message-ID: <20070111194346.GA29607@infradead.org>
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
	<20070111192056.GB24623@infradead.org>
	<20070111194054.GA11770@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070111194054.GA11770@localdomain>
Cc: Roland Dreier <rdreier@cisco.com>, openfabrics-ewg@openib.org,
	openib-general@openib.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2007 at 01:40:54PM -0600, Nathan Lynch wrote:
> Christoph Hellwig wrote:
> > On Thu, Jan 11, 2007 at 08:08:36PM +0100, Hoang-Nam Nguyen wrote:
> > 
> > >  	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
> > >  	while (my_cq->nr_callbacks)
> > >  		yield();
> > 
> > Calling yield is a very bad idea in general.  You should probably
> > add a waitqueue that gets woken when nr_callbacks reaches zero to
> > sleep effectively here.
> 
> Isn't that code outright buggy?  Calling into the scheduler with a
> spinlock held and local interrupts disabled...

Umm, yes - of course.  I missed the spin_lock_irqsave line just above.
