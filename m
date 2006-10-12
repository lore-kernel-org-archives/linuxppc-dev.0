Return-Path: <mgreer@mvista.com>
Date: Wed, 11 Oct 2006 18:35:44 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/4] powerpc: Add simple memory allocator to bootwrapper
Message-ID: <20061012013544.GE9143@mag.az.mvista.com>
References: <20061012013223.GA9143@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061012013223.GA9143@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Provide primitive malloc, free, and realloc functions for bootwrapper.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 Makefile       |    2 
 simple_alloc.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+), 1 deletion(-)
---

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ef1bec4..895e537 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -41,7 +41,7 @@ zliblinuxheader := zlib.h zconf.h zutil.
 		$(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S stdio.c main.c flatdevtree.c flatdevtree_misc.c ns16550.c \
-		serial.c div64.S util.S $(zlib)
+		serial.c simple_alloc.c div64.S util.S $(zlib)
 src-plat := of.c
 src-boot := crt0.S $(src-wlib) $(src-plat) empty.c
 
diff --git a/arch/powerpc/boot/simple_alloc.c b/arch/powerpc/boot/simple_alloc.c
new file mode 100644
index 0000000..478a381
--- /dev/null
+++ b/arch/powerpc/boot/simple_alloc.c
@@ -0,0 +1,147 @@
+/*
+ * Implement primitive realloc(3) functionality.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <stddef.h>
+#include "types.h"
+#include "page.h"
+#include "string.h"
+#include "ops.h"
+
+#define	ENTRY_BEEN_USED	0x01
+#define	ENTRY_IN_USE	0x02
+
+static struct alloc_info {
+	u32	flags;
+	u32	base;
+	u32	size;
+} *alloc_tbl;
+
+static u32 tbl_entries;
+static u32 alloc_min;
+static u32 space_left;
+
+/*
+ * First time an entry is used, its base and size are set.
+ * An entry can be freed and re-malloc'd but its base & size don't change.
+ * Should be smart enough for needs of bootwrapper.
+ */
+static void *simple_malloc(u32 size)
+{
+	u32 i;
+	struct alloc_info *p = alloc_tbl, *prevp = NULL;
+
+	if (size == 0)
+		goto err_out;
+
+	size = _ALIGN_UP(size, alloc_min);
+
+	for (i=0; i<tbl_entries; i++) {
+		if (!(p->flags & ENTRY_BEEN_USED)) { /* never been used */
+			if (size <= space_left) {
+				if (i > 0)
+					p->base = prevp->base + prevp->size;
+				p->size = size;
+				p->flags = ENTRY_BEEN_USED | ENTRY_IN_USE;
+				space_left -= size;
+				return (void *)p->base;
+			}
+			goto err_out; /* not enough space left */
+		}
+		/* reuse an entry keeping same base & size */
+		else if (!(p->flags & ENTRY_IN_USE) && (size <= p->size)) {
+			p->flags |= ENTRY_IN_USE;
+			return (void *)p->base;
+		}
+		prevp = p++;
+	}
+err_out:
+	return NULL;
+}
+
+static struct alloc_info *simple_find_entry(void *ptr)
+{
+	u32 i;
+	struct alloc_info *p = alloc_tbl;
+
+	for (i=0; i<tbl_entries; i++,p++) {
+		if (!(p->flags & ENTRY_BEEN_USED))
+			break;
+		if ((p->flags & ENTRY_IN_USE) && (p->base == (u32)ptr))
+			return p;
+	}
+	return NULL;
+}
+
+static void simple_free(void *ptr)
+{
+	struct alloc_info *p = simple_find_entry(ptr);
+
+	if (p != NULL)
+		p->flags &= ~ENTRY_IN_USE;
+}
+
+/*
+ * Change size of area pointed to by 'ptr' to 'size'.
+ * If 'ptr' is NULL, then its a malloc().  If 'size' is 0, then its a free().
+ * 'ptr' must be NULL or a value previously returned by simple_realloc().
+ */
+static void *simple_realloc(void *ptr, unsigned long size)
+{
+	struct alloc_info *p;
+	void *new;
+
+	if (size == 0) {
+		simple_free(ptr);
+		return NULL;
+	}
+
+	/* also malloc if ptr didn't come from simple_malloc/realloc */
+	if ((ptr == NULL) || ((p = simple_find_entry(ptr)) == NULL))
+		return simple_malloc(size);
+
+	if (size <= p->size) /* fits in current block */
+		return ptr;
+
+	new = simple_malloc(size);
+	memcpy(new, ptr, p->size);
+	simple_free(ptr);
+	return new;
+}
+
+/*
+ * Returns addr of first byte after heap so caller can see if it took
+ * too much space.  If so, change args & try again.
+ */
+void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
+		u32 max_allocs)
+{
+	u32 heap_base, tbl_size;
+
+	heap_size = _ALIGN_UP(heap_size, granularity);
+	alloc_min = granularity;
+	tbl_entries = max_allocs;
+
+	tbl_size = tbl_entries * sizeof(struct alloc_info);
+
+	alloc_tbl = (struct alloc_info *)_ALIGN_UP((unsigned long)base, 8);
+	memset(alloc_tbl, 0, tbl_size);
+
+	heap_base = _ALIGN_UP((u32)alloc_tbl + tbl_size, alloc_min);
+
+	alloc_tbl[0].base = heap_base;
+	space_left = heap_size;
+
+	platform_ops.malloc = simple_malloc;
+	platform_ops.free = simple_free;
+	platform_ops.realloc = simple_realloc;
+
+	return (void *)(heap_base + heap_size);
+}
