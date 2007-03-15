Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A0F3DDDF4
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 19:46:52 +1100 (EST)
Date: Thu, 15 Mar 2007 08:46:45 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 10/13] BLK_DEV_IDE_CELLEB dependency fix
Message-ID: <20070315084645.GR4095@ftp.linux.org.uk>
References: <E1HRPb0-0003Eh-OG@ZenIV.linux.org.uk>
	<200703150523.l2F5NelE001987@toshiba.co.jp>
	<20070315053607.GQ4095@ftp.linux.org.uk>
	<200703150608.l2F68JY2026403@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200703150608.l2F68JY2026403@toshiba.co.jp>
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

On Thu, Mar 15, 2007 at 03:10:20PM +0900, Akira Iguchi wrote:
> Al wrote:
> >
> >Eh...  You still need dependency on IDE=y; otherwise you'll get configs
> >with IDE=m, BLK_DEV_IDE_CELLEB=y and those won't link.  BLK_DEV_IDEDMA_PCI
> >is selectable just fine with IDE=m.
> >
> >It's the same problem as with ps3 fb.
> >
> 
> I'm sorry I missed this case.
> Using some configurations, I found BLK_DEV_IDE=y was better.
> (I failed to link when IDE=y and BLK_DEV_IDE=m.)

Umm...  Point taken.  After looking at the entire thing... well.

a) BLK_DEV_IDE_PMAC has bogus dependency on IDE=y.  If anything, that
should've been BLK_DEV_IDE=y; however, it *does* build with ide modular -
it doesn't generate a separate module and its initialization is called
explicitly from ide one.  AFAICS, we can simply drop that dependency.

b) BLK_DEV_IDE_PMAC does *not* build without BLK_DEV_IDEDMA_PMAC.  Quoting
benh, "I don't see any reason to keep that dma thingy optional anyway".

c) BLK_DEV_MPC8xx_IDE depends on BLK_DEV_IDE=y *and* IDE=y.  The latter is
obviously redundant.  The former...  No idea, 8xx is currently b0rken in
ARCH=powerpc and I can't be arsed to wade through arch/ppc bitrot.  As it
is, driver definitely wants ARCH=ppc stuff (__res, for one thing).

Now, BLK_DEV_IDE_CELLEB looks interesting.  The nature of breakage is not
the same as usual (non-modular driver depends on stuff that might be built
modular); what's going on here is funnier.  If you get ide-core modular,
you'll have BLK_DEV_IDE_CELLEB code *linked* *into* ide-core.ko.  Unlike
the rest of its ilk, however, it doesn't have its init called directly from
ide init.  It uses module_init(), which happens to work when it goes into
the kernel image (ide-core.o has several initcalls, not a problem), but breaks
when it goes into a modular ide-core.ko; there multiple module_init() are
fatal.

So AFAICS the minimal fix for that sucker is dependency on BLK_DEV_IDE=y;
however, I really wonder if
	* it needs to be linked into ide-core (as opposed to being a normal
module of its own)
	* alternatively, its init should be called explicitly.

Comments?
