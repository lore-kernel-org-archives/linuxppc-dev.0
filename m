Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE745DDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 13:41:28 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <200806111329.35894.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <adaskvl3yb0.fsf@cisco.com>
	<200806101219.34995.jbarnes@virtuousgeek.org>
	<200806111329.35894.nickpiggin@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 13:40:44 +1000
Message-Id: <1213155644.25745.60.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	David Miller <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Trent Piepho <tpiepho@freescale.com>, alan@lxorguk.ukuu.org.uk
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-06-11 at 13:29 +1000, Nick Piggin wrote:
> 
> Exactly, yes. I guess everybody has had good intentions here, but
> as noticed, what is lacking is coordination and documentation.
> 
> You mention strong ordering WRT spin_unlock, which suggests that
> you would prefer to take option #2 (the current powerpc one): io/io
> is ordered and io is contained inside spinlocks, but io/cacheable
> in general is not ordered.

IO/cacheable -is- ordered on powepc in what we believe is the direction
that matter: IO reads are fully ordered vs. anything and IO writes are
ordered vs. previous cacheable stores. The only "relaxed" situation is
IO writes followed by cacheable stores, which I believe shouldn't be
a problem. (except for spinlocks for which we use the flag trick)

> I *would* prefer that io/cacheable actually is strongly ordered with
> the default accessors. Because if you have that, then the driver
> writer never has to care about memory ordering, provided they use
> correct locking for SMP issues. Same as x86. With option 2, there
> are still windows where you could possibly have issues.
> 
> For any high performance drivers that are well maintained (ie. the
> ones where slowdown might be noticed), everyone should have a pretty
> good handle on memory ordering requirements, so it shouldn't take
> long to go through and convert them to relaxed accessors.

Ben.
