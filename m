Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9NxP3YCRzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:08:57 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BN8g2V086880
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:08:55 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24ryurx55h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:08:55 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 20:08:53 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id DB5A11DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:08:40 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BN8n9D58195978
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 20:08:49 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BN8mKj027511
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 20:08:49 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v5 11/13] powerpc: Allow userspace to set device tree
 properties in kexec_file_load
Date: Thu, 11 Aug 2016 20:08:16 -0300
In-Reply-To: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1470956898-5991-12-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement the arch_kexec_verify_buffer hook to verify that a device
tree blob passed by userspace via kexec_file_load contains only nodes
and properties from a whitelist.

In elf64_load we merge those properties into the device tree that
will be passed to the next kernel.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kexec.h       |   1 +
 arch/powerpc/kernel/kexec_elf_64.c     |   9 ++
 arch/powerpc/kernel/machine_kexec_64.c | 242 +++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index f263cc867891..31bc64e07c8f 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -99,6 +99,7 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 int setup_new_fdt(void *fdt, unsigned long initrd_load_addr,
 		  unsigned long initrd_len, const char *cmdline);
 bool find_debug_console(const void *fdt, int chosen_node);
+int merge_partial_dtb(void *to, const void *from);
 #endif /* CONFIG_KEXEC_FILE */
 
 #else /* !CONFIG_KEXEC */
diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
index 49cba9509464..1b902ad66e2a 100644
--- a/arch/powerpc/kernel/kexec_elf_64.c
+++ b/arch/powerpc/kernel/kexec_elf_64.c
@@ -210,6 +210,15 @@ void *elf64_load(struct kimage *image, char *kernel_buf,
 		goto out;
 	}
 
+	/* Add nodes and properties from the DTB passed by userspace. */
+	if (image->dtb_buf) {
+		ret = merge_partial_dtb(fdt, image->dtb_buf);
+		if (ret) {
+			pr_err("Error merging partial device tree.\n");
+			goto out;
+		}
+	}
+
 	ret = setup_new_fdt(fdt, initrd_load_addr, initrd_len, cmdline);
 	if (ret)
 		goto out;
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 527f98efe651..a484a6346146 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -35,6 +35,7 @@
 #include <asm/kexec_elf_64.h>
 
 #define SLAVE_CODE_SIZE		256
+#define MAX_DT_PATH		512
 
 #ifdef CONFIG_KEXEC_FILE
 static struct kexec_file_ops *kexec_file_loaders[] = {
@@ -908,4 +909,245 @@ bool find_debug_console(const void *fdt, int chosen_node)
 	return false;
 }
 
+/**
+ * struct allowed_node - a node in the whitelist and its allowed properties.
+ * @name:		node name or full node path
+ * @properties:		NULL-terminated array of names or name=value pairs
+ *
+ * If name starts with /, then the node has to be at the specified path in
+ * the device tree (including unit addresses for all nodes in the path).
+ * If it doesn't, then the node can be anywhere in the device tree.
+ *
+ * An entry in properties can specify a string value that the property must
+ * have by using the "name=value" format. If the entry ends with =, it means
+ * that the property must be empty.
+ */
+static struct allowed_node {
+	const char *name;
+	const char *properties[9];
+} allowed_nodes[] = {
+	{
+		.name = "/chosen",
+		.properties = {
+			"stdout-path",
+			"linux,stdout-path",
+			NULL,
+		}
+	},
+	{
+		.name = "vga",
+		.properties = {
+			"device_type=display",
+			"assigned-addresses",
+			"width",
+			"height",
+			"depth",
+			"little-endian=",
+			"linux,opened=",
+			"linux,boot-display=",
+			NULL,
+		}
+	},
+};
+
+/**
+ * verify_properties() - verify that all properties in a node are allowed
+ * @properties:	Array of allowed properties in the node.
+ * @fdt:	Device tree blob.
+ * @node:	Offset to node being verified.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int verify_properties(const char *properties[], const void *fdt, int node)
+{
+	int prop;
+
+	for (prop = fdt_first_property_offset(fdt, node); prop >= 0;
+	     prop = fdt_next_property_offset(fdt, prop)) {
+		const char *prop_name;
+		const void *prop_val;
+		int i;
+
+		prop_val = fdt_getprop_by_offset(fdt, prop, &prop_name, NULL);
+		if (prop_val == NULL) {
+			pr_debug("Error reading device tree.\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; properties[i] != NULL; i++) {
+			size_t len;
+			const char *allowed_prop = properties[i];
+
+			len = strchrnul(allowed_prop, '=') - allowed_prop;
+			if (!strncmp(allowed_prop, prop_name, len)) {
+				if (strchr(allowed_prop, '=') != NULL)
+					/* We only support checking strings. */
+					if (strcmp(allowed_prop + len + 1, prop_val)) {
+						pr_debug("Device tree property %s has an invalid value for node %s.\n",
+							 prop_name, fdt_get_name(fdt, node, NULL));
+						return -EINVAL;
+					}
+
+				break;
+			}
+		}
+
+		if (properties[i] == NULL) {
+			pr_debug("Device tree property not allowed for node %s: %s\n",
+				 fdt_get_name(fdt, node, NULL), prop_name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int arch_kexec_verify_buffer(enum kexec_file_type type, const void *buf,
+			     unsigned long size)
+{
+	int node;
+
+	if (type != KEXEC_FILE_TYPE_PARTIAL_DTB) {
+		pr_debug("Invalid file type.\n");
+		return -EINVAL;
+	}
+
+	if (fdt_check_header(buf)) {
+		pr_debug("Malformed device tree.\n");
+		return -EINVAL;
+	}
+
+	if (fdt_num_mem_rsv(buf) != 0) {
+		pr_debug("Device tree has memory reservations.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Check that the device tree only has nodes and properties listed
+	 * in the whitelist.
+	 */
+	for (node = fdt_next_node(buf, -1, NULL); node >= 0;
+	     node = fdt_next_node(buf, node, NULL)) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(allowed_nodes); i++) {
+			int ret;
+
+			if (allowed_nodes[i].name[0] == '/') {
+				char path[MAX_DT_PATH];
+
+				if (fdt_get_path(buf, node, path, sizeof(path))) {
+					pr_debug("Error reading device tree.\n");
+					return -EINVAL;
+				}
+
+				if (!strcmp(allowed_nodes[i].name, path)) {
+					ret = verify_properties(allowed_nodes[i].properties,
+								buf, node);
+					if (ret)
+						return ret;
+
+					break;
+				}
+			} else {
+				const char *name;
+				size_t len;
+
+				name = fdt_get_name(buf, node, NULL);
+				if (name == NULL) {
+					pr_debug("Error reading device tree.\n");
+					return -EINVAL;
+				}
+
+				len = strchrnul(name, '@') - name;
+				if (!strncmp(allowed_nodes[i].name, name, len)) {
+					ret = verify_properties(allowed_nodes[i].properties,
+								buf, node);
+					if (ret)
+						return ret;
+
+					break;
+				}
+			}
+		}
+
+		/*
+		 * If a node isn't in the whitelist but has at least one subnode
+		 * and no properties we allow it, since there may be a
+		 * whitelisted node under it.
+		 */
+		if (i == ARRAY_SIZE(allowed_nodes) &&
+		    (fdt_first_property_offset(buf, node) != -FDT_ERR_NOTFOUND ||
+		     fdt_first_subnode(buf, node) == -FDT_ERR_NOTFOUND)) {
+			pr_debug("Device tree node not allowed: %s\n",
+				 fdt_get_name(buf, node, NULL));
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * merge_partial_dtb() - copy all nodes and properties from one DTB to another
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int merge_partial_dtb(void *to, const void *from)
+{
+	int from_node;
+
+	for (from_node = fdt_next_node(from, -1, NULL); from_node >= 0;
+	     from_node = fdt_next_node(from, from_node, NULL)) {
+		int prop, to_node;
+		char path[MAX_DT_PATH];
+
+		if (fdt_get_path(from, from_node, path, sizeof(path))) {
+			pr_debug("Error reading device tree.\n");
+			return -EINVAL;
+		}
+
+		to_node = fdt_path_offset(to, path);
+		if (to_node == -FDT_ERR_NOTFOUND) {
+			/* We allow creating /chosen if it doesn't exist. */
+			if (strcmp(path, "/chosen")) {
+				pr_debug("%s doesn't exist in the device tree.\n",
+					 path);
+				return -EINVAL;
+			}
+
+			to_node = fdt_add_subnode(to, fdt_path_offset(to, "/"),
+						  "chosen");
+			if (to_node < 0) {
+				pr_debug("Error creating the /chosen node.\n");
+				return -EINVAL;
+			}
+		} else if (to_node < 0) {
+			pr_debug("Error reading device tree.\n");
+			return -EINVAL;
+		}
+
+		for (prop = fdt_first_property_offset(from, from_node); prop >= 0;
+		     prop = fdt_next_property_offset(from, prop)) {
+			const char *name;
+			const void *val;
+			int len, ret;
+
+			val = fdt_getprop_by_offset(from, prop, &name, &len);
+			if (val == NULL) {
+				pr_debug("Error reading device tree.\n");
+				return -EINVAL;
+			}
+
+			ret = fdt_setprop(to, to_node, name, val, len);
+			if (ret) {
+				pr_debug("Error writing new device tree.\n");
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
 #endif /* CONFIG_KEXEC_FILE */
-- 
1.9.1
