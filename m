Return-Path: <axboe@kernel.dk>
Date: Mon, 9 Mar 2009 11:58:28 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH/RFC] ps3/block: Add ps3vram-ng driver for accessing
	video        RAM as block device
Message-ID: <20090309105828.GO11787@kernel.dk>
References: <alpine.LRH.2.00.0903051325450.2618@vixen.sonytel.be>
	<20090306074639.GN11787@kernel.dk>
	<alpine.LRH.2.00.0903061347360.16809@vixen.sonytel.be>
	<20090306125832.GX11787@kernel.dk>
	<alpine.LRH.2.00.0903061525340.16809@vixen.sonytel.be>
	<20090306190350.GD11787@kernel.dk>
	<alpine.LRH.2.00.0903091142500.19484@vixen.sonytel.be>
	<20090309104833.GM11787@kernel.dk>
	<20090309105022.GN11787@kernel.dk>
	<alpine.LRH.2.00.0903091151480.19484@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.0903091151480.19484@vixen.sonytel.be>
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

On Mon, Mar 09 2009, Geert Uytterhoeven wrote:
> On Mon, 9 Mar 2009, Jens Axboe wrote:
> > On Mon, Mar 09 2009, Jens Axboe wrote:
> > > On Mon, Mar 09 2009, Geert Uytterhoeven wrote:
> > > > On Fri, 6 Mar 2009, Jens Axboe wrote:
> > > > > On Fri, Mar 06 2009, Geert Uytterhoeven wrote:
> > > > > > On Fri, 6 Mar 2009, Jens Axboe wrote:
> > > > > > > On Fri, Mar 06 2009, Geert Uytterhoeven wrote:
> > > > > > > > On Fri, 6 Mar 2009, Jens Axboe wrote:
> > > > > > > > > On Thu, Mar 05 2009, Geert Uytterhoeven wrote:
> > > > > > > > > > But then I noticed ps3vram_make_request() may be called concurrently,
> > > > > > > > > > so I had to add a mutex to avoid data corruption. This slows the
> > > > > > > > > > driver down, and in the end, the version with a thread turns out to be
> > > > > > > > > > ca. 1% faster. The version without a thread is about 50 lines less
> > > > > > > > > > code, though.
> > > > > > > > >
> > > > > > > > > That is correct, ->make_request_fn may get reentered. I'm not surprised
> > > > > > > > > that performance dropped if you just shoved everything under a mutex.
> > > > > > > > > You could be a little more smart and queue concurrent bio's for
> > > > > > > > > processing when the current one is complete though, there are several
> > > > > > > > > approaches there that be a lot faster than going all the way through the
> > > > > > > > > IO stack and scheduler just to avoid concurrency.
> > > > > > > >
> > > > > > > > Yes, using a spinlock and queueing requests on a list if the driver is
> > > > > > > > busy can be done after 2.6.29...
> > > > > > >
> > > > > > > Certainly. Even just replacing your current mutex with a spinlock during
> > > > > > > the memcpy() would surely be a lot faster. Or even just grabbing the
> > > > > > > mutex before calling into the write for the duration of the bio. The way
> > > > > > > you do it is certain context switch death :-)
> > > > > >
> > > > > > It's not just the memcpy(). ps3vram_{up,down}load() call msleep(), so
> > > > > > I cannot use a spinlock.
> > > > >
> > > > > Ah right, I hadn't looked close enough. But putting the mutex_lock()
> > > > > outside of the bio_for_each_segment() is going to be much faster than
> > > > > getting/releasing it for each segment.
> > > >
> > > > It doesn't seem to make any measurable difference, so I'm gonna leave it for
> > > > now.
> > >
> > > It will depend on where the bio's are coming from. If they are all
> > > single segment, then there will be no difference. If they contain
> > > multiple segments, you reduce the lock/release by that amount.
> > >
> > > But yeah, just leave it as-is for now. You can send a final patch for
> > > inclusion though. Unless I'm mistaken, I only saw the original and then
> > > an incremental patch for changing it to ->make_request_fn?
> >
> > There was a full version, my mistake. I got confused by the removal of
> 
> Indeed.
> 
> > the old driver in another directory :-)
> 
> Can you please ack it? Thx!

Sure, I thought we had agreed to queue it up for 2.6.29?

-- 
Jens Axboe
