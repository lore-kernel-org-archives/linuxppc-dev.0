Return-Path: <david@fromorbit.com>
Received: from ipmail01.adl2.internode.on.net (ipmail01.adl2.internode.on.net
 [150.101.137.133])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xx0SM5ScdzDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 08:05:39 +1000 (AEST)
Date: Tue, 19 Sep 2017 08:05:02 +1000
From: Dave Chinner <david@fromorbit.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 chandan <chandan@linux.vnet.ibm.com>
Subject: Re: [linux-next][XFS][trinity] WARNING: CPU: 32 PID: 31369 at
 fs/iomap.c:993
Message-ID: <20170918220502.GL10621@dastard>
References: <1505746565.6990.18.camel@abdul.in.ibm.com>
 <20170918152706.GA11482@lst.de>
 <8abed401-1634-760f-6543-4652fa495315@kernel.dk>
 <20170918213143.GJ10621@dastard>
 <21c53d3f-5ca9-886d-a326-cb6f1bbddffd@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21c53d3f-5ca9-886d-a326-cb6f1bbddffd@sandeen.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 18, 2017 at 05:00:58PM -0500, Eric Sandeen wrote:
> On 9/18/17 4:31 PM, Dave Chinner wrote:
> > On Mon, Sep 18, 2017 at 09:28:55AM -0600, Jens Axboe wrote:
> >> On 09/18/2017 09:27 AM, Christoph Hellwig wrote:
> >>> On Mon, Sep 18, 2017 at 08:26:05PM +0530, Abdul Haleem wrote:
> >>>> Hi,
> >>>>
> >>>> A warning is triggered from:
> >>>>
> >>>> file fs/iomap.c in function iomap_dio_rw
> >>>>
> >>>>     if (ret)
> >>>>         goto out_free_dio;
> >>>>
> >>>>     ret = invalidate_inode_pages2_range(mapping,
> >>>>             start >> PAGE_SHIFT, end >> PAGE_SHIFT);
> >>>>>>  WARN_ON_ONCE(ret);
> >>>>     ret = 0;
> >>>>
> >>>>     inode_dio_begin(inode);
> >>>
> >>> This is expected and an indication of a problematic workload - which
> >>> may be triggered by a fuzzer.
> >>
> >> If it's expected, why don't we kill the WARN_ON_ONCE()? I get it all
> >> the time running xfstests as well.
> > 
> > Because when a user reports a data corruption, the only evidence we
> > have that they are running an app that does something stupid is this
> > warning in their syslogs.  Tracepoints are not useful for replacing
> > warnings about data corruption vectors being triggered.
> 
> Is the full WARN_ON spew really helpful to us, though?  Certainly
> the user has no idea what it means, and will come away terrified
> but none the wiser.
> 
> Would a more informative printk_once() still give us the evidence
> without the ZOMG I THINK I OOPSED that a WARN_ON produces?  Or do we 
> want/need the backtrace?

backtrace is actually useful - that's how I recently learnt that
splice now supports direct IO.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
