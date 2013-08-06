Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 40/63] powerpc: Support endian agnostic MMIO
Date: Wed,  7 Aug 2013 02:01:57 +1000
Message-Id: <1375804940-22050-41-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch maps the MMIO functions for 32bit PowerPC to their
appropriate instructions depending on CPU endianness.

The macros used to create the corresponding inline functions are also
renamed by this patch. Previously they had BE or LE in their names which
was misleading - they had nothing to do with endianness, but actually
created different instruction forms so their new names reflect the
instruction form they are creating (D-Form and X-Form).

Little endian 64bit PowerPC is not supported, so the lack of mappings
(and corresponding breakage) for that case is intentional to bring the
attention of anyone doing a 64bit little endian port. 64bit big endian
is unaffected.

[ Added 64 bit versions - Anton ]

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/io.h | 67 +++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index dd15e5e..3aca565 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -103,7 +103,7 @@ extern resource_size_t isa_mem_base;
 
 /* gcc 4.0 and older doesn't have 'Z' constraint */
 #if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ == 0)
-#define DEF_MMIO_IN_LE(name, size, insn)				\
+#define DEF_MMIO_IN_X(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
@@ -112,7 +112,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT_LE(name, size, insn) 				\
+#define DEF_MMIO_OUT_X(name, size, insn)				\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn" %1,0,%2"			\
@@ -120,7 +120,7 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 	IO_SET_SYNC_FLAG();						\
 }
 #else /* newer gcc */
-#define DEF_MMIO_IN_LE(name, size, insn)				\
+#define DEF_MMIO_IN_X(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
@@ -129,7 +129,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT_LE(name, size, insn) 				\
+#define DEF_MMIO_OUT_X(name, size, insn)				\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn" %1,%y0"			\
@@ -138,7 +138,7 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 }
 #endif
 
-#define DEF_MMIO_IN_BE(name, size, insn)				\
+#define DEF_MMIO_IN_D(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
@@ -147,7 +147,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT_BE(name, size, insn)				\
+#define DEF_MMIO_OUT_D(name, size, insn)				\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"			\
@@ -155,22 +155,37 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 	IO_SET_SYNC_FLAG();						\
 }
 
+DEF_MMIO_IN_D(in_8,     8, lbz);
+DEF_MMIO_OUT_D(out_8,   8, stb);
 
-DEF_MMIO_IN_BE(in_8,     8, lbz);
-DEF_MMIO_IN_BE(in_be16, 16, lhz);
-DEF_MMIO_IN_BE(in_be32, 32, lwz);
-DEF_MMIO_IN_LE(in_le16, 16, lhbrx);
-DEF_MMIO_IN_LE(in_le32, 32, lwbrx);
+#ifdef __BIG_ENDIAN__
+DEF_MMIO_IN_D(in_be16, 16, lhz);
+DEF_MMIO_IN_D(in_be32, 32, lwz);
+DEF_MMIO_IN_X(in_le16, 16, lhbrx);
+DEF_MMIO_IN_X(in_le32, 32, lwbrx);
 
-DEF_MMIO_OUT_BE(out_8,     8, stb);
-DEF_MMIO_OUT_BE(out_be16, 16, sth);
-DEF_MMIO_OUT_BE(out_be32, 32, stw);
-DEF_MMIO_OUT_LE(out_le16, 16, sthbrx);
-DEF_MMIO_OUT_LE(out_le32, 32, stwbrx);
+DEF_MMIO_OUT_D(out_be16, 16, sth);
+DEF_MMIO_OUT_D(out_be32, 32, stw);
+DEF_MMIO_OUT_X(out_le16, 16, sthbrx);
+DEF_MMIO_OUT_X(out_le32, 32, stwbrx);
+#else
+DEF_MMIO_IN_X(in_be16, 16, lhbrx);
+DEF_MMIO_IN_X(in_be32, 32, lwbrx);
+DEF_MMIO_IN_D(in_le16, 16, lhz);
+DEF_MMIO_IN_D(in_le32, 32, lwz);
+
+DEF_MMIO_OUT_X(out_be16, 16, sthbrx);
+DEF_MMIO_OUT_X(out_be32, 32, stwbrx);
+DEF_MMIO_OUT_D(out_le16, 16, sth);
+DEF_MMIO_OUT_D(out_le32, 32, stw);
+
+#endif /* __BIG_ENDIAN */
 
 #ifdef __powerpc64__
-DEF_MMIO_OUT_BE(out_be64, 64, std);
-DEF_MMIO_IN_BE(in_be64, 64, ld);
+
+#ifdef __BIG_ENDIAN__
+DEF_MMIO_OUT_D(out_be64, 64, std);
+DEF_MMIO_IN_D(in_be64, 64, ld);
 
 /* There is no asm instructions for 64 bits reverse loads and stores */
 static inline u64 in_le64(const volatile u64 __iomem *addr)
@@ -182,6 +197,22 @@ static inline void out_le64(volatile u64 __iomem *addr, u64 val)
 {
 	out_be64(addr, swab64(val));
 }
+#else
+DEF_MMIO_OUT_D(out_le64, 64, std);
+DEF_MMIO_IN_D(in_le64, 64, ld);
+
+/* There is no asm instructions for 64 bits reverse loads and stores */
+static inline u64 in_be64(const volatile u64 __iomem *addr)
+{
+	return swab64(in_le64(addr));
+}
+
+static inline void out_be64(volatile u64 __iomem *addr, u64 val)
+{
+	out_le64(addr, swab64(val));
+}
+
+#endif
 #endif /* __powerpc64__ */
 
 /*
-- 
1.8.1.2
