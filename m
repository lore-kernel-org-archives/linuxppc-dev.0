Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 677E92C0796
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 11:23:12 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH v3 5/7] powerpc: introduce early_get_first_memblock_info
Date: Wed, 7 Aug 2013 09:18:33 +0800
Message-ID: <1375838315-27797-6-git-send-email-haokexin@gmail.com>
In-Reply-To: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
References: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
v3: Introduce a variable to avoid to mess the memblock.

v2: A new patch in v2.

 arch/powerpc/kernel/prom.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/of_fdt.h     |  1 +
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index eb23ac9..bfd525e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -521,6 +521,20 @@ static int __init early_init_dt_scan_memory_ppc(unsigned long node,
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
@@ -541,7 +555,8 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 	}
 
 	/* Add the chunk to the MEMBLOCK list */
-	memblock_add(base, size);
+	if (add_mem_to_memblock)
+		memblock_add(base, size);
 }
 
 void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
@@ -753,6 +768,30 @@ void __init early_init_devtree(void *params)
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
index ed136ad..befe744 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -117,6 +117,7 @@ extern int early_init_dt_scan_root(unsigned long node, const char *uname,
 /* Other Prototypes */
 extern void unflatten_device_tree(void);
 extern void early_init_devtree(void *);
+extern void early_get_first_memblock_info(void *, phys_addr_t *);
 #else /* CONFIG_OF_FLATTREE */
 static inline void unflatten_device_tree(void) {}
 #endif /* CONFIG_OF_FLATTREE */
-- 
1.8.3.1
