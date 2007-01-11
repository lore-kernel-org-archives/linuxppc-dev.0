Return-Path: <SRS0+9585c4e39412ddbfd682+1236+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCD53DE0DD
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:21:04 +1100 (EST)
Date: Thu, 11 Jan 2007 19:20:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of
	do_mmap()
Message-ID: <20070111192056.GB24623@infradead.org>
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, openfabrics-ewg@openib.org,
	hch@infradead.org, linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2007 at 08:08:36PM +0100, Hoang-Nam Nguyen wrote:
> Hello Roland and Christoph H.!
> This is a patch for ehca_cq.c. It removes all direct calls of do_mmap()/munmap()
> when creating and destroying a completion queue respectively. 
> Thanks
> Nam

This patch looks good, but there are some issues with the surrounding code:

> +		if (my_cq->ownpid != cur_pid) {
> +			ehca_err(device, "Invalid caller pid=%x ownpid=%x "
> +				 "cq_num=%x",
> +				 cur_pid, my_cq->ownpid, my_cq->cq_number);
> +			return -EINVAL;
> +		}

(for other reviewers: this is not new code, just moved around)

Owner tracking by pid is really dangerous.  File descriptors can be
passed around by unix sockets, a single process can have files open
more than once, etc..

It seems ehca wants to prevent threads other than the creating one
from performing most operations.  Can you explain the reason for this?

>  	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
>  	while (my_cq->nr_callbacks)
>  		yield();

Calling yield is a very bad idea in general.  You should probably
add a waitqueue that gets woken when nr_callbacks reaches zero to
sleep effectively here.
