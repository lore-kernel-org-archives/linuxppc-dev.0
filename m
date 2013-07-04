Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA55D2C0473
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:55:43 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH v2 6/8] powerpc: introduce early_get_first_memblock_info
Date: Thu, 4 Jul 2013 20:54:12 +0800
Message-ID: <1372942454-25191-7-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
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
A new patch in v2.

 arch/powerpc/kernel/prom.c | 24 ++++++++++++++++++++++++
 include/linux/of_fdt.h     |  1 +
 2 files changed, 25 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index eb23ac9..9a69d2d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -753,6 +753,30 @@ void __init early_init_devtree(void *params)
 	DBG(" <- early_init_devtree()\n");
 }
 
+#ifdef CONFIG_RELOCATABLE
+/*
+ * This function run before early_init_devtree, so we have to init
+ * initial_boot_params. Since early_init_dt_scan_memory_ppc will be
+ * executed again in early_init_devtree, we have to reinitialize the
+ * memblock data before return.
+ */
+void __init early_get_first_memblock_info(void *params, phys_addr_t *size)
+{
+	/* Setup flat device-tree pointer */
+	initial_boot_params = params;
+
+	/* Scan memory nodes and rebuild MEMBLOCKs */
+	of_scan_flat_dt(early_init_dt_scan_root, NULL);
+	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
+
+	if (size)
+		*size = first_memblock_size;
+
+	/* Undo what early_init_dt_scan_memory_ppc does to memblock */
+	memblock_reinit();
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
1.8.1.4
