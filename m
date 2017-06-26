Return-Path: <tushar.n.dave@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxNTC3Sp9zDr2d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 08:07:27 +1000 (AEST)
Subject: Re: clean up and modularize arch dma_mapping interface V2
To: Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mips@linux-mips.org, linux-samsung-soc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 x86@kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org,
 openrisc@lists.librecores.org, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20170616181059.19206-1-hch@lst.de>
 <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
 <20170624071855.GD14580@lst.de>
 <1498318616.31581.87.camel@kernel.crashing.org>
 <20170626094739.GB13981@lst.de>
From: tndave <tushar.n.dave@oracle.com>
Message-ID: <91360640-546b-edab-9f4a-952c7a1d0061@oracle.com>
Date: Mon, 26 Jun 2017 15:06:25 -0700
MIME-Version: 1.0
In-Reply-To: <20170626094739.GB13981@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/26/2017 02:47 AM, Christoph Hellwig wrote:
> On Sat, Jun 24, 2017 at 10:36:56AM -0500, Benjamin Herrenschmidt wrote:
>> I think we still need to do it. For example we have a bunch new "funky"
>> cases.
> 
> I have no plan to do away with the selection - I just want a better
> interface than the current one.
I agree we need better interface than the current one.
Like Benjamin mentioned cases for powerpc , sparc also need some special
treatment for ATU IOMMU depending on device's DMA mask.

For sparc, I am in process of enabling one or more dedicated IOTSB (I/O
Translation Storage Buffer) per PCI BDF (contrary to current design
where all PCI device under root complex share a 32bit and/or 64bit IOTSB
depending on 32bit and/or 64bit DMA). I am planning to use DMA set mask
APIs as hook where based on device's dma mask values (dma_mask and
coherent_dma_mask) one or more IOTSB resource will be allocated (and
released [1]).

Without set_dma_mask ops, I can still rely on HAVE_ARCH_DMA_SET_MASK and
dma_supported() that allows me to distinguish if device is setting
its streaming dma_mask and coherent_dma_mask respectively.

-Tushar

[1] By default, every PCI BDF will have one dedicated 32bit IOTSB. This
is to support default case where some device drivers even don't bother
to set DMA mask but instead are fine with default 32bit mask.
A 64bit IOTSB will be allocated when device request 64bit dma_mask.
However if device wants 64bit dma mask for both coherent and
non-coherent, a default 32bit IOTSB will be released as well. Wasting an
IOTSB is not a good idea because there is a hard limit on max number of
IOTSB per guest domain per root complex.


> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
