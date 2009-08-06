Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A1598B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 01:55:11 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 382F0DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 01:55:09 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n76FsoJp000931
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 08:55:00 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n76FsnWc002906
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 10:54:49 -0500 (CDT)
Date: Thu, 6 Aug 2009 10:54:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kenneth Johansson <kenneth@southpole.se>
Subject: Re: kexec on e300 core / mpc5121
Message-ID: <20090806155448.GB31581@b07421-ec1.am.freescale.net>
References: <20090804230605.GA28753@Chamillionaire.breakpoint.cc>
	<1249512585.13069.9.camel@localhost>
	<20090805234737.GA26183@b07421-ec1.am.freescale.net>
	<1249518050.13069.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1249518050.13069.21.camel@localhost>
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

On Thu, Aug 06, 2009 at 02:20:50AM +0200, Kenneth Johansson wrote:
> > > Before you turn off the cache you need to flush out all dirty data. best
> > > done by simply reading in 32kb of crap from somewhere. otherwise you are
> > > sure to loose at least the stack and you do not want that.
> > 
> > 32KiB is usually not sufficient -- depending on the initial state, an
> > 8-way 32KiB cache with PLRU (such as in e300) can require up to 52KiB of
> > data (13 loads per set) to fully flush if you simply load+dcbf (in
> > separate passes) an arbitrary chunk of data which may already be in the
> > cache.
> 
> if you have 
> int crap[1024*32/4] __attribute__((aligned(32)))
> 
> What will happen with the cache if you just load data into a register
> from that array ?? Wont it force out everything else in the cache to
> make room for the crap ? 

Under certain circumstances, the newly loaded flush data will replace
previous flush data rather than the actual data you're trying to displace
-- especially if some of the "crap" is already in the cache, or if there
were some empty cache lines at the start of the process.  It's not a true
LRU.

If you read 52K, and then dcbf that same 52K, with interrupts disabled
(they can disturb the PLRU), you should be OK.  It doesn't even need to
be dedicated junk, any memory will work.

-Scott
