Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32AD61A055C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 06:10:09 +1000 (AEST)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 14:10:07 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B08881FF004C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 13:58:08 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92K8h5E53018654
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 13:08:43 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92K9smB029095
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 14:09:56 -0600
Date: Fri, 2 Oct 2015 13:09:53 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151002200953.GB40695@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151002171606.GA41011@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We received a bug report recently when DDW (64-bit direct DMA on Power)
is not enabled for NVMe devices. In that case, we fall back to 32-bit
DMA via the IOMMU, which is always done via 4K TCEs (Translation Control
Entries).
 
The NVMe device driver, though, assumes that the DMA alignment for the
PRP entries will match the device's page size, and that the DMA aligment
matches the kernel's page aligment. On Power, the the IOMMU page size,
as mentioned above, can be 4K, while the device can have a page size of
8K, while the kernel has a page size of 64K. This eventually trips the
BUG_ON in nvme_setup_prps(), as we have a 'dma_len' that is a multiple
of 4K but not 8K (e.g., 0xF000).
 
In this particular case, and generally, we want to use the IOMMU's page
size for the default device page size, rather than the kernel's page
size.
 
This series consists of five patches:

1) add a generic dma_get_page_shift implementation that just returns
PAGE_SHIFT
2) override the generic implementation on Power to use the IOMMU table's
page shift if available
3) allow further specific overriding on power with machdep platform
overrides
4) use the machdep override on pseries, as the DDW code puts the TCE
shift in a special property and there is no IOMMU table available
5) leverage the new API in the NVMe driver
 
With these patches, a NVMe device survives our internal hardware
exerciser; the kernel BUGs within a few seconds without the patch.

 arch/powerpc/include/asm/dma-mapping.h   |  3 +++
 arch/powerpc/include/asm/machdep.h       |  3 ++-
 arch/powerpc/kernel/dma.c                | 11 +++++++++++
 arch/powerpc/platforms/pseries/iommu.c   | 36 ++++++++++++++++++++++++++++++++++++
 drivers/block/nvme-core.c                |  3 ++-
 include/asm-generic/dma-mapping-common.h |  7 +++++++
 6 files changed, 61 insertions(+), 2 deletions(-)

v1 -> v2:
  Based upon feedback from Christoph Hellwig, rather than using an
  arch-specific hack, expose the DMA page shift via a generic DMA API and
  override it on Power as needed.
