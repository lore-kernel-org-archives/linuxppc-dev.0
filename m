Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [80.160.20.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 433C7DDEBC
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 15:33:27 +1000 (EST)
Date: Thu, 19 Jul 2007 07:33:02 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/3] ps3: Disk Storage Driver
Message-ID: <20070719053302.GO11657@kernel.dk>
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.392129000@pademelon.sonytel.be>
	<20070718163637.3f0e0164.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718163637.3f0e0164.akpm@linux-foundation.org>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 18 2007, Andrew Morton wrote:
> On Mon, 16 Jul 2007 18:15:40 +0200
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> 
> > From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > 
> > Add a Disk Storage Driver for the PS3:
> 
> Your patchset significantly hits powerpc, scsi and block.  So who gets to
> merge this?  Jens?  James?  Paul?
> 
> Me, I guess ;)

I think Paul was going to take it, or at least Geert hinted as such.

> > +#define PS3DISK_MAX_DISKS	16
> > +#define PS3DISK_MINORS		16
> > +
> > +#define KERNEL_SECTOR_SIZE	512
> 
> Sigh.  We have at least ten separate definitions of SECTOR_SIZE< none of
> them in the right place.  Cleanup opportunity for someone.

Indeed, it's universally 512 or << 9, just use that...

> > +#ifdef DEBUG
> > +	unsigned int n = 0;
> > +	struct bio *bio;
> > +	rq_for_each_bio(bio, req)
> > +		n++;
> 
> I'm surprised that the block core doesn't have a helper to count the number
> of bios in a request.

What would be the point of such a helper? I've never seen a need for it.
Geert uses it as debug code here, but the fact is that the number of
bios in a request is a pretty pointless number. It doesn't tell you
anything. There's no 1:1 mapping between bios and segments (or anything
else for that matter), so the exercise is purely pointless.

-- 
Jens Axboe
