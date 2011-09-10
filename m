Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7EBAEB7AED
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 00:20:50 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/21] powerpc/powernv: Add RTC and NVRAM support plus RTAS
	fallbacks
Date: Sat, 10 Sep 2011 11:20:02 -0300
Message-Id: <1315664408-16797-15-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implements OPAL RTC and NVRAM support and wire all that up to
the powernv platform.

We use RTAS for RTC as a fallback if available. Using RTAS for nvram
is not supported yet, pending some rework/cleanup and generalization
of the pSeries & CHRP code. We also use RTAS fallbacks for power off
and reboot

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h             |    6 ++
 arch/powerpc/platforms/powernv/Makefile     |    2 +
 arch/powerpc/platforms/powernv/opal-nvram.c |   88 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-rtc.c   |   97 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c      |   57 ++++++++++------
 5 files changed, 229 insertions(+), 21 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-nvram.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-rtc.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index dbeabea..9bb0efd 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -430,6 +430,12 @@ extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
 
 extern void hvc_opal_init_early(void);
 
+struct rtc_time;
+extern int opal_set_rtc_time(struct rtc_time *tm);
+extern void opal_get_rtc_time(struct rtc_time *tm);
+extern unsigned long opal_get_boot_time(void);
+extern void opal_nvram_init(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 8f69c0d..618ad83 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,2 +1,4 @@
 obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o
+obj-y			+= opal-rtc.o opal-nvram.o
+
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
new file mode 100644
index 0000000..3f83e1a
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -0,0 +1,88 @@
+/*
+ * PowerNV nvram code.
+ *
+ * Copyright 2011 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+
+#include <asm/opal.h>
+#include <asm/machdep.h>
+
+static unsigned int nvram_size;
+
+static ssize_t opal_nvram_size(void)
+{
+	return nvram_size;
+}
+
+static ssize_t opal_nvram_read(char *buf, size_t count, loff_t *index)
+{
+	s64 rc;
+	int off;
+
+	if (*index >= nvram_size)
+		return 0;
+	off = *index;
+	if ((off + count) > nvram_size)
+		count = nvram_size - off;
+	rc = opal_read_nvram(__pa(buf), count, off);
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+	*index += count;
+	return count;
+}
+
+static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
+{
+	s64 rc = OPAL_BUSY;
+	int off;
+
+	if (*index >= nvram_size)
+		return 0;
+	off = *index;
+	if ((off + count) > nvram_size)
+		count = nvram_size - off;
+
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_write_nvram(__pa(buf), count, off);
+		if (rc == OPAL_BUSY_EVENT)
+			opal_poll_events(NULL);
+	}
+	*index += count;
+	return count;
+}
+
+void __init opal_nvram_init(void)
+{
+	struct device_node *np;
+	const u32 *nbytes_p;
+
+	np = of_find_compatible_node(NULL, NULL, "ibm,opal-nvram");
+	if (np == NULL)
+		return;
+
+	nbytes_p = of_get_property(np, "#bytes", NULL);
+	if (!nbytes_p) {
+		of_node_put(np);
+		return;
+	}
+	nvram_size = *nbytes_p;
+
+	printk(KERN_INFO "OPAL nvram setup, %u bytes\n", nvram_size);
+	of_node_put(np);
+
+	ppc_md.nvram_read = opal_nvram_read;
+	ppc_md.nvram_write = opal_nvram_write;
+	ppc_md.nvram_size = opal_nvram_size;
+}
+
diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
new file mode 100644
index 0000000..2aa7641
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -0,0 +1,97 @@
+/*
+ * PowerNV Real Time Clock.
+ *
+ * Copyright 2011 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+
+#include <linux/kernel.h>
+#include <linux/time.h>
+#include <linux/bcd.h>
+#include <linux/rtc.h>
+#include <linux/delay.h>
+
+#include <asm/opal.h>
+#include <asm/firmware.h>
+
+static void opal_to_tm(u32 y_m_d, u64 h_m_s_ms, struct rtc_time *tm)
+{
+	tm->tm_year	= ((bcd2bin(y_m_d >> 24) * 100) +
+			   bcd2bin((y_m_d >> 16) & 0xff)) - 1900;
+	tm->tm_mon	= bcd2bin((y_m_d >> 8) & 0xff) - 1;
+	tm->tm_mday	= bcd2bin(y_m_d & 0xff);
+	tm->tm_hour	= bcd2bin((h_m_s_ms >> 56) & 0xff);
+	tm->tm_min	= bcd2bin((h_m_s_ms >> 48) & 0xff);
+	tm->tm_sec	= bcd2bin((h_m_s_ms >> 40) & 0xff);
+
+        GregorianDay(tm);
+}
+
+unsigned long __init opal_get_boot_time(void)
+{
+	struct rtc_time tm;
+	u32 y_m_d;
+	u64 h_m_s_ms;
+	long rc = OPAL_BUSY;
+
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_rtc_read(&y_m_d, &h_m_s_ms);
+		if (rc == OPAL_BUSY_EVENT)
+			opal_poll_events(NULL);
+		else
+			mdelay(10);
+	}
+	if (rc != OPAL_SUCCESS)
+		return 0;
+	opal_to_tm(y_m_d, h_m_s_ms, &tm);
+	return mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+		      tm.tm_hour, tm.tm_min, tm.tm_sec);
+}
+
+void opal_get_rtc_time(struct rtc_time *tm)
+{
+	long rc = OPAL_BUSY;
+	u32 y_m_d;
+	u64 h_m_s_ms;
+
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_rtc_read(&y_m_d, &h_m_s_ms);
+		if (rc == OPAL_BUSY_EVENT)
+			opal_poll_events(NULL);
+		else
+			mdelay(10);
+	}
+	if (rc != OPAL_SUCCESS)
+		return;
+	opal_to_tm(y_m_d, h_m_s_ms, tm);
+}
+
+int opal_set_rtc_time(struct rtc_time *tm)
+{
+	long rc = OPAL_BUSY;
+	u32 y_m_d = 0;
+	u64 h_m_s_ms = 0;
+
+	y_m_d |= ((u32)bin2bcd((tm->tm_year + 1900) / 100)) << 24;
+	y_m_d |= ((u32)bin2bcd((tm->tm_year + 1900) % 100)) << 16;
+	y_m_d |= ((u32)bin2bcd((tm->tm_mon + 1))) << 8;
+	y_m_d |= ((u32)bin2bcd(tm->tm_mday));
+
+	h_m_s_ms |= ((u64)bin2bcd(tm->tm_hour)) << 56;
+	h_m_s_ms |= ((u64)bin2bcd(tm->tm_min)) << 48;
+	h_m_s_ms |= ((u64)bin2bcd(tm->tm_sec)) << 40;
+
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_rtc_write(y_m_d, h_m_s_ms);
+		if (rc == OPAL_BUSY_EVENT)
+			opal_poll_events(NULL);
+		else
+			mdelay(10);
+	}
+	return rc == OPAL_SUCCESS ? 0 : -EIO;
+}
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 0fac0a6..4a2b2e2 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -29,7 +29,9 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/xics.h>
+#include <asm/rtas.h>
 #include <asm/opal.h>
+#include <asm/xics.h>
 
 #include "powernv.h"
 
@@ -40,7 +42,9 @@ static void __init pnv_setup_arch(void)
 
 	/* XXX PCI */
 
-	/* XXX NVRAM */
+	/* Setup RTC and NVRAM callbacks */
+	if (firmware_has_feature(FW_FEATURE_OPAL))
+		opal_nvram_init();
 
 	/* Enable NAP mode */
 	powersave_nap = 1;
@@ -118,30 +122,40 @@ static void __noreturn pnv_halt(void)
 	pnv_power_off();
 }
 
-static unsigned long __init pnv_get_boot_time(void)
-{
-	return 0;
-}
-
-static void pnv_get_rtc_time(struct rtc_time *rtc_tm)
+static void pnv_progress(char *s, unsigned short hex)
 {
 }
 
-static int pnv_set_rtc_time(struct rtc_time *tm)
+#ifdef CONFIG_KEXEC
+static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 {
-	return 0;
+	xics_kexec_teardown_cpu(secondary);
 }
+#endif /* CONFIG_KEXEC */
 
-static void pnv_progress(char *s, unsigned short hex)
+static void __init pnv_setup_machdep_opal(void)
 {
+	ppc_md.get_boot_time = opal_get_boot_time;
+	ppc_md.get_rtc_time = opal_get_rtc_time;
+	ppc_md.set_rtc_time = opal_set_rtc_time;
+	ppc_md.restart = pnv_restart;
+	ppc_md.power_off = pnv_power_off;
+	ppc_md.halt = pnv_halt;
 }
 
-#ifdef CONFIG_KEXEC
-static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
+#ifdef CONFIG_PPC_POWERNV_RTAS
+static void __init pnv_setup_machdep_rtas(void)
 {
-	xics_kexec_teardown_cpu(secondary);
+	if (rtas_token("get-time-of-day") != RTAS_UNKNOWN_SERVICE) {
+		ppc_md.get_boot_time = rtas_get_boot_time;
+		ppc_md.get_rtc_time = rtas_get_rtc_time;
+		ppc_md.set_rtc_time = rtas_set_rtc_time;
+	}
+	ppc_md.restart = rtas_restart;
+	ppc_md.power_off = rtas_power_off;
+	ppc_md.halt = rtas_halt;
 }
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_PPC_POWERNV_RTAS */
 
 static int __init pnv_probe(void)
 {
@@ -152,6 +166,13 @@ static int __init pnv_probe(void)
 
 	hpte_init_native();
 
+	if (firmware_has_feature(FW_FEATURE_OPAL))
+		pnv_setup_machdep_opal();
+#ifdef CONFIG_PPC_POWERNV_RTAS
+	else if (rtas.base)
+		pnv_setup_machdep_rtas();
+#endif /* CONFIG_PPC_POWERNV_RTAS */
+
 	pr_debug("PowerNV detected !\n");
 
 	return 1;
@@ -160,16 +181,10 @@ static int __init pnv_probe(void)
 define_machine(powernv) {
 	.name			= "PowerNV",
 	.probe			= pnv_probe,
-	.setup_arch		= pnv_setup_arch,
 	.init_early		= pnv_init_early,
+	.setup_arch		= pnv_setup_arch,
 	.init_IRQ		= pnv_init_IRQ,
 	.show_cpuinfo		= pnv_show_cpuinfo,
-	.restart		= pnv_restart,
-	.power_off		= pnv_power_off,
-	.halt			= pnv_halt,
-	.get_boot_time		= pnv_get_boot_time,
-	.get_rtc_time		= pnv_get_rtc_time,
-	.set_rtc_time		= pnv_set_rtc_time,
 	.progress		= pnv_progress,
 	.power_save             = power7_idle,
 	.calibrate_decr		= generic_calibrate_decr,
-- 
1.7.4.1
