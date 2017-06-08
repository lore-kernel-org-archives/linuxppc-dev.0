Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk7Td0JtXzDqPP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 00:43:47 +1000 (AEST)
Date: Thu, 8 Jun 2017 15:43:14 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <20170608144313.GL4902@n2100.armlinux.org.uk>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-26-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608132609.32662-26-hch@lst.de>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BOn Thu, Jun 08, 2017 at 03:25:50PM +0200, Christoph Hellwig wrote:
> +static int dmabounce_mapping_error(struct device *dev, dma_addr_t dma_addr)
> +{
> +	if (dev->archdata.dmabounce)
> +		return 0;

I'm not convinced that we need this check here:

        dev->archdata.dmabounce = device_info;
        set_dma_ops(dev, &dmabounce_ops);

There shouldn't be any chance of dev->archdata.dmabounce being NULL if
the dmabounce_ops has been set as the current device DMA ops.  So I
think that test can be killed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
