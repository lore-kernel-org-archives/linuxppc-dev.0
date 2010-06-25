Return-Path: <jakub@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id D0F00B6F10
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 19:55:33 +1000 (EST)
Date: Fri, 25 Jun 2010 11:56:06 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Adjust arch/powerpc inline asms for recent gcc change
Message-ID: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Reply-To: Jakub Jelinek <jakub@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

I've recently changed gcc handling of inline-asm, such that it by default
disallows side-effects on memory operands of inline-asm and only allows
them if < or > constraint is present for the operand.
See http://gcc.gnu.org/PR44492 and http://bugzilla.redhat.com/602359
for details.  The change prevents miscompilations with inline-asm using "m",
"g" etc. constraints and either not using the the operand at all, or not
in an instruction (e.g. in some data section, comment, etc.), or using it
twice or more, or on architectures that require it such as PowerPC or IA-64
not using it in instructions that handle the side-effects, or not using
on PowerPC %UN corresponding to the operand, or on IA-64 not using %PN.
It might penalize asm written with side-effects in mind.
This completely untested patch adjusts the constraints of such inline-asm
operands in powerpc kernel (and fixes one bug where %U was used for
incorrect operand).

Signed-off-by: Jakub Jelinek <jakub@redhat.com>

 boot/io.h             |   12 ++++++------
 include/asm/atomic.h  |    8 ++++----
 include/asm/io.h      |    4 ++--
 include/asm/pgtable.h |    4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
index 7c09f48..3dd1462 100644
--- a/arch/powerpc/boot/io.h
+++ b/arch/powerpc/boot/io.h
@@ -13,14 +13,14 @@ static inline int in_8(const volatile unsigned char *addr)
 	int ret;
 
 	__asm__ __volatile__("lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "m" (*addr));
+			     : "=r" (ret) : "m<>" (*addr));
 	return ret;
 }
 
 static inline void out_8(volatile unsigned char *addr, int val)
 {
 	__asm__ __volatile__("stb%U0%X0 %1,%0; sync"
-			     : "=m" (*addr) : "r" (val));
+			     : "=m<>" (*addr) : "r" (val));
 }
 
 static inline unsigned in_le16(const volatile u16 *addr)
@@ -38,7 +38,7 @@ static inline unsigned in_be16(const volatile u16 *addr)
 	unsigned ret;
 
 	__asm__ __volatile__("lhz%U1%X1 %0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "m" (*addr));
+			     : "=r" (ret) : "m<>" (*addr));
 	return ret;
 }
 
@@ -51,7 +51,7 @@ static inline void out_le16(volatile u16 *addr, int val)
 static inline void out_be16(volatile u16 *addr, int val)
 {
 	__asm__ __volatile__("sth%U0%X0 %1,%0; sync"
-			     : "=m" (*addr) : "r" (val));
+			     : "=m<>" (*addr) : "r" (val));
 }
 
 static inline unsigned in_le32(const volatile unsigned *addr)
@@ -68,7 +68,7 @@ static inline unsigned in_be32(const volatile unsigned *addr)
 	unsigned ret;
 
 	__asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync"
-			     : "=r" (ret) : "m" (*addr));
+			     : "=r" (ret) : "m<>" (*addr));
 	return ret;
 }
 
@@ -81,7 +81,7 @@ static inline void out_le32(volatile unsigned *addr, int val)
 static inline void out_be32(volatile unsigned *addr, int val)
 {
 	__asm__ __volatile__("stw%U0%X0 %1,%0; sync"
-			     : "=m" (*addr) : "r" (val));
+			     : "=m<>" (*addr) : "r" (val));
 }
 
 static inline void sync(void)
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index b8f152e..288d8b2 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -19,14 +19,14 @@ static __inline__ int atomic_read(const atomic_t *v)
 {
 	int t;
 
-	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
+	__asm__ __volatile__("lwz%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
 
 	return t;
 }
 
 static __inline__ void atomic_set(atomic_t *v, int i)
 {
-	__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m"(v->counter) : "r"(i));
+	__asm__ __volatile__("stw%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
 }
 
 static __inline__ void atomic_add(int a, atomic_t *v)
@@ -257,14 +257,14 @@ static __inline__ long atomic64_read(const atomic64_t *v)
 {
 	long t;
 
-	__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m"(v->counter));
+	__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
 
 	return t;
 }
 
 static __inline__ void atomic64_set(atomic64_t *v, long i)
 {
-	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m"(v->counter) : "r"(i));
+	__asm__ __volatile__("std%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
 }
 
 static __inline__ void atomic64_add(long a, atomic64_t *v)
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 001f2f1..f05db20 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -137,7 +137,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
 	u##size ret;							\
 	__asm__ __volatile__("sync;"#insn"%U1%X1 %0,%1;twi 0,%0,0;isync"\
-		: "=r" (ret) : "m" (*addr) : "memory");			\
+		: "=r" (ret) : "m<>" (*addr) : "memory");		\
 	return ret;							\
 }
 
@@ -145,7 +145,7 @@ static inline u##size name(const volatile u##size __iomem *addr)	\
 static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
 	__asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"			\
-		: "=m" (*addr) : "r" (val) : "memory");			\
+		: "=m<>" (*addr) : "r" (val) : "memory");		\
 	IO_SET_SYNC_FLAG();						\
 }
 
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 89f1587..2e27eaa 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -125,8 +125,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	__asm__ __volatile__("\
 		stw%U0%X0 %2,%0\n\
 		eieio\n\
-		stw%U0%X0 %L2,%1"
-	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
+		stw%U1%X1 %L2,%1"
+	: "=m<>" (*ptep), "=m<>" (*((unsigned char *)ptep+4))
 	: "r" (pte) : "memory");
 
 #elif defined(CONFIG_PPC_STD_MMU_32)

	Jakub
