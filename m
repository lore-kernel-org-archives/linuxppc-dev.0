Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [80.160.20.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DB68BDE09F
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 05:21:12 +1000 (EST)
Date: Wed, 18 Jul 2007 19:57:56 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: PS3 Storage Driver O_DIRECT issue
Message-ID: <20070718175756.GC11657@kernel.dk>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<20070713122752.GA854@aepfle.de>
	<Pine.LNX.4.62.0707181808030.15632@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0707181808030.15632@pademelon.sonytel.be>
Cc: "James E.J.  Bottomley" <James.Bottomley@SteelEye.com>,
	Olaf Hering <olaf@aepfle.de>, linux-scsi@vger.kernel.org,
	Alessandro Rubini <rubini@ipvvis.unipv.it>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 18 2007, Geert Uytterhoeven wrote:
> On Fri, 13 Jul 2007, Olaf Hering wrote:
> > This driver (or the generic PS3 code) has appearently problems with
> > O_DIRECT. 
> > glibc aborts parted because the malloc metadata get corrupted. While it
> > is reproducible, the place where it crashes changes with every version
> > of the debug attempt.
> > I dont have a handle right now, all I know is that the metadata after a
> > malloc area get overwritten with zeros.
> > 
> > 
> > Can you have a look at this? 
> > parted /dev/ps3da
> > print (a few times)
> 
> I could reproduce it with parted 1.8.0 and later.
> 
> The patch below fixes it (tested with 1.8.0, 1.8.2 (FC6), 1.9.0 (git)).
> 
> Apparently sometimes bio_cur_sectors(bio)*KERNEL_SECTOR_SIZE != bvec->bv_len
> when using O_DIRECT. Is that true (or a bug?)?
> 
> If it's OK, I'll fold this patch into the main ps3disk patch.

The bug is in your code - you iterate the bio segments, but always
reference the current one. Which of course makes no sense, you may as
well just kill the loop in that case, the code would be the same.

-- 
Jens Axboe
