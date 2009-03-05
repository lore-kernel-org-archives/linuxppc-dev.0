Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 5 Mar 2009 11:50:54 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH/RFC] ps3/block: Add ps3vram-ng driver for accessing video
	RAM as block device
In-Reply-To: <20090305083701.GQ11787@kernel.dk>
Message-ID: <alpine.LRH.2.00.0903051146440.2618@vixen.sonytel.be>
References: <alpine.LRH.2.00.0903041444300.32279@vixen.sonytel.be>
	<20090305083701.GQ11787@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
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

	Hi Jens,

On Thu, 5 Mar 2009, Jens Axboe wrote:
> On Wed, Mar 04 2009, Geert Uytterhoeven wrote:
> > Below is the rewrite of the PS3 Video RAM Storage Driver as a plain block
> > device, as requested by Arnd Bergmann.
> > 
> > The MTD-based PS3 Video RAM Storage Driver was integrated into the mainline
> > kernel in 2.6.29-rc1.
> > 
> > Ideally, we think it would be best if the existing MTD-based ps3vram driver
> > would be replaced by the new block-based ps3vram driver before 2.6.29 is
> > released. This would relieve the burden of supporting two different swap space
> > schemes on PS3 (swap on /dev/mtdblock0 vs. /dev/ps3vram) from the distro
> > maintainer's shoulders, as in that case there would never have been a stable
> > kernel version containing the MTD-based ps3vram driver.
> > 
> > What do you think? If this is accepted, I'll submit a patch to remove the MTD
> > ps3vram and add the new driver as ps3vram (instead of ps3vram-ng).
> > 
> > Thanks for your (review and other) comments!
> 
> I'd rewrite this as a ->make_request_fn handler instead. Then you can
> get rid of the kernel thread. IOW, change
> 
> queue = blk_init_queue(ps3vram_request, &priv->lock);
> 
> to
> 
> queue = blk_alloc_queue(GFP_KERNEL);
> blk_queue_make_request(queue, ps3vram_make_request);

Thanks, I didn't know that part...

> Add error handling of course, and call blk_queue_max_*() to set your
> limits for this device.

I took out the blk_queue_max_*() calls (compared to ps3disk.c), as none of the
limits apply, and the defaults are fine.

Is that OK, or is it better to make it explicit?

> Then add a ps3vram_make_request() ala:

> static void ps3vram_do_request(struct request_queue *q, struct bio *bio)
> {
> 	struct ps3_system_bus_device *dev = q->queuedata;
> 	struct ps3vram_priv *priv = dev->core.driver_data;
> 	int write, res, err = -EIO;
>         struct bio_vec *bv;
> 	sector_t sector;
> 	loff_t offset;
> 	size_t len, retlen;
>         int i;
> 
> 	write = bio_data_dir(bio) == WRITE;
> 
> 	sector = bio->bi_sector;
>         bio_for_each_segment(bv, bio, i) {
>                 char *ptr = page_address(bv->bv_page) + bv->bv_offset;
> 
>                 len = bv->bv_len;
> 	        offset = sector << 9;
> 
>         	if (write)
> 	        	res = ps3vram_write(dev, offset, len, &retlen, ptr);
>         	else
> 	        	res = ps3vram_read(dev, offset, len, &retlen, ptr);
> 
> 	        if (res) {
>         		dev_err(&dev->core, "%s failed\n", op);
> 	        	goto out;
>         	}
> 
>         	if (retlen != len) {
> 	        	dev_err(&dev->core, "Short %s\n", op);
> 		        goto out;
>         	}
>                 sector += (len >> 9);
>         }
> 
> 	dev_dbg(&dev->core, "%s completed\n", op);
>         err = 0;
> out:
>         bio_endio(bio, err);
> }
> 
> I just typed it here, so if it doesn't compile you get to keep the
> pieces :-)

OK, I'll give it a try...

BTW, does this mean the `simple' way, which I used based on LDD3, is
deprecated?

> Since ps3 is very RAM limited, I didn't bother with any highmem mapping
> for the bio, since I gather that isn't an issue on that platform. You
> may want to detail that in a comment above the page_addres() thing at
> the top of the loop, though.

PS3 is ppc64, so no highmem. But I guess I best add the code for that anyway,
in case people will copy the driver in the future (I remember receiving a
similar comment for ps3disk).

Thanks for your comments!

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
