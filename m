Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6714D1A2B37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 22:05:12 +1100 (AEDT)
Message-ID: <1427108695.4770.227.camel@kernel.crashing.org>
Subject: Re: Generic IOMMU pooled allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Mar 2015 22:04:55 +1100
In-Reply-To: <201503230704.31878.arnd@arndb.de>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <20150322220708.GA14061@oracle.com>
 <1427062924.4770.208.camel@kernel.crashing.org>
 <201503230704.31878.arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sparclinux@vger.kernel.org, Sowmini Varadhan <sowmini.varadhan@oracle.com>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-23 at 07:04 +0100, Arnd Bergmann wrote:
> 
> My guess is that the ARM code so far has been concerned mainly with
> getting things to work in the first place, but scalability problems
> will only be seen when there are faster CPU cores become available.

In any case, I think this is mostly a non-issue. The complexity of the
ARM code is in various areas related to making shit work (handling
coherent allocations mostly) but only remotely related to the actual
iommu DMA space allocator (iova in ARM as far as I understand the code)
which is pretty standard.

The work Sowmini is doing is about specifically the allocator. Making
our (powerpc) allocator generic since it has some nice scalability
features.

In fact, what Aik and I have been pushing and Sowmini is close to
achieving is to mostly disconnect that allocator from the rest of the
iommu management (the caller).

So in the end, the allocator itself should be splitable into something
separate that resides in lib/ or similar, which ARM can chose to use as
well.

Sowmini: it might be worthwhile creating a separate data structure
iommu_virt_zone or something like that which is what the allocator works
on exclusively, which we would just embed into sparc and powerpc. The
only remaining problem I see is your "reset" op, but I think we should
be able to sort it out once we understand what it's there for :-)

Cheers,
Ben.
