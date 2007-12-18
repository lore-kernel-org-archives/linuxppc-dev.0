Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79067DDE04
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 11:40:46 +1100 (EST)
Subject: Re: [PATCH] Implement pci_set_dma_mask() in terms of the dma_ops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20071217100248.GA8433@lst.de>
References: <a3b033f72681dd15badb0218b505512ce1c3a9c8.1197873226.git.michael@ellerman.id.au>
	<20071217100248.GA8433@lst.de>
Content-Type: text/plain
Date: Tue, 18 Dec 2007 11:40:22 +1100
Message-Id: <1197938422.13400.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-17 at 11:02 +0100, Christoph Hellwig wrote:
> On Mon, Dec 17, 2007 at 05:35:53PM +1100, Michael Ellerman wrote:
> > To save adding a hook to the dma mapping ops, pci-set_consistent_dma_mask()
> > simply calls the dma_set_mask() hook and then copies the new mask into
> > dev.coherenet_dma_mask.
> 
> How is this supposed to work?  There are various devices around that
> want different mask for coherent vs streaming dma mappings, and we need
> to tell the iommu that we're setting it for either the former or the
> latter.

I don't think we ever supported that difference. Too broken HW for us.

We don't use coherent_dma_mask for anything at the moment on powerpc.

Ben.
