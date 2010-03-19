Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id D488CB7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 05:32:53 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v5 02/10] swiotlb: make swiotlb_bounce() __weak
Date: Fri, 19 Mar 2010 19:32:18 +0100
Message-Id: <1269023546-25534-3-git-send-email-albert_herranz@yahoo.es>
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

This patch converts swiotlb_bounce() into a weak function making it
overloadable by platform support code.

This will be used later to support the Nintendo Wii video game console,
which is a NOT_COHERENT_CACHE platform and requires explicit cache handling
when dealing with the swiotlb bounce buffers.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 lib/swiotlb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index ab1622a..9ce5cd2 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -328,7 +328,7 @@ EXPORT_SYMBOL_GPL(is_swiotlb_buffer);
 /*
  * Bounce: copy the swiotlb buffer back to the original dma location
  */
-void swiotlb_bounce(phys_addr_t phys, char *dma_addr, size_t size,
+void __weak swiotlb_bounce(phys_addr_t phys, char *dma_addr, size_t size,
 			   enum dma_data_direction dir)
 {
 	unsigned long pfn = PFN_DOWN(phys);
-- 
1.6.3.3
