Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B645C2C010B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 12:12:55 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/4] powerpc: Convert some mftb/mftbu into mfspr
Date: Tue, 20 Aug 2013 21:12:39 -0500
Message-ID: <1377051162-2588-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1377051162-2588-1-git-send-email-scottwood@freescale.com>
References: <1377051162-2588-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Catalin Udma <catalin.udma@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some CPUs (such as e500v1/v2) don't implement mftb and will take a
trap.  mfspr should work on everything that has a timebase, and is the
preferred instruction according to ISA v2.06.

Currently we get away with mftb on 85xx because the assembler converts
it to mfspr due to -Wa,-me500.  However, that flag has other effects
that are undesireable for certain targets (e.g.  lwsync is converted to
sync), and is hostile to multiplatform kernels.  Thus we would like to
stop setting it for all e500-family builds.

mftb/mftbu instances which are in 85xx code or common code are
converted.  Instances which will never run on 85xx are left alone.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/ppc_asm.h               |  3 +++
 arch/powerpc/boot/util.S                  | 10 +++++-----
 arch/powerpc/include/asm/ppc_asm.h        |  4 ++--
 arch/powerpc/include/asm/reg.h            | 15 ++++++++++-----
 arch/powerpc/include/asm/timex.h          |  4 ++--
 arch/powerpc/kernel/vdso32/gettimeofday.S |  6 +++---
 arch/powerpc/platforms/85xx/smp.c         |  6 ++++--
 7 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/boot/ppc_asm.h b/arch/powerpc/boot/ppc_asm.h
index 1c2c281..eb0e98b 100644
--- a/arch/powerpc/boot/ppc_asm.h
+++ b/arch/powerpc/boot/ppc_asm.h
@@ -59,4 +59,7 @@
 #define	r30	30
 #define	r31	31
 
+#define SPRN_TBRL	268
+#define SPRN_TBRU	269
+
 #endif /* _PPC64_PPC_ASM_H */
diff --git a/arch/powerpc/boot/util.S b/arch/powerpc/boot/util.S
index 427ddfc..5143228 100644
--- a/arch/powerpc/boot/util.S
+++ b/arch/powerpc/boot/util.S
@@ -71,18 +71,18 @@ udelay:
 	add	r4,r4,r5
 	addi	r4,r4,-1
 	divw	r4,r4,r5	/* BUS ticks */
-1:	mftbu	r5
-	mftb	r6
-	mftbu	r7
+1:	mfspr	r5, SPRN_TBRU
+	mfspr	r6, SPRN_TBRL
+	mfspr	r7, SPRN_TBRU
 	cmpw	0,r5,r7
 	bne	1b		/* Get [synced] base time */
 	addc	r9,r6,r4	/* Compute end time */
 	addze	r8,r5
-2:	mftbu	r5
+2:	mfspr	r5, SPRN_TBRU
 	cmpw	0,r5,r8
 	blt	2b
 	bgt	3f
-	mftb	r6
+	mfspr	r6, SPRN_TBRL
 	cmpw	0,r6,r9
 	blt	2b
 3:	blr
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 8fdd3da..5995457 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -433,13 +433,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 
 #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
 #define MFTB(dest)			\
-90:	mftb  dest;			\
+90:	mfspr dest, SPRN_TBRL;		\
 BEGIN_FTR_SECTION_NESTED(96);		\
 	cmpwi dest,0;			\
 	beq-  90b;			\
 END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_CELL_TB_BUG, 96)
 #else
-#define MFTB(dest)			mftb dest
+#define MFTB(dest)			mfspr dest, SPRN_TBRL
 #endif
 
 #ifndef CONFIG_SMP
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 55b0307..64264bf 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1120,7 +1120,7 @@
 #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
 #define mftb()		({unsigned long rval;				\
 			asm volatile(					\
-				"90:	mftb %0;\n"			\
+				"90:	mfspr %0, %2;\n"		\
 				"97:	cmpwi %0,0;\n"			\
 				"	beq- 90b;\n"			\
 				"99:\n"					\
@@ -1134,18 +1134,23 @@
 				"	.llong 0\n"			\
 				"	.llong 0\n"			\
 				".previous"				\
-			: "=r" (rval) : "i" (CPU_FTR_CELL_TB_BUG)); rval;})
+			: "=r" (rval) \
+			: "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL)); \
+			rval;})
 #else
 #define mftb()		({unsigned long rval;	\
-			asm volatile("mftb %0" : "=r" (rval)); rval;})
+			asm volatile("mfspr %0, %1" : \
+				     "=r" (rval) : "i" (SPRN_TBRL)); rval;})
 #endif /* !CONFIG_PPC_CELL */
 
 #else /* __powerpc64__ */
 
 #define mftbl()		({unsigned long rval;	\
-			asm volatile("mftbl %0" : "=r" (rval)); rval;})
+			asm volatile("mfspr %0, %1" : "=r" (rval) : \
+				"i" (SPRN_TBRL)); rval;})
 #define mftbu()		({unsigned long rval;	\
-			asm volatile("mftbu %0" : "=r" (rval)); rval;})
+			asm volatile("mfspr %0, %1" : "=r" (rval) : \
+				"i" (SPRN_TBRU)); rval;})
 #endif /* !__powerpc64__ */
 
 #define mttbl(v)	asm volatile("mttbl %0":: "r"(v))
diff --git a/arch/powerpc/include/asm/timex.h b/arch/powerpc/include/asm/timex.h
index c55e14f..18908ca 100644
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -29,7 +29,7 @@ static inline cycles_t get_cycles(void)
 	ret = 0;
 
 	__asm__ __volatile__(
-		"97:	mftb %0\n"
+		"97:	mfspr %0, %2\n"
 		"99:\n"
 		".section __ftr_fixup,\"a\"\n"
 		".align 2\n"
@@ -41,7 +41,7 @@ static inline cycles_t get_cycles(void)
 		"	.long 0\n"
 		"	.long 0\n"
 		".previous"
-		: "=r" (ret) : "i" (CPU_FTR_601));
+		: "=r" (ret) : "i" (CPU_FTR_601), "i" (SPRN_TBRL));
 	return ret;
 #endif
 }
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 27e2f62..6b1f2a6 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -232,9 +232,9 @@ __do_get_tspec:
 	lwz	r6,(CFG_TB_ORIG_STAMP+4)(r9)
 
 	/* Get a stable TB value */
-2:	mftbu	r3
-	mftbl	r4
-	mftbu	r0
+2:	mfspr	r3, SPRN_TBRU
+	mfspr	r4, SPRN_TBRL
+	mfspr	r0, SPRN_TBRU
 	cmplw	cr0,r3,r0
 	bne-	2b
 
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index ea7e629..281b7f0 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -83,11 +83,13 @@ static void mpc85xx_give_timebase(void)
 	{
 		u64 prev;
 
-		asm volatile("mftb %0" : "=r" (timebase));
+		asm volatile("mfspr %0, %1" : "=r" (timebase) :
+			     "i" (SPRN_TBRL));
 
 		do {
 			prev = timebase;
-			asm volatile("mftb %0" : "=r" (timebase));
+			asm volatile("mfspr %0, %1" : "=r" (timebase) :
+				     "i" (SPRN_TBRL));
 		} while (prev != timebase);
 	}
 #else
-- 
1.8.1.2
