Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6C90DDE44
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 16:30:05 +1000 (EST)
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070509231937.ea254c26.akpm@linux-foundation.org>
References: <20070430145414.88fda272.akpm@linux-foundation.org>
	<20070430.150407.07642146.davem@davemloft.net>
	<1177977619.24962.6.camel@localhost.localdomain>
	<20070430.173806.112621225.davem@davemloft.net>
	<Pine.LNX.4.61.0705010223040.3556@mtfhpc.demon.co.uk>
	<1177985136.24962.8.camel@localhost.localdomain>
	<Pine.LNX.4.61.0705011453380.4771@mtfhpc.demon.co.uk>
	<1178055110.13263.2.camel@localhost.localdomain>
	<Pine.LNX.4.61.0705012354290.12808@mtfhpc.demon.co.uk>
	<20070509231937.ea254c26.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 10 May 2007 16:29:43 +1000
Message-Id: <1178778583.14928.210.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Mark Fortescue <mark@mtfhpc.demon.co.uk>, linuxppc-dev@ozlabs.org,
	wli@holomorphy.com, linux-mm@kvack.org, andrea@suse.de,
	sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> We never seemed to reach completion here?

Well, I'm waiting for other people comments too... as I said earlier,
I'm not too fan of burrying the update_mmu_cache() inside
ptep_set_access_flags(), but perhaps we could remove the whole logic of
reading the old PTE & comparing it, and instead have
ptep_set_access_flags() do that locally and return to the caller wether
a change occured that requires update_mmu_cache() to be called.

That way, archs who don't actually need update_mmu_cache() under some
circumstances will be able to return 0 there.

What do you guys thing ?

Ben.
