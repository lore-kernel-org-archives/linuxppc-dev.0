Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 426C367B72
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 17:24:12 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix ide-pmac sysfs entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060515000810.487b834e.akpm@osdl.org>
References: <1147676318.21291.105.camel@localhost.localdomain>
	<20060515000810.487b834e.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 15 May 2006 17:23:50 +1000
Message-Id: <1147677830.21291.114.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Pete Popov <ppopov@embeddedalley.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-15 at 00:08 -0700, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > It looks like the generic ide code now wants ide_init_hwif_ports() to
> > set the parent struct device into the ide_hw structure (new field ?).
> > Without this, the mac ide code can cause the ide probing code to explode
> > in flames in sysfs registration due to what looks like a stale pointer
> > in there (happens when removing/re-inserting one of the hotswap media
> > bays on some laptops).
> > 
> 
> You don't sound very confident.

Well, the problem is fixed with my change, I'd like to have Bart
confirmation that's its the right approach. It looks like it is but that
code is fairly intricated :)

> afaict things went bad in October last year.  hw_regs_t.dev was added here:
> 
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=26a940e21752e0de8f068f77dad606a7d1986937
> 
> but that only converted one driver to initialse ->dev.
> 
> How come things didn't break then?  Did some later change cause the
> problems?

Well, for one, very few drivers cause ide_unregister nor rely on those
old mecanism... it seems that the way I initialize things at boot works
fine, it's when I unregister/re-register via the hotswap bay that things
go bunk.

It's possible that it got broken back then and not noticed since ... or
another change actually made _use_ of that field... not sure, Bart might
confirm. The Mac laptops with those hotswap bays are fairly old and I
haven't tested for some time. I just did after getting user reports, and
users of old machines like that tend to use stable distro kernels which
tend to be fairly old...

Ben.
 
