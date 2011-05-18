Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BBA62100842
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:52:11 +1000 (EST)
Subject: Re: [PATCH 1/7] powerpc/mm: 64-bit 4k: use page-sized PMDs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110518164645.0ae83ad5@schlenkerla.am.freescale.net>
References: <20110518210453.GA29500@schlenkerla.am.freescale.net>
	<1305754361.7481.2.camel@pasglop>
	<20110518164645.0ae83ad5@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 07:52:02 +1000
Message-ID: <1305755522.7481.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > Why do you want to create a virtual page table at the PMD level ? Also,
> > you are changing the geometry of the page tables which I think we don't
> > want. We chose that geometry so that the levels match the segment sizes
> > on server, I think it may have an impact with the hugetlbfs code (check
> > with David), it also was meant as a way to implement shared page tables
> > on hash64 tho we never published that.
> 
> The number of virtual page table misses were very high on certain loads.
> Cutting back to a virtual PMD eliminates most of that for the benchmark I
> tested, though it could still be painful for access patterns that are
> extremely spread out through the 64-bit address space.  I'll try a full
> 4-level walk and see what the performance is like; I was aiming for a
> compromise between random access and linear/localized access.

Let's get more numbers first then :-)

> Why does it need to match segment sizes on server?

I'm not sure whether we have a dependency with hugetlbfs there, I need
to check (remember we have one page size per segment there). For sharing
page tables that came from us using the PMD pointer as a base to
calculate the VSIDs. But I don't think we have plans to revive those
patches in the immediate future.

Cheers,
Ben.

> As for hugetlbfs, it merged easily enough with Becky's patches (you'll have
> to ask her when they'll be published).
> 
> -Scott
