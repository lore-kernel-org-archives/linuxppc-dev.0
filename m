Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH] powerpc/47x: Use the new ppc-opcode intrastructiure.
Date: Wed,  3 Oct 2012 11:52:19 +1000
Message-Id: <1349229139-6330-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't use 47x only #defines for TLBIVAX or ICBT, supply and use helpers
in ppc-opcode.h

This fixes a compile breakage.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |    4 ++++
 arch/powerpc/mm/tlb_nohash_low.S      |   15 ++++-----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 4c25319..b5ed49c 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -86,6 +86,7 @@
 #define PPC_INST_DCBA_MASK		0xfc0007fe
 #define PPC_INST_DCBAL			0x7c2005ec
 #define PPC_INST_DCBZL			0x7c2007ec
+#define PPC_INST_ICBT			0x7c00002c
 #define PPC_INST_ISEL			0x7c00001e
 #define PPC_INST_ISEL_MASK		0xfc00003e
 #define PPC_INST_LDARX			0x7c0000a8
@@ -197,6 +198,7 @@
 #define __PPC_MB(s)	(((s) & 0x1f) << 6)
 #define __PPC_ME(s)	(((s) & 0x1f) << 1)
 #define __PPC_BI(s)	(((s) & 0x1f) << 16)
+#define __PPC_CT(t)	(((t) & 0x0f) << 21)
 
 /*
  * Only use the larx hint bit on 64bit CPUs. e500v1/v2 based CPUs will treat a
@@ -259,6 +261,8 @@
 					__PPC_RS(t) | __PPC_RA0(a) | __PPC_RB(b))
 #define PPC_SLBFEE_DOT(t, b)	stringify_in_c(.long PPC_INST_SLBFEE | \
 					__PPC_RT(t) | __PPC_RB(b))
+#define PPC_ICBT(c,a,b)		stringify_in_c(.long PPC_INST_ICBT | \
+				       __PPC_CT(c) | __PPC_RA0(a) | __PPC_RB(b))
 /* PASemi instructions */
 #define LBZCIX(t,a,b)		stringify_in_c(.long PPC_INST_LBZCIX | \
 				       __PPC_RT(t) | __PPC_RA(a) | __PPC_RB(b))
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index fab919f..626ad08 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -191,12 +191,6 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 #ifdef CONFIG_PPC_47x
 
 /*
- * 47x variant of icbt
- */
-# define ICBT(CT,RA,RB)	\
-	.long	0x7c00002c | ((CT) << 21) | ((RA) << 16) | ((RB) << 11)
-
-/*
  * _tlbivax_bcast is only on 47x. We don't bother doing a runtime
  * check though, it will blow up soon enough if we mistakenly try
  * to use it on a 440.
@@ -208,8 +202,7 @@ _GLOBAL(_tlbivax_bcast)
 	wrteei	0
 	mtspr	SPRN_MMUCR,r5
 	isync
-/*	tlbivax	0,r3 - use .long to avoid binutils deps */
-	.long 0x7c000624 | (r3 << 11)
+	PPC_TLBIVAX(0, R3)
 	isync
 	eieio
 	tlbsync
@@ -227,11 +220,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_476_DD2)
 	bl	2f
 2:	mflr	r6
 	li	r7,32
-	ICBT(0,r6,r7)		/* touch next cache line */
+	PPC_ICBT(0,R6,R7)		/* touch next cache line */
 	add	r6,r6,r7
-	ICBT(0,r6,r7)		/* touch next cache line */
+	PPC_ICBT(0,R6,R7)		/* touch next cache line */
 	add	r6,r6,r7
-	ICBT(0,r6,r7)		/* touch next cache line */
+	PPC_ICBT(0,R6,R7)		/* touch next cache line */
 	sync
 	nop
 	nop
-- 
1.7.7.6
