Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8928DEEDB
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:48 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1ZgZt027627
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:43 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZgD4001493
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:42 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1B1c1007929
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:01 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 3CF0EAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:41 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZfL3015387
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:41 -0500
Date: Tue, 17 Jul 2007 20:35:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 32/61] mpc82xx: Move PQ2 restart and halt functions out of
	mpc8272-specific code.
Message-ID: <20070718013541.GD15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I renamed it from m82xx to pq2 because it won't work on the Integrated
Host Processor line of 82xx chips (i.e. 8240, 8245, and such).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/82xx/Makefile     |    1 +
 arch/powerpc/platforms/82xx/mpc8272ads.c |   27 ++----------------
 arch/powerpc/platforms/82xx/pq2.c        |   44 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/82xx/pq2.h        |    7 +++++
 include/asm-ppc/immap_cpm2.h             |    2 +
 5 files changed, 57 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/platforms/82xx/pq2.c
 create mode 100644 arch/powerpc/platforms/82xx/pq2.h

diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index 881a3f6..6049640 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -3,3 +3,4 @@
 #
 obj-$(CONFIG_PPC_82xx) += mpc82xx.o
 obj-$(CONFIG_MPC8272ADS) += mpc8272ads.o
+obj-$(CONFIG_CPM2) += pq2.o
diff --git a/arch/powerpc/platforms/82xx/mpc8272ads.c b/arch/powerpc/platforms/82xx/mpc8272ads.c
index fbf9c67..cd14a48 100644
--- a/arch/powerpc/platforms/82xx/mpc8272ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272ads.c
@@ -2,7 +2,6 @@
  * MPC8272ADS setup and early boot code plus other random bits.
  *
  * Author: Vitaly Bordug <vbordug@ru.mvista.com>
- * m82xx_restart fix by Wade Farnsworth <wfarnsworth@mvista.com>
  *
  * Copyright (c) 2006 MontaVista Software, Inc.
  *
@@ -42,6 +41,7 @@
 #include <asm/mpc8260.h>
 #include <asm/irq.h>
 #include <mm/mmu_decl.h>
+#include <platforms/82xx/pq2.h>
 #include <asm/prom.h>
 #include <asm/cpm2.h>
 #include <asm/udbg.h>
@@ -603,27 +603,6 @@ static int __init mpc8272ads_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,mpc8272ads");
 }
 
-#define RMR_CSRE 0x00000001
-static void m82xx_restart(char *cmd)
-{
-	__volatile__ unsigned char dummy;
-
-	local_irq_disable();
-	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
-
-	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
-	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
-	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
-	printk("Restart failed\n");
-	while (1) ;
-}
-
-static void m82xx_halt(void)
-{
-	local_irq_disable();
-	while (1) ;
-}
-
 define_machine(mpc8272ads)
 {
 	.name = "Freescale MPC8272ADS",
@@ -633,6 +612,6 @@ define_machine(mpc8272ads)
 	.show_cpuinfo = m82xx_show_cpuinfo,
 	.get_irq = cpm2_get_irq,
 	.calibrate_decr = m82xx_calibrate_decr,
-	.restart = m82xx_restart,
-	.halt = m82xx_halt,
+	.restart = pq2_restart,
+	.halt = pq2_halt,
 };
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
new file mode 100644
index 0000000..e58980d
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -0,0 +1,44 @@
+/*
+ * Common PowerQUICC II code.
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ * Copyright (c) 2007 Freescale Semiconductor
+ *
+ * Based on code by Vitaly Bordug <vbordug@ru.mvista.com>
+ * pq2_restart fix by Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright (c) 2006 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/cpm2.h>
+#include <asm/io.h>
+#include <asm/system.h>
+
+#include <platforms/82xx/pq2.h>
+
+#define RMR_CSRE 0x00000001
+
+void pq2_restart(char *cmd)
+{
+	local_irq_disable();
+	cpm2_immr->im_clkrst.car_rmr |= RMR_CSRE;
+
+	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
+	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
+	in_8(&cpm2_immr->im_clkrst.res[0]);
+
+	printk("Restart failed\n");
+	while (1)
+		;
+}
+
+void pq2_halt(void)
+{
+	local_irq_disable();
+	while (1)
+		;
+}
diff --git a/arch/powerpc/platforms/82xx/pq2.h b/arch/powerpc/platforms/82xx/pq2.h
new file mode 100644
index 0000000..3c9620f
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2.h
@@ -0,0 +1,7 @@
+#ifndef _PQ2_H
+#define _PQ2_H
+
+void pq2_restart(char *cmd);
+void pq2_halt(void);
+
+#endif
diff --git a/include/asm-ppc/immap_cpm2.h b/include/asm-ppc/immap_cpm2.h
index 3c23d9c..8795bcc 100644
--- a/include/asm-ppc/immap_cpm2.h
+++ b/include/asm-ppc/immap_cpm2.h
@@ -10,6 +10,8 @@
 #ifndef __IMMAP_CPM2__
 #define __IMMAP_CPM2__
 
+#include <linux/types.h>
+
 /* System configuration registers.
 */
 typedef	struct sys_82xx_conf {
-- 
1.5.0.3
