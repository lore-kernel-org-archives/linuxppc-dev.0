Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17746DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 21:03:03 +1100 (EST)
Date: Mon, 17 Dec 2007 11:02:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Implement pci_set_dma_mask() in terms of the dma_ops
Message-ID: <20071217100248.GA8433@lst.de>
References: <a3b033f72681dd15badb0218b505512ce1c3a9c8.1197873226.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a3b033f72681dd15badb0218b505512ce1c3a9c8.1197873226.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 17, 2007 at 05:35:53PM +1100, Michael Ellerman wrote:
> To save adding a hook to the dma mapping ops, pci-set_consistent_dma_mask()
> simply calls the dma_set_mask() hook and then copies the new mask into
> dev.coherenet_dma_mask.

How is this supposed to work?  There are various devices around that
want different mask for coherent vs streaming dma mappings, and we need
to tell the iommu that we're setting it for either the former or the
latter.
