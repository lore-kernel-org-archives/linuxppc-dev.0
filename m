Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ECBC52C0164
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 18:13:38 +1100 (EST)
Received: by mail-pa0-f49.google.com with SMTP id kx10so6197420pab.22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 23:13:36 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 06/10] powerpc: introduce early_get_first_memblock_info
Date: Tue, 24 Dec 2013 15:12:08 +0800
Message-Id: <1387869132-12650-7-git-send-email-haokexin@gmail.com>
In-Reply-To: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
References: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a relocatable kernel since it can be loaded at any place, there
is no any relation between the kernel start addr and the memstart_addr.
So we can't calculate the memstart_addr from kernel start addr. And
also we can't wait to do the relocation after we get the real
memstart_addr from device tree because it is so late. So introduce
a new function we can use to get the first memblock address and size
in a very early stage (before machine_init).

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v4: No change.

v3: Introduce a variable to avoid to mess the memblock.

v2: A new patch in v2.

 arch/powerpc/kernel/prom.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/of_fdt.h     |  1 +
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fa0ad8aafbcc..f58c0d3aaeb4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -523,6 +523,20 @@ static int __init early_init_dt_scan_memory_ppc(unsigned long node,
 	return early_init_dt_scan_memory(node, uname, depth, data);
 }
 
+/*
+ * For a relocatable kernel, we need to get the memstart_addr first,
+ * then use it to calculate the virtual kernel start address. This has
+ * to happen at a very early stage (before machine_init). In this case,
+ * we just want to get the memstart_address and would not like to mess the
+ * memblock at this stage. So introduce a variable to skip the memblock_add()
+ * for this reason.
+ */
+#ifdef CONFIG_RELOCATABLE
+static int add_mem_to_memblock = 1;
+#else
+#define add_mem_to_memblock 1
+#endif
+
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 #ifdef CONFIG_PPC64
@@ -543,7 +557,8 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 	}
 
 	/* Add the chunk to the MEMBLOCK list */
-	memblock_add(base, size);
+	if (add_mem_to_memblock)
+		memblock_add(base, size);
 }
 
 static void __init early_reserve_mem_dt(void)
@@ -740,6 +755,30 @@ void __init early_init_devtree(void *params)
 	DBG(" <- early_init_devtree()\n");
 }
 
+#ifdef CONFIG_RELOCATABLE
+/*
+ * This function run before early_init_devtree, so we have to init
+ * initial_boot_params.
+ */
+void __init early_get_first_memblock_info(void *params, phys_addr_t *size)
+{
+	/* Setup flat device-tree pointer */
+	initial_boot_params = params;
+
+	/*
+	 * Scan the memory nodes and set add_mem_to_memblock to 0 to avoid
+	 * mess the memblock.
+	 */
+	add_mem_to_memblock = 0;
+	of_scan_flat_dt(early_init_dt_scan_root, NULL);
+	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
+	add_mem_to_memblock = 1;
+
+	if (size)
+		*size = first_memblock_size;
+}
+#endif
+
 /*******
  *
  * New implementation of the OF "find" APIs, return a refcounted
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 0beaee9dac1f..2b77058a7335 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -116,6 +116,7 @@ extern const void *of_flat_dt_match_machine(const void *default_match,
 extern void unflatten_device_tree(void);
 extern void unflatten_and_copy_device_tree(void);
 extern void early_init_devtree(void *);
+extern void early_get_first_memblock_info(void *, phys_addr_t *);
 #else /* CONFIG_OF_FLATTREE */
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
 static inline void unflatten_device_tree(void) {}
-- 
1.8.3.1
