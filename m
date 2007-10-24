Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	by ozlabs.org (Postfix) with ESMTP id 463EFDDF39
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:14:51 +1000 (EST)
Date: Wed, 24 Oct 2007 11:14:47 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] fix powerpc breakage in sg chaining code (again)
Message-ID: <20071024091446.GL14671@kernel.dk>
References: <1193173222.7733.42.camel@johannes.berg>
	<1193176034.4097.3.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193176034.4097.3.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23 2007, Johannes Berg wrote:
> On Tue, 2007-10-23 at 23:00 +0200, Johannes Berg wrote:
> > Commit 33ff910f0f466184ffc3514628f18403dcd86761 fixed commit
> > 78bdc3106a877cfa50439fa66b52acbc4e7868df but the code that got put in
> > uses struct scatterlist->page which no longer exists since commit
> > 18dabf473e15850c0dbc8ff13ac1e2806d542c15 which requires using
> > sg_page(sg) instead of sg->page.
> 
> This doesn't help though, when I boot I get a NULL-pointer dereference
> that looks approximately like this:
> 
> NIP blk_rq_map_sg + 0x64/0x190
> LR ide_map_sg + 0x38/?
> Call trace:
> cfq_remove_request + 0x168 (unreliable)
> cfq_dispatch_request + 0x44
> ide_build_sglist + 0x38?
> pmac_ide_dma_setup + 0xa0?
> ide_do_rw_disk? + ?
> [...]
> 
> I can upload the picture I took but it's hardly readable (taken with my
> crappy cell phone)

I lost track - which kernel are you booting? This looks like something
that should be fixed, did you try 2.6.24-rc1?

-- 
Jens Axboe
