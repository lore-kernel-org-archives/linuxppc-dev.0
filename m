Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id 3AD91B7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 05:32:55 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v5 04/10] powerpc: add min_direct_dma_addr
Date: Fri, 19 Mar 2010 19:32:20 +0100
Message-Id: <1269023546-25534-5-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
References: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>, konrad.wilk@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds min_direct_dma_addr to struct dev_archdata.

min_direct_dma_addr can be used to define which is the minimum address
suitable for a DMA operation.
dma_capable() is updated to use this information in the SWIOTLB case.

This will be used later to support the Nintendo Wii video game console
which has limitations performing DMA to memory below 0x10000000 (MEM1).

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/include/asm/device.h      |    1 +
 arch/powerpc/include/asm/dma-mapping.h |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 6d94d27..23f0009 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -27,6 +27,7 @@ struct dev_archdata {
 
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
+	dma_addr_t		min_direct_dma_addr;
 #endif
 };
 
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 18ecec8..eda3ebe 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -193,6 +193,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 	if (sd->max_direct_dma_addr && addr + size > sd->max_direct_dma_addr)
 		return 0;
+	if (sd->min_direct_dma_addr && addr < sd->min_direct_dma_addr)
+		return 0;
 #endif
 
 	if (!dev->dma_mask)
-- 
1.6.3.3
