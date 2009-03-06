Return-Path: <axboe@kernel.dk>
Date: Fri, 6 Mar 2009 08:46:39 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH/RFC] ps3/block: Add ps3vram-ng driver for accessing
	video    RAM as block device
Message-ID: <20090306074639.GN11787@kernel.dk>
References: <alpine.LRH.2.00.0903041444300.32279@vixen.sonytel.be>
	<20090305083701.GQ11787@kernel.dk>
	<alpine.LRH.2.00.0903051146440.2618@vixen.sonytel.be>
	<20090305110940.GY11787@kernel.dk>
	<alpine.LRH.2.00.0903051325450.2618@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.0903051325450.2618@vixen.sonytel.be>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Jim Paris <jim@jtan.com>, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-mtd@lists.infradead.org,
	Vivien Chappelier <vivien.chappelier@free.fr>,
	David Woodhouse <dwmw2@infradead.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 05 2009, Geert Uytterhoeven wrote:
> On Thu, 5 Mar 2009, Jens Axboe wrote:
> > On Thu, Mar 05 2009, Geert Uytterhoeven wrote:
> > > On Thu, 5 Mar 2009, Jens Axboe wrote:
> > > > On Wed, Mar 04 2009, Geert Uytterhoeven wrote:
> > > > > Below is the rewrite of the PS3 Video RAM Storage Driver as a plain block
> > > > > device, as requested by Arnd Bergmann.
> 
> > > > I'd rewrite this as a ->make_request_fn handler instead. Then you can
> > > > get rid of the kernel thread. IOW, change
> > > >
> > > > queue = blk_init_queue(ps3vram_request, &priv->lock);
> > > >
> > > > to
> > > >
> > > > queue = blk_alloc_queue(GFP_KERNEL);
> > > > blk_queue_make_request(queue, ps3vram_make_request);
> > >
> > > Thanks, I didn't know that part...
> > >
> > > > Add error handling of course, and call blk_queue_max_*() to set your
> > > > limits for this device.
> > >
> > > I took out the blk_queue_max_*() calls (compared to ps3disk.c), as
> > > none of the limits apply, and the defaults are fine.
> > >
> > > Is that OK, or is it better to make it explicit?
> >
> > I think it's always good to make it explicit. Plus for this case you
> > definitely need it, as blk_init_queue() wont do it for you anymore.
> 
> blk_queue_make_request() does it for me, too:
> 
> void blk_queue_make_request(struct request_queue *q, make_request_fn *mfn)
> {
> 	...
> 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
> 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
> 	...
> 	blk_queue_max_segment_size(q, MAX_SEGMENT_SIZE);
> 	...
> 	blk_queue_max_sectors(q, SAFE_MAX_SECTORS);
> 	...
> }
> 
> struct request_queue *
> blk_init_queue_node(request_fn_proc *rfn, spinlock_t *lock, int node_id)
> {
> 	...
> 	blk_queue_max_segment_size(q, MAX_SEGMENT_SIZE);
> 
> 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
> 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
> 	...
> }

Indeed, there's some duplicated code in blk_init_queue_node(), I'll make
sure to get rid of that!

> > > > Then add a ps3vram_make_request() ala:
> > >
> > > > static void ps3vram_do_request(struct request_queue *q, struct bio *bio)
> > > > {
> 
> > > > }
> > > >
> > > > I just typed it here, so if it doesn't compile you get to keep the
> > > > pieces :-)
> > >
> > > OK, I'll give it a try...
> > >
> > > BTW, does this mean the `simple' way, which I used based on LDD3, is
> > > deprecated?
> >
> > Depends.. It's obviously not a very effective approach, since you punt
> > to a thread for each request. But if you need the IO scheduler helping
> > you with merging and sorting (for a rotational device), it still has
> > some merit. For this particular case, the ->make_request_fn approach is
> > much better.
> 
> Without the thread, performance indeed increased.
> 
> But then I noticed ps3vram_make_request() may be called concurrently,
> so I had to add a mutex to avoid data corruption. This slows the
> driver down, and in the end, the version with a thread turns out to be
> ca. 1% faster. The version without a thread is about 50 lines less
> code, though.

That is correct, ->make_request_fn may get reentered. I'm not surprised
that performance dropped if you just shoved everything under a mutex.
You could be a little more smart and queue concurrent bio's for
processing when the current one is complete though, there are several
approaches there that be a lot faster than going all the way through the
IO stack and scheduler just to avoid concurrency.

-- 
Jens Axboe
