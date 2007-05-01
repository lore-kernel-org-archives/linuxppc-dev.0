Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A133DDEC6
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 10:00:40 +1000 (EST)
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070430.150407.07642146.davem@davemloft.net>
References: <1177852457.4390.26.camel@localhost.localdomain>
	<Pine.LNX.4.61.0704302159140.3178@mtfhpc.demon.co.uk>
	<20070430145414.88fda272.akpm@linux-foundation.org>
	<20070430.150407.07642146.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 01 May 2007 10:00:19 +1000
Message-Id: <1177977619.24962.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: mark@mtfhpc.demon.co.uk, linuxppc-dev@ozlabs.org, wli@holomorphy.com,
	linux-mm@kvack.org, andrea@suse.de, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Interesting - thanks for working that out.  Let's keep linux-mm on cc please.
> 
> You can't elide the update_mmu_cache() call on sun4c because that will
> miss some critical TLB setups which are performed there.
> 
> The sun4c TLB has two tiers of entries:
> 
> 1) segment maps, these hold ptes for a range of addresses
> 2) ptes, mapped into segment maps
> 
> update_mmu_cache() on sun4c take care of allocating and setting
> up the segment maps, so if you elide the call this never happens
> and we fault forever.

Maybe we can move that logic to ptep_set_access_flags()... in fact, the
tlb flush logic should be done there too imho.

There would still be the update_mmu_cache() that we don't want on
powerpc in all cases I suppose. That can be done by having
ptep_set_access_flags() return a boolean indicating wether
update_mmu_cache() shall be called or not ...

Ben.
