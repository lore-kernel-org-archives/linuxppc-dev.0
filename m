Return-Path: <bgill@freescale.com>
Date: Tue, 27 Sep 2005 14:28:56 -0500 (CDT)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509271427090.21928@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] powerpc: merge byteorder.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Merge byteorder.h

Essentially adopts the 64-bit version of this file.  The 32-bit version had
been using unsigned ints for arguments/return values that were actually
only 16 bits - the new file uses __u16 for these items as in the 64-bit
version of the header.  The order of some of the asm constraints
in the 64-bit version was slightly different than the 32-bit version,
but they produce identical code.  

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 01344596fdecbe2b97e122b6a50570a19218cd2f
tree ccdf20534198e69459d95f21b8f45aafc00e8238
parent d407c9f3f6f3c84d9daec257f9a2550aacbd2892
author Becky Bruce <becky.bruce@freescale.com> Tue, 27 Sep 2005 14:04:44 -0500
committer Becky Bruce <becky.bruce@freescale.com> Tue, 27 Sep 2005 14:04:44 -0500

 include/asm-powerpc/byteorder.h |   89 +++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/byteorder.h     |   76 ---------------------------------
 include/asm-ppc64/byteorder.h   |   86 --------------------------------------
 3 files changed, 89 insertions(+), 162 deletions(-)

diff --git a/include/asm-powerpc/byteorder.h b/include/asm-powerpc/byteorder.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/byteorder.h
@@ -0,0 +1,89 @@
+#ifndef _ASM_POWERPC_BYTEORDER_H
+#define _ASM_POWERPC_BYTEORDER_H
+
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/types.h>
+#include <linux/compiler.h>
+
+#ifdef __GNUC__
+#ifdef __KERNEL__
+
+static __inline__ __u16 ld_le16(const volatile __u16 *addr)
+{
+	__u16 val;
+
+	__asm__ __volatile__ ("lhbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
+	return val;
+}
+
+static __inline__ void st_le16(volatile __u16 *addr, const __u16 val)
+{
+	__asm__ __volatile__ ("sthbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
+}
+
+static __inline__ __u32 ld_le32(const volatile __u32 *addr)
+{
+	__u32 val;
+
+	__asm__ __volatile__ ("lwbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
+	return val;
+}
+
+static __inline__ void st_le32(volatile __u32 *addr, const __u32 val)
+{
+	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
+}
+
+static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 value)
+{
+	__u16 result;
+
+	__asm__("rlwimi %0,%1,8,16,23"
+	    : "=r" (result)
+	    : "r" (value), "0" (value >> 8));
+	return result;
+}
+
+static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 value)
+{
+	__u32 result;
+
+	__asm__("rlwimi %0,%1,24,16,23\n\t"
+	    "rlwimi %0,%1,8,8,15\n\t"
+	    "rlwimi %0,%1,24,0,7"
+	    : "=r" (result)
+	    : "r" (value), "0" (value >> 24));
+	return result;
+}
+
+#define __arch__swab16(x) ___arch__swab16(x)
+#define __arch__swab32(x) ___arch__swab32(x)
+
+/* The same, but returns converted value from the location pointer by addr. */
+#define __arch__swab16p(addr) ld_le16(addr)
+#define __arch__swab32p(addr) ld_le32(addr)
+
+/* The same, but do the conversion in situ, ie. put the value back to addr. */
+#define __arch__swab16s(addr) st_le16(addr,*addr)
+#define __arch__swab32s(addr) st_le32(addr,*addr)
+
+#endif /* __KERNEL__ */
+
+#ifndef __STRICT_ANSI__
+#define __BYTEORDER_HAS_U64__
+#ifndef __powerpc64__
+#define __SWAB_64_THRU_32__
+#endif /* __powerpc64__ */
+#endif /* __STRICT_ANSI__ */
+
+#endif /* __GNUC__ */
+
+#include <linux/byteorder/big_endian.h>
+
+#endif /* _ASM_POWERPC_BYTEORDER_H */
diff --git a/include/asm-ppc/byteorder.h b/include/asm-ppc/byteorder.h
deleted file mode 100644
--- a/include/asm-ppc/byteorder.h
+++ /dev/null
@@ -1,76 +0,0 @@
-#ifndef _PPC_BYTEORDER_H
-#define _PPC_BYTEORDER_H
-
-#include <asm/types.h>
-#include <linux/compiler.h>
-
-#ifdef __GNUC__
-#ifdef __KERNEL__
-
-extern __inline__ unsigned ld_le16(const volatile unsigned short *addr)
-{
-	unsigned val;
-
-	__asm__ __volatile__ ("lhbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
-	return val;
-}
-
-extern __inline__ void st_le16(volatile unsigned short *addr, const unsigned val)
-{
-	__asm__ __volatile__ ("sthbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
-}
-
-extern __inline__ unsigned ld_le32(const volatile unsigned *addr)
-{
-	unsigned val;
-
-	__asm__ __volatile__ ("lwbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
-	return val;
-}
-
-extern __inline__ void st_le32(volatile unsigned *addr, const unsigned val)
-{
-	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
-}
-
-static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 value)
-{
-	__u16 result;
-
-	__asm__("rlwimi %0,%2,8,16,23" : "=&r" (result) : "0" (value >> 8), "r" (value));
-	return result;
-}
-
-static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 value)
-{
-	__u32 result;
-
-	__asm__("rlwimi %0,%2,24,16,23" : "=&r" (result) : "0" (value>>24), "r" (value));
-	__asm__("rlwimi %0,%2,8,8,15"   : "=&r" (result) : "0" (result),    "r" (value));
-	__asm__("rlwimi %0,%2,24,0,7"   : "=&r" (result) : "0" (result),    "r" (value));
-
-	return result;
-}
-#define __arch__swab32(x) ___arch__swab32(x)
-#define __arch__swab16(x) ___arch__swab16(x)
-
-/* The same, but returns converted value from the location pointer by addr. */
-#define __arch__swab16p(addr) ld_le16(addr)
-#define __arch__swab32p(addr) ld_le32(addr)
-
-/* The same, but do the conversion in situ, ie. put the value back to addr. */
-#define __arch__swab16s(addr) st_le16(addr,*addr)
-#define __arch__swab32s(addr) st_le32(addr,*addr)
-
-#endif /* __KERNEL__ */
-
-#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
-#  define __BYTEORDER_HAS_U64__
-#  define __SWAB_64_THRU_32__
-#endif
-
-#endif /* __GNUC__ */
-
-#include <linux/byteorder/big_endian.h>
-
-#endif /* _PPC_BYTEORDER_H */
diff --git a/include/asm-ppc64/byteorder.h b/include/asm-ppc64/byteorder.h
deleted file mode 100644
--- a/include/asm-ppc64/byteorder.h
+++ /dev/null
@@ -1,86 +0,0 @@
-#ifndef _PPC64_BYTEORDER_H
-#define _PPC64_BYTEORDER_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <asm/types.h>
-#include <linux/compiler.h>
-
-#ifdef __GNUC__
-#ifdef __KERNEL__
-
-static __inline__ __u16 ld_le16(const volatile __u16 *addr)
-{
-	__u16 val;
-
-	__asm__ __volatile__ ("lhbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
-	return val;
-}
-
-static __inline__ void st_le16(volatile __u16 *addr, const __u16 val)
-{
-	__asm__ __volatile__ ("sthbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
-}
-
-static __inline__ __u32 ld_le32(const volatile __u32 *addr)
-{
-	__u32 val;
-
-	__asm__ __volatile__ ("lwbrx %0,0,%1" : "=r" (val) : "r" (addr), "m" (*addr));
-	return val;
-}
-
-static __inline__ void st_le32(volatile __u32 *addr, const __u32 val)
-{
-	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
-}
-
-static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 value)
-{
-	__u16 result;
-
-	__asm__("rlwimi %0,%1,8,16,23"
-	    : "=r" (result)
-	    : "r" (value), "0" (value >> 8));
-	return result;
-}
-
-static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 value)
-{
-	__u32 result;
-
-	__asm__("rlwimi %0,%1,24,16,23\n\t"
-	    "rlwimi %0,%1,8,8,15\n\t"
-	    "rlwimi %0,%1,24,0,7"
-	    : "=r" (result)
-	    : "r" (value), "0" (value >> 24));
-	return result;
-}
-
-#define __arch__swab16(x) ___arch__swab16(x)
-#define __arch__swab32(x) ___arch__swab32(x)
-
-/* The same, but returns converted value from the location pointer by addr. */
-#define __arch__swab16p(addr) ld_le16(addr)
-#define __arch__swab32p(addr) ld_le32(addr)
-
-/* The same, but do the conversion in situ, ie. put the value back to addr. */
-#define __arch__swab16s(addr) st_le16(addr,*addr)
-#define __arch__swab32s(addr) st_le32(addr,*addr)
-
-#endif /* __KERNEL__ */
-
-#ifndef __STRICT_ANSI__
-#define __BYTEORDER_HAS_U64__
-#endif
-
-#endif /* __GNUC__ */
-
-#include <linux/byteorder/big_endian.h>
-
-#endif /* _PPC64_BYTEORDER_H */
