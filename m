Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpv6D2BHLzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 18:43:32 +1000 (AEST)
Date: Fri, 16 Jun 2017 10:43:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/44] arm: implement ->mapping_error
Message-ID: <20170616084328.GC10582@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-26-hch@lst.de>
 <20170608144313.GL4902@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608144313.GL4902@n2100.armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 08, 2017 at 03:43:14PM +0100, Russell King - ARM Linux wrote:
> BOn Thu, Jun 08, 2017 at 03:25:50PM +0200, Christoph Hellwig wrote:
> > +static int dmabounce_mapping_error(struct device *dev, dma_addr_t dma_addr)
> > +{
> > +	if (dev->archdata.dmabounce)
> > +		return 0;
> 
> I'm not convinced that we need this check here:
> 
>         dev->archdata.dmabounce = device_info;
>         set_dma_ops(dev, &dmabounce_ops);
> 
> There shouldn't be any chance of dev->archdata.dmabounce being NULL if
> the dmabounce_ops has been set as the current device DMA ops.  So I
> think that test can be killed.

Ok, I'll fix it up.
