Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5025867E05
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2005 19:56:33 +1000 (EST)
Date: Tue, 2 Aug 2005 11:56:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: paulus@samba.org, akpm@osdl.org
Message-ID: <20050802095625.GB32585@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix asm-ppc/dma-mapping.h sparse warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

GFP flags must be passed as unisgned int __nocast these days, else we'll get
tons of sparse warnings in every driver.


Index: linux-2.6/include/asm-ppc/dma-mapping.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/dma-mapping.h	2005-07-28 19:32:32.000000000 +0200
+++ linux-2.6/include/asm-ppc/dma-mapping.h	2005-07-31 16:22:20.000000000 +0200
@@ -60,7 +60,8 @@
 }
 
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t * dma_handle, int gfp)
+				       dma_addr_t * dma_handle,
+				       unsigned int __nocast gfp)
 {
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	return __dma_alloc_coherent(size, dma_handle, gfp);
