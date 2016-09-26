Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjWGN0XdJzDrRR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 03:31:07 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8QHSkSJ035029
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:31:06 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25q57dgkyb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:31:05 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 23:01:01 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 97D90125805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:01:19 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8QHUw1g40173736
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:00:58 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8QHUuNw009199
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:00:58 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 01/10] powerpc: ima: Get the kexec buffer passed by the
 previous kernel
Date: Mon, 26 Sep 2016 13:30:20 -0400
In-Reply-To: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1474911029-6372-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1474911029-6372-2-git-send-email-zohar@linux.vnet.ibm.com>
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
---
 arch/Kconfig                           |   3 +
 arch/powerpc/Kconfig                   |   1 +
 arch/powerpc/include/asm/ima.h         |  13 ++++
 arch/powerpc/include/asm/kexec.h       |   1 +
 arch/powerpc/kernel/Makefile           |   4 +
 arch/powerpc/kernel/ima_kexec.c        | 132 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c | 106 +++++++++++++-------------
 7 files changed, 208 insertions(+), 52 deletions(-)
 create mode 100644 arch/powerpc/include/asm/ima.h
 create mode 100644 arch/powerpc/kernel/ima_kexec.c

diff --git a/arch/Kconfig b/arch/Kconfig
index e9c9334..60283562 100644
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
index d1ba864..17fff29 100644
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
index 0000000..d5a72dd
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
index 73f88b5..5dda514 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -99,6 +99,7 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 		  unsigned long initrd_len, const char *cmdline);
 bool find_debug_console(const void *fdt);
+int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
 #endif /* CONFIG_KEXEC_FILE */
 
 #else /* !CONFIG_KEXEC_CORE */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0ee1b3f..5e0bacc 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -109,6 +109,10 @@ obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o crash.o \
 				   machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf_$(BITS).o
+ifeq ($(CONFIG_HAVE_IMA_KEXEC)$(CONFIG_IMA),yy)
+obj-y				+= ima_kexec.o
+endif
+
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
diff --git a/arch/powerpc/kernel/ima_kexec.c b/arch/powerpc/kernel/ima_kexec.c
new file mode 100644
index 0000000..36e5a5d
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
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 9cd8f3b..c2e0b18 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -34,6 +34,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/asm-prototypes.h>
 #include <asm/kexec_elf_64.h>
+#include <asm/ima.h>
 
 #define SLAVE_CODE_SIZE		256
 
@@ -657,9 +658,9 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 	return 0;
 }
 
-/*
- * setup_new_fdt() - modify /chosen and memory reservation for the next kernel
- * @fdt:
+/**
+ * setup_new_fdt() - modify /chosen and memory reservations for the next kernel
+ * @fdt:		Flattened device tree for the next kernel.
  * @initrd_load_addr:	Address where the next initrd will be loaded.
  * @initrd_len:		Size of the next initrd, or 0 if there will be none.
  * @cmdline:		Command line for the next kernel, or NULL if there will
@@ -670,33 +671,16 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 		  unsigned long initrd_len, const char *cmdline)
 {
-	uint64_t oldfdt_addr;
-	int i, ret, chosen_node;
+	int ret, chosen_node;
 	const void *prop;
 
 	/* Remove memory reservation for the current device tree. */
-	oldfdt_addr = __pa(initial_boot_params);
-	for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
-		uint64_t rsv_start, rsv_size;
-
-		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
-		if (ret) {
-			pr_err("Malformed device tree.\n");
-			return -EINVAL;
-		}
-
-		if (rsv_start == oldfdt_addr &&
-		    rsv_size == fdt_totalsize(initial_boot_params)) {
-			ret = fdt_del_mem_rsv(fdt, i);
-			if (ret) {
-				pr_err("Error deleting fdt reservation.\n");
-				return -EINVAL;
-			}
-
-			pr_debug("Removed old device tree reservation.\n");
-			break;
-		}
-	}
+	ret = delete_fdt_mem_rsv(fdt, __pa(initial_boot_params),
+				 fdt_totalsize(initial_boot_params));
+	if (ret == 0)
+		pr_debug("Removed old device tree reservation.\n");
+	else if (ret != -ENOENT)
+		return ret;
 
 	chosen_node = fdt_path_offset(fdt, "/chosen");
 	if (chosen_node == -FDT_ERR_NOTFOUND) {
@@ -714,7 +698,7 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 	/* Did we boot using an initrd? */
 	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
 	if (prop) {
-		uint64_t tmp_start, tmp_end, tmp_size, tmp_sizepg;
+		uint64_t tmp_start, tmp_end, tmp_size;
 
 		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
 
@@ -730,30 +714,14 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 		 * reserve a multiple of PAGE_SIZE, so check for both.
 		 */
 		tmp_size = tmp_end - tmp_start;
-		tmp_sizepg = round_up(tmp_size, PAGE_SIZE);
-
-		/* Remove memory reservation for the current initrd. */
-		for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
-			uint64_t rsv_start, rsv_size;
-
-			ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
-			if (ret) {
-				pr_err("Malformed device tree.\n");
-				return -EINVAL;
-			}
-
-			if (rsv_start == tmp_start &&
-			    (rsv_size == tmp_size || rsv_size == tmp_sizepg)) {
-				ret = fdt_del_mem_rsv(fdt, i);
-				if (ret) {
-					pr_err("Error deleting fdt reservation.\n");
-					return -EINVAL;
-				}
-				pr_debug("Removed old initrd reservation.\n");
-
-				break;
-			}
-		}
+		ret = delete_fdt_mem_rsv(fdt, tmp_start, tmp_size);
+		if (ret == -ENOENT)
+			ret = delete_fdt_mem_rsv(fdt, tmp_start,
+						 round_up(tmp_size, PAGE_SIZE));
+		if (ret == 0)
+			pr_debug("Removed old initrd reservation.\n");
+		else if (ret != -ENOENT)
+			return ret;
 
 		/* If there's no new initrd, delete the old initrd's info. */
 		if (initrd_len == 0) {
@@ -811,6 +779,8 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 		}
 	}
 
+	remove_ima_buffer(fdt, chosen_node);
+
 	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
 	if (ret) {
 		pr_err("Error setting up the new device tree.\n");
@@ -821,6 +791,38 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 }
 
 /**
+ * delete_fdt_mem_rsv - delete memory reservation with given address and size
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
+{
+	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
+
+	for (i = 0; i < num_rsvs; i++) {
+		uint64_t rsv_start, rsv_size;
+
+		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+		if (ret) {
+			pr_err("Malformed device tree.\n");
+			return -EINVAL;
+		}
+
+		if (rsv_start == start && rsv_size == size) {
+			ret = fdt_del_mem_rsv(fdt, i);
+			if (ret) {
+				pr_err("Error deleting device tree reservation.\n");
+				return -EINVAL;
+			}
+
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+/**
  * find_debug_console() - find out whether there is a console for the purgatory
  * @fdt:		Flattened device tree to search.
  */
-- 
2.1.0
