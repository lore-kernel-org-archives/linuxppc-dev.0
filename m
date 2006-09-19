Return-Path: <Amy.Fong@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 4082867B59
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 18:56:00 +1000 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k8J37SY1020505
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Sep 2006 20:07:29 -0700 (PDT)
Received: from afong by lucciola with local (Exim 4.63)
	(envelope-from <amy.fong@windriver.com>) id 1GPVxE-0006Up-T1
	for linuxppc-dev@ozlabs.org; Mon, 18 Sep 2006 23:07:24 -0400
Date: Mon, 18 Sep 2006 23:07:24 -0400
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix compile error in sbc8560
Message-ID: <20060919030724.GA24962@lucciola.windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Amy Fong <amy.fong@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following fixes compile errors in sbc8560.

Signed-off-by: Amy Fong <amy.fong@windriver.com>


Index: linux-2.6.18-rc7/arch/ppc/platforms/85xx/sbc8560.h
===================================================================
--- linux-2.6.18-rc7.orig/arch/ppc/platforms/85xx/sbc8560.h
+++ linux-2.6.18-rc7/arch/ppc/platforms/85xx/sbc8560.h
@@ -14,6 +14,7 @@
 #define __MACH_SBC8560_H__
  
 #include <platforms/85xx/sbc85xx.h>
+#include <asm/irq.h>
 
 #define CPM_MAP_ADDR    (CCSRBAR + MPC85xx_CPM_OFFSET)
  
Index: linux-2.6.18-rc7/arch/ppc/platforms/85xx/sbc85xx.h
===================================================================
--- linux-2.6.18-rc7.orig/arch/ppc/platforms/85xx/sbc85xx.h
+++ linux-2.6.18-rc7/arch/ppc/platforms/85xx/sbc85xx.h
@@ -49,4 +49,22 @@
 
 #define MPC85XX_PCI1_IO_SIZE	0x01000000
 
+/* FCC1 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK9-12 */
+#define F1_RXCLK       12
+#define F1_TXCLK       11
+
+/* FCC2 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK13-16 */
+#define F2_RXCLK       13
+#define F2_TXCLK       14
+
+/* FCC3 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK13-16 */
+#define F3_RXCLK       15
+#define F3_TXCLK       16
+
 #endif /* __PLATFORMS_85XX_SBC85XX_H__ */
