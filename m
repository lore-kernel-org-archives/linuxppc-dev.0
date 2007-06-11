Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A3F83DDECC
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 09:36:27 +1000 (EST)
Message-Id: <20070611233354.573564809@arndb.de>
References: <20070611232824.489103547@arndb.de>
Date: Tue, 12 Jun 2007 01:28:32 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 08/10] powerpc: multiplatformize 85xx Kconfig
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The various e500 platforms can be built in a single kernel,
as long as a small conflict in the header files is resolved.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/arch/powerpc/platforms/85xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/85xx/Kconfig
@@ -1,28 +1,27 @@
-choice
-	prompt "Machine Type"
-	depends on PPC_85xx
-	default MPC8540_ADS
-
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC 8540 ADS board
 
 config MPC8560_ADS
 	bool "Freescale MPC8560 ADS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC 8560 ADS board
 
 config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC85xx CDS board
 
 config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 #	select QUICC_ENGINE
 	help
@@ -30,12 +29,11 @@ config MPC85xx_MDS
 
 config MPC8544_DS
 	bool "Freescale MPC8544 DS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8544 DS board
 
-endchoice
-
 config MPC8540
 	bool
 	select PPC_UDBG_16550
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
