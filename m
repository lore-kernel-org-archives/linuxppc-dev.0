Date: Thu, 13 Nov 2003 14:25:12 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: paulus@samba.org, ebs@ebshome.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Make consistent_sync_page() highmem safe
Message-ID: <20031113142512.D10903@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

consistent_sync_page() is currently not highmem safe on
non coherent platforms.  PPC44x, for example, allows very
large system memory (2GB).  The following patch addresses
this by kmap/kunmapping each segment of the buffer before
calling consistent_sync().  It is interrupt safe since the
streaming DMA API callers can be called from an interrupt
context.

The code is only used on non-coherent systems and only if
highmem support is enabled.

Comments?

-Matt

===== include/asm-ppc/kmap_types.h 1.14 vs edited =====
--- 1.14/include/asm-ppc/kmap_types.h	Thu Feb  6 13:06:42 2003
+++ edited/include/asm-ppc/kmap_types.h	Thu Nov 13 14:04:51 2003
@@ -16,6 +16,7 @@
 	KM_IRQ1,
 	KM_SOFTIRQ0,
 	KM_SOFTIRQ1,
+	KM_PPC_SYNC_PAGE,
 	KM_TYPE_NR
 };

===== arch/ppc/mm/cachemap.c 1.15 vs edited =====
--- 1.15/arch/ppc/mm/cachemap.c	Sun Oct  5 18:25:15 2003
+++ edited/arch/ppc/mm/cachemap.c	Thu Nov 13 14:19:59 2003
@@ -36,6 +36,7 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>

 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -157,16 +158,63 @@
 	}
 }

+#ifdef CONFIG_HIGHMEM
 /*
- * consistent_sync_page make a page are consistent. identical
- * to consistent_sync, but takes a struct page instead of a virtual address
+ * consistent_sync_page() implementation for non cache coherent
+ * systems using highmem. In this case, each page of a buffer
+ * must be kmapped/kunmapped in order to have a virtual address
+ * for consistent_sync(). This must be interrupt safe so hard
+ * interrupts are disabled and kmap_atomic() are used when in an
+ * interrupt context.
  */
+static inline void __consistent_sync_page(struct page *page,
+		unsigned long offset, size_t size, int direction,
+		int in_int)
+{
+	size_t seg_size = min((size_t)PAGE_SIZE, size) - offset;
+	size_t cur_size = seg_size;
+	unsigned long start, seg_offset = offset;
+	int nr_segs = PAGE_ALIGN(size + (PAGE_SIZE - offset))/PAGE_SIZE;
+	int seg_nr = 0;
+	int flags;
+
+	if (in_int) local_irq_save(flags);
+
+	do {
+		if (in_int)
+			start = (unsigned long)kmap_atomic(page + seg_nr, KM_PPC_SYNC_PAGE) + seg_offset;
+		else
+			start = (unsigned long)kmap(page + seg_nr) + seg_offset;
+		/* Sync this buffer segment */
+		consistent_sync((void *)start, seg_size, direction);
+		if (in_int)
+			kunmap_atomic((void *)start, KM_PPC_SYNC_PAGE);
+		else
+			kunmap(page + seg_nr);
+		seg_nr++;
+		/* Calculate next buffer segment size */
+		seg_size = min((size_t)PAGE_SIZE, size - cur_size);
+		/* Add the segment size to our running total */
+		cur_size += seg_size;
+		seg_offset = 0;
+	} while (seg_nr < nr_segs);
+
+	if (in_int) local_irq_restore(flags);
+}
+#endif /* CONFIG_HIGHMEM */

+/*
+ * consistent_sync_page makes memory consistent. identical
+ * to consistent_sync, but takes a struct page instead of a
+ * virtual address
+ */
 void consistent_sync_page(struct page *page, unsigned long offset,
 	size_t size, int direction)
 {
-	unsigned long start;
-
-	start = (unsigned long)page_address(page) + offset;
+#ifdef CONFIG_HIGHMEM
+	__consistent_sync_page(page, offset, size, direction, in_interrupt());
+#else
+	unsigned long start = (unsigned long)page_address(page) + offset;
 	consistent_sync((void *)start, size, direction);
+#endif
 }

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
