Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Kl955SfzzF3Dr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 14:20:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
In-Reply-To: <20180925201619.GB8413@lst.de>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net>
 <20180925201619.GB8413@lst.de>
Date: Wed, 26 Sep 2018 14:20:19 +1000
Message-ID: <87r2hgga9o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christoph Hellwig <hch@lst.de> writes:

> Looking at the code I think this commit is simply broken for
> architectures not using arch_setup_dma_ops, but instead setting up
> the dma ops through arch specific magic.

I arch_setup_dma_ops() called from of_dma_configure(), but
pci_dma_configure() doesn't call that for this device:

static int pci_dma_configure(struct device *dev)
{
	...
	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
	    bridge->parent->of_node) {
		ret = of_dma_configure(dev, bridge->parent->of_node, true);

bridge->parent is NULL.

So I don't think arch_setup_dma_ops() would help here?

> I'll revert the patch.

Thanks.

cheers
