Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70C121A0222
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 03:46:10 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 31 Jul 2014 23:16:04 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6F9E4394B34A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 16:00:49 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6VAWhtF23199780
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 16:02:44 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6VAUau4021217
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 16:00:37 +0530
Subject: [PATCH v2 2/2] powerpc/powernv: Interface to register/unregister
 opal dump region
To: linux-kernel@vger.kernel.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Thu, 31 Jul 2014 16:00:23 +0530
Message-ID: <20140731103019.27954.37756.stgit@hegdevasant.in.ibm.com>
In-Reply-To: <20140731102920.27954.25076.stgit@hegdevasant.in.ibm.com>
References: <20140731102920.27954.25076.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerNV platform is capable of capturing host memory region when system
crashes (because of host/firmware). We have new OPAL API to register/
unregister memory region to be captured when system crashes.

This patch adds support for new API. Also during boot time we register
kernel log buffer and unregister before doing kexec.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                   |   15 +++++
 arch/powerpc/platforms/powernv/Makefile           |    2 -
 arch/powerpc/platforms/powernv/opal-dump-region.c |   64 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S    |    2 +
 arch/powerpc/platforms/powernv/opal.c             |    2 +
 arch/powerpc/platforms/powernv/setup.c            |    3 +
 6 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-dump-region.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0da1dbd..f9261d7 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -147,6 +147,8 @@ struct opal_sg_list {
 #define OPAL_SET_PARAM				90
 #define OPAL_DUMP_RESEND			91
 #define OPAL_DUMP_INFO2				94
+#define OPAL_REGISTER_DUMP_REGION		101
+#define OPAL_UNREGISTER_DUMP_REGION		102
 
 #ifndef __ASSEMBLY__
 
@@ -860,6 +862,8 @@ int64_t opal_get_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 		uint64_t length);
 int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
+int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
+int64_t opal_unregister_dump_region(uint32_t id);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
@@ -899,6 +903,8 @@ extern int opal_elog_init(void);
 extern void opal_platform_dump_init(void);
 extern void opal_sys_param_init(void);
 extern void opal_msglog_init(void);
+extern void opal_dump_region_init(void);
+extern void opal_dump_kexec_callback(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
@@ -912,6 +918,15 @@ struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
 					     unsigned long vmalloc_size);
 void opal_free_sg_list(struct opal_sg_list *sg);
 
+/*
+ * Dump regions ids
+ *   0x01 - 0x7F : OPAL
+ *   0x80 - 0xFF : Kernel
+ */
+#define DUMP_REGION_HOST_START		0x80
+#define DUMP_REGION_LOG_BUF		0x80
+#define DUMP_REGION_HOST_END		0xFF
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 4ad227d..e2819aa 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,7 +1,7 @@
 obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
-obj-y			+= opal-msglog.o
+obj-y			+= opal-msglog.o opal-dump-region.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-dump-region.c b/arch/powerpc/platforms/powernv/opal-dump-region.c
new file mode 100644
index 0000000..c3f1536
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-dump-region.c
@@ -0,0 +1,64 @@
+/*
+ * PowerNV OPAL dump memory region interface
+ *
+ * Copyright 2014 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/pagemap.h>
+#include <linux/printk.h>
+#include <asm/opal.h>
+
+/*
+ * Pass kernel address range (start, size) that will be included in
+ * system dump (collected by service processor whenever system crashes).
+ *
+ * @id		: Memory region ID (see opal.h)
+ * @addr	: Start address
+ * @size	: size in bytes
+ */
+static int add_dump_region_entry(uint32_t id, void *addr, uint64_t size)
+{
+	__be32 be_id = cpu_to_be32(id);
+	__be64 be_addr = cpu_to_be64(__pa(addr));
+	__be64 be_size = cpu_to_be64(size);
+
+	return opal_register_dump_region(be_id, be_addr, be_size);
+}
+
+static int remove_dump_region_entry(uint32_t id)
+{
+	__be32 be_id = cpu_to_be32(id);
+
+	return opal_unregister_dump_region(be_id);
+}
+
+/* This gets called just before kexec */
+void opal_dump_kexec_callback(void)
+{
+	int rc;
+
+	rc = remove_dump_region_entry(DUMP_REGION_LOG_BUF);
+	if (rc)
+		pr_warn("DUMP: Failed to unregister kernel log buffer. "
+			"rc = %d\n", rc);
+}
+
+void __init opal_dump_region_init(void)
+{
+	void *addr;
+	uint64_t size;
+	int rc;
+
+	/* Register kernel log buffer */
+	addr = get_log_buf_addr();
+	size = get_log_buf_len();
+	rc = add_dump_region_entry(DUMP_REGION_LOG_BUF, addr, size);
+	if (rc)
+		pr_warn("DUMP: Failed to register kernel log buffer. "
+			"rc = %d\n", rc);
+}
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4abbff2..0f016cb 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -146,3 +146,5 @@ OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
 OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
+OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
+OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1999756..2834303 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -616,6 +616,8 @@ static int __init opal_init(void)
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
 	if (rc == 0) {
+		/* Setup dump region interface */
+		opal_dump_region_init();
 		/* Setup error log interface */
 		rc = opal_elog_init();
 		/* Setup code update interface */
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d9b88fa..644c9ba 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -184,6 +184,9 @@ static void pnv_shutdown(void)
 	 * DMA'ing ops are complete (such as dump retrieval).
 	 */
 	opal_shutdown();
+
+	/* Unregister memory dump region */
+	opal_dump_kexec_callback();
 }
 
 #ifdef CONFIG_KEXEC
