Return-Path: <kenneth@southpole.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D13F3B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 10:20:53 +1000 (EST)
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 6AD09DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 10:20:53 +1000 (EST)
Subject: Re: kexec on e300 core / mpc5121
From: Kenneth Johansson <kenneth@southpole.se>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090805234737.GA26183@b07421-ec1.am.freescale.net>
References: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
	<1249512585.13069.9.camel@localhost>
	<20090805234737.GA26183@b07421-ec1.am.freescale.net>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 02:20:50 +0200
Message-Id: <1249518050.13069.21.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-05 at 18:47 -0500, Scott Wood wrote:
> On Thu, Aug 06, 2009 at 12:49:45AM +0200, Kenneth Johansson wrote:
> > On Wed, 2009-08-05 at 01:06 +0200, Sebastian Andrzej Siewior wrote:
> > > I've tried kexec on e300 core which should be easy since it is possible
> > > to disable the MMU on that core. However it does not work.
> > 
> > Is it not possible to disable the mmu on all cpu's that have one ?? 
> 
> No, on e500 for example it is always on.  You can use large pages with
> identity maps to make it seem like it's off, though.

why do something like that ? 

> > Before you turn off the cache you need to flush out all dirty data. best
> > done by simply reading in 32kb of crap from somewhere. otherwise you are
> > sure to loose at least the stack and you do not want that.
> 
> 32KiB is usually not sufficient -- depending on the initial state, an
> 8-way 32KiB cache with PLRU (such as in e300) can require up to 52KiB of
> data (13 loads per set) to fully flush if you simply load+dcbf (in
> separate passes) an arbitrary chunk of data which may already be in the
> cache.

if you have 
int crap[1024*32/4] __attribute__((aligned(32)))

What will happen with the cache if you just load data into a register
from that array ?? Wont it force out everything else in the cache to
make room for the crap ? 

 
