Return-Path: <bgill@freescale.com>
Date: Wed, 19 Oct 2005 11:55:28 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0510191140350.29058@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] powerpc: merge types.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Merge types.h

This patch merges types.h into include/asm-powerpc.  The only real changes
here are that umode_t has become short instead of int in the 64-bit case,
which appears to match what most other platforms have done.  Also, the
32-bit version was #including linux/config.h - I have removed this as it
does not appear necessary.

This patch has been built on several different 32 and 64-bit platforms,
and booted on mpc8540_ads.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 995fc5087d7f02d7e570c9a904a16453e1d8d307
tree 8326faf3664a5c2912ab28f822d9ab7e84fc8a1b
parent 4746820969c846263fca3f0b54e0c1af883b67ed
author Becky Bruce <becky.bruce@freescale.com> Wed, 19 Oct 2005 11:12:13 -0500
committer Becky Bruce <becky.bruce@freescale.com> Wed, 19 Oct 2005 11:12:13 -0500

 include/asm-powerpc/types.h |  100 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/types.h     |   69 ------------------------------
 include/asm-ppc64/types.h   |   79 ----------------------------------
 3 files changed, 100 insertions(+), 148 deletions(-)

diff --git a/include/asm-powerpc/types.h b/include/asm-powerpc/types.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/types.h
@@ -0,0 +1,100 @@
+#ifndef _ASM_POWERPC_TYPES_H
+#define _ASM_POWERPC_TYPES_H
+
+#ifndef __ASSEMBLY__
+
+/*
+ * This file is never included by application software unless
+ * explicitly requested (e.g., via linux/types.h) in which case the
+ * application is Linux specific so (user-) name space pollution is
+ * not a major issue.  However, for interoperability, libraries still
+ * need to be careful to avoid a name clashes.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+typedef unsigned short umode_t;
+
+/*
+ * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
+ * header files exported to user space
+ */
+
+typedef __signed__ char __s8;
+typedef unsigned char __u8;
+
+typedef __signed__ short __s16;
+typedef unsigned short __u16;
+
+typedef __signed__ int __s32;
+typedef unsigned int __u32;
+
+#ifdef __powerpc64__
+typedef __signed__ long __s64;
+typedef unsigned long __u64;
+#else
+#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
+#endif
+#endif /* __powerpc64__ */
+
+typedef struct {
+	__u32 u[4];
+} __attribute((aligned(16))) __vector128;
+
+#endif /* __ASSEMBLY__ */
+
+#ifdef __KERNEL__
+/*
+ * These aren't exported outside the kernel to avoid name space clashes
+ */
+#ifdef __powerpc64__
+#define BITS_PER_LONG 64
+#else
+#define BITS_PER_LONG 32
+#endif
+
+#ifndef __ASSEMBLY__
+
+typedef signed char s8;
+typedef unsigned char u8;
+
+typedef signed short s16;
+typedef unsigned short u16;
+
+typedef signed int s32;
+typedef unsigned int u32;
+
+#ifdef __powerpc64__
+typedef signed long s64;
+typedef unsigned long u64;
+#else
+typedef signed long long s64;
+typedef unsigned long long u64;
+#endif
+
+typedef __vector128 vector128;
+
+typedef u32 dma_addr_t;
+typedef u64 dma64_addr_t;
+
+typedef struct {
+	unsigned long entry;
+	unsigned long toc;
+	unsigned long env;
+} func_descr_t;
+
+#ifdef CONFIG_LBD
+typedef u64 sector_t;
+#define HAVE_SECTOR_T
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_POWERPC_TYPES_H */
diff --git a/include/asm-ppc/types.h b/include/asm-ppc/types.h
deleted file mode 100644
--- a/include/asm-ppc/types.h
+++ /dev/null
@@ -1,69 +0,0 @@
-#ifndef _PPC_TYPES_H
-#define _PPC_TYPES_H
-
-#ifndef __ASSEMBLY__
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
-
-typedef struct {
-	__u32 u[4];
-} __vector128;
-
-/*
- * XXX allowed outside of __KERNEL__ for now, until glibc gets
- * a proper set of asm headers of its own.  -- paulus
- */
-typedef unsigned short umode_t;
-
-#endif /* __ASSEMBLY__ */
-
-#ifdef __KERNEL__
-/*
- * These aren't exported outside the kernel to avoid name space clashes
- */
-#define BITS_PER_LONG 32
-
-#ifndef __ASSEMBLY__
-
-#include <linux/config.h>
-
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
-typedef __vector128 vector128;
-
-/* DMA addresses are 32-bits wide */
-typedef u32 dma_addr_t;
-typedef u64 dma64_addr_t;
-
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif
diff --git a/include/asm-ppc64/types.h b/include/asm-ppc64/types.h
deleted file mode 100644
--- a/include/asm-ppc64/types.h
+++ /dev/null
@@ -1,79 +0,0 @@
-#ifndef _PPC64_TYPES_H
-#define _PPC64_TYPES_H
-
-#ifndef __ASSEMBLY__
-
-/*
- * This file is never included by application software unless
- * explicitly requested (e.g., via linux/types.h) in which case the
- * application is Linux specific so (user-) name space pollution is
- * not a major issue.  However, for interoperability, libraries still
- * need to be careful to avoid a name clashes.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-typedef unsigned int umode_t;
-
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
-
-typedef struct {
-	__u32 u[4];
-} __attribute((aligned(16))) __vector128;
-
-#endif /* __ASSEMBLY__ */
-
-#ifdef __KERNEL__
-/*
- * These aren't exported outside the kernel to avoid name space clashes
- */
-#define BITS_PER_LONG 64
-
-#ifndef __ASSEMBLY__
-
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long s64;
-typedef unsigned long u64;
-
-typedef __vector128 vector128;
-
-typedef u32 dma_addr_t;
-typedef u64 dma64_addr_t;
-
-typedef struct {
-	unsigned long entry;
-	unsigned long toc;
-	unsigned long env;
-} func_descr_t;
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif /* _PPC64_TYPES_H */
