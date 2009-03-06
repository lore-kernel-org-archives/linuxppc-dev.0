Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [93.163.65.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 12F7BDDDA5
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 07:46:28 +1100 (EST)
Date: Fri, 6 Mar 2009 21:46:23 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Fix Xilinx SystemACE driver to handle empty CF slot
Message-ID: <20090306204623.GJ11787@kernel.dk>
References: <20090228204622.29719.55082.stgit@localhost.localdomain>
	<fa686aa40903060805i489d8676waad08e8263c02fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa686aa40903060805i489d8676waad08e8263c02fe@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 06 2009, Grant Likely wrote:
> Oops, sorry Jens.  I forgot to CC: you on this patch.
> 
> g.
> 
> On Sat, Feb 28, 2009 at 1:46 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > The SystemACE driver does not handle an empty CF slot gracefully.  An
> > empty CF slot ends up hanging the system.  This patch adds a check for
> > the CF state and stops trying to process requests if the slot is empty.

So with patches like this, it's always nice to know what your target is.
Do you want this in .29, or just queued up for .30? It's not always easy
to judge the urgency of such patches :-)

Also, I note that you are using end_request() throughout the driver. We
really want to get away from that, you should be using blk_end_request()
as that will handle full requests and not just segment-by-segment. No
worries for this patch, but you may want to consider that for a future
patch.

-- 
Jens Axboe
