Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZKhH5kHCzDsWr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 10:55:11 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8F0qdVk122551
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:55:09 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25exsmx759-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:55:09 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 21:55:06 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 7AAE1352005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:54:41 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8F0t4OP11534488
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:55:04 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8F0t30N005397
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:55:04 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v5 3/5] powerpc: kexec_file: Add buffer hand-over support for
 the next kernel
Date: Wed, 14 Sep 2016 21:54:48 -0300
In-Reply-To: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1473900890-1476-4-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The buffer hand-over mechanism allows the currently running kernel to pass
data to kernel that will be kexec'd via a kexec segment. The second kernel
can check whether the previous kernel sent data and retrieve it.

This is the architecture-specific part.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kexec.h       |  12 +-
 arch/powerpc/kernel/kexec_elf_64.c     |   2 +-
 arch/powerpc/kernel/machine_kexec_64.c | 274 +++++++++++++++++++++++++++------
 3 files changed, 240 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 73f88b5f9bd1..b8e32194ce63 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -92,12 +92,20 @@ static inline bool kdump_in_progress(void)
 }
 
 #ifdef CONFIG_KEXEC_FILE
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+	phys_addr_t handover_buffer_addr;
+	unsigned long handover_buffer_size;
+};
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
 #endif /* CONFIG_KEXEC_FILE */
 
diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
index 3cc8ebce1a86..0c576e300384 100644
--- a/arch/powerpc/kernel/kexec_elf_64.c
+++ b/arch/powerpc/kernel/kexec_elf_64.c
@@ -208,7 +208,7 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
 		goto out;
 	}
 
-	ret = setup_new_fdt(fdt, initrd_load_addr, initrd_len, cmdline);
+	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len, cmdline);
 	if (ret)
 		goto out;
 
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 3879b6d91c0b..d6077898200a 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -489,6 +489,77 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return image->fops->cleanup(image->image_loader_data);
 }
 
+bool kexec_can_hand_over_buffer(void)
+{
+	return true;
+}
+
+int arch_kexec_add_handover_buffer(struct kimage *image,
+				   unsigned long load_addr, unsigned long size)
+{
+	image->arch.handover_buffer_addr = load_addr;
+	image->arch.handover_buffer_size = size;
+
+	return 0;
+}
+
+int kexec_get_handover_buffer(void **addr, unsigned long *size)
+{
+	int ret;
+	u64 start_addr, end_addr;
+
+	ret = of_property_read_u64(of_chosen,
+				   "linux,kexec-handover-buffer-start",
+				   &start_addr);
+	if (ret == -EINVAL)
+		return -ENOENT;
+	else if (ret)
+		return -EINVAL;
+
+	ret = of_property_read_u64(of_chosen, "linux,kexec-handover-buffer-end",
+				   &end_addr);
+	if (ret == -EINVAL)
+		return -ENOENT;
+	else if (ret)
+		return -EINVAL;
+
+	*addr =  __va(start_addr);
+	/* -end is the first address after the buffer. */
+	*size = end_addr - start_addr;
+
+	return 0;
+}
+
+int kexec_free_handover_buffer(void)
+{
+	int ret;
+	void *addr;
+	unsigned long size;
+	struct property *prop;
+
+	ret = kexec_get_handover_buffer(&addr, &size);
+	if (ret)
+		return ret;
+
+	ret = memblock_free(__pa(addr), size);
+	if (ret)
+		return ret;
+
+	prop = of_find_property(of_chosen, "linux,kexec-handover-buffer-start",
+				NULL);
+	ret = of_remove_property(of_chosen, prop);
+	if (ret)
+		return ret;
+
+	prop = of_find_property(of_chosen, "linux,kexec-handover-buffer-end",
+				NULL);
+	ret = of_remove_property(of_chosen, prop);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /**
  * arch_kexec_walk_mem() - call func(data) for each unreserved memory block
  * @kbuf:	Context info for the search. Also passed to @func.
@@ -686,26 +757,16 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 	return 0;
 }
 
-/*
- * setup_new_fdt() - modify /chosen and memory reservation for the next kernel
- * @fdt:
- * @initrd_load_addr:	Address where the next initrd will be loaded.
- * @initrd_len:		Size of the next initrd, or 0 if there will be none.
- * @cmdline:		Command line for the next kernel, or NULL if there will
- *			be none.
+/**
+ * delete_fdt_mem_rsv() - delete memory reservation with given address and size
  *
  * Return: 0 on success, or negative errno on error.
  */
-int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
-		  unsigned long initrd_len, const char *cmdline)
+static int delete_fdt_mem_rsv(void *fdt, uint64_t start, uint64_t size)
 {
-	uint64_t oldfdt_addr;
-	int i, ret, chosen_node;
-	const void *prop;
+	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
 
-	/* Remove memory reservation for the current device tree. */
-	oldfdt_addr = __pa(initial_boot_params);
-	for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
+	for (i = 0; i < num_rsvs; i++) {
 		uint64_t rsv_start, rsv_size;
 
 		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
@@ -714,19 +775,152 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 			return -EINVAL;
 		}
 
-		if (rsv_start == oldfdt_addr &&
-		    rsv_size == fdt_totalsize(initial_boot_params)) {
+		if (rsv_start == start && rsv_size == size) {
 			ret = fdt_del_mem_rsv(fdt, i);
 			if (ret) {
-				pr_err("Error deleting fdt reservation.\n");
+				pr_err("Error deleting device tree reservation.\n");
 				return -EINVAL;
 			}
 
-			pr_debug("Removed old device tree reservation.\n");
-			break;
+			return 0;
 		}
 	}
 
+	return -ENOENT;
+}
+
+/**
+ * setup_handover_buffer() - add handover buffer information to the fdt
+ * @image:		kexec image being loaded.
+ * @fdt:		Flattened device tree for the next kernel.
+ * @chosen_node:	Offset to the chosen node.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int setup_handover_buffer(const struct kimage *image, void *fdt,
+				 int chosen_node)
+{
+	int ret;
+	const void *prop;
+
+	/* Did we receive a buffer from the previous kernel? */
+	prop = fdt_getprop(fdt, chosen_node,
+			   "linux,kexec-handover-buffer-start", NULL);
+	if (prop) {
+		u64 orig_start, orig_end;
+		unsigned long size;
+		void *addr;
+
+		orig_start = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		prop = fdt_getprop(fdt, chosen_node,
+				   "linux,kexec-handover-buffer-end", NULL);
+		if (!prop) {
+			pr_err("Malformed device tree.\n");
+			return -EINVAL;
+		}
+		orig_end = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		/* Did we free the hand-over buffer from the previous kernel? */
+		ret = kexec_get_handover_buffer(&addr, &size);
+		if (ret == -ENOENT)
+			addr = NULL;
+		else if (ret)
+			return ret;
+
+		/*
+		 * If we received a buffer from the previous kernel but deleted
+		 * it from the live DT, or if we have a new buffer for the next
+		 * kernel then we should remove the memory reservation from
+		 * the FDT.
+		 */
+		if (addr == NULL || image->arch.handover_buffer_addr != 0) {
+			ret = delete_fdt_mem_rsv(fdt, orig_start,
+						 orig_end - orig_start);
+			if (ret == 0)
+				pr_debug("Removed old hand-over buffer reservation.\n");
+			else if (ret != -ENOENT)
+				return ret;
+		}
+
+		/*
+		 * If we received a buffer from the previous kernel but deleted
+		 * it from the live DT and we have no buffer for the next kernel
+		 * then we should remove the hand-over buffer properties from
+		 * the FDT.
+		 */
+		if (addr == NULL && image->arch.handover_buffer_addr == 0) {
+			ret = fdt_delprop(fdt, chosen_node,
+					  "linux,kexec-handover-buffer-start");
+			if (ret) {
+				pr_err("Error setting up the new device tree.\n");
+				return -EINVAL;
+			}
+
+			ret = fdt_delprop(fdt, chosen_node,
+					  "linux,kexec-handover-buffer-end");
+			if (ret) {
+				pr_err("Error setting up the new device tree.\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (image->arch.handover_buffer_addr == 0)
+		return 0;
+
+	ret = fdt_setprop_u64(fdt, chosen_node,
+			      "linux,kexec-handover-buffer-start",
+			      image->arch.handover_buffer_addr);
+	if (ret < 0)
+		return -EINVAL;
+
+	/* -end is the first address after the buffer. */
+	ret = fdt_setprop_u64(fdt, chosen_node,
+			      "linux,kexec-handover-buffer-end",
+			      image->arch.handover_buffer_addr +
+			      image->arch.handover_buffer_size);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = fdt_add_mem_rsv(fdt, image->arch.handover_buffer_addr,
+			      image->arch.handover_buffer_size);
+	if (ret)
+		return -EINVAL;
+
+	pr_debug("kexec handover buffer at 0x%llx, size = 0x%lx\n",
+		 image->arch.handover_buffer_addr,
+		 image->arch.handover_buffer_size);
+
+	return 0;
+}
+
+/**
+ * setup_new_fdt() - modify /chosen and memory reservations for the next kernel
+ * @image:		kexec image being loaded.
+ * @fdt:		Flattened device tree for the next kernel.
+ * @initrd_load_addr:	Address where the next initrd will be loaded.
+ * @initrd_len:		Size of the next initrd, or 0 if there will be none.
+ * @cmdline:		Command line for the next kernel, or NULL if there will
+ *			be none.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int setup_new_fdt(const struct kimage *image, void *fdt,
+		  unsigned long initrd_load_addr, unsigned long initrd_len,
+		  const char *cmdline)
+{
+	int ret, chosen_node;
+	const void *prop;
+
+	/* Remove memory reservation for the current device tree. */
+	ret = delete_fdt_mem_rsv(fdt, __pa(initial_boot_params),
+				 fdt_totalsize(initial_boot_params));
+	if (ret == 0)
+		pr_debug("Removed old device tree reservation.\n");
+	else if (ret != -ENOENT)
+		return ret;
+
 	chosen_node = fdt_path_offset(fdt, "/chosen");
 	if (chosen_node == -FDT_ERR_NOTFOUND) {
 		chosen_node = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
@@ -743,7 +937,7 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 	/* Did we boot using an initrd? */
 	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
 	if (prop) {
-		uint64_t tmp_start, tmp_end, tmp_size, tmp_sizepg;
+		uint64_t tmp_start, tmp_end, tmp_size;
 
 		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
 
@@ -759,30 +953,14 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
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
@@ -840,6 +1018,12 @@ int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 		}
 	}
 
+	ret = setup_handover_buffer(image, fdt, chosen_node);
+	if (ret) {
+		pr_err("Error setting up the new device tree.\n");
+		return ret;
+	}
+
 	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
 	if (ret) {
 		pr_err("Error setting up the new device tree.\n");
-- 
1.9.1
