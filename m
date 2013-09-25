Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc: Rename IO accessor generation macros
Date: Wed, 25 Sep 2013 15:38:51 +1000
Message-Id: <1380087532-20219-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In io.h we have macros to generate our IO accessors. These are currently
named FOO_BE() and FOO_LE() to indicate big & little endian. However the
distinction between the macros is not so much the endianess as the form
of the instruction that is used.

Rename the macros to reflect that, so we end up with XFORM and DFORM
variants, and use them appropriately.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/io.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 5a64757..8b3bd66 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -113,7 +113,7 @@ extern bool isa_io_special;
 
 /* gcc 4.0 and older doesn't have 'Z' constraint */
 #if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ == 0)
-#define DEF_MMIO_IN_LE(name, size, insn)				\
+#define DEF_MMIO_IN_XFORM(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
@@ -122,7 +122,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT_LE(name, size, insn) 				\
+#define DEF_MMIO_OUT_XFORM(name, size, insn) 				\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn" %1,0,%2"			\
@@ -130,7 +130,7 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 	IO_SET_SYNC_FLAG();						\
 }
 #else /* newer gcc */
-#define DEF_MMIO_IN_LE(name, size, insn)				\
+#define DEF_MMIO_IN_XFORM(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
@@ -139,7 +139,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT_LE(name, size, insn) 				\
+#define DEF_MMIO_OUT_XFORM(name, size, insn) 				\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn" %1,%y0"			\
@@ -148,7 +148,7 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 }
 #endif
 
-#define DEF_MMIO_IN_BE(name, size, insn)				\
+#define DEF_MMIO_IN_DFORM(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
@@ -157,7 +157,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT_BE(name, size, insn)				\
+#define DEF_MMIO_OUT_DFORM(name, size, insn)				\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"			\
@@ -166,21 +166,21 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 }
 
 
-DEF_MMIO_IN_BE(in_8,     8, lbz);
-DEF_MMIO_IN_BE(in_be16, 16, lhz);
-DEF_MMIO_IN_BE(in_be32, 32, lwz);
-DEF_MMIO_IN_LE(in_le16, 16, lhbrx);
-DEF_MMIO_IN_LE(in_le32, 32, lwbrx);
+DEF_MMIO_IN_DFORM(in_8,     8, lbz);
+DEF_MMIO_IN_DFORM(in_be16, 16, lhz);
+DEF_MMIO_IN_DFORM(in_be32, 32, lwz);
+DEF_MMIO_IN_XFORM(in_le16, 16, lhbrx);
+DEF_MMIO_IN_XFORM(in_le32, 32, lwbrx);
 
-DEF_MMIO_OUT_BE(out_8,     8, stb);
-DEF_MMIO_OUT_BE(out_be16, 16, sth);
-DEF_MMIO_OUT_BE(out_be32, 32, stw);
-DEF_MMIO_OUT_LE(out_le16, 16, sthbrx);
-DEF_MMIO_OUT_LE(out_le32, 32, stwbrx);
+DEF_MMIO_OUT_DFORM(out_8,     8, stb);
+DEF_MMIO_OUT_DFORM(out_be16, 16, sth);
+DEF_MMIO_OUT_DFORM(out_be32, 32, stw);
+DEF_MMIO_OUT_XFORM(out_le16, 16, sthbrx);
+DEF_MMIO_OUT_XFORM(out_le32, 32, stwbrx);
 
 #ifdef __powerpc64__
-DEF_MMIO_OUT_BE(out_be64, 64, std);
-DEF_MMIO_IN_BE(in_be64, 64, ld);
+DEF_MMIO_OUT_DFORM(out_be64, 64, std);
+DEF_MMIO_IN_DFORM(in_be64, 64, ld);
 
 /* There is no asm instructions for 64 bits reverse loads and stores */
 static inline u64 in_le64(const volatile u64 __iomem *addr)
-- 
1.8.1.2
