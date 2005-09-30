Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFD41683A8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 23:22:30 +1000 (EST)
Date: Fri, 30 Sep 2005 14:22:18 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Kalle Pokki <kalle.pokki@iki.fi>
Message-Id: <20050930142218.348041d6.ajz@cambridgebroadband.com>
In-Reply-To: <433BDCE7.2060206@iki.fi>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 29 Sep 2005 14:24:07 +0200
Kalle Pokki <kalle.pokki@iki.fi> wrote:

> Kalle Pokki wrote:
> 
> > I guess Linux remaps the RAM as copy-back. But snooping should
> > work with copy-back caches, shouldn't it?
> 
> Oh, well. The kernel boots just fine if I add
> 
> flags |= _PAGE_WRITETHRU | _PAGE_COHERENT;
> 
> in setbat() in arch/ppc/mm/ppc_mmu.c. But this should not depend on
> this kind of a hack, should it?
> 

I was experiencing a similar problem with the mpc8260sar ATM driver,
and Kalle's hack seems to fix the problem.

On the 8260 ATM SAR you can specify that the CPM asserts the GBL
signal whenever it accesses buffers, BDs, or interrupt queues. This
allows the cache to snoop accesses to these areas and invalidate cache
lines to keep the cache coherent.

However, there seems to be no way of telling the CPM to assert the GBL
signal when it is accessing External Connection Tables, or Second
Level lookup Tables - both of which are also accessed by the core.

Because of this the cache does not know when the CPM is accessing
these areas.

It seems to me that whilst the CPM was designed to be cache coherent
Freescale have overlooked some areas!

Till now I have worked around this problem by calling
dcache_invalidate_range() and dcache_flush_range() before and after
accesses to these areas.  I'm now considering changing to Kalle's way
of doing it.

Are there any drawbacks to this approach?

TIA,

Alex Zeffertt
