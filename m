Return-Path: <BATV+bfa31428277ec1635a02+3390+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 03FB52C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 21:15:53 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: dwmw2@infradead.org
Subject: [PATCH 1/4] byteorder: allow arch to opt to use GCC intrinsics for
 byteswapping
Date: Tue,  4 Dec 2012 10:15:27 +0000
Message-Id: <1354616130-21587-2-git-send-email-dwmw2@infradead.org>
In-Reply-To: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
References: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Woodhouse <David.Woodhouse@intel.com>

Since GCC 4.4, there have been __builtin_bswap32() and __builtin_bswap16()
intrinsics. A __builtin_bswap16() came a little later (4.6 for PowerPC,
48 for other platforms).

By using these instead of the inline assembler that most architectures
have in their __arch_swabXX() macros, we let the compiler see what's
actually happening. The resulting code should be at least as good, and
much *better* in the cases where it can be combined with a nearby load
or store, using a load-and-byteswap or store-and-byteswap instruction
(e.g. lwbrx/stwbrx on PowerPC, movbe on Atom).

When GCC is sufficiently recent *and* the architecture opts in to using
the intrinsics by setting CONFIG_ARCH_USE_BUILTIN_BSWAP, they will be
used in preference to the __arch_swabXX() macros. An architecture which
does not set ARCH_USE_BUILTIN_BSWAP will continue to use its own
hand-crafted macros.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 include/linux/compiler-gcc4.h  | 10 ++++++++++
 include/linux/compiler-intel.h |  7 +++++++
 include/uapi/linux/swab.h      | 12 +++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index 412bc6c..dc16a85 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -63,3 +63,13 @@
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
 #endif
+
+#ifdef CONFIG_ARCH_USE_BUILTIN_BSWAP
+#if __GNUC_MINOR__ >= 4
+#define __HAVE_BUILTIN_BSWAP32__
+#define __HAVE_BUILTIN_BSWAP64__
+#endif
+#if __GNUC_MINOR__ >= 8 || (defined(__powerpc__) && __GNUC_MINOR__ >= 6)
+#define __HAVE_BUILTIN_BSWAP16__
+#endif
+#endif
diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index d8e636e..973ce10 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -29,3 +29,10 @@
 #endif
 
 #define uninitialized_var(x) x
+
+#ifndef __HAVE_BUILTIN_BSWAP16__
+/* icc has this, but it's called _bswap16 */
+#define __HAVE_BUILTIN_BSWAP16__
+#define __builtin_bswap16 _bswap16
+#endif
+
diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index e811474..0e011eb 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -45,7 +45,9 @@
 
 static inline __attribute_const__ __u16 __fswab16(__u16 val)
 {
-#ifdef __arch_swab16
+#ifdef __HAVE_BUILTIN_BSWAP16__
+	return __builtin_bswap16(val);
+#elif defined (__arch_swab16)
 	return __arch_swab16(val);
 #else
 	return ___constant_swab16(val);
@@ -54,7 +56,9 @@ static inline __attribute_const__ __u16 __fswab16(__u16 val)
 
 static inline __attribute_const__ __u32 __fswab32(__u32 val)
 {
-#ifdef __arch_swab32
+#ifdef __HAVE_BUILTIN_BSWAP32__
+	return __builtin_bswap32(val);
+#elif defined(__arch_swab32)
 	return __arch_swab32(val);
 #else
 	return ___constant_swab32(val);
@@ -63,7 +67,9 @@ static inline __attribute_const__ __u32 __fswab32(__u32 val)
 
 static inline __attribute_const__ __u64 __fswab64(__u64 val)
 {
-#ifdef __arch_swab64
+#ifdef __HAVE_BUILTIN_BSWAP64__
+	return __builtin_bswap64(val);
+#elif defined (__arch_swab64)
 	return __arch_swab64(val);
 #elif defined(__SWAB_64_THRU_32__)
 	__u32 h = val >> 32;
-- 
1.8.0
