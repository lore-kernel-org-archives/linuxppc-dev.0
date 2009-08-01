Return-Path: <BATV+f268737823f173ec3b40+2169+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B3D7AB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 17:55:02 +1000 (EST)
Subject: Re: [PATCH] Stop pci_set_dma_mask() from failing when RAM doesn't
	exceed the mask anyway
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1249079105.1509.95.camel@pasglop>
References: <1249069310.20192.220.camel@macbook.infradead.org>
	<1249079105.1509.95.camel@pasglop>
Content-Type: text/plain
Date: Sat, 01 Aug 2009 08:54:45 +0100
Message-Id: <1249113285.20192.961.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-08-01 at 08:25 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2009-07-31 at 20:41 +0100, David Woodhouse wrote:
> > On an iMac G5, the b43 driver is failing to initialise because trying to
> > set the dma mask to 30-bit fails. Even though there's only 512MiB of RAM
> > in the machine anyway:
> > 	https://bugzilla.redhat.com/show_bug.cgi?id=514787
> > 
> > We should probably let it succeed if the available RAM in the system
> > doesn't exceed the requested limit.
> > 
> > Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> 
> Also, isn't our iommu code smart enough to clamp allocations to the DMA
> mask nowadays ? In that case, we could probably just force iommu on
> always...

We're not using the IOMMU on this box:

PowerMac motherboard: iMac G5
DART: table not allocated, using direct DMA

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
