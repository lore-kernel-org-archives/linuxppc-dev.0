Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC283DDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 05:15:12 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l8JJF71s014871
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 12:15:07 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: rheap-managed bootmem allocator
Date: Wed, 19 Sep 2007 14:15:04 -0500
Message-Id: <1190229304592-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the ability to allocate a block of memory via alloc_bootmem() and manage
that memory with a remote heap (rheap).

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch will conflict with Sylvain's "powerpc: Changes the config mechanism
for rheap" patch, but that patch hasn't been accepted yet, so I'm posting this
for review and comment.

 arch/powerpc/lib/rheap.c    |   79 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/rheap.h |    4 ++
 2 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index ada5b42..d2c8913 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -18,6 +18,8 @@
 #include <linux/mm.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/bootmem.h>
+#include <linux/module.h>
 
 #include <asm/rheap.h>
 
@@ -729,3 +731,80 @@ void rh_dump_blk(rh_info_t * info, rh_block_t * blk)
 	       "blk @0x%p: 0x%lx-0x%lx (%u)\n",
 	       blk, blk->start, blk->start + blk->size, blk->size);
 }
+
+/* Bootmem-allocated rheap
+ *
+ * If the "rhbootmem=X" command-line parameter is specified, then the RHEAP
+ * code will allocate a chunk of memory using alloc_bootmem() and create an
+ * rheap for it.
+*/
+
+static rh_info_t bootmem_rh_info;
+static rh_block_t bootmem_rh_block[16];
+
+static void *bootmem_ptr;
+static unsigned long bootmem_size;
+
+static int __init early_parse_rhbootmem(char *p)
+{
+	if (!p)
+		return 1;
+
+	bootmem_size = _ALIGN_UP(memparse(p, &p), 32);
+
+	return 0;
+}
+early_param("rhbootmem", early_parse_rhbootmem);
+
+static int __init rheap_bootmem_init(void)
+{
+	if (!bootmem_size)
+		return 0;
+
+	bootmem_ptr = __alloc_bootmem(bootmem_size, 32, 0);
+	if (!bootmem_ptr) {
+		printk(KERN_ERR "rheap: cannot allocate %lu bootmem bytes\n",
+			bootmem_size);
+		return -ENOMEM;
+	}
+
+	rh_init(&bootmem_rh_info, 32, ARRAY_SIZE(bootmem_rh_block),
+		bootmem_rh_block);
+
+	rh_attach_region(&bootmem_rh_info, bootmem_ptr, bootmem_size);
+
+	printk(KERN_INFO "rheap: allocated %lu bootmem bytes\n", bootmem_size);
+
+	return 0;
+}
+arch_initcall(rheap_bootmem_init);
+
+/* Allocatate a block from the bootmem
+ *
+ * This function allocates a block of memory from the bootmem
+ */
+void *rheap_bootmem_alloc(size_t size)
+{
+	return rh_alloc(&bootmem_rh_info, size, "BOOTMEM");
+}
+EXPORT_SYMBOL(rheap_bootmem_alloc);
+
+/* Free a previously allocated block
+ */
+void rheap_bootmem_free(void *p, size_t size)
+{
+	if (p)
+		rh_free(&bootmem_rh_info, p);
+}
+EXPORT_SYMBOL(rheap_bootmem_free);
+
+/* Returns 1 if pointer is inside bootmem
+ *
+ * This function tells you if the given pointer points to the allocated
+ * bootmem.
+ */
+int rheap_is_bootmem(void *p)
+{
+	return 	(p >= bootmem_ptr) && (p < (bootmem_ptr + bootmem_size));
+}
+EXPORT_SYMBOL(rheap_is_bootmem);
diff --git a/include/asm-powerpc/rheap.h b/include/asm-powerpc/rheap.h
index 1723817..5a8dee1 100644
--- a/include/asm-powerpc/rheap.h
+++ b/include/asm-powerpc/rheap.h
@@ -86,4 +86,8 @@ extern void rh_dump(rh_info_t * info);
 /* Set owner of taken block */
 extern int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner);
 
+void *rheap_bootmem_alloc(size_t size);
+void rheap_bootmem_free(void *p, size_t size);
+int rheap_is_bootmem(void *p);
+
 #endif				/* __ASM_PPC_RHEAP_H__ */
-- 
1.5.2.4
