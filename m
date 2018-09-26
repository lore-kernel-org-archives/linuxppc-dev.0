Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42KvjV6Z0LzF3JJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 20:45:34 +1000 (AEST)
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
To: Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Cc: iommu@lists.linux-foundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net>
 <20180925201619.GB8413@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fe8bae9a-10d1-ca88-158d-5caf9aa80885@arm.com>
Date: Wed, 26 Sep 2018 11:45:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180925201619.GB8413@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/09/18 21:16, Christoph Hellwig wrote:
> Looking at the code I think this commit is simply broken for
> architectures not using arch_setup_dma_ops, but instead setting up
> the dma ops through arch specific magic.
> 
> I'll revert the patch.

Ugh, sorry about missing that too. Ack to a revert - thinking about 
those PPC symptoms, it might actually be that other architectures could 
also get into the same pickle just by unbinding and rebinding a driver 
(e.g. switching to VFIO then back again).

Robin.
