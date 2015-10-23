Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D218C1A0BCC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 07:58:03 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 23 Oct 2015 14:58:01 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 501CF19D8048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:46:03 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9NKummI10551776
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 13:56:48 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9NKvpXX022617
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:57:53 -0600
Date: Fri, 23 Oct 2015 13:57:49 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151023205749.GD10197@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Sorry, subject should have been 0/7!]

On 23.10.2015 [13:54:20 -0700], Nishanth Aravamudan wrote:
> We received a bug report recently when DDW (64-bit direct DMA on Power)
> is not enabled for NVMe devices. In that case, we fall back to 32-bit
> DMA via the IOMMU, which is always done via 4K TCEs (Translation Control
> Entries).
> 
> The NVMe device driver, though, assumes that the DMA alignment for the
> PRP entries will match the device's page size, and that the DMA aligment
> matches the kernel's page aligment. On Power, the the IOMMU page size,
> as mentioned above, can be 4K, while the device can have a page size of
> 8K, while the kernel has a page size of 64K. This eventually trips the
> BUG_ON in nvme_setup_prps(), as we have a 'dma_len' that is a multiple
> of 4K but not 8K (e.g., 0xF000).
> 
> In this particular case, and generally, we want to use the IOMMU's page
> size for the default device page size, rather than the kernel's page
> size.
> 
> This series consists of five patches:
> 
> 1) add a generic dma_get_page_shift implementation that just returns
> PAGE_SHIFT
> 2) override the generic implementation on Power to use the IOMMU table's
> page shift if available
> 3) allow further specific overriding on power with machdep platform
> overrides
> 4) use the machdep override on pseries, as the DDW code puts the TCE
> shift in a special property and there is no IOMMU table available
> 5) move some sparc code around to make IOMMU_PAGE_SHIFT available in
> include/asm
> 6) override the generic implementation on sparce to use IOMMU_PAGE_SHIFT
> 7) leverage the new API in the NVMe driver
> 
> With these patches, a NVMe device survives our internal hardware
> exerciser; the kernel BUGs within a few seconds without the patch.
> 
>  arch/powerpc/include/asm/dma-mapping.h |  3 +++
>  arch/powerpc/include/asm/machdep.h     |  3 ++-
>  arch/powerpc/kernel/dma.c              | 11 +++++++++++
>  arch/powerpc/platforms/pseries/iommu.c | 36 ++++++++++++++++++++++++++++++++++++
>  arch/sparc/include/asm/dma-mapping.h   |  8 ++++++++
>  arch/sparc/include/asm/iommu_common.h  | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/iommu.c              |  2 +-
>  arch/sparc/kernel/iommu_common.h       | 51 ---------------------------------------------------
>  arch/sparc/kernel/pci_psycho.c         |  2 +-
>  arch/sparc/kernel/pci_sabre.c          |  2 +-
>  arch/sparc/kernel/pci_schizo.c         |  2 +-
>  arch/sparc/kernel/pci_sun4v.c          |  2 +-
>  arch/sparc/kernel/psycho_common.c      |  2 +-
>  arch/sparc/kernel/sbus.c               |  3 +--
>  drivers/block/nvme-core.c              |  3 ++-
>  include/linux/dma-mapping.h            |  7 +++++++
>  16 files changed, 127 insertions(+), 61 deletions(-)
> 
> v1 -> v2:
>   Based upon feedback from Christoph Hellwig, rather than using an
>   arch-specific hack, expose the DMA page shift via a generic DMA API and
>   override it on Power as needed.
> v2 -> v3:
>   Based upon feedback from Christoph Hellwig, put the generic
>   implementation in include/linux/dma-mapping.h, since not all archs use
>   include/asm-generic/dma-mapping-common.h.
>   Add sparc implementation, as that arch seems to have a different IOMMU
>   page size.
