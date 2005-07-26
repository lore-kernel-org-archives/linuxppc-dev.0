Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4A76E67D25
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jul 2005 16:52:14 +1000 (EST)
Date: Mon, 25 Jul 2005 23:52:12 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050726065212.GB2906@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: fix dma_map_page() to use page_to_bus()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt,

the following trivial patch changes dma_map_page() to use 
page_to_bus() instead of open-coding it (incorrectly in some cases).

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/include/asm-ppc/dma-mapping.h b/include/asm-ppc/dma-mapping.h
--- a/include/asm-ppc/dma-mapping.h
+++ b/include/asm-ppc/dma-mapping.h
@@ -117,7 +117,7 @@ dma_map_page(struct device *dev, struct 
 
 	__dma_sync_page(page, offset, size, direction);
 
-	return (page - mem_map) * PAGE_SIZE + PCI_DRAM_OFFSET + offset;
+	return page_to_bus(page) + offset;
 }
 
 /* We do nothing. */
