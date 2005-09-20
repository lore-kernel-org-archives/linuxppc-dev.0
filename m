Return-Path: <jdl@jdl.com>
From: linuxppc@jdl.com
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Tue, 20 Sep 2005 14:32:37 -0500
Message-Id: <E1EHnr3-0002XL-JT@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: PATCH powerpc Merge asm-ppc*/vga.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Merge asm-ppc*/vga.h

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---

 include/asm-powerpc/vga.h |   54 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/vga.h     |   46 --------------------------------------
 include/asm-ppc64/vga.h   |   50 ------------------------------------------
 3 files changed, 54 insertions(+), 96 deletions(-)


diff --git a/include/asm-powerpc/vga.h b/include/asm-powerpc/vga.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/vga.h
@@ -0,0 +1,54 @@
+#ifndef _ASM_POWERPC_VGA_H_
+#define _ASM_POWERPC_VGA_H_
+
+#ifdef __KERNEL__
+
+/*
+ *	Access to VGA videoram
+ *
+ *	(c) 1998 Martin Mares <mj@ucw.cz>
+ */
+
+
+#include <asm/io.h>
+
+#include <linux/config.h>
+
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+
+#define VT_BUF_HAVE_RW
+/*
+ *  These are only needed for supporting VGA or MDA text mode, which use little
+ *  endian byte ordering.
+ *  In other cases, we can optimize by using native byte ordering and
+ *  <linux/vt_buffer.h> has already done the right job for us.
+ */
+
+static inline void scr_writew(u16 val, volatile u16 *addr)
+{
+    st_le16(addr, val);
+}
+
+static inline u16 scr_readw(volatile const u16 *addr)
+{
+    return ld_le16(addr);
+}
+
+#define VT_BUF_HAVE_MEMCPYW
+#define scr_memcpyw	memcpy
+
+#endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
+
+extern unsigned long vgacon_remap_base;
+
+#ifdef __powerpc64__
+#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
+#else
+#define VGA_MAP_MEM(x) (x + vgacon_remap_base)
+#endif
+
+#define vga_readb(x) (*(x))
+#define vga_writeb(x,y) (*(y) = (x))
+
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_VGA_H_ */
diff --git a/include/asm-ppc/vga.h b/include/asm-ppc/vga.h
deleted file mode 100644
--- a/include/asm-ppc/vga.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- *	Access to VGA videoram
- *
- *	(c) 1998 Martin Mares <mj@ucw.cz>
- */
-
-#ifdef __KERNEL__
-#ifndef _LINUX_ASM_VGA_H_
-#define _LINUX_ASM_VGA_H_
-
-#include <asm/io.h>
-
-#include <linux/config.h>
-
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
-
-#define VT_BUF_HAVE_RW
-/*
- *  These are only needed for supporting VGA or MDA text mode, which use little
- *  endian byte ordering.
- *  In other cases, we can optimize by using native byte ordering and
- *  <linux/vt_buffer.h> has already done the right job for us.
- */
-
-extern inline void scr_writew(u16 val, volatile u16 *addr)
-{
-    st_le16(addr, val);
-}
-
-extern inline u16 scr_readw(volatile const u16 *addr)
-{
-    return ld_le16(addr);
-}
-
-#define VT_BUF_HAVE_MEMCPYW
-#define scr_memcpyw	memcpy
-
-#endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
-
-extern unsigned long vgacon_remap_base;
-#define VGA_MAP_MEM(x) (x + vgacon_remap_base)
-#define vga_readb(x) (*(x))
-#define vga_writeb(x,y) (*(y) = (x))
-
-#endif
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc64/vga.h b/include/asm-ppc64/vga.h
deleted file mode 100644
--- a/include/asm-ppc64/vga.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- *	Access to VGA videoram
- *
- *	(c) 1998 Martin Mares <mj@ucw.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _LINUX_ASM_VGA_H_
-#define _LINUX_ASM_VGA_H_
-
-#include <asm/io.h>
-
-#include <linux/config.h>
-
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
-
-#define VT_BUF_HAVE_RW
-/*
- *  These are only needed for supporting VGA or MDA text mode, which use little
- *  endian byte ordering.
- *  In other cases, we can optimize by using native byte ordering and
- *  <linux/vt_buffer.h> has already done the right job for us.
- */
-
-static inline void scr_writew(u16 val, volatile u16 *addr)
-{
-    st_le16(addr, val);
-}
-
-static inline u16 scr_readw(volatile const u16 *addr)
-{
-    return ld_le16(addr);
-}
-
-#define VT_BUF_HAVE_MEMCPYW
-#define scr_memcpyw	memcpy
-
-#endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
-
-extern unsigned long vgacon_remap_base;
-#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
-
-#define vga_readb(x) (*(x))
-#define vga_writeb(x,y) (*(y) = (x))
-
-#endif
