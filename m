Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 54B4B68134
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 15:47:28 +1000 (EST)
Received: from oak (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 2107F368024
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 15:47:28 +1000 (EST)
Date: Mon, 29 Aug 2005 14:06:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050829140656.5b9e751f.sfr@canb.auug.org.au>
In-Reply-To: <20050829131550.39e97cf3.sfr@canb.auug.org.au>
References: <20050829130133.519391c6.sfr@canb.auug.org.au>
	<20050829131550.39e97cf3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Resent-Message-Id: <20050829154733.06e37299.sfr@canb.auug.org.au>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@samba.org
Subject: [PATCH 2/3] Move the identical files from include/asm-ppc{,64}
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move the identical files from include/asm-ppc{,64}/ to
include/asm-powerpc/.  Remove hdreg.h completely as it is unused in
the tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-powerpc/8253pit.h           |   10 ++++++++++
 include/asm-powerpc/agp.h               |   23 +++++++++++++++++++++++
 include/asm-powerpc/cputime.h           |    1 +
 include/asm-powerpc/div64.h             |    1 +
 include/asm-powerpc/emergency-restart.h |    1 +
 include/asm-powerpc/ipc.h               |    1 +
 include/asm-powerpc/xor.h               |    1 +
 include/asm-ppc/8253pit.h               |   10 ----------
 include/asm-ppc/agp.h                   |   23 -----------------------
 include/asm-ppc/cputime.h               |    6 ------
 include/asm-ppc/div64.h                 |    1 -
 include/asm-ppc/emergency-restart.h     |    6 ------
 include/asm-ppc/hdreg.h                 |    1 -
 include/asm-ppc/ipc.h                   |    1 -
 include/asm-ppc/xor.h                   |    1 -
 include/asm-ppc64/8253pit.h             |   10 ----------
 include/asm-ppc64/agp.h                 |   23 -----------------------
 include/asm-ppc64/cputime.h             |    6 ------
 include/asm-ppc64/div64.h               |    1 -
 include/asm-ppc64/emergency-restart.h   |    6 ------
 include/asm-ppc64/hdreg.h               |    1 -
 include/asm-ppc64/ipc.h                 |    1 -
 include/asm-ppc64/xor.h                 |    1 -
 23 files changed, 38 insertions(+), 98 deletions(-)
 create mode 100644 include/asm-powerpc/8253pit.h
 create mode 100644 include/asm-powerpc/agp.h
 create mode 100644 include/asm-powerpc/cputime.h
 create mode 100644 include/asm-powerpc/div64.h
 create mode 100644 include/asm-powerpc/emergency-restart.h
 create mode 100644 include/asm-powerpc/ipc.h
 create mode 100644 include/asm-powerpc/xor.h
 delete mode 100644 include/asm-ppc/8253pit.h
 delete mode 100644 include/asm-ppc/agp.h
 delete mode 100644 include/asm-ppc/cputime.h
 delete mode 100644 include/asm-ppc/div64.h
 delete mode 100644 include/asm-ppc/emergency-restart.h
 delete mode 100644 include/asm-ppc/hdreg.h
 delete mode 100644 include/asm-ppc/ipc.h
 delete mode 100644 include/asm-ppc/xor.h
 delete mode 100644 include/asm-ppc64/8253pit.h
 delete mode 100644 include/asm-ppc64/agp.h
 delete mode 100644 include/asm-ppc64/cputime.h
 delete mode 100644 include/asm-ppc64/div64.h
 delete mode 100644 include/asm-ppc64/emergency-restart.h
 delete mode 100644 include/asm-ppc64/hdreg.h
 delete mode 100644 include/asm-ppc64/ipc.h
 delete mode 100644 include/asm-ppc64/xor.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

9ead132760dbd38ffa1bf132703d5fbb77e1081d
diff --git a/include/asm-powerpc/8253pit.h b/include/asm-powerpc/8253pit.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/8253pit.h
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE	1193182UL
+
+#endif
diff --git a/include/asm-powerpc/agp.h b/include/asm-powerpc/agp.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/agp.h
@@ -0,0 +1,23 @@
+#ifndef AGP_H
+#define AGP_H 1
+
+#include <asm/io.h>
+
+/* nothing much needed here */
+
+#define map_page_into_agp(page)
+#define unmap_page_from_agp(page)
+#define flush_agp_mappings()
+#define flush_agp_cache() mb()
+
+/* Convert a physical address to an address suitable for the GART. */
+#define phys_to_gart(x) (x)
+#define gart_to_phys(x) (x)
+
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
+#endif
diff --git a/include/asm-powerpc/cputime.h b/include/asm-powerpc/cputime.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/cputime.h
@@ -0,0 +1 @@
+#include <asm-generic/cputime.h>
diff --git a/include/asm-powerpc/div64.h b/include/asm-powerpc/div64.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/div64.h
@@ -0,0 +1 @@
+#include <asm-generic/div64.h>
diff --git a/include/asm-powerpc/emergency-restart.h b/include/asm-powerpc/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/emergency-restart.h
@@ -0,0 +1 @@
+#include <asm-generic/emergency-restart.h>
diff --git a/include/asm-powerpc/ipc.h b/include/asm-powerpc/ipc.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/ipc.h
@@ -0,0 +1 @@
+#include <asm-generic/ipc.h>
diff --git a/include/asm-powerpc/xor.h b/include/asm-powerpc/xor.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/xor.h
@@ -0,0 +1 @@
+#include <asm-generic/xor.h>
diff --git a/include/asm-ppc/8253pit.h b/include/asm-ppc/8253pit.h
deleted file mode 100644
--- a/include/asm-ppc/8253pit.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * 8253/8254 Programmable Interval Timer
- */
-
-#ifndef _8253PIT_H
-#define _8253PIT_H
-
-#define PIT_TICK_RATE 	1193182UL
-
-#endif
diff --git a/include/asm-ppc/agp.h b/include/asm-ppc/agp.h
deleted file mode 100644
--- a/include/asm-ppc/agp.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef AGP_H
-#define AGP_H 1
-
-#include <asm/io.h>
-
-/* nothing much needed here */
-
-#define map_page_into_agp(page)
-#define unmap_page_from_agp(page)
-#define flush_agp_mappings()
-#define flush_agp_cache() mb()
-
-/* Convert a physical address to an address suitable for the GART. */
-#define phys_to_gart(x) (x)
-#define gart_to_phys(x) (x)
-
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
-#endif
diff --git a/include/asm-ppc/cputime.h b/include/asm-ppc/cputime.h
deleted file mode 100644
--- a/include/asm-ppc/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __PPC_CPUTIME_H
-#define __PPC_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* __PPC_CPUTIME_H */
diff --git a/include/asm-ppc/div64.h b/include/asm-ppc/div64.h
deleted file mode 100644
--- a/include/asm-ppc/div64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/div64.h>
diff --git a/include/asm-ppc/emergency-restart.h b/include/asm-ppc/emergency-restart.h
deleted file mode 100644
--- a/include/asm-ppc/emergency-restart.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_EMERGENCY_RESTART_H
-#define _ASM_EMERGENCY_RESTART_H
-
-#include <asm-generic/emergency-restart.h>
-
-#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-ppc/hdreg.h b/include/asm-ppc/hdreg.h
deleted file mode 100644
--- a/include/asm-ppc/hdreg.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
diff --git a/include/asm-ppc/ipc.h b/include/asm-ppc/ipc.h
deleted file mode 100644
--- a/include/asm-ppc/ipc.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ipc.h>
diff --git a/include/asm-ppc/xor.h b/include/asm-ppc/xor.h
deleted file mode 100644
--- a/include/asm-ppc/xor.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/xor.h>
diff --git a/include/asm-ppc64/8253pit.h b/include/asm-ppc64/8253pit.h
deleted file mode 100644
--- a/include/asm-ppc64/8253pit.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * 8253/8254 Programmable Interval Timer
- */
-
-#ifndef _8253PIT_H
-#define _8253PIT_H
-
-#define PIT_TICK_RATE 	1193182UL
-
-#endif
diff --git a/include/asm-ppc64/agp.h b/include/asm-ppc64/agp.h
deleted file mode 100644
--- a/include/asm-ppc64/agp.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef AGP_H
-#define AGP_H 1
-
-#include <asm/io.h>
-
-/* nothing much needed here */
-
-#define map_page_into_agp(page)
-#define unmap_page_from_agp(page)
-#define flush_agp_mappings()
-#define flush_agp_cache() mb()
-
-/* Convert a physical address to an address suitable for the GART. */
-#define phys_to_gart(x) (x)
-#define gart_to_phys(x) (x)
-
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
-#endif
diff --git a/include/asm-ppc64/cputime.h b/include/asm-ppc64/cputime.h
deleted file mode 100644
--- a/include/asm-ppc64/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __PPC_CPUTIME_H
-#define __PPC_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* __PPC_CPUTIME_H */
diff --git a/include/asm-ppc64/div64.h b/include/asm-ppc64/div64.h
deleted file mode 100644
--- a/include/asm-ppc64/div64.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/div64.h>
diff --git a/include/asm-ppc64/emergency-restart.h b/include/asm-ppc64/emergency-restart.h
deleted file mode 100644
--- a/include/asm-ppc64/emergency-restart.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_EMERGENCY_RESTART_H
-#define _ASM_EMERGENCY_RESTART_H
-
-#include <asm-generic/emergency-restart.h>
-
-#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-ppc64/hdreg.h b/include/asm-ppc64/hdreg.h
deleted file mode 100644
--- a/include/asm-ppc64/hdreg.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
diff --git a/include/asm-ppc64/ipc.h b/include/asm-ppc64/ipc.h
deleted file mode 100644
--- a/include/asm-ppc64/ipc.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ipc.h>
diff --git a/include/asm-ppc64/xor.h b/include/asm-ppc64/xor.h
deleted file mode 100644
--- a/include/asm-ppc64/xor.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/xor.h>
