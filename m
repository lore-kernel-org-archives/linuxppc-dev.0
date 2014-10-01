Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E44A21A1903
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:48:31 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0EC8114012B
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2014 17:48:30 +1000 (EST)
Message-ID: <1412149682.4285.209.camel@pasglop>
Subject: Re: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
Date: Wed, 01 Oct 2014 17:48:02 +1000
In-Reply-To: <1412149289.4285.204.camel@pasglop>
References: <1412129393.4285.195.camel@pasglop>
 <s5htx3o44tv.wl-tiwai@suse.de> <1412149289.4285.204.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Brian King <brking@linux.vnet.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Yijing Wang <wangyijing@huawei.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 17:41 +1000, Benjamin Herrenschmidt wrote:

> I don't like that approach because technically the chip doesn't do
> 64-bit DMA ... it does something like 40 or 48 (might actually depend on
> the chip version) and for all I know it will break on future x86 with
> more memory or other platforms with similar address encodings as
> powerpc...
> 
> The right thing might be to get the exact number of bits and do the
> appropriate dma_set_mask() like the graphics driver does, but that's a
> bit tricky unless we add a DMA mask field in that big array of chips in
> there...

Note that I made the assumption that in the grand scheme of things, HDMI
audio isn't a very big throughput device and thus the extra iommu
mappings (or swiotlb) shouldn't hurt that much. But I may be wrong...

So by all means, let me know what you want done here, but I don't think
CONFIG_PPC is the right thing to do here, especially since this is not
even something that affects all PPCs, but specifically the POWER server
PCI bridges for which we configure a 64-bit window high up in the
address space.

FYI: Basically we setup PCI DMA addresses 0...2G as a 32-bit IOMMU
remapped window and we also configure a "direct map" window higher up
that bypasses the IOMMU and provides a direct linear mapping of RAM for
64-bit capable devices. The problem is that the HW on those server chips
requires that second window to have address bit 59 set. Then based on
the DMA mask, the arch code provide the device with DMA ops that will
either go through the iommu remap window or through the bypass window
based on the DMA mask set by the driver.

Cheers,
Ben.
