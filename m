Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id E52DE2BDB7
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Oct 2004 07:55:26 +1000 (EST)
Date: Sat, 9 Oct 2004 14:55:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20041009145521.A21783@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Configure PPC440GX L2 cache based on CPU rev
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch enables/disables the PPC440GX L2 cache based on
errata which prevents reliable operation on certain CPU
revisions and speed grades.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/platforms/4xx/ocotea.c 1.7 vs edited =====
--- 1.7/arch/ppc/platforms/4xx/ocotea.c	2004-10-08 18:57:01 -07:00
+++ edited/arch/ppc/platforms/4xx/ocotea.c	2004-10-08 19:46:25 -07:00
@@ -81,7 +81,7 @@
 {
 	seq_printf(m, "vendor\t\t: IBM\n");
 	seq_printf(m, "machine\t\t: PPC440GX EVB (Ocotea)\n");
-
+	ibm440gx_show_cpuinfo(m);
 	return 0;
 }
 
@@ -299,15 +299,6 @@
         mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
 #endif
 
-	/*
-	 * Determine various clocks.
-	 * To be completely correct we should get SysClk
-	 * from FPGA, because it can be changed by on-board switches
-	 * --ebs
-	 */
-	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
-	ocp_sys_info.opb_bus_freq = clocks.opb;
-
 	/* Setup TODC access */
 	TODC_INIT(TODC_TYPE_DS1743,
 			0,
@@ -350,8 +341,17 @@
 	if (r3)
 		__res = *(bd_t *)(r3 + KERNELBASE);
 
-	/* Disable L2-Cache due to hardware issues */
-	ibm440gx_l2c_disable();
+	/*
+	 * Determine various clocks.
+	 * To be completely correct we should get SysClk
+	 * from FPGA, because it can be changed by on-board switches
+	 * --ebs
+	 */
+	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+	
+	/* Disable L2-Cache on broken hardware, enable it otherwise */
+	ibm440gx_l2c_setup(&clocks);
 
 	ibm44x_platform_init();
 
===== arch/ppc/syslib/ibm440gx_common.c 1.1 vs edited =====
--- 1.1/arch/ppc/syslib/ibm440gx_common.c	2004-05-14 19:00:24 -07:00
+++ edited/arch/ppc/syslib/ibm440gx_common.c	2004-10-08 19:35:02 -07:00
@@ -171,6 +171,19 @@
 	asm volatile ("sync; isync" ::: "memory");
 }
 
+void __init ibm440gx_l2c_setup(struct ibm44x_clocks* p)
+{
+	/* Disable L2C on rev.A, rev.B and 800MHz version of rev.C,
+	   enable it on all other revisions
+	 */
+	u32 pvr = mfspr(PVR);
+	if (pvr == PVR_440GX_RA || pvr == PVR_440GX_RB ||
+	    (pvr == PVR_440GX_RC && p->cpu > 667000000))
+		ibm440gx_l2c_disable();
+	else
+		ibm440gx_l2c_enable();
+}
+
 int __init ibm440gx_get_eth_grp(void)
 {
 	return (SDR_READ(DCRN_SDR_PFC1) & DCRN_SDR_PFC1_EPS) >> DCRN_SDR_PFC1_EPS_SHIFT;
===== arch/ppc/syslib/ibm440gx_common.h 1.1 vs edited =====
--- 1.1/arch/ppc/syslib/ibm440gx_common.h	2004-05-14 19:00:24 -07:00
+++ edited/arch/ppc/syslib/ibm440gx_common.h	2004-10-08 19:36:03 -07:00
@@ -4,7 +4,7 @@
  * PPC440GX system library
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- * Copyright (c) 2003 Zultys Technologies
+ * Copyright (c) 2003, 2004 Zultys Technologies
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -36,6 +36,9 @@
 
 /* Disable L2 cache */
 void ibm440gx_l2c_disable(void) __init;
+
+/* Enable/disable L2 cache for a particular chip revision */
+void ibm440gx_l2c_setup(struct ibm44x_clocks*) __init;
 
 /* Get Ethernet Group */
 int ibm440gx_get_eth_grp(void) __init;
