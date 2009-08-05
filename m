Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 07106B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 09:48:02 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 801E5DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 09:47:59 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n75Nlcbr009818
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 16:47:49 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n75Nm3Xv017862
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 18:48:03 -0500 (CDT)
Date: Wed, 5 Aug 2009 18:47:37 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kenneth Johansson <kenneth@southpole.se>
Subject: Re: kexec on e300 core / mpc5121
Message-ID: <20090805234737.GA26183@b07421-ec1.am.freescale.net>
References: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
	<1249512585.13069.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1249512585.13069.9.camel@localhost>
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

On Thu, Aug 06, 2009 at 12:49:45AM +0200, Kenneth Johansson wrote:
> On Wed, 2009-08-05 at 01:06 +0200, Sebastian Andrzej Siewior wrote:
> > I've tried kexec on e300 core which should be easy since it is possible
> > to disable the MMU on that core. However it does not work.
> 
> Is it not possible to disable the mmu on all cpu's that have one ?? 

No, on e500 for example it is always on.  You can use large pages with
identity maps to make it seem like it's off, though.

> Before you turn off the cache you need to flush out all dirty data. best
> done by simply reading in 32kb of crap from somewhere. otherwise you are
> sure to loose at least the stack and you do not want that.

32KiB is usually not sufficient -- depending on the initial state, an
8-way 32KiB cache with PLRU (such as in e300) can require up to 52KiB of
data (13 loads per set) to fully flush if you simply load+dcbf (in
separate passes) an arbitrary chunk of data which may already be in the
cache.

If instead you load+dcbf something that you know is not already in the
cache, or if you have a flush-assist mode that does not choose vacant
cache lines when available (instead sticking strictly to the PLRU), the
maximum is 48KiB.

If you have flush-assist *and* you guarantee no hit on the flush data,
then you can get away with only 32KiB.

-Scott
