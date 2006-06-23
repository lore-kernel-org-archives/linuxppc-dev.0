Return-Path: <arnd@arndb.de>
Message-Id: <20060623185825.013037000@klappe.arndb.de>
References: <20060623185746.037897000@klappe.arndb.de>
Date: Fri, 23 Jun 2006 20:57:50 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [PATCH 4/5] spufs: fix class0 interrupt assignment
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The class zero interrupt handling for spus
was confusing alignment and error interrupts,
so swap them.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linus-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linus-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -168,12 +168,12 @@ spu_irq_class_0_bottom(struct spu *spu)
 
 	stat &= mask;
 
-	if (stat & 1) /* invalid MFC DMA */
-		__spu_trap_invalid_dma(spu);
-
-	if (stat & 2) /* invalid DMA alignment */
+	if (stat & 1) /* invalid DMA alignment */
 		__spu_trap_dma_align(spu);
 
+	if (stat & 2) /* invalid MFC DMA */
+		__spu_trap_invalid_dma(spu);
+
 	if (stat & 4) /* error on SPU */
 		__spu_trap_error(spu);
 

--
