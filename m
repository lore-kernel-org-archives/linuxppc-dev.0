Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 477E1B7102
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:27 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9176QMm024363
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:26 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176Qog1265912
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:26 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176Qji018952
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:26 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH 10/18] powerpc: Support endian agnostic MMIO
Date: Fri,  1 Oct 2010 17:06:03 +1000
Message-Id: <1285916771-18033-11-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: paulus@samba.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
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

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/io.h |   51 ++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 001f2f1..fd8e922 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -97,7 +97,7 @@ extern resource_size_t isa_mem_base;
 
 /* gcc 4.0 and older doesn't have 'Z' constraint */
 #if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ == 0)
-#define DEF_MMIO_IN_LE(name, size, insn)				\
+#define DEF_MMIO_IN_X(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
@@ -106,7 +106,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT_LE(name, size, insn) 				\
+#define DEF_MMIO_OUT_X(name, size, insn) 				\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn" %1,0,%2"			\
@@ -114,7 +114,7 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 	IO_SET_SYNC_FLAG();						\
 }
 #else /* newer gcc */
-#define DEF_MMIO_IN_LE(name, size, insn)				\
+#define DEF_MMIO_IN_X(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
@@ -123,7 +123,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT_LE(name, size, insn) 				\
+#define DEF_MMIO_OUT_X(name, size, insn) 				\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn" %1,%y0"			\
@@ -132,7 +132,7 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
 }
 #endif
 
-#define DEF_MMIO_IN_BE(name, size, insn)				\
+#define DEF_MMIO_IN_D(name, size, insn)				\
 static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
@@ -141,7 +141,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT_BE(name, size, insn)				\
+#define DEF_MMIO_OUT_D(name, size, insn)				\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"			\
@@ -149,22 +149,37 @@ static inline void name(volatile u##size __iomem *addr, u##size val)	\
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
+#endif /* __BIG_ENDIAN */
 
 #ifdef __powerpc64__
-DEF_MMIO_OUT_BE(out_be64, 64, std);
-DEF_MMIO_IN_BE(in_be64, 64, ld);
+
+#ifndef __LITTLE_ENDIAN__
+DEF_MMIO_OUT_D(out_be64, 64, std);
+DEF_MMIO_IN_D(in_be64, 64, ld);
+#endif
 
 /* There is no asm instructions for 64 bits reverse loads and stores */
 static inline u64 in_le64(const volatile u64 __iomem *addr)
-- 
1.7.1
