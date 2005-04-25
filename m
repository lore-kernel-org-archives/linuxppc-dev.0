Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1FC567B3B
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 16:05:03 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPwhw-0007SQ-3f@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Mon, 25 Apr 2005 07:04:36 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc iomem annotations: mv643xx_eth
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	void * __iomem replaced with intended void __iomem *.
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-ppc-signal/drivers/net/mv643xx_eth.c RC12-rc3-mveth/drivers/net/mv643xx_eth.c
--- RC12-rc3-ppc-signal/drivers/net/mv643xx_eth.c	Wed Apr 20 21:25:38 2005
+++ RC12-rc3-mveth/drivers/net/mv643xx_eth.c	Mon Apr 25 01:36:36 2005
@@ -99,7 +99,7 @@
 
 static inline u32 mv_read(int offset)
 {
-	void *__iomem reg_base;
+	void __iomem *reg_base;
 
 	reg_base = mv643xx_eth_shared_base - MV643XX_ETH_SHARED_REGS;
 
@@ -108,7 +108,7 @@
 
 static inline void mv_write(int offset, u32 data)
 {
-	void * __iomem reg_base;
+	void __iomem *reg_base;
 
 	reg_base = mv643xx_eth_shared_base - MV643XX_ETH_SHARED_REGS;
 	writel(data, reg_base + offset);
