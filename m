Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8133467B18
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2005 11:10:31 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DQEav-0007qL-TK@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 26 Apr 2005 02:10:33 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc annotations: mpsc 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Usual iomem annotations + NULL noise removal.
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-sent/drivers/serial/mpsc.c RC12-rc3-mpsc/drivers/serial/mpsc.c
--- RC12-rc3-sent/drivers/serial/mpsc.c	Fri Mar 11 15:54:53 2005
+++ RC12-rc3-mpsc/drivers/serial/mpsc.c	Mon Apr 25 19:53:06 2005
@@ -329,8 +329,8 @@
 	mpsc_sdma_cmd(pi, SDMA_SDCM_AR | SDMA_SDCM_AT);
 
 	/* Clear the SDMA current and first TX and RX pointers */
-	mpsc_sdma_set_tx_ring(pi, 0);
-	mpsc_sdma_set_rx_ring(pi, 0);
+	mpsc_sdma_set_tx_ring(pi, NULL);
+	mpsc_sdma_set_rx_ring(pi, NULL);
 
 	/* Disable interrupts */
 	mpsc_sdma_intr_mask(pi, 0xf);
@@ -1540,8 +1540,8 @@
 			MPSC_SDMA_INTR_REG_BLOCK_SIZE);
 	}
 
-	mpsc_shared_regs.mpsc_routing_base = 0;
-	mpsc_shared_regs.sdma_intr_base = 0;
+	mpsc_shared_regs.mpsc_routing_base = NULL;
+	mpsc_shared_regs.sdma_intr_base = NULL;
 
 	mpsc_shared_regs.mpsc_routing_base_p = 0;
 	mpsc_shared_regs.sdma_intr_base_p = 0;
@@ -1678,9 +1678,9 @@
 		release_mem_region(pi->brg_base_p, MPSC_BRG_REG_BLOCK_SIZE);
 	}
 
-	pi->mpsc_base = 0;
-	pi->sdma_base = 0;
-	pi->brg_base = 0;
+	pi->mpsc_base = NULL;
+	pi->sdma_base = NULL;
+	pi->brg_base = NULL;
 
 	pi->mpsc_base_p = 0;
 	pi->sdma_base_p = 0;
diff -urN RC12-rc3-sent/drivers/serial/mpsc.h RC12-rc3-mpsc/drivers/serial/mpsc.h
--- RC12-rc3-sent/drivers/serial/mpsc.h	Fri Mar 11 15:54:53 2005
+++ RC12-rc3-mpsc/drivers/serial/mpsc.h	Mon Apr 25 19:53:06 2005
@@ -83,8 +83,8 @@
 	phys_addr_t mpsc_routing_base_p;
 	phys_addr_t sdma_intr_base_p;
 
-	void *mpsc_routing_base;
-	void *sdma_intr_base;
+	void __iomem *mpsc_routing_base;
+	void __iomem *sdma_intr_base;
 
 	u32 MPSC_MRR_m;
 	u32 MPSC_RCRR_m;
@@ -120,9 +120,9 @@
 	phys_addr_t brg_base_p;
 
 	/* Virtual addresses of various blocks of registers (from platform) */
-	void *mpsc_base;
-	void *sdma_base;
-	void *brg_base;
+	void __iomem *mpsc_base;
+	void __iomem *sdma_base;
+	void __iomem *brg_base;
 
 	/* Descriptor ring and buffer allocations */
 	void *dma_region;
