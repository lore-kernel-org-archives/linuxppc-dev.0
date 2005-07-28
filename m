Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1C0167DDE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 07:57:10 +1000 (EST)
Date: Thu, 28 Jul 2005 06:14:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Message-ID: <20050728091439.GC6101@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] 8xx: using dma_alloc_coherent() instead consistent_alloc()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


From: Aristeu Sergio Rozanski Filho <aris@conectiva.com.br>

8xx: using dma_alloc_coherent() instead consistent_alloc()

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@conectiva.com.br>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Index: 2.6-8xx/arch/ppc/8xx_io/fec.c
===================================================================
--- 2.6-8xx.orig/arch/ppc/8xx_io/fec.c	2005-07-04 11:45:57.000000000 -0300
+++ 2.6-8xx/arch/ppc/8xx_io/fec.c	2005-07-04 11:45:58.000000000 -0300
@@ -1580,7 +1580,7 @@
 	struct fec_enet_private *fep;
 	int i, j, k, err;
 	unsigned char	*eap, *iap, *ba;
-	unsigned long	mem_addr;
+	dma_addr_t	mem_addr;
 	volatile	cbd_t	*bdp;
 	cbd_t		*cbd_base;
 	volatile	immap_t	*immap;
@@ -1645,7 +1645,8 @@
 		printk("FEC initialization failed.\n");
 		return 1;
 	}
-	cbd_base = (cbd_t *)consistent_alloc(GFP_KERNEL, PAGE_SIZE, &mem_addr);
+	cbd_base = (cbd_t *)dma_alloc_coherent(dev->class_dev.dev, PAGE_SIZE,
+					       &mem_addr, GFP_KERNEL);
 
 	/* Set receive and transmit descriptor base.
 	*/
@@ -1662,7 +1663,10 @@
 
 		/* Allocate a page.
 		*/
-		ba = (unsigned char *)consistent_alloc(GFP_KERNEL, PAGE_SIZE, &mem_addr);
+		ba = (unsigned char *)dma_alloc_coherent(dev->class_dev.dev,
+							 PAGE_SIZE,
+							 &mem_addr,
+							 GFP_KERNEL);
 		/* BUG: no check for failure */
 
 		/* Initialize the BD for every fragment in the page.
