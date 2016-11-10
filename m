Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tF5jk0WChzDvkC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 01:56:57 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAAEs6GV086470
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 09:56:56 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26mss6wmf4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 09:56:55 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 00:56:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1F2E12CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 01:56:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAAEupax37290100
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 01:56:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAAEuoFY025736
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 01:56:50 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCHC v7 05/10] powerpc: ima: Send the kexec buffer to the next
 kernel
Date: Thu, 10 Nov 2016 09:56:15 -0500
In-Reply-To: <1478789780-17719-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1478789780-17719-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1478789780-17719-6-git-send-email-zohar@linux.vnet.ibm.com>
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
kexec'd.

This is the architecture-specific part of setting up the IMA kexec
buffer for the next kernel. It will be used in the next patch.

Changelog v5:
- New patch in this version. This code was previously in the kexec buffer
  handover patch series.

Changelog relative to kexec handover patches v5:
- Moved code to arch/powerpc/kernel/ima_kexec.c.
- Renamed functions and struct members to variations of ima_kexec_buffer
  instead of variations of kexec_handover_buffer.
- Use a single property /chosen/linux,ima-kexec-buffer containing
  the buffer address and length, instead of
  /chosen/linux,kexec-handover-buffer-{start,end}.
- Use #address-cells and #size-cells to write the DT property.
- Use size_t instead of unsigned long for size arguments.
- Use CONFIG_IMA_KEXEC to build this code only when necessary.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ima.h              | 16 +++++
 arch/powerpc/include/asm/kexec.h            | 14 ++++-
 arch/powerpc/kernel/ima_kexec.c             | 91 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/kexec_elf_64.c          |  2 +-
 arch/powerpc/kernel/machine_kexec_file_64.c | 12 +++-
 5 files changed, 129 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index d5a72dd9b499..2313bdface34 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_POWERPC_IMA_H
 #define _ASM_POWERPC_IMA_H
 
+struct kimage;
+
 int ima_get_kexec_buffer(void **addr, size_t *size);
 int ima_free_kexec_buffer(void);
 
@@ -10,4 +12,18 @@ void remove_ima_buffer(void *fdt, int chosen_node);
 static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
 #endif
 
+#ifdef CONFIG_IMA_KEXEC
+int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
+			      size_t size);
+
+int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
+#else
+static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
+				   int chosen_node)
+{
+	remove_ima_buffer(fdt, chosen_node);
+	return 0;
+}
+#endif /* CONFIG_IMA_KEXEC */
+
 #endif /* _ASM_POWERPC_IMA_H */
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 23056d2dc330..a49cab287acb 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -94,12 +94,22 @@ static inline bool kdump_in_progress(void)
 #ifdef CONFIG_KEXEC_FILE
 extern struct kexec_file_ops kexec_elf64_ops;
 
+#ifdef CONFIG_IMA_KEXEC
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
+};
+#endif
+
 int setup_purgatory(struct kimage *image, const void *slave_code,
 		    const void *fdt, unsigned long kernel_load_addr,
 		    unsigned long fdt_load_addr, unsigned long stack_top,
 		    int debug);
-int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
-		  unsigned long initrd_len, const char *cmdline);
+int setup_new_fdt(const struct kimage *image, void *fdt,
+		  unsigned long initrd_load_addr, unsigned long initrd_len,
+		  const char *cmdline);
 bool find_debug_console(const void *fdt);
 int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
 #endif /* CONFIG_KEXEC_FILE */
diff --git a/arch/powerpc/kernel/ima_kexec.c b/arch/powerpc/kernel/ima_kexec.c
index 36e5a5df3804..5ea42c937ca9 100644
--- a/arch/powerpc/kernel/ima_kexec.c
+++ b/arch/powerpc/kernel/ima_kexec.c
@@ -130,3 +130,94 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 	if (!ret)
 		pr_debug("Removed old IMA buffer reservation.\n");
 }
+
+#ifdef CONFIG_IMA_KEXEC
+/**
+ * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
+ *
+ * Architectures should use this function to pass on the IMA buffer
+ * information to the next kernel.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
+			      size_t size)
+{
+	image->arch.ima_buffer_addr = load_addr;
+	image->arch.ima_buffer_size = size;
+
+	return 0;
+}
+
+static int write_number(void *p, u64 value, int cells)
+{
+	if (cells == 1) {
+		u32 tmp;
+
+		if (value > U32_MAX)
+			return -EINVAL;
+
+		tmp = cpu_to_be32(value);
+		memcpy(p, &tmp, sizeof(tmp));
+	} else if (cells == 2) {
+		u64 tmp;
+
+		tmp = cpu_to_be64(value);
+		memcpy(p, &tmp, sizeof(tmp));
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * setup_ima_buffer - add IMA buffer information to the fdt
+ * @image:		kexec image being loaded.
+ * @fdt:		Flattened device tree for the next kernel.
+ * @chosen_node:	Offset to the chosen node.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
+{
+	int ret, addr_cells, size_cells, entry_size;
+	u8 value[16];
+
+	remove_ima_buffer(fdt, chosen_node);
+	if (!image->arch.ima_buffer_size)
+		return 0;
+
+	ret = get_addr_size_cells(&addr_cells, &size_cells);
+	if (ret)
+		return ret;
+
+	entry_size = 4 * (addr_cells + size_cells);
+
+	if (entry_size > sizeof(value))
+		return -EINVAL;
+
+	ret = write_number(value, image->arch.ima_buffer_addr, addr_cells);
+	if (ret)
+		return ret;
+
+	ret = write_number(value + 4 * addr_cells, image->arch.ima_buffer_size,
+			   size_cells);
+	if (ret)
+		return ret;
+
+	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
+			  entry_size);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
+			      image->arch.ima_buffer_size);
+	if (ret)
+		return -EINVAL;
+
+	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
+		 image->arch.ima_buffer_addr, image->arch.ima_buffer_size);
+
+	return 0;
+}
+#endif /* CONFIG_IMA_KEXEC */
diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
index dc29e0131b76..1bd1e9865835 100644
--- a/arch/powerpc/kernel/kexec_elf_64.c
+++ b/arch/powerpc/kernel/kexec_elf_64.c
@@ -206,7 +206,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 		goto out;
 	}
 
-	ret = setup_new_fdt(fdt, initrd_load_addr, initrd_len, cmdline);
+	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len, cmdline);
 	if (ret)
 		goto out;
 
diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index 7b13634f71bf..e4da26dabbaf 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -393,6 +393,7 @@ int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
 
 /*
  * setup_new_fdt - modify /chosen and memory reservation for the next kernel
+ * @image:		kexec image being loaded.
  * @fdt:		Flattened device tree for the next kernel.
  * @initrd_load_addr:	Address where the next initrd will be loaded.
  * @initrd_len:		Size of the next initrd, or 0 if there will be none.
@@ -401,8 +402,9 @@ int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
  *
  * Return: 0 on success, or negative errno on error.
  */
-int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
-		  unsigned long initrd_len, const char *cmdline)
+int setup_new_fdt(const struct kimage *image, void *fdt,
+		  unsigned long initrd_load_addr, unsigned long initrd_len,
+		  const char *cmdline)
 {
 	int ret, chosen_node;
 	const void *prop;
@@ -512,7 +514,11 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 		}
 	}
 
-	remove_ima_buffer(fdt, chosen_node);
+	ret = setup_ima_buffer(image, fdt, chosen_node);
+	if (ret) {
+		pr_err("Error setting up the new device tree.\n");
+		return ret;
+	}
 
 	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
 	if (ret) {
-- 
2.1.0
