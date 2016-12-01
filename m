Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTfHZ4Y0bzDw00
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 12:06:18 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB1142NG017833
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:06:16 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2726cr8ff3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:06:16 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 1 Dec 2016 06:36:11 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3FF85394005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 06:36:07 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB1166pg32440406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 06:36:06 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB1166kC013864
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 06:36:06 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v8 01/10] powerpc: ima: Get the kexec buffer passed by the
 previous kernel
Date: Wed, 30 Nov 2016 20:05:37 -0500
In-Reply-To: <1480554346-29071-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1480554346-29071-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1480554346-29071-2-git-send-email-zohar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

The IMA kexec buffer allows the currently running kernel to pass
the measurement list via a kexec segment to the kernel that will be
kexec'd. The second kernel can check whether the previous kernel sent
the buffer and retrieve it.

This is the architecture-specific part which enables IMA to receive the
measurement list passed by the previous kernel. It will be used in the
next patch.

The change in machine_kexec_64.c is to factor out the logic of removing
an FDT memory reservation so that it can be used by remove_ima_buffer.

Changelog v6:
- The kexec_file_load patches v9 already define delete_fdt_mem_rsv,
  so now we just need to export it.

Changelog v5:
- New patch in this version. This code was previously in the kexec buffer
  handover patch series.

Changelog relative to kexec handover patches v5:
- Added CONFIG_HAVE_IMA_KEXEC.
- Added arch/powerpc/include/asm/ima.h.
- Moved code to arch/powerpc/kernel/ima_kexec.c.
- Renamed functions to variations of ima_kexec_buffer instead of
  variations of kexec_handover_buffer.
- Use a single property /chosen/linux,ima-kexec-buffer containing
  the buffer address and length, instead of
  /chosen/linux,kexec-handover-buffer-{start,end}.
- Use #address-cells and #size-cells to read the DT property.
- Use size_t instead of unsigned long for size arguments.
- Always remove linux,ima-kexec-buffer and its memory reservation
  when preparing a device tree for kexec_file_load.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 arch/Kconfig                                |   3 +
 arch/powerpc/Kconfig                        |   1 +
 arch/powerpc/include/asm/ima.h              |  13 +++
 arch/powerpc/include/asm/kexec.h            |   1 +
 arch/powerpc/kernel/Makefile                |   4 +
 arch/powerpc/kernel/ima_kexec.c             | 132 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_file_64.c |   5 +-
 7 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/ima.h
 create mode 100644 arch/powerpc/kernel/ima_kexec.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 659bdd079277..e1605ff286a1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -5,6 +5,9 @@
 config KEXEC_CORE
 	bool
 
+config HAVE_IMA_KEXEC
+	bool
+
 config OPROFILE
 	tristate "OProfile system profiling"
 	depends on PROFILING
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 897d0f14447d..40ee044f1915 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -458,6 +458,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select HAVE_IMA_KEXEC
 	select BUILD_BIN2C
 	depends on PPC64
 	depends on CRYPTO=y
diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
new file mode 100644
index 000000000000..d5a72dd9b499
--- /dev/null
+++ b/arch/powerpc/include/asm/ima.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_POWERPC_IMA_H
+#define _ASM_POWERPC_IMA_H
+
+int ima_get_kexec_buffer(void **addr, size_t *size);
+int ima_free_kexec_buffer(void);
+
+#ifdef CONFIG_IMA
+void remove_ima_buffer(void *fdt, int chosen_node);
+#else
+static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
+#endif
+
+#endif /* _ASM_POWERPC_IMA_H */
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 6c3b71502fbc..b0fdffb7179b 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -99,6 +99,7 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 		    unsigned long fdt_load_addr);
 int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 		  unsigned long initrd_len, const char *cmdline);
+int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
 #endif /* CONFIG_KEXEC_FILE */
 
 #else /* !CONFIG_KEXEC_CORE */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 41d8ff34ae27..5f074806cfab 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -110,6 +110,10 @@ obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o crash.o \
 				   machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file_$(BITS).o kexec_elf_$(BITS).o
+ifeq ($(CONFIG_HAVE_IMA_KEXEC)$(CONFIG_IMA),yy)
+obj-y				+= ima_kexec.o
+endif
+
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
diff --git a/arch/powerpc/kernel/ima_kexec.c b/arch/powerpc/kernel/ima_kexec.c
new file mode 100644
index 000000000000..36e5a5df3804
--- /dev/null
+++ b/arch/powerpc/kernel/ima_kexec.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (C) 2016 IBM Corporation
+ *
+ * Authors:
+ * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/slab.h>
+#include <linux/kexec.h>
+#include <linux/of.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
+
+static int get_addr_size_cells(int *addr_cells, int *size_cells)
+{
+	struct device_node *root;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return -EINVAL;
+
+	*addr_cells = of_n_addr_cells(root);
+	*size_cells = of_n_size_cells(root);
+
+	of_node_put(root);
+
+	return 0;
+}
+
+static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
+			       size_t *size)
+{
+	int ret, addr_cells, size_cells;
+
+	ret = get_addr_size_cells(&addr_cells, &size_cells);
+	if (ret)
+		return ret;
+
+	if (len < 4 * (addr_cells + size_cells))
+		return -ENOENT;
+
+	*addr = of_read_number(prop, addr_cells);
+	*size = of_read_number(prop + 4 * addr_cells, size_cells);
+
+	return 0;
+}
+
+/**
+ * ima_get_kexec_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	int ret, len;
+	unsigned long tmp_addr;
+	size_t tmp_size;
+	const void *prop;
+
+	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
+	if (!prop)
+		return -ENOENT;
+
+	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
+	if (ret)
+		return ret;
+
+	*addr = __va(tmp_addr);
+	*size = tmp_size;
+
+	return 0;
+}
+
+/**
+ * ima_free_kexec_buffer - free memory used by the IMA buffer
+ */
+int ima_free_kexec_buffer(void)
+{
+	int ret;
+	unsigned long addr;
+	size_t size;
+	struct property *prop;
+
+	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
+	if (!prop)
+		return -ENOENT;
+
+	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
+	if (ret)
+		return ret;
+
+	ret = of_remove_property(of_chosen, prop);
+	if (ret)
+		return ret;
+
+	return memblock_free(addr, size);
+
+}
+
+/**
+ * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
+ *
+ * The IMA measurement buffer is of no use to a subsequent kernel, so we always
+ * remove it from the device tree.
+ */
+void remove_ima_buffer(void *fdt, int chosen_node)
+{
+	int ret, len;
+	unsigned long addr;
+	size_t size;
+	const void *prop;
+
+	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
+	if (!prop)
+		return;
+
+	ret = do_get_kexec_buffer(prop, len, &addr, &size);
+	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+	if (ret)
+		return;
+
+	ret = delete_fdt_mem_rsv(fdt, addr, size);
+	if (!ret)
+		pr_debug("Removed old IMA buffer reservation.\n");
+}
diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index 7abc8a75ee48..29331fffad13 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -27,6 +27,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <asm/ima.h>
 
 #define SLAVE_CODE_SIZE		256
 
@@ -180,7 +181,7 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
  *
  * Return: 0 on success, or negative errno on error.
  */
-static int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
+int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
 {
 	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
 
@@ -328,6 +329,8 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 		}
 	}
 
+	remove_ima_buffer(fdt, chosen_node);
+
 	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
 	if (ret) {
 		pr_err("Error setting up the new device tree.\n");
-- 
2.1.0
