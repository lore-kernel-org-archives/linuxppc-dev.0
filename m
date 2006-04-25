Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6D09867A03
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Apr 2006 18:22:47 +1000 (EST)
Date: Tue, 25 Apr 2006 01:22:44 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc32: add 440GX erratum 440_43 workaround
Message-ID: <20060425082244.GB20228@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch adds workaround for PPC 440GX erratum 440_43. According to 
this erratum spurious MachineChecks (caused by L1 cache parity) can 
happen during DataTLB miss processing. We disable L1 cache parity 
checking for 440GX rev.C and rev.F

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
index f841972..554776d 100644
--- a/arch/ppc/platforms/4xx/ocotea.c
+++ b/arch/ppc/platforms/4xx/ocotea.c
@@ -331,7 +331,7 @@ static void __init ocotea_init(void)
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
-	ibm44x_platform_init(r3, r4, r5, r6, r7);
+	ibm440gx_platform_init(r3, r4, r5, r6, r7);
 
 	ppc_md.setup_arch = ocotea_setup_arch;
 	ppc_md.show_cpuinfo = ocotea_show_cpuinfo;
diff --git a/arch/ppc/syslib/ibm440gx_common.c b/arch/ppc/syslib/ibm440gx_common.c
index a7dd55f..f6cc168 100644
--- a/arch/ppc/syslib/ibm440gx_common.c
+++ b/arch/ppc/syslib/ibm440gx_common.c
@@ -2,7 +2,7 @@
  * PPC440GX system library
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- * Copyright (c) 2003, 2004 Zultys Technologies
+ * Copyright (c) 2003 - 2006 Zultys Technologies
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -282,3 +282,14 @@ int ibm440gx_show_cpuinfo(struct seq_fil
 	return 0;
 }
 
+void __init ibm440gx_platform_init(unsigned long r3, unsigned long r4,
+				   unsigned long r5, unsigned long r6,
+				   unsigned long r7)
+{
+	/* Erratum 440_43 workaround, disable L1 cache parity checking */
+	if (!strcmp(cur_cpu_spec->cpu_name, "440GX Rev. C") ||
+	    !strcmp(cur_cpu_spec->cpu_name, "440GX Rev. F"))
+		mtspr(SPRN_CCR1, mfspr(SPRN_CCR1) | CCR1_DPC);
+
+	ibm44x_platform_init(r3, r4, r5, r6, r7);
+}
diff --git a/arch/ppc/syslib/ibm440gx_common.h b/arch/ppc/syslib/ibm440gx_common.h
index a2ab9fa..a03ec60 100644
--- a/arch/ppc/syslib/ibm440gx_common.h
+++ b/arch/ppc/syslib/ibm440gx_common.h
@@ -29,6 +29,10 @@ #include <syslib/ibm44x_common.h>
 void ibm440gx_get_clocks(struct ibm44x_clocks*, unsigned int sys_clk,
 	unsigned int ser_clk) __init;
 
+/* common 440GX platform init */
+void ibm440gx_platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+			    unsigned long r6, unsigned long r7) __init;
+
 /* Enable L2 cache */
 void ibm440gx_l2c_enable(void) __init;
 
diff --git a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
index 00ad9c7..4944c0f 100644
--- a/include/asm-ppc/reg_booke.h
+++ b/include/asm-ppc/reg_booke.h
@@ -237,6 +237,7 @@ #define SPRN_CSRR1	SPRN_SRR3 /* Critical
 #endif
 
 /* Bit definitions for CCR1. */
+#define	CCR1_DPC	0x00000100 /* Disable L1 I-Cache/D-Cache parity checking */
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
 /* Bit definitions for the MCSR. */
