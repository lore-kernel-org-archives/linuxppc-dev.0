Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [149.20.54.216])
 by ozlabs.org (Postfix) with ESMTP id 27FFF2C007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 08:53:22 +1000 (EST)
Date: Thu, 20 Sep 2012 18:53:15 -0400 (EDT)
Message-Id: <20120920.185315.576326460331670020.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: linux-next: build failure after merge of the final tree
 (net-next tree related)
From: David Miller <davem@davemloft.net>
In-Reply-To: <1348179764.1132.35.camel@pasglop>
References: <20120920.164558.2281417114805373564.davem@davemloft.net>
 <20120921081531.67db8a7d0ac1b35426b22c45@canb.auug.org.au>
 <1348179764.1132.35.camel@pasglop>
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
Date: Fri, 21 Sep 2012 08:22:44 +1000

> Hrm, that's ancient gunk, I'll have to dig. We potentially can support
> ISA devices DMA'ing from an ISA bridge... but via the iommu, which means
> isa_virt_to_bus is a non-starter.
> 
> But then, do we really care ? IE. Is there single device that actually
> requires ISA_DMA_API and that is expected to work on any currently
> supported powerpc hw ? :-)
> 
> We don't even support PReP anymore, so that leaves us with what ?

ISA_DMA_API implies a fixed window of addresses which are <= 32-bits
on the bus, which is a hardware requirement of these devices.

isa_virt_to_bus() goes to that physical address, and the expection is
that you use GFP_DMA and thus the physical addresses fit inside of
an unsigned int.

isa_virt_to_bus() basically amounts to a virt-->phys plus a cast.

> Anybody has an objection to turning ISA_DMA_API off ?

Then you can remove all of the DMA api stuff in powerpc's asm/dma.h
but some of it looks like it might be in use.
