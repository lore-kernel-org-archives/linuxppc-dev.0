Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 046721A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 07:56:17 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 23 Oct 2015 14:56:16 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 40E183E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:56:13 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9NKsqxZ11600166
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 13:54:52 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9NKuBFI011242
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:56:12 -0600
Date: Fri, 23 Oct 2015 13:56:10 -0700
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
Subject: [PATCH 1/7 v3] dma-mapping: add generic dma_get_page_shift API
Message-ID: <20151023205610.GB10197@linux.vnet.ibm.com>
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

Drivers like NVMe need to be able to determine the page size used for
DMA transfers. Add a new API that defaults to return PAGE_SHIFT on all
architectures.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
v1 -> v2:
  Based upon feedback from Christoph Hellwig, implement the IOMMU page
  size lookup as a generic DMA API, rather than an architecture-specific
  hack.
v2 -> v3:
  Based upon feedback from Christoph Hellwig that not all architectures
  have moved to dma-mapping-common.h, so move the #ifdef and default to
  linux/dma-mapping.h.
---
 include/linux/dma-mapping.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac07ff0..7eaba8d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -95,6 +95,13 @@ static inline u64 dma_get_mask(struct device *dev)
 	return DMA_BIT_MASK(32);
 }
 
+#ifndef HAVE_ARCH_DMA_GET_PAGE_SHIFT
+static inline unsigned long dma_get_page_shift(struct device *dev)
+{
+	return PAGE_SHIFT;
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 #else
-- 
1.9.1
