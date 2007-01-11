Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 6A1D0DDEA0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:56:24 +1100 (EST)
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of
	do_mmap()
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
	<20070111192056.GB24623@infradead.org>
	<20070111194054.GA11770@localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 11 Jan 2007 11:56:18 -0800
In-Reply-To: <20070111194054.GA11770@localdomain> (Nathan Lynch's message of
	"Thu, 11 Jan 2007 13:40:54 -0600")
Message-ID: <adaodp5ibh9.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org,
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

 > >  	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
 > >  	while (my_cq->nr_callbacks)
 > >  		yield();

 > Isn't that code outright buggy?  Calling into the scheduler with a
 > spinlock held and local interrupts disabled...

Yes, absolutely -- if nr_callbacks is ever nonzero then this will
obviously crash instantly.

 - R.
