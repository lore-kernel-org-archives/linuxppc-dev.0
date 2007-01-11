Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 1988DDE098
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:41:08 +1100 (EST)
Date: Thu, 11 Jan 2007 13:40:54 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Christoph Hellwig <hch@infradead.org>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
	openib-general@openib.org, raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of
	do_mmap()
Message-ID: <20070111194054.GA11770@localdomain>
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
	<20070111192056.GB24623@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070111192056.GB24623@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Thu, Jan 11, 2007 at 08:08:36PM +0100, Hoang-Nam Nguyen wrote:
> 
> >  	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
> >  	while (my_cq->nr_callbacks)
> >  		yield();
> 
> Calling yield is a very bad idea in general.  You should probably
> add a waitqueue that gets woken when nr_callbacks reaches zero to
> sleep effectively here.

Isn't that code outright buggy?  Calling into the scheduler with a
spinlock held and local interrupts disabled...
