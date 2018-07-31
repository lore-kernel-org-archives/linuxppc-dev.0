Return-Path: <jroedel@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fpCM21g4zF14l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 17:36:07 +1000 (AEST)
Date: Tue, 31 Jul 2018 09:36:02 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common
 code
Message-ID: <20180731073602.jbbcr4twd2gnkfoc@suse.de>
References: <20180730073842.16092-1-hch@lst.de>
 <20180730211713.GA45322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730211713.GA45322@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2018 at 04:17:13PM -0500, Bjorn Helgaas wrote:
> [+cc Joerg]
> 
> On Mon, Jul 30, 2018 at 09:38:42AM +0200, Christoph Hellwig wrote:
> > There is nothing arch specific about PCI or dma-debug, so move this
> > call to common code just after registering the bus type.
> 
> I assume that previously, even if the user set CONFIG_DMA_API_DEBUG=y
> we only got PCI DMA debug on powerpc, sh, and x86.  And after this
> patch, we'll get PCI DMA debug on *all* arches?
> 
> If that's true, I'll add a comment to that effect to the commitlog
> since that new functionality might be of interest to other arches.

There should be implicit support for dma-debug for all arches that use
the generic dma_ops code. The dma_debug_add_bus() function just adds the
reporting of pending dma-allocations on driver-unload for a device. 

Regards,

	Joerg
