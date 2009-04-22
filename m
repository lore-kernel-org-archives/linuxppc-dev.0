Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2886BDE0A2
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:45:56 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n3MIjrrq027258
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 13:45:53 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/cpm: Remove some cruft code and defines
Date: Wed, 22 Apr 2009 13:45:53 -0500
Message-Id: <1240425953-27650-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kill of some old defines and macros that we no longer use like
CPM_MAP_ADDR and CPM_IRQ_OFFSET.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/cpm2.h        |    4 ----
 arch/powerpc/platforms/82xx/pq2ads.h   |   13 -------------
 arch/powerpc/platforms/8xx/mpc885ads.h |    4 ----
 arch/powerpc/sysdev/cpm2.c             |    2 +-
 4 files changed, 1 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/cpm2.h b/arch/powerpc/include/asm/cpm2.h
index 0f5e8ff..990ff19 100644
--- a/arch/powerpc/include/asm/cpm2.h
+++ b/arch/powerpc/include/asm/cpm2.h
@@ -14,10 +14,6 @@
 #include <asm/cpm.h>
 #include <sysdev/fsl_soc.h>
 
-#ifdef CONFIG_PPC_85xx
-#define CPM_MAP_ADDR (get_immrbase() + 0x80000)
-#endif
-
 /* CPM Command register.
 */
 #define CPM_CR_RST	((uint)0x80000000)
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index 984db42..6cf0f97 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -24,10 +24,6 @@
 
 #include <linux/seq_file.h>
 
-/* Backword-compatibility stuff for the drivers */
-#define CPM_MAP_ADDR		((uint)0xf0000000)
-#define CPM_IRQ_OFFSET 0
-
 /* The ADS8260 has 16, 32-bit wide control/status registers, accessed
  * only on word boundaries.
  * Not all are used (yet), or are interesting to us (yet).
@@ -44,14 +40,5 @@
 #define BCSR3_FETHIEN2		((uint)0x10000000)      /* 0 == enable*/
 #define BCSR3_FETH2_RST		((uint)0x80000000)      /* 0 == reset */
 
-/* cpm serial driver works with constants below */
-
-#define SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
-#define SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
-#define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
-
 #endif /* __MACH_ADS8260_DEFS */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/8xx/mpc885ads.h b/arch/powerpc/platforms/8xx/mpc885ads.h
index a507666..19412f7 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads.h
+++ b/arch/powerpc/platforms/8xx/mpc885ads.h
@@ -17,10 +17,6 @@
 
 #include <sysdev/fsl_soc.h>
 
-#define MPC8xx_CPM_OFFSET	(0x9c0)
-#define CPM_MAP_ADDR		(get_immrbase() + MPC8xx_CPM_OFFSET)
-#define CPM_IRQ_OFFSET		16     // for compability with cpm_uart driver
-
 /* Bits of interest in the BCSRs.
  */
 #define BCSR1_ETHEN		((uint)0x20000000)
diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index fd969f0..eb59272 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -61,7 +61,7 @@ EXPORT_SYMBOL(cpm2_immr);
 void __init cpm2_reset(void)
 {
 #ifdef CONFIG_PPC_85xx
-	cpm2_immr = ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
+	cpm2_immr = ioremap(get_immrbase() + 0x80000, CPM_MAP_SIZE);
 #else
 	cpm2_immr = ioremap(get_immrbase(), CPM_MAP_SIZE);
 #endif
-- 
1.6.0.6
