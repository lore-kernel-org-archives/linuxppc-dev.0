Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSkjw1tjBzDrpV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 08:22:12 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85MHjnB075142
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 18:22:10 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259dmk6bq8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 18:22:10 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 5 Sep 2016 19:22:08 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9AE113520070
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 18:21:42 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85MM5CU5234792
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:22:05 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85MM38J015955
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:22:05 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v8 10/13] powerpc: Add code to work with device trees in
 kexec_file_load.
Date: Mon,  5 Sep 2016 19:20:11 -0300
In-Reply-To: <1473114014-20769-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1473114014-20769-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1473114014-20769-11-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kexec_file_load needs to set up the device tree that will be used
by the next kernel and check whether it provides a console
that can be used by the purgatory.

[akpm@linux-foundation.org: coding-style fixes]
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/powerpc/include/asm/kexec.h       |   3 +
 arch/powerpc/kernel/machine_kexec_64.c | 221 +++++++++++++++++++++++++++++++++
 2 files changed, 224 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 0c7e020d935a..73f88b5f9bd1 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -96,6 +96,9 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 		    const void *fdt, unsigned long kernel_load_addr,
 		    unsigned long fdt_load_addr, unsigned long stack_top,
 		    int debug);
+int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
+		  unsigned long initrd_len, const char *cmdline);
+bool find_debug_console(const void *fdt);
 #endif /* CONFIG_KEXEC_FILE */
 
 #else /* !CONFIG_KEXEC_CORE */
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 1e678dc5096a..31c5090705e0 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -683,4 +683,225 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 	return 0;
 }
 
+/*
+ * setup_new_fdt() - modify /chosen and memory reservation for the next kernel
+ * @fdt:
+ * @initrd_load_addr:	Address where the next initrd will be loaded.
+ * @initrd_len:		Size of the next initrd, or 0 if there will be none.
+ * @cmdline:		Command line for the next kernel, or NULL if there will
+ *			be none.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
+		  unsigned long initrd_len, const char *cmdline)
+{
+	uint64_t oldfdt_addr;
+	int i, ret, chosen_node;
+	const void *prop;
+
+	/* Remove memory reservation for the current device tree. */
+	oldfdt_addr = __pa(initial_boot_params);
+	for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
+		uint64_t rsv_start, rsv_size;
+
+		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+		if (ret) {
+			pr_err("Malformed device tree.\n");
+			return -EINVAL;
+		}
+
+		if (rsv_start == oldfdt_addr &&
+		    rsv_size == fdt_totalsize(initial_boot_params)) {
+			ret = fdt_del_mem_rsv(fdt, i);
+			if (ret) {
+				pr_err("Error deleting fdt reservation.\n");
+				return -EINVAL;
+			}
+
+			pr_debug("Removed old device tree reservation.\n");
+			break;
+		}
+	}
+
+	chosen_node = fdt_path_offset(fdt, "/chosen");
+	if (chosen_node == -FDT_ERR_NOTFOUND) {
+		chosen_node = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
+					      "chosen");
+		if (chosen_node < 0) {
+			pr_err("Error creating /chosen.\n");
+			return -EINVAL;
+		}
+	} else if (chosen_node < 0) {
+		pr_err("Malformed device tree: error reading /chosen.\n");
+		return -EINVAL;
+	}
+
+	/* Did we boot using an initrd? */
+	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
+	if (prop) {
+		uint64_t tmp_start, tmp_end, tmp_size, tmp_sizepg;
+
+		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
+		if (!prop) {
+			pr_err("Malformed device tree.\n");
+			return -EINVAL;
+		}
+		tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		/*
+		 * kexec reserves exact initrd size, while firmware may
+		 * reserve a multiple of PAGE_SIZE, so check for both.
+		 */
+		tmp_size = tmp_end - tmp_start;
+		tmp_sizepg = round_up(tmp_size, PAGE_SIZE);
+
+		/* Remove memory reservation for the current initrd. */
+		for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
+			uint64_t rsv_start, rsv_size;
+
+			ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+			if (ret) {
+				pr_err("Malformed device tree.\n");
+				return -EINVAL;
+			}
+
+			if (rsv_start == tmp_start &&
+			    (rsv_size == tmp_size || rsv_size == tmp_sizepg)) {
+				ret = fdt_del_mem_rsv(fdt, i);
+				if (ret) {
+					pr_err("Error deleting fdt reservation.\n");
+					return -EINVAL;
+				}
+				pr_debug("Removed old initrd reservation.\n");
+
+				break;
+			}
+		}
+
+		/* If there's no new initrd, delete the old initrd's info. */
+		if (initrd_len == 0) {
+			ret = fdt_delprop(fdt, chosen_node,
+					  "linux,initrd-start");
+			if (ret) {
+				pr_err("Error deleting linux,initrd-start.\n");
+				return -EINVAL;
+			}
+
+			ret = fdt_delprop(fdt, chosen_node, "linux,initrd-end");
+			if (ret) {
+				pr_err("Error deleting linux,initrd-end.\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (initrd_len) {
+		ret = fdt_setprop_u64(fdt, chosen_node,
+				      "linux,initrd-start",
+				      initrd_load_addr);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			return -EINVAL;
+		}
+
+		/* initrd-end is the first address after the initrd image. */
+		ret = fdt_setprop_u64(fdt, chosen_node, "linux,initrd-end",
+				      initrd_load_addr + initrd_len);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			return -EINVAL;
+		}
+
+		ret = fdt_add_mem_rsv(fdt, initrd_load_addr, initrd_len);
+		if (ret) {
+			pr_err("Error reserving initrd memory: %s\n",
+			       fdt_strerror(ret));
+			return -EINVAL;
+		}
+	}
+
+	if (cmdline != NULL) {
+		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
+		if (ret < 0) {
+			pr_err("Error setting up the new device tree.\n");
+			return -EINVAL;
+		}
+	} else {
+		ret = fdt_delprop(fdt, chosen_node, "bootargs");
+		if (ret && ret != -FDT_ERR_NOTFOUND) {
+			pr_err("Error deleting bootargs.\n");
+			return -EINVAL;
+		}
+	}
+
+	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
+	if (ret) {
+		pr_err("Error setting up the new device tree.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * find_debug_console() - find out whether there is a console for the purgatory
+ * @fdt:		Flattened device tree to search.
+ */
+bool find_debug_console(const void *fdt)
+{
+	int len;
+	int console_node, chosen_node;
+	const void *prop, *colon;
+
+	chosen_node = fdt_path_offset(fdt, "/chosen");
+	if (chosen_node < 0) {
+		pr_err("Malformed device tree: /chosen not found.\n");
+		return false;
+	}
+
+	prop = fdt_getprop(fdt, chosen_node, "stdout-path", &len);
+	if (prop == NULL) {
+		if (len == -FDT_ERR_NOTFOUND) {
+			prop = fdt_getprop(fdt, chosen_node,
+					   "linux,stdout-path", &len);
+			if (prop == NULL) {
+				pr_debug("Unable to find [linux,]stdout-path.\n");
+				return false;
+			}
+		} else {
+			pr_debug("Error finding console: %s\n",
+				 fdt_strerror(len));
+			return false;
+		}
+	}
+
+	/*
+	 * stdout-path can have a ':' separating the path from device-specific
+	 * information, so we should only consider what's before it.
+	 */
+	colon = strchr(prop, ':');
+	if (colon != NULL)
+		len = colon - prop;
+	else
+		len -= 1;	/* Ignore the terminating NUL. */
+
+	console_node = fdt_path_offset_namelen(fdt, prop, len);
+	if (console_node < 0) {
+		pr_debug("Error finding console: %s\n",
+			 fdt_strerror(console_node));
+		return false;
+	}
+
+	if (fdt_node_check_compatible(fdt, console_node, "hvterm1") == 0)
+		return true;
+	else if (fdt_node_check_compatible(fdt, console_node,
+					   "hvterm-protocol") == 0)
+		return true;
+
+	return false;
+}
+
 #endif /* CONFIG_KEXEC_FILE */
-- 
1.9.1
