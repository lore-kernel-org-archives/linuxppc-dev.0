Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 25 Oct 2005 16:59:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20051025165903.3d4cf14c.sfr@canb.auug.org.au>
In-Reply-To: <20051025165643.39cac31d.sfr@canb.auug.org.au>
References: <20051025165643.39cac31d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc: merge scatterlist.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This depends on the 64bit dma_addr_t patch.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-powerpc/scatterlist.h |   45 +++++++++++++++++++++++++++++++++++++
 include/asm-ppc/scatterlist.h     |   25 ---------------------
 include/asm-ppc64/scatterlist.h   |   31 -------------------------
 3 files changed, 45 insertions(+), 56 deletions(-)
 create mode 100644 include/asm-powerpc/scatterlist.h
 delete mode 100644 include/asm-ppc/scatterlist.h
 delete mode 100644 include/asm-ppc64/scatterlist.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
d
b7d026746092f2b10eb5c2931aac88cdbec3eb3
diff --git a/include/asm-powerpc/scatterlist.h b/include/asm-powerpc/scatterlist.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/scatterlist.h
@@ -0,0 +1,45 @@
+#ifndef _ASM_POWERPC_SCATTERLIST_H
+#define _ASM_POWERPC_SCATTERLIST_H
+/*
+ * Copyright (C) 2001 PPC64 Team, IBM Corp
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <asm/dma.h>
+
+struct scatterlist {
+	struct page *page;
+	unsigned int offset;
+	unsigned int length;
+
+	/* For TCE support */
+	dma_addr_t dma_address;
+	u32 dma_length;
+};
+
+/*
+ * These macros should be used after a dma_map_sg call has been done
+ * to get bus addresses of each of the SG entries and their lengths.
+ * You should only work with the number of sg entries pci_map_sg
+ * returns, or alternatively stop on the first sg_dma_len(sg) which
+ * is 0.
+ */
+#define sg_dma_address(sg)	((sg)->dma_address)
+#ifdef __powerpc64__
+#define sg_dma_len(sg)		((sg)->dma_length)
+#else
+#define sg_dma_len(sg)		((sg)->length)
+#endif
+
+#ifdef __powerpc64__
+#define ISA_DMA_THRESHOLD	(~0UL)
+#endif
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_SCATTERLIST_H */
diff --git a/include/asm-ppc/scatterlist.h b/include/asm-ppc/scatterlist.h
deleted file mode 100644
--- a/include/asm-ppc/scatterlist.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifdef __KERNEL__
-#ifndef _PPC_SCATTERLIST_H
-#define _PPC_SCATTERLIST_H
-
-#include <asm/dma.h>
-
-struct scatterlist {
-	struct page	*page;
-	unsigned int	offset;
-	dma_addr_t	dma_address;
-	unsigned int	length;
-};
-
-/*
- * These macros should be used after a pci_map_sg call has been done
- * to get bus addresses of each of the SG entries and their lengths.
- * You should only work with the number of sg entries pci_map_sg
- * returns, or alternatively stop on the first sg_dma_len(sg) which
- * is 0.
- */
-#define sg_dma_address(sg)      ((sg)->dma_address)
-#define sg_dma_len(sg)          ((sg)->length)
-
-#endif /* !(_PPC_SCATTERLIST_H) */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc64/scatterlist.h b/include/asm-ppc64/scatterlist.h
deleted file mode 100644
--- a/include/asm-ppc64/scatterlist.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef _PPC64_SCATTERLIST_H
-#define _PPC64_SCATTERLIST_H
-
-/*
- * Copyright (C) 2001 PPC64 Team, IBM Corp
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/types.h>
-#include <asm/dma.h>
-
-struct scatterlist {
-	struct page *page;
-	unsigned int offset;
-	unsigned int length;
-
-	/* For TCE support */
-	dma_addr_t dma_address;
-	u32 dma_length;
-};
-
-#define sg_dma_address(sg)	((sg)->dma_address)
-#define sg_dma_len(sg)		((sg)->dma_length)
-
-#define ISA_DMA_THRESHOLD	(~0UL)
-
-#endif /* !(_PPC64_SCATTERLIST_H) */
