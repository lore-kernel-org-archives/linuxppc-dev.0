Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EFAA1A2AF5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 05:45:32 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Generic IOMMU pooled allocator
Date: Mon, 23 Mar 2015 19:45:13 +0100
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <201503230704.31878.arnd@arndb.de>
 <1427108695.4770.227.camel@kernel.crashing.org>
In-Reply-To: <1427108695.4770.227.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201503231945.13719.arnd@arndb.de>
Cc: sparclinux@vger.kernel.org, paulus@samba.org,
 David Miller <davem@davemloft.net>,
 Sowmini Varadhan <sowmini.varadhan@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 23 March 2015, Benjamin Herrenschmidt wrote:
> On Mon, 2015-03-23 at 07:04 +0100, Arnd Bergmann wrote:
> > 
> > My guess is that the ARM code so far has been concerned mainly with
> > getting things to work in the first place, but scalability problems
> > will only be seen when there are faster CPU cores become available.
> 
> In any case, I think this is mostly a non-issue. The complexity of the
> ARM code is in various areas related to making shit work (handling
> coherent allocations mostly) but only remotely related to the actual
> iommu DMA space allocator (iova in ARM as far as I understand the code)
> which is pretty standard.

Ok, got it. Thanks for explaining tht part.

> The work Sowmini is doing is about specifically the allocator. Making
> our (powerpc) allocator generic since it has some nice scalability
> features.
> 
> In fact, what Aik and I have been pushing and Sowmini is close to
> achieving is to mostly disconnect that allocator from the rest of the
> iommu management (the caller).
> 
> So in the end, the allocator itself should be splitable into something
> separate that resides in lib/ or similar, which ARM can chose to use as
> well.

Yes, this sounds like a good idea. I'm currently at ELC and will bring this
up with the people working on ARM IOMMU support.

	Arnd
