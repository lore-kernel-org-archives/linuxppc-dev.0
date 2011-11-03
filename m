Return-Path: <anton@samba.org>
Date: Thu, 3 Nov 2011 11:56:12 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Add System RAM to /proc/iomem
Message-ID: <20111103115612.1558c0dc@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We've resisted adding System RAM to /proc/iomem because it is
the wrong place for it. Unfortunately we continue to find tools
that rely on this behaviour so give up and add it in.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/mm/mem.c
===================================================================
--- linux-build.orig/arch/powerpc/mm/mem.c	2011-11-03 11:28:48.128478738 +1100
+++ linux-build/arch/powerpc/mm/mem.c	2011-11-03 11:53:39.002465556 +1100
@@ -34,6 +34,7 @@
 #include <linux/suspend.h>
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
+#include <linux/slab.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -549,3 +550,32 @@ void update_mmu_cache(struct vm_area_str
 	hash_preload(vma->vm_mm, address, access, trap);
 #endif /* CONFIG_PPC_STD_MMU */
 }
+
+/*
+ * System memory should not be in /proc/iomem but various tools expect it
+ * (eg kdump).
+ */
+static int add_system_ram_resources(void)
+{
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg) {
+		struct resource *res;
+		unsigned long base = reg->base;
+		unsigned long size = reg->size;
+
+		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+		WARN_ON(!res);
+
+		if (res) {
+			res->name = "System RAM";
+			res->start = base;
+			res->end = base + size - 1;
+			res->flags = IORESOURCE_MEM;
+			WARN_ON(request_resource(&iomem_resource, res) < 0);
+		}
+	}
+
+	return 0;
+}
+subsys_initcall(add_system_ram_resources);
