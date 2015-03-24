Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0108.outbound.protection.outlook.com [65.55.169.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A1C51A0961
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 09:49:51 +1100 (AEDT)
Date: Tue, 24 Mar 2015 17:44:26 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <scottwood@freescale.com>, Joel Stanley <joel@jms.id.au>, Anton Blanchard
 <anton@samba.org>, Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina
 <jkosina@suse.cz>, Ulrich Weigand <ulrich.weigand@de.ibm.com>, "Alexander
 Graf" <agraf@suse.de>, Stewart Smith <stewart@linux.vnet.ibm.com>, "Kyle
 Moffett" <Kyle.D.Moffett@boeing.com>
Subject: [PATCH 2/3] powerpc: make copyuser_power7.S 64-byte cacheline friendly
Message-ID: <20150324174426.acde5e836bcc8e71ee93055d@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shuah Khan <shuahkh@osg.samsung.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The innermost copyloops were optimized for POWER7's 128-byte cacheline.
This patch adds optimization for the e6500, which has a 64-byte
cacheline.

We basically do this by stripping loop bodies using L1_CACHE_BYTES
ifdeferry, replace 128 with L1_CACHE_BYTES, and 7's with L1_CACHE_SHIFTs.

We also add an e6500 copyuser to copyloops tests, which requires we copy
asm/cache.h into copyloops, just to satisfy the #include:  We define
the define symbols manually in the testing makefile.

Includes a minor spelling fix: desination->destination.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com> [SELFTESTS]
Cc: linux-api@vger.kernel.org [SELFTESTS]
---
 arch/powerpc/lib/copyuser_power7.S                 | 74 +++++++++++++------
 tools/testing/selftests/powerpc/copyloops/Makefile | 11 ++-
 .../selftests/powerpc/copyloops/asm/cache.h        | 84 ++++++++++++++++++++++
 3 files changed, 144 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/copyloops/asm/cache.h

diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index 92ee840..2d22e58 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -18,6 +18,7 @@
  * Author: Anton Blanchard <anton@au.ibm.com>
  */
 #include <asm/ppc_asm.h>
+#include <asm/cache.h>
 
 #ifdef __BIG_ENDIAN__
 #define LVS(VRT,RA,RB)		lvsl	VRT,RA,RB
@@ -137,7 +138,7 @@ err1;	stw	r0,0(r3)
 	addi	r3,r3,4
 
 3:	sub	r5,r5,r6
-	cmpldi	r5,128
+	cmpldi	r5,L1_CACHE_BYTES
 	blt	5f
 
 	mflr	r0
@@ -153,10 +154,10 @@ err1;	stw	r0,0(r3)
 	std	r22,STK_REG(R22)(r1)
 	std	r0,STACKFRAMESIZE+16(r1)
 
-	srdi	r6,r5,7
+	srdi	r6,r5,L1_CACHE_SHIFT
 	mtctr	r6
 
-	/* Now do cacheline (128B) sized loads and stores. */
+	/* Now do cacheline sized loads and stores. */
 	.align	5
 4:
 err2;	ld	r0,0(r4)
@@ -167,6 +168,7 @@ err2;	ld	r9,32(r4)
 err2;	ld	r10,40(r4)
 err2;	ld	r11,48(r4)
 err2;	ld	r12,56(r4)
+#if L1_CACHE_BYTES >= 128
 err2;	ld	r14,64(r4)
 err2;	ld	r15,72(r4)
 err2;	ld	r16,80(r4)
@@ -175,7 +177,8 @@ err2;	ld	r18,96(r4)
 err2;	ld	r19,104(r4)
 err2;	ld	r20,112(r4)
 err2;	ld	r21,120(r4)
-	addi	r4,r4,128
+#endif
+	addi	r4,r4,L1_CACHE_BYTES
 err2;	std	r0,0(r3)
 err2;	std	r6,8(r3)
 err2;	std	r7,16(r3)
@@ -184,6 +187,7 @@ err2;	std	r9,32(r3)
 err2;	std	r10,40(r3)
 err2;	std	r11,48(r3)
 err2;	std	r12,56(r3)
+#if L1_CACHE_BYTES >= 128
 err2;	std	r14,64(r3)
 err2;	std	r15,72(r3)
 err2;	std	r16,80(r3)
@@ -192,10 +196,11 @@ err2;	std	r18,96(r3)
 err2;	std	r19,104(r3)
 err2;	std	r20,112(r3)
 err2;	std	r21,120(r3)
-	addi	r3,r3,128
+#endif
+	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	4b
 
-	clrldi	r5,r5,(64-7)
+	clrldi	r5,r5,(64-L1_CACHE_SHIFT)
 
 	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
@@ -208,10 +213,11 @@ err2;	std	r21,120(r3)
 	ld	r22,STK_REG(R22)(r1)
 	addi	r1,r1,STACKFRAMESIZE
 
-	/* Up to 127B to go */
+	/* Up to L1_CACHE_BYTES - 1 to go */
 5:	srdi	r6,r5,4
 	mtocrf	0x01,r6
 
+#if L1_CACHE_BYTES >= 128
 6:	bf	cr7*4+1,7f
 err1;	ld	r0,0(r4)
 err1;	ld	r6,8(r4)
@@ -231,6 +237,7 @@ err1;	std	r10,40(r3)
 err1;	std	r11,48(r3)
 err1;	std	r12,56(r3)
 	addi	r3,r3,64
+#endif
 
 	/* Up to 63B to go */
 7:	bf	cr7*4+2,8f
@@ -377,11 +384,11 @@ err3;	std	r0,0(r3)
 
 4:	sub	r5,r5,r6
 
-	/* Get the desination 128B aligned */
+	/* Get the destination L1_CACHE_BYTES aligned */
 	neg	r6,r3
 	srdi	r7,r6,4
 	mtocrf	0x01,r7
-	clrldi	r6,r6,(64-7)
+	clrldi	r6,r6,(64-L1_CACHE_SHIFT)
 
 	li	r9,16
 	li	r10,32
@@ -401,7 +408,9 @@ err3;	stvx	vr1,r0,r3
 err3;	stvx	vr0,r3,r9
 	addi	r3,r3,32
 
-6:	bf	cr7*4+1,7f
+6:
+#if L1_CACHE_BYTES >= 128
+	bf	cr7*4+1,7f
 err3;	lvx	vr3,r0,r4
 err3;	lvx	vr2,r4,r9
 err3;	lvx	vr1,r4,r10
@@ -412,9 +421,10 @@ err3;	stvx	vr2,r3,r9
 err3;	stvx	vr1,r3,r10
 err3;	stvx	vr0,r3,r11
 	addi	r3,r3,64
+#endif
 
 7:	sub	r5,r5,r6
-	srdi	r6,r5,7
+	srdi	r6,r5,L1_CACHE_SHIFT
 
 	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
@@ -437,31 +447,36 @@ err4;	lvx	vr7,r0,r4
 err4;	lvx	vr6,r4,r9
 err4;	lvx	vr5,r4,r10
 err4;	lvx	vr4,r4,r11
+#if L1_CACHE_BYTES >= 128
 err4;	lvx	vr3,r4,r12
 err4;	lvx	vr2,r4,r14
 err4;	lvx	vr1,r4,r15
 err4;	lvx	vr0,r4,r16
-	addi	r4,r4,128
+#endif
+	addi	r4,r4,L1_CACHE_BYTES
 err4;	stvx	vr7,r0,r3
 err4;	stvx	vr6,r3,r9
 err4;	stvx	vr5,r3,r10
 err4;	stvx	vr4,r3,r11
+#if L1_CACHE_BYTES >= 128
 err4;	stvx	vr3,r3,r12
 err4;	stvx	vr2,r3,r14
 err4;	stvx	vr1,r3,r15
 err4;	stvx	vr0,r3,r16
-	addi	r3,r3,128
+#endif
+	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	8b
 
 	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
 
-	/* Up to 127B to go */
-	clrldi	r5,r5,(64-7)
+	/* Up to L1_CACHE_BYTES - 1 to go */
+	clrldi	r5,r5,(64-L1_CACHE_SHIFT)
 	srdi	r6,r5,4
 	mtocrf	0x01,r6
 
+#if L1_CACHE_BYTES >= 128
 	bf	cr7*4+1,9f
 err3;	lvx	vr3,r0,r4
 err3;	lvx	vr2,r4,r9
@@ -473,6 +488,7 @@ err3;	stvx	vr2,r3,r9
 err3;	stvx	vr1,r3,r10
 err3;	stvx	vr0,r3,r11
 	addi	r3,r3,64
+#endif
 
 9:	bf	cr7*4+2,10f
 err3;	lvx	vr1,r0,r4
@@ -550,11 +566,11 @@ err3;	stw	r7,4(r3)
 
 4:	sub	r5,r5,r6
 
-	/* Get the desination 128B aligned */
+	/* Get the destination L1_CACHE_BYTES aligned */
 	neg	r6,r3
 	srdi	r7,r6,4
 	mtocrf	0x01,r7
-	clrldi	r6,r6,(64-7)
+	clrldi	r6,r6,(64-L1_CACHE_SHIFT)
 
 	li	r9,16
 	li	r10,32
@@ -582,7 +598,9 @@ err3;	stvx	vr8,r0,r3
 err3;	stvx	vr9,r3,r9
 	addi	r3,r3,32
 
-6:	bf	cr7*4+1,7f
+6:
+#if L1_CACHE_BYTES >= 128
+	bf	cr7*4+1,7f
 err3;	lvx	vr3,r0,r4
 	VPERM(vr8,vr0,vr3,vr16)
 err3;	lvx	vr2,r4,r9
@@ -597,9 +615,10 @@ err3;	stvx	vr9,r3,r9
 err3;	stvx	vr10,r3,r10
 err3;	stvx	vr11,r3,r11
 	addi	r3,r3,64
+#endif
 
 7:	sub	r5,r5,r6
-	srdi	r6,r5,7
+	srdi	r6,r5,L1_CACHE_SHIFT
 
 	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
@@ -626,6 +645,10 @@ err4;	lvx	vr5,r4,r10
 	VPERM(vr10,vr6,vr5,vr16)
 err4;	lvx	vr4,r4,r11
 	VPERM(vr11,vr5,vr4,vr16)
+#if L1_CACHE_BYTES == 64
+err4;	lvx	vr0,r4,r11
+	VPERM(vr11,vr5,vr0,vr16)
+#else
 err4;	lvx	vr3,r4,r12
 	VPERM(vr12,vr4,vr3,vr16)
 err4;	lvx	vr2,r4,r14
@@ -634,27 +657,31 @@ err4;	lvx	vr1,r4,r15
 	VPERM(vr14,vr2,vr1,vr16)
 err4;	lvx	vr0,r4,r16
 	VPERM(vr15,vr1,vr0,vr16)
-	addi	r4,r4,128
+#endif
+	addi	r4,r4,L1_CACHE_BYTES
 err4;	stvx	vr8,r0,r3
 err4;	stvx	vr9,r3,r9
 err4;	stvx	vr10,r3,r10
 err4;	stvx	vr11,r3,r11
+#if L1_CACHE_BYTES >= 128
 err4;	stvx	vr12,r3,r12
 err4;	stvx	vr13,r3,r14
 err4;	stvx	vr14,r3,r15
 err4;	stvx	vr15,r3,r16
-	addi	r3,r3,128
+#endif
+	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	8b
 
 	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
 
-	/* Up to 127B to go */
-	clrldi	r5,r5,(64-7)
+	/* Up to L1_CACHE_BYTES - 1 to go */
+	clrldi	r5,r5,(64-L1_CACHE_SHIFT)
 	srdi	r6,r5,4
 	mtocrf	0x01,r6
 
+#if L1_CACHE_BYTES >= 128
 	bf	cr7*4+1,9f
 err3;	lvx	vr3,r0,r4
 	VPERM(vr8,vr0,vr3,vr16)
@@ -670,6 +697,7 @@ err3;	stvx	vr9,r3,r9
 err3;	stvx	vr10,r3,r10
 err3;	stvx	vr11,r3,r11
 	addi	r3,r3,64
+#endif
 
 9:	bf	cr7*4+2,10f
 err3;	lvx	vr1,r0,r4
diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
index 6f2d3be..eb912c5 100644
--- a/tools/testing/selftests/powerpc/copyloops/Makefile
+++ b/tools/testing/selftests/powerpc/copyloops/Makefile
@@ -6,18 +6,25 @@ CFLAGS += -D SELFTEST
 # Use our CFLAGS for the implicit .S rule
 ASFLAGS = $(CFLAGS)
 
-PROGS := copyuser_64 copyuser_power7 memcpy_64 memcpy_power7
+PROGS := copyuser_64 copyuser_power7 copyuser_e6500 memcpy_64 memcpy_power7
 EXTRA_SOURCES := validate.c ../harness.c
 
 all: $(PROGS)
 
 copyuser_64:     CPPFLAGS += -D COPY_LOOP=test___copy_tofrom_user_base
-copyuser_power7: CPPFLAGS += -D COPY_LOOP=test___copy_tofrom_user_power7
+copyuser_power7: CPPFLAGS += -D COPY_LOOP=test___copy_tofrom_user_power7 \
+			     -D CONFIG_PPC_BOOK3S_64 -D L1_CACHE_SHIFT=7 \
+			     -D L1_CACHE_BYTES=128
 memcpy_64:       CPPFLAGS += -D COPY_LOOP=test_memcpy
 memcpy_power7:   CPPFLAGS += -D COPY_LOOP=test_memcpy_power7
 
 $(PROGS): $(EXTRA_SOURCES)
 
+copyuser_e6500: copyuser_power7.S
+	$(CC) $(CFLAGS) -D COPY_LOOP=test___copy_tofrom_user_power7 \
+		-D CONFIG_PPC_BOOK3E_64 -D L1_CACHE_SHIFT=6 \
+		-D L1_CACHE_BYTES=64 copyuser_power7.S $(EXTRA_SOURCES) -o $@
+
 run_tests: all
 	@-for PROG in $(PROGS); do \
 		./$$PROG; \
diff --git a/tools/testing/selftests/powerpc/copyloops/asm/cache.h b/tools/testing/selftests/powerpc/copyloops/asm/cache.h
new file mode 100644
index 0000000..34a05a1
--- /dev/null
+++ b/tools/testing/selftests/powerpc/copyloops/asm/cache.h
@@ -0,0 +1,84 @@
+#ifndef _ASM_POWERPC_CACHE_H
+#define _ASM_POWERPC_CACHE_H
+
+#ifdef __KERNEL__
+
+#include <asm/reg.h>
+
+/* bytes per L1 cache line */
+#if defined(CONFIG_8xx) || defined(CONFIG_403GCX)
+#define L1_CACHE_SHIFT		4
+#define MAX_COPY_PREFETCH	1
+#elif defined(CONFIG_PPC_E500MC)
+#define L1_CACHE_SHIFT		6
+#define MAX_COPY_PREFETCH	4
+#elif defined(CONFIG_PPC32)
+#define MAX_COPY_PREFETCH	4
+#if defined(CONFIG_PPC_47x)
+#define L1_CACHE_SHIFT		7
+#else
+#define L1_CACHE_SHIFT		5
+#endif
+#else /* CONFIG_PPC64 */
+#define L1_CACHE_SHIFT		7
+#endif
+
+#define	L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
+
+#define	SMP_CACHE_BYTES		L1_CACHE_BYTES
+
+#if defined(__powerpc64__) && !defined(__ASSEMBLY__)
+struct ppc64_caches {
+	u32	dsize;			/* L1 d-cache size */
+	u32	dline_size;		/* L1 d-cache line size	*/
+	u32	log_dline_size;
+	u32	dlines_per_page;
+	u32	isize;			/* L1 i-cache size */
+	u32	iline_size;		/* L1 i-cache line size	*/
+	u32	log_iline_size;
+	u32	ilines_per_page;
+};
+
+extern struct ppc64_caches ppc64_caches;
+
+static inline void logmpp(u64 x)
+{
+	asm volatile(PPC_LOGMPP(R1) : : "r" (x));
+}
+
+#endif /* __powerpc64__ && ! __ASSEMBLY__ */
+
+#if defined(__ASSEMBLY__)
+/*
+ * For a snooping icache, we still need a dummy icbi to purge all the
+ * prefetched instructions from the ifetch buffers. We also need a sync
+ * before the icbi to order the the actual stores to memory that might
+ * have modified instructions with the icbi.
+ */
+#define PURGE_PREFETCHED_INS	\
+	sync;			\
+	icbi	0,r3;		\
+	sync;			\
+	isync
+
+#else
+#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+
+#ifdef CONFIG_6xx
+extern long _get_L2CR(void);
+extern long _get_L3CR(void);
+extern void _set_L2CR(unsigned long);
+extern void _set_L3CR(unsigned long);
+#else
+#define _get_L2CR()	0L
+#define _get_L3CR()	0L
+#define _set_L2CR(val)	do { } while(0)
+#define _set_L3CR(val)	do { } while(0)
+#endif
+
+extern void cacheable_memzero(void *p, unsigned int nb);
+extern void *cacheable_memcpy(void *, const void *, unsigned int);
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_CACHE_H */
-- 
2.3.3
