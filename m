Return-Path: <markn@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0408DDE20
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:51:04 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m3U7oRWu031848
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:50:27 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3U7rmn7248532
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:53:49 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3U7nx8s007879
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:49:59 +1000
Message-Id: <20080430074954.624893875@au1.ibm.com>
References: <20080430074621.104662132@au1.ibm.com>
Date: Wed, 30 Apr 2008 17:46:25 +1000
From: markn@au1.ibm.com
To: olof@lixom.net
Subject: [RFC] [PATCH 4/5] [POWERPC] Move device_to_mask() to dma-mapping.h
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move device_to_mask() to dma-mapping.h because we need to use it from
outside dma_64.c in a later patch.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/kernel/dma_64.c      |    9 ---------
 include/asm-powerpc/dma-mapping.h |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

Index: upstream/arch/powerpc/kernel/dma_64.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/dma_64.c
+++ upstream/arch/powerpc/kernel/dma_64.c
@@ -15,15 +15,6 @@
  * Generic iommu implementation
  */
 
-static inline unsigned long device_to_mask(struct device *dev)
-{
-	if (dev->dma_mask && *dev->dma_mask)
-		return *dev->dma_mask;
-	/* Assume devices without mask can take 32 bit addresses */
-	return 0xfffffffful;
-}
-
-
 /* Allocates a contiguous real buffer and creates mappings over it.
  * Returns the virtual address of the buffer and sets dma_handle
  * to the dma address (mapping) of the first page.
Index: upstream/include/asm-powerpc/dma-mapping.h
===================================================================
--- upstream.orig/include/asm-powerpc/dma-mapping.h
+++ upstream/include/asm-powerpc/dma-mapping.h
@@ -45,6 +45,15 @@ extern void __dma_sync_page(struct page 
 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
 #ifdef CONFIG_PPC64
+
+static inline unsigned long device_to_mask(struct device *dev)
+{
+	if (dev->dma_mask && *dev->dma_mask)
+		return *dev->dma_mask;
+	/* Assume devices without mask can take 32 bit addresses */
+	return 0xfffffffful;
+}
+
 /*
  * DMA operations are abstracted for G5 vs. i/pSeries, PCI vs. VIO
  */

-- 
