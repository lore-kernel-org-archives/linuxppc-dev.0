Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K8pp22HSzDrbV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 15:32:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
In-Reply-To: <20180922150119.GA14761@roeck-us.net>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net>
Date: Tue, 25 Sep 2018 15:32:30 +1000
Message-ID: <87r2hi3zwx.fsf@concordia.ellerman.id.au>
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

Guenter Roeck <linux@roeck-us.net> writes:
> Hi,
>
> On Mon, Aug 27, 2018 at 10:47:11AM +0200, Christoph Hellwig wrote:
>> There is no reason to leave the per-device dma_ops around when
>> deconfiguring a device, so move this code from arm64 into the
>> common code.
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> This patch causes various ppc images to crash in -next due to NULL
> DMA ops in dma_alloc_attrs().

I finally remembered where you autobuilder is :)

https://kerneltests.org/builders/qemu-ppc-next/builds/970/steps/qemubuildcommand_1/logs/stdio

Looks like mac99 at least is failing.

Just reproduced it on my setup.

> Looking into the code, the macio driver tries to instantiate on
> the 0000:f0:0d.0 PCI address (the driver maps to all Apple PCI IDs)
> and fails. This results in a call to arch_teardown_dma_ops(). Later,
> the same device pointer is used to instantiate ohci-pci, which
> crashes in probe because the dma_ops pointer has been cleared.
>
> I don't claim to fully understand the code, but to me it looks like
> the pci device is allocated and waiting for a driver to attach to.
> See arch/powerpc/kernel/pci_of_scan.c:of_create_pci_dev().
> If attaching a driver (here: macio) fails, the same device pointer
> is then reused for the next matching driver until a match is found
> and the device is successfully instantiated. Of course this fails
> quite badly if the device pointer has been scrubbed after the first
> failure.
>
> I don't know if this is generic PCI behavior or ppc specific.
> I am copying pci and ppc maintainers for additional input.

I would guess this is some PPC special sauce  O_o

Will have a look.

cheers
