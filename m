Return-Path: <jyoung5@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E77C8DDF0F
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 23:12:45 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2VDEhA1006136
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 09:14:43 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2VDCd9U144422
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 09:12:39 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2VDCdY2029876
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 09:12:39 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Add idle power save for ppc 4xx
Message-Id: <10aea37177130bbe5de7.1206969157@thinkpadL>
Date: Mon, 31 Mar 2008 08:12:37 -0500
From: Jerone Young <jyoung5@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

# HG changeset patch
# User Jerone Young <jyoung5@us.ibm.com>
# Date 1206969060 18000
# Node ID 10aea37177130bbe5de7bee6ec06d9010bc5da1f
# Parent  1506aa38ddabb0bf73fff3ac3f3db5f9ef6458cc
Add idle power save for ppc 4xx

This patch sets the wait state MSR when power_save is called in cpu_idle loop for ppc4xx. This is mainly to help out virtualization solutions such as KVM. This way the virtualization soultions are able to tell if the guest kernel is idle.

I have tested this on hardware & KVM virtual guest.

Signed-off-by: Jerone Young <jyoung5@us.ibm.com>

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsy
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
+obj-$(CONFIG_4xx)		+= idle_4xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o \
 				   swsusp_$(CONFIG_WORD_SIZE).o
diff --git a/arch/powerpc/kernel/idle_4xx.c b/arch/powerpc/kernel/idle_4xx.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/kernel/idle_4xx.c
@@ -0,0 +1,24 @@
+/*
+ * This file contains the power_save function for 4xx CPUs
+ *
+ * added by Jerone Young <jyoung5@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/processor.h>
+#include <asm/machdep.h>
+
+void ppc4xx_idle()
+{
+	unsigned long msr_save;
+
+	/* set wait state MSR */
+	local_irq_enable();
+	msr_save = mfmsr();
+	mtmsr(msr_save|MSR_WE);
+	local_irq_disable();
+}
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -132,6 +132,10 @@ void __init machine_init(unsigned long d
 	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
 	    cpu_has_feature(CPU_FTR_CAN_NAP))
 		ppc_md.power_save = ppc6xx_idle;
+#endif
+
+#ifdef CONFIG_4xx
+	ppc_md.power_save = ppc4xx_idle;
 #endif
 
 	if (ppc_md.progress)
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -266,6 +266,7 @@ extern void power4_idle(void);
 extern void power4_idle(void);
 extern void power4_cpu_offline_powersave(void);
 extern void ppc6xx_idle(void);
+extern void ppc4xx_idle(void);
 
 /*
  * ppc_md contains a copy of the machine description structure for the
