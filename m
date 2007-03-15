Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 84966DDD06
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 06:41:37 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so416165ugf
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 12:41:35 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 10/13] BLK_DEV_IDE_CELLEB dependency fix
Date: Thu, 15 Mar 2007 20:48:42 +0100
References: <E1HRPb0-0003Eh-OG@ZenIV.linux.org.uk>
	<200703150608.l2F68JY2026403@toshiba.co.jp>
	<20070315084645.GR4095@ftp.linux.org.uk>
In-Reply-To: <20070315084645.GR4095@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703152048.42972.bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thursday 15 March 2007, Al Viro wrote:
> On Thu, Mar 15, 2007 at 03:10:20PM +0900, Akira Iguchi wrote:
> > Al wrote:
> > >
> > >Eh...  You still need dependency on IDE=y; otherwise you'll get configs
> > >with IDE=m, BLK_DEV_IDE_CELLEB=y and those won't link.  BLK_DEV_IDEDMA_PCI
> > >is selectable just fine with IDE=m.
> > >
> > >It's the same problem as with ps3 fb.
> > >
> > 
> > I'm sorry I missed this case.
> > Using some configurations, I found BLK_DEV_IDE=y was better.
> > (I failed to link when IDE=y and BLK_DEV_IDE=m.)
> 
> Umm...  Point taken.  After looking at the entire thing... well.
> 
> a) BLK_DEV_IDE_PMAC has bogus dependency on IDE=y.  If anything, that
> should've been BLK_DEV_IDE=y; however, it *does* build with ide modular -
> it doesn't generate a separate module and its initialization is called
> explicitly from ide one.  AFAICS, we can simply drop that dependency.

agreed

> b) BLK_DEV_IDE_PMAC does *not* build without BLK_DEV_IDEDMA_PMAC.  Quoting
> benh, "I don't see any reason to keep that dma thingy optional anyway".

ditto

> c) BLK_DEV_MPC8xx_IDE depends on BLK_DEV_IDE=y *and* IDE=y.  The latter is
> obviously redundant.  The former...  No idea, 8xx is currently b0rken in

ditto

> ARCH=powerpc and I can't be arsed to wade through arch/ppc bitrot.  As it
> is, driver definitely wants ARCH=ppc stuff (__res, for one thing).
> 
> Now, BLK_DEV_IDE_CELLEB looks interesting.  The nature of breakage is not
> the same as usual (non-modular driver depends on stuff that might be built
> modular); what's going on here is funnier.  If you get ide-core modular,
> you'll have BLK_DEV_IDE_CELLEB code *linked* *into* ide-core.ko.  Unlike
> the rest of its ilk, however, it doesn't have its init called directly from
> ide init.  It uses module_init(), which happens to work when it goes into
> the kernel image (ide-core.o has several initcalls, not a problem), but breaks
> when it goes into a modular ide-core.ko; there multiple module_init() are
> fatal.
> 
> So AFAICS the minimal fix for that sucker is dependency on BLK_DEV_IDE=y;
> however, I really wonder if
> 	* it needs to be linked into ide-core (as opposed to being a normal
> module of its own)

AFAICS there are no legacy device ordering issues with scc_pata so it doesn't
need to be linked into ide-core but I'll leave the definitive answer to Akira

> 	* alternatively, its init should be called explicitly.
> 
> Comments?

Care to provide patch for non-scc_pata issues that you've discovered? :-)

Thanks,
Bart
