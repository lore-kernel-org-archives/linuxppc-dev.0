Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
 by ozlabs.org (Postfix) with ESMTP id 4673C2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 06:00:32 +1000 (EST)
Date: Sat, 22 Sep 2012 16:00:27 -0400 (EDT)
Message-Id: <20120922.160027.1528491047223302539.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: linux-next: build failure after merge of the final tree
 (net-next tree related)
From: David Miller <davem@davemloft.net>
In-Reply-To: <1348264000.1132.63.camel@pasglop>
References: <1348179764.1132.35.camel@pasglop>
 <20120920.185315.576326460331670020.davem@davemloft.net>
 <1348264000.1132.63.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, mika.westerberg@linux.intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 22 Sep 2012 07:46:40 +1000

> Right, but on ppc, GFP_DMA is a nop (no separate ZONE_DMA, or rather all
> of memory is ZONE_DMA). It's always been like that afaik.
> 
> We could support ISA device limited addressability using the iommu but
> that would involve a map/unmap type API (which I remember we did support
> in the old days by passing NULL to pci_map_*, but we dropped that along
> the way).

I think I'm going to just end up restricting this driver to X86
as was originally suggested.

There seems to be no real consistent Kconfig protection for users
of isa_virt_to_bus() and friends.

We know that ISA_DMA_API doesn't do it, and ISA doesn't do it either
as powerpc also allows that to bet set for CHRP and friends.

Thanks.
