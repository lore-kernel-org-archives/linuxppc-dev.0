Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id C8C33DDFF4
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 10:09:13 +1000 (EST)
Message-Id: <20070616000619.096176701@arndb.de>
References: <20070616000511.712667424@arndb.de>
Date: Sat, 16 Jun 2007 02:05:19 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 8/9] fix conflicting mpc85xx board headers
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In order to allow multiplatform kernels, we can not have header
files that define the same symbols. Probably these board specific
headers should just go away entirely, but for the easiest fix
is to rename the conflicting symbols.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_ads.h
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.h
@@ -29,14 +29,14 @@
 #define MPC85xx_CPM_OFFSET	(0x80000)
 
 #define CPM_MAP_ADDR		(get_immrbase() + MPC85xx_CPM_OFFSET)
-#define CPM_IRQ_OFFSET		60
+#define MPC85xxADS_CPM_IRQ_OFFSET		60
 
-#define SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
-#define SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
+#define SIU_INT_SMC1		((uint)0x04+MPC85xxADS_CPM_IRQ_OFFSET)
+#define SIU_INT_SMC2		((uint)0x05+MPC85xxADS_CPM_IRQ_OFFSET)
+#define SIU_INT_SCC1		((uint)0x28+MPC85xxADS_CPM_IRQ_OFFSET)
+#define SIU_INT_SCC2		((uint)0x29+MPC85xxADS_CPM_IRQ_OFFSET)
+#define SIU_INT_SCC3		((uint)0x2a+MPC85xxADS_CPM_IRQ_OFFSET)
+#define SIU_INT_SCC4		((uint)0x2b+MPC85xxADS_CPM_IRQ_OFFSET)
 
 /* FCC1 Clock Source Configuration.  These can be
  * redefined in the board specific file.
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.h
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.h
@@ -36,7 +36,7 @@
 #define PIRQ1A			MPC85xx_IRQ_EXT11
 
 #define NR_8259_INTS		16
-#define CPM_IRQ_OFFSET		NR_8259_INTS
+#define MPC85xxCDS_CPM_IRQ_OFFSET		NR_8259_INTS
 
 #define MPC85xx_OPENPIC_IRQ_OFFSET	80
 

--
