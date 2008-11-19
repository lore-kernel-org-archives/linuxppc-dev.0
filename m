Return-Path: <axboe@kernel.dk>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 5311DDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 00:35:57 +1100 (EST)
Date: Wed, 19 Nov 2008 14:34:09 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: spinlock lockup with next-20081118 on powerpc
Message-ID: <20081119133408.GE26308@kernel.dk>
References: <20081119093023.48895b84.sfr@canb.auug.org.au>
	<20081119091628.GT26308@kernel.dk>
	<20081119203922.0412c041.sfr@canb.auug.org.au>
	<20081119094300.GW26308@kernel.dk>
	<20081119213304.d2d21042.sfr@canb.auug.org.au>
	<20081119105833.GZ26308@kernel.dk>
	<20081120003224.8d0f481c.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081120003224.8d0f481c.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20 2008, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Wed, 19 Nov 2008 11:58:33 +0100 Jens Axboe <jens.axboe@oracle.com> wrote:
> >
> > ;-) I'm aware of that, I meant the 'timer' data argument. But you are
> > right, it's probably q->queue_lock being NULL here or we would have
> > oopsed earlier. There's no code line.
> > 
> > > address of the spinlock (though I need to check more to be sure) as it
> > > crashed inside _spin_lock_irqsave.
> > 
> > Do you know what device this might be? It still makes no sense, if the
> > timer was added, we went through the normal IO paths and we would have
> > crashed on NULL ->queue_lock much earlier.
> 
> I don't know much more, but I may find out tomorrow with Paul's help.
> However it bisects down to commit
> 279430a72bb6e83d335b4219e9af5557e2ff3350 "block: leave the request
> timeout timer running even on an empty list" and reverting that commit on
> next-20081118 makes the spinlock lockup go away.

Are you removing devices or modules? We have a bug there it seems, does
this help?

diff --git a/block/blk-core.c b/block/blk-core.c
index 04267d6..44f547c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -391,6 +391,7 @@ EXPORT_SYMBOL(blk_stop_queue);
 void blk_sync_queue(struct request_queue *q)
 {
 	del_timer_sync(&q->unplug_timer);
+	del_timer_sync(&q->timeout);
 	kblockd_flush_work(&q->unplug_work);
 }
 EXPORT_SYMBOL(blk_sync_queue);

-- 
Jens Axboe
