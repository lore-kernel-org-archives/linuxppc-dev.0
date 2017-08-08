Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXx96HddzDqpc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:58:53 +1000 (AEST)
Message-Id: <1807d3100d87fb9b589cafbf29a0c19e0a54b5d1.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 06/12] powerpc/time: refactor MFTB() to limit number of ifdefs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:58:50 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 8xx cannot access the TBL and TBU registers using mfspr/mtspr
It must be accessed using mftb/mftbu

Due to this, there is a number of places with #ifdef CONFIG_8xx

This patch defines new macros MFTBL(x) and MFTBU(x) on the same model
as MFTB(x) and tries to make use of them as much as possible.

In arch/powerpc/include/asm/timex.h, we also remove the ifdef
for the asm() operands as the compiler doesn't mind unused operands

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/boot/ppc_asm.h               |  8 ++++++++
 arch/powerpc/boot/util.S                  | 24 +++++-------------------
 arch/powerpc/include/asm/ppc_asm.h        | 12 +++++++++---
 arch/powerpc/include/asm/timex.h          |  4 ----
 arch/powerpc/kernel/vdso32/gettimeofday.S | 12 +++---------
 5 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/boot/ppc_asm.h b/arch/powerpc/boot/ppc_asm.h
index 68e388ee94fe..c63299f9fdd9 100644
--- a/arch/powerpc/boot/ppc_asm.h
+++ b/arch/powerpc/boot/ppc_asm.h
@@ -80,4 +80,12 @@
 	.long 0xa6037b7d; /* mtsrr1 r11				*/ \
 	.long 0x2400004c  /* rfid				*/
 
+#ifdef CONFIG_PPC_8xx
+#define MFTBL(dest)			mftb dest
+#define MFTBU(dest)			mftbu dest
+#else
+#define MFTBL(dest)			mfspr dest, SPRN_TBRL
+#define MFTBU(dest)			mfspr dest, SPRN_TBRU
+#endif
+
 #endif /* _PPC64_PPC_ASM_H */
diff --git a/arch/powerpc/boot/util.S b/arch/powerpc/boot/util.S
index 243b8497d58b..ec069177d942 100644
--- a/arch/powerpc/boot/util.S
+++ b/arch/powerpc/boot/util.S
@@ -71,32 +71,18 @@ udelay:
 	add	r4,r4,r5
 	addi	r4,r4,-1
 	divw	r4,r4,r5	/* BUS ticks */
-#ifdef CONFIG_8xx
-1:	mftbu	r5
-	mftb	r6
-	mftbu	r7
-#else
-1:	mfspr	r5, SPRN_TBRU
-	mfspr	r6, SPRN_TBRL
-	mfspr	r7, SPRN_TBRU
-#endif
+1:	MFTBU(r5)
+	MFTBL(r6)
+	MFTBU(r7)
 	cmpw	0,r5,r7
 	bne	1b		/* Get [synced] base time */
 	addc	r9,r6,r4	/* Compute end time */
 	addze	r8,r5
-#ifdef CONFIG_8xx
-2:	mftbu	r5
-#else
-2:	mfspr	r5, SPRN_TBRU
-#endif
+2:	MFTBU(r5)
 	cmpw	0,r5,r8
 	blt	2b
 	bgt	3f
-#ifdef CONFIG_8xx
-	mftb	r6
-#else
-	mfspr	r6, SPRN_TBRL
-#endif
+	MFTBL(r6)
 	cmpw	0,r6,r9
 	blt	2b
 3:	blr
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 6baeeb9acd0d..d0e4f909ee36 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -378,10 +378,16 @@ BEGIN_FTR_SECTION_NESTED(96);		\
 	cmpwi dest,0;			\
 	beq-  90b;			\
 END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_CELL_TB_BUG, 96)
-#elif defined(CONFIG_8xx)
-#define MFTB(dest)			mftb dest
 #else
-#define MFTB(dest)			mfspr dest, SPRN_TBRL
+#define MFTB(dest)			MFTBL(dest)
+#endif
+
+#ifdef CONFIG_PPC_8xx
+#define MFTBL(dest)			mftb dest
+#define MFTBU(dest)			mftbu dest
+#else
+#define MFTBL(dest)			mfspr dest, SPRN_TBRL
+#define MFTBU(dest)			mfspr dest, SPRN_TBRU
 #endif
 
 #ifndef CONFIG_SMP
diff --git a/arch/powerpc/include/asm/timex.h b/arch/powerpc/include/asm/timex.h
index 2cf846edb3fc..b467dbcb0fb7 100644
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -45,11 +45,7 @@ static inline cycles_t get_cycles(void)
 		"	.long 0\n"
 		"	.long 0\n"
 		".previous"
-#ifdef CONFIG_8xx
-		: "=r" (ret) : "i" (CPU_FTR_601));
-#else
 		: "=r" (ret) : "i" (CPU_FTR_601), "i" (SPRN_TBRL));
-#endif
 	return ret;
 #endif
 }
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 6b2b69616e77..769c2624e0a6 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -232,15 +232,9 @@ __do_get_tspec:
 	lwz	r6,(CFG_TB_ORIG_STAMP+4)(r9)
 
 	/* Get a stable TB value */
-#ifdef CONFIG_8xx
-2:	mftbu	r3
-	mftbl	r4
-	mftbu	r0
-#else
-2:	mfspr	r3, SPRN_TBRU
-	mfspr	r4, SPRN_TBRL
-	mfspr	r0, SPRN_TBRU
-#endif
+2:	MFTBU(r3)
+	MFTBL(r4)
+	MFTBU(r0)
 	cmplw	cr0,r3,r0
 	bne-	2b
 
-- 
2.13.3
