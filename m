Return-Path: <joel@jms.id.au>
Received: from mail-pb0-x233.google.com (mail-pb0-x233.google.com
 [IPv6:2607:f8b0:400e:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B8CC61401A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 15:00:02 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id uo5so9239592pbc.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 20:59:59 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 shangw@linux.vnet.ibm.com, hegdevasant@linux.vnet.ibm.com,
 michael@ellerman.id.au, mikey@neuling.org, stewart@linux.vnet.ibm.com
Subject: [PATCH v2 1/2] powerpc/powernv: Add OPAL message log interface
Date: Tue,  1 Apr 2014 14:28:19 +1030
Message-Id: <1396324700-22457-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1396324700-22457-1-git-send-email-joel@jms.id.au>
References: <1396324700-22457-1-git-send-email-joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL provides an in-memory circular buffer containing a message log
populated with various runtime messages produced by the firmware.

Provide a sysfs interface /sys/firmware/opal/msglog for userspace to
view the messages.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/include/asm/opal.h              |   4 +
 arch/powerpc/platforms/powernv/Makefile      |   1 +
 arch/powerpc/platforms/powernv/opal-msglog.c | 120 +++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c        |   4 +-
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-msglog.c

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ffafab0..693bdc4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -729,6 +729,9 @@ typedef struct oppanel_line {
 /* /sys/firmware/opal */
 extern struct kobject *opal_kobj;
 
+/* /ibm,opal */
+extern struct device_node *opal_node;
+
 /* API functions */
 int64_t opal_console_write(int64_t term_number, __be64 *length,
 			   const uint8_t *buffer);
@@ -918,6 +921,7 @@ extern void opal_flash_init(void);
 extern int opal_elog_init(void);
 extern void opal_platform_dump_init(void);
 extern void opal_sys_param_init(void);
+extern void opal_msglog_init(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index f324ea0..63cebb9 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,6 +1,7 @@
 obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
+obj-y			+= opal-msglog.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
new file mode 100644
index 0000000..1bb25b9
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -0,0 +1,120 @@
+/*
+ * PowerNV OPAL in-memory console interface
+ *
+ * Copyright 2014 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/io.h>
+#include <asm/opal.h>
+#include <linux/debugfs.h>
+#include <linux/of.h>
+#include <linux/types.h>
+#include <asm/barrier.h>
+
+/* OPAL in-memory console. Defined in OPAL source at core/console.c */
+struct memcons {
+	__be64 magic;
+#define MEMCONS_MAGIC	0x6630696567726173L
+	__be64 obuf_phys;
+	__be64 ibuf_phys;
+	__be32 obuf_size;
+	__be32 ibuf_size;
+	__be32 out_pos;
+#define MEMCONS_OUT_POS_WRAP	0x80000000u
+#define MEMCONS_OUT_POS_MASK	0x00ffffffu
+	__be32 in_prod;
+	__be32 in_cons;
+};
+
+static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
+				struct bin_attribute *bin_attr, char *to,
+				loff_t pos, size_t count)
+{
+	struct memcons *mc = bin_attr->private;
+	const char *conbuf;
+	size_t ret, first_read = 0;
+	uint32_t out_pos, avail;
+
+	if (!mc)
+		return -ENODEV;
+
+	out_pos = be32_to_cpu(ACCESS_ONCE(mc->out_pos));
+
+	/* Now we've read out_pos, put a barrier in before reading the new
+	 * data it points to in conbuf. */
+	smp_rmb();
+
+	conbuf = phys_to_virt(be64_to_cpu(mc->obuf_phys));
+
+	/* When the buffer has wrapped, read from the out_pos marker to the end
+	 * of the buffer, and then read the remaining data as in the un-wrapped
+	 * case. */
+	if (out_pos & MEMCONS_OUT_POS_WRAP) {
+
+		out_pos &= MEMCONS_OUT_POS_MASK;
+		avail = be32_to_cpu(mc->obuf_size) - out_pos;
+
+		ret = memory_read_from_buffer(to, count, &pos,
+				conbuf + out_pos, avail);
+
+		if (ret < 0)
+			goto out;
+
+		first_read = ret;
+		to += first_read;
+		count -= first_read;
+		pos -= avail;
+	}
+
+	/* Sanity check. The firmware should not do this to us. */
+	if (out_pos > be32_to_cpu(mc->obuf_size)) {
+		pr_err("OPAL: memory console corruption. Aborting read.\n");
+		return -EINVAL;
+	}
+
+	ret = memory_read_from_buffer(to, count, &pos, conbuf, out_pos);
+
+	if (ret < 0)
+		goto out;
+
+	ret += first_read;
+out:
+	return ret;
+}
+
+static struct bin_attribute opal_msglog_attr = {
+	.attr = {.name = "msglog", .mode = 0444},
+	.read = opal_msglog_read
+};
+
+void __init opal_msglog_init(void)
+{
+	u64 mcaddr;
+	struct memcons *mc;
+
+	if (of_property_read_u64(opal_node, "ibm,opal-memcons", &mcaddr)) {
+		pr_warn("OPAL: Property ibm,opal-memcons not found, no message log\n");
+		return;
+	}
+
+	mc = phys_to_virt(mcaddr);
+	if (!mc) {
+		pr_warn("OPAL: memory console address is invalid\n");
+		return;
+	}
+
+	if (be64_to_cpu(mc->magic) != MEMCONS_MAGIC) {
+		pr_warn("OPAL: memory console version is invalid\n");
+		return;
+	}
+
+	opal_msglog_attr.private = mc;
+
+	if (sysfs_create_bin_file(opal_kobj, &opal_msglog_attr) != 0)
+		pr_warn("OPAL: sysfs file creation failed\n");
+}
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index e92f2f6..e6f14d7 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -46,7 +46,7 @@ struct mcheck_recoverable_range {
 static struct mcheck_recoverable_range *mc_recoverable_range;
 static int mc_recoverable_range_len;
 
-static struct device_node *opal_node;
+struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
 extern u64 opal_mc_secondary_handler[];
 static unsigned int *opal_irqs;
@@ -574,6 +574,8 @@ static int __init opal_init(void)
 		opal_platform_dump_init();
 		/* Setup system parameters interface */
 		opal_sys_param_init();
+		/* Setup message log interface. */
+		opal_msglog_init();
 	}
 
 	return 0;
-- 
1.9.1
