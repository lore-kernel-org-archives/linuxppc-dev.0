Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 21 Jun 2012 12:04:34 +1000
Subject: [PATCH 7/18] powerpc: merge STK_REG/PARAM/FRAMESIZE
In-Reply-To: <1340244266.960241.475925824909.qpush@ale>
Message-Id: <20120621020434.39541D431D9@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge the defines of STACKFRAMESIZE, STK_REG, STK_PARAM from different
places.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc_asm.h             |    5 +
 arch/powerpc/lib/checksum_64.S                 |    3 
 arch/powerpc/lib/copypage_power7.S             |    3 
 arch/powerpc/lib/copyuser_power7.S             |    3 
 arch/powerpc/lib/memcpy_power7.S               |    3 
 arch/powerpc/mm/hash_low_64.S                  |   88 +++++++++++--------------
 arch/powerpc/platforms/cell/beat_hvCall.S      |   28 +++----
 arch/powerpc/platforms/powernv/opal-takeover.S |    2 
 arch/powerpc/platforms/pseries/hvCall.S        |   72 +++++++++-----------
 9 files changed, 93 insertions(+), 114 deletions(-)

Index: powerpc-test/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc_asm.h
+++ powerpc-test/arch/powerpc/include/asm/ppc_asm.h
@@ -181,6 +181,11 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLP
 #ifdef __KERNEL__
 #ifdef CONFIG_PPC64
 
+#define STACKFRAMESIZE 256
+#define STK_REG(i)     (112 + ((i)-14)*8)
+
+#define STK_PARAM(i)	(48 + ((i)-3)*8)
+
 #define XGLUE(a,b) a##b
 #define GLUE(a,b) XGLUE(a,b)
 
Index: powerpc-test/arch/powerpc/lib/checksum_64.S
===================================================================
--- powerpc-test.orig/arch/powerpc/lib/checksum_64.S
+++ powerpc-test/arch/powerpc/lib/checksum_64.S
@@ -65,9 +65,6 @@ _GLOBAL(csum_tcpudp_magic)
 	srwi	r3,r3,16
 	blr
 
-#define STACKFRAMESIZE 256
-#define STK_REG(i)	(112 + ((i)-14)*8)
-
 /*
  * Computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit).
Index: powerpc-test/arch/powerpc/lib/copypage_power7.S
===================================================================
--- powerpc-test.orig/arch/powerpc/lib/copypage_power7.S
+++ powerpc-test/arch/powerpc/lib/copypage_power7.S
@@ -20,9 +20,6 @@
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
 
-#define STACKFRAMESIZE	256
-#define STK_REG(i)	(112 + ((i)-14)*8)
-
 _GLOBAL(copypage_power7)
 	/*
 	 * We prefetch both the source and destination using enhanced touch
Index: powerpc-test/arch/powerpc/lib/copyuser_power7.S
===================================================================
--- powerpc-test.orig/arch/powerpc/lib/copyuser_power7.S
+++ powerpc-test/arch/powerpc/lib/copyuser_power7.S
@@ -19,9 +19,6 @@
  */
 #include <asm/ppc_asm.h>
 
-#define STACKFRAMESIZE	256
-#define STK_REG(i)	(112 + ((i)-14)*8)
-
 	.macro err1
 100:
 	.section __ex_table,"a"
Index: powerpc-test/arch/powerpc/lib/memcpy_power7.S
===================================================================
--- powerpc-test.orig/arch/powerpc/lib/memcpy_power7.S
+++ powerpc-test/arch/powerpc/lib/memcpy_power7.S
@@ -19,9 +19,6 @@
  */
 #include <asm/ppc_asm.h>
 
-#define STACKFRAMESIZE	256
-#define STK_REG(i)	(112 + ((i)-14)*8)
-
 _GLOBAL(memcpy_power7)
 #ifdef CONFIG_ALTIVEC
 	cmpldi	r5,16
Index: powerpc-test/arch/powerpc/mm/hash_low_64.S
===================================================================
--- powerpc-test.orig/arch/powerpc/mm/hash_low_64.S
+++ powerpc-test/arch/powerpc/mm/hash_low_64.S
@@ -34,14 +34,6 @@
  *         |   CR save area			(SP + 8)
  * SP ---> +-- Back chain			(SP + 0)
  */
-#define STACKFRAMESIZE	256
-
-/* Save parameters offsets */
-#define STK_PARM(i)	(STACKFRAMESIZE + 48 + ((i)-3)*8)
-
-/* Save non-volatile offsets */
-#define STK_REG(i)	(112 + ((i)-14)*8)
-
 
 #ifndef CONFIG_PPC_64K_PAGES
 
@@ -64,9 +56,9 @@ _GLOBAL(__hash_page_4K)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	/* Save all params that we need after a function call */
-	std	r6,STK_PARM(R6)(r1)
-	std	r8,STK_PARM(R8)(r1)
-	std	r9,STK_PARM(R9)(r1)
+	std	r6,STK_PARAM(R6)(r1)
+	std	r8,STK_PARAM(R8)(r1)
+	std	r9,STK_PARAM(R9)(r1)
 	
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
@@ -162,7 +154,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	/* At this point, r3 contains new PP bits, save them in
 	 * place of "access" in the param area (sic)
 	 */
-	std	r3,STK_PARM(R4)(r1)
+	std	r3,STK_PARAM(R4)(r1)
 
 	/* Get htab_hash_mask */
 	ld	r4,htab_hash_mask@got(2)
@@ -192,11 +184,11 @@ htab_insert_pte:
 	rldicr	r3,r0,3,63-3		/* r3 = (hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARAM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(R9)(r1)	/* segment size */
+	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -215,11 +207,11 @@ _GLOBAL(htab_call_hpte_insert1)
 	rldicr	r3,r0,3,63-3	/* r0 = (~hash & mask) << 3 */
 	
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARAM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(R9)(r1)	/* segment size */
+	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* Patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -255,7 +247,7 @@ htab_pte_insert_ok:
 	 * (maybe add eieio may be good still ?)
 	 */
 htab_write_out_pte:
-	ld	r6,STK_PARM(R6)(r1)
+	ld	r6,STK_PARAM(R6)(r1)
 	std	r30,0(r6)
 	li	r3, 0
 htab_bail:
@@ -288,8 +280,8 @@ htab_modify_pte:
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* va */
 	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARM(R9)(r1)	/* segment size */
-	ld	r8,STK_PARM(R8)(r1)	/* get "local" param */
+	ld	r7,STK_PARAM(R9)(r1)	/* segment size */
+	ld	r8,STK_PARAM(R8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* Patched by htab_finish_init() */
 
@@ -312,7 +304,7 @@ htab_wrong_access:
 
 htab_pte_insert_failure:
 	/* Bail out restoring old PTE */
-	ld	r6,STK_PARM(R6)(r1)
+	ld	r6,STK_PARAM(R6)(r1)
 	std	r31,0(r6)
 	li	r3,-1
 	b	htab_bail
@@ -340,9 +332,9 @@ _GLOBAL(__hash_page_4K)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	/* Save all params that we need after a function call */
-	std	r6,STK_PARM(R6)(r1)
-	std	r8,STK_PARM(R8)(r1)
-	std	r9,STK_PARM(R9)(r1)
+	std	r6,STK_PARAM(R6)(r1)
+	std	r8,STK_PARAM(R8)(r1)
+	std	r9,STK_PARAM(R9)(r1)
 
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
@@ -452,7 +444,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	/* At this point, r3 contains new PP bits, save them in
 	 * place of "access" in the param area (sic)
 	 */
-	std	r3,STK_PARM(R4)(r1)
+	std	r3,STK_PARAM(R4)(r1)
 
 	/* Get htab_hash_mask */
 	ld	r4,htab_hash_mask@got(2)
@@ -473,7 +465,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	andis.	r0,r31,_PAGE_COMBO@h
 	beq	htab_inval_old_hpte
 
-	ld	r6,STK_PARM(R6)(r1)
+	ld	r6,STK_PARAM(R6)(r1)
 	ori	r26,r6,0x8000		/* Load the hidx mask */
 	ld	r26,0(r26)
 	addi	r5,r25,36		/* Check actual HPTE_SUB bit, this */
@@ -495,11 +487,11 @@ htab_special_pfn:
 	rldicr	r3,r0,3,63-3		/* r0 = (hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARAM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(R9)(r1)	/* segment size */
+	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -522,11 +514,11 @@ _GLOBAL(htab_call_hpte_insert1)
 	rldicr	r3,r0,3,63-3		/* r0 = (~hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARAM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_4K		/* page size */
-	ld	r9,STK_PARM(R9)(r1)	/* segment size */
+	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(htab_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -559,8 +551,8 @@ htab_inval_old_hpte:
 	mr	r4,r31			/* PTE.pte */
 	li	r5,0			/* PTE.hidx */
 	li	r6,MMU_PAGE_64K		/* psize */
-	ld	r7,STK_PARM(R9)(r1)	/* ssize */
-	ld	r8,STK_PARM(R8)(r1)	/* local */
+	ld	r7,STK_PARAM(R9)(r1)	/* ssize */
+	ld	r8,STK_PARAM(R8)(r1)	/* local */
 	bl	.flush_hash_page
 	/* Clear out _PAGE_HPTE_SUB bits in the new linux PTE */
 	lis	r0,_PAGE_HPTE_SUB@h
@@ -576,7 +568,7 @@ htab_pte_insert_ok:
 	/* Insert slot number & secondary bit in PTE second half,
 	 * clear _PAGE_BUSY and set approriate HPTE slot bit
 	 */
-	ld	r6,STK_PARM(R6)(r1)
+	ld	r6,STK_PARAM(R6)(r1)
 	li	r0,_PAGE_BUSY
 	andc	r30,r30,r0
 	/* HPTE SUB bit */
@@ -630,8 +622,8 @@ htab_modify_pte:
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* va */
 	li	r6,MMU_PAGE_4K		/* page size */
-	ld	r7,STK_PARM(R9)(r1)	/* segment size */
-	ld	r8,STK_PARM(R8)(r1)	/* get "local" param */
+	ld	r7,STK_PARAM(R9)(r1)	/* segment size */
+	ld	r8,STK_PARAM(R8)(r1)	/* get "local" param */
 _GLOBAL(htab_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
 
@@ -644,7 +636,7 @@ _GLOBAL(htab_call_hpte_updatepp)
 	/* Clear the BUSY bit and Write out the PTE */
 	li	r0,_PAGE_BUSY
 	andc	r30,r30,r0
-	ld	r6,STK_PARM(R6)(r1)
+	ld	r6,STK_PARAM(R6)(r1)
 	std	r30,0(r6)
 	li	r3,0
 	b	htab_bail
@@ -657,7 +649,7 @@ htab_wrong_access:
 
 htab_pte_insert_failure:
 	/* Bail out restoring old PTE */
-	ld	r6,STK_PARM(R6)(r1)
+	ld	r6,STK_PARAM(R6)(r1)
 	std	r31,0(r6)
 	li	r3,-1
 	b	htab_bail
@@ -677,9 +669,9 @@ _GLOBAL(__hash_page_64K)
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
 	/* Save all params that we need after a function call */
-	std	r6,STK_PARM(R6)(r1)
-	std	r8,STK_PARM(R8)(r1)
-	std	r9,STK_PARM(R9)(r1)
+	std	r6,STK_PARAM(R6)(r1)
+	std	r8,STK_PARAM(R8)(r1)
+	std	r9,STK_PARAM(R9)(r1)
 
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
@@ -780,7 +772,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	/* At this point, r3 contains new PP bits, save them in
 	 * place of "access" in the param area (sic)
 	 */
-	std	r3,STK_PARM(R4)(r1)
+	std	r3,STK_PARAM(R4)(r1)
 
 	/* Get htab_hash_mask */
 	ld	r4,htab_hash_mask@got(2)
@@ -813,11 +805,11 @@ ht64_insert_pte:
 	rldicr	r3,r0,3,63-3	/* r0 = (hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARAM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,0			/* !bolted, !secondary */
 	li	r8,MMU_PAGE_64K
-	ld	r9,STK_PARM(R9)(r1)	/* segment size */
+	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert1)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -836,11 +828,11 @@ _GLOBAL(ht64_call_hpte_insert1)
 	rldicr	r3,r0,3,63-3	/* r0 = (~hash & mask) << 3 */
 
 	/* Call ppc_md.hpte_insert */
-	ld	r6,STK_PARM(R4)(r1)	/* Retrieve new pp bits */
+	ld	r6,STK_PARAM(R4)(r1)	/* Retrieve new pp bits */
 	mr	r4,r29			/* Retrieve va */
 	li	r7,HPTE_V_SECONDARY	/* !bolted, secondary */
 	li	r8,MMU_PAGE_64K
-	ld	r9,STK_PARM(R9)(r1)	/* segment size */
+	ld	r9,STK_PARAM(R9)(r1)	/* segment size */
 _GLOBAL(ht64_call_hpte_insert2)
 	bl	.			/* patched by htab_finish_init() */
 	cmpdi	0,r3,0
@@ -876,7 +868,7 @@ ht64_pte_insert_ok:
 	 * (maybe add eieio may be good still ?)
 	 */
 ht64_write_out_pte:
-	ld	r6,STK_PARM(R6)(r1)
+	ld	r6,STK_PARAM(R6)(r1)
 	std	r30,0(r6)
 	li	r3, 0
 ht64_bail:
@@ -909,8 +901,8 @@ ht64_modify_pte:
 	/* Call ppc_md.hpte_updatepp */
 	mr	r5,r29			/* va */
 	li	r6,MMU_PAGE_64K
-	ld	r7,STK_PARM(R9)(r1)	/* segment size */
-	ld	r8,STK_PARM(R8)(r1)	/* get "local" param */
+	ld	r7,STK_PARAM(R9)(r1)	/* segment size */
+	ld	r8,STK_PARAM(R8)(r1)	/* get "local" param */
 _GLOBAL(ht64_call_hpte_updatepp)
 	bl	.			/* patched by htab_finish_init() */
 
@@ -933,7 +925,7 @@ ht64_wrong_access:
 
 ht64_pte_insert_failure:
 	/* Bail out restoring old PTE */
-	ld	r6,STK_PARM(R6)(r1)
+	ld	r6,STK_PARAM(R6)(r1)
 	std	r31,0(r6)
 	li	r3,-1
 	b	ht64_bail
Index: powerpc-test/arch/powerpc/platforms/cell/beat_hvCall.S
===================================================================
--- powerpc-test.orig/arch/powerpc/platforms/cell/beat_hvCall.S
+++ powerpc-test/arch/powerpc/platforms/cell/beat_hvCall.S
@@ -22,8 +22,6 @@
 
 #include <asm/ppc_asm.h>
 
-#define	STK_PARM(i)	(48 + ((i)-3)*8)
-
 /* Not implemented on Beat, now */
 #define	HCALL_INST_PRECALL
 #define	HCALL_INST_POSTCALL
@@ -74,7 +72,7 @@ _GLOBAL(beat_hcall_norets8)
 	mr	r6,r7
 	mr	r7,r8
 	mr	r8,r9
-	ld	r10,STK_PARM(R10)(r1)
+	ld	r10,STK_PARAM(R10)(r1)
 
 	HVSC				/* invoke the hypervisor */
 
@@ -94,7 +92,7 @@ _GLOBAL(beat_hcall1)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
+	std	r4,STK_PARAM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -108,7 +106,7 @@ _GLOBAL(beat_hcall1)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 
 	lwz	r0,8(r1)
@@ -125,7 +123,7 @@ _GLOBAL(beat_hcall2)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
+	std	r4,STK_PARAM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -139,7 +137,7 @@ _GLOBAL(beat_hcall2)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 
@@ -157,7 +155,7 @@ _GLOBAL(beat_hcall3)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
+	std	r4,STK_PARAM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -171,7 +169,7 @@ _GLOBAL(beat_hcall3)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -190,7 +188,7 @@ _GLOBAL(beat_hcall4)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
+	std	r4,STK_PARAM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -204,7 +202,7 @@ _GLOBAL(beat_hcall4)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -224,7 +222,7 @@ _GLOBAL(beat_hcall5)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
+	std	r4,STK_PARAM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -238,7 +236,7 @@ _GLOBAL(beat_hcall5)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -259,7 +257,7 @@ _GLOBAL(beat_hcall6)
 
 	HCALL_INST_PRECALL
 
-	std	r4,STK_PARM(R4)(r1)	/* save ret buffer */
+	std	r4,STK_PARAM(R4)(r1)	/* save ret buffer */
 
 	mr	r11,r3
 	mr	r3,r5
@@ -273,7 +271,7 @@ _GLOBAL(beat_hcall6)
 
 	HCALL_INST_POSTCALL
 
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
Index: powerpc-test/arch/powerpc/platforms/powernv/opal-takeover.S
===================================================================
--- powerpc-test.orig/arch/powerpc/platforms/powernv/opal-takeover.S
+++ powerpc-test/arch/powerpc/platforms/powernv/opal-takeover.S
@@ -14,8 +14,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/opal.h>
 
-#define STK_PARAM(i)	(48 + ((i)-3)*8)
-
 #define H_HAL_TAKEOVER			0x5124
 #define H_HAL_TAKEOVER_QUERY_MAGIC	-1
 
Index: powerpc-test/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- powerpc-test.orig/arch/powerpc/platforms/pseries/hvCall.S
+++ powerpc-test/arch/powerpc/platforms/pseries/hvCall.S
@@ -13,8 +13,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 	
-#define STK_PARM(i)     (48 + ((i)-3)*8)
-
 #ifdef CONFIG_TRACEPOINTS
 
 	.section	".toc","aw"
@@ -26,7 +24,7 @@ hcall_tracepoint_refcount:
 	.section	".text"
 
 /*
- * precall must preserve all registers.  use unused STK_PARM()
+ * precall must preserve all registers.  use unused STK_PARAM()
  * areas to save snapshots and opcode. We branch around this
  * in early init (eg when populating the MMU hashtable) by using an
  * unconditional cpu feature.
@@ -40,28 +38,28 @@ END_FTR_SECTION(0, 1);						\
 	cmpdi	r12,0;						\
 	beq+	1f;						\
 	mflr	r0;						\
-	std	r3,STK_PARM(R3)(r1);				\
-	std	r4,STK_PARM(R4)(r1);				\
-	std	r5,STK_PARM(R5)(r1);				\
-	std	r6,STK_PARM(R6)(r1);				\
-	std	r7,STK_PARM(R7)(r1);				\
-	std	r8,STK_PARM(R8)(r1);				\
-	std	r9,STK_PARM(R9)(r1);				\
-	std	r10,STK_PARM(R10)(r1);				\
+	std	r3,STK_PARAM(R3)(r1);				\
+	std	r4,STK_PARAM(R4)(r1);				\
+	std	r5,STK_PARAM(R5)(r1);				\
+	std	r6,STK_PARAM(R6)(r1);				\
+	std	r7,STK_PARAM(R7)(r1);				\
+	std	r8,STK_PARAM(R8)(r1);				\
+	std	r9,STK_PARAM(R9)(r1);				\
+	std	r10,STK_PARAM(R10)(r1);				\
 	std	r0,16(r1);					\
-	addi	r4,r1,STK_PARM(FIRST_REG);			\
+	addi	r4,r1,STK_PARAM(FIRST_REG);			\
 	stdu	r1,-STACK_FRAME_OVERHEAD(r1);			\
 	bl	.__trace_hcall_entry;				\
 	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
 	ld	r0,16(r1);					\
-	ld	r3,STK_PARM(R3)(r1);				\
-	ld	r4,STK_PARM(R4)(r1);				\
-	ld	r5,STK_PARM(R5)(r1);				\
-	ld	r6,STK_PARM(R6)(r1);				\
-	ld	r7,STK_PARM(R7)(r1);				\
-	ld	r8,STK_PARM(R8)(r1);				\
-	ld	r9,STK_PARM(R9)(r1);				\
-	ld	r10,STK_PARM(R10)(r1);				\
+	ld	r3,STK_PARAM(R3)(r1);				\
+	ld	r4,STK_PARAM(R4)(r1);				\
+	ld	r5,STK_PARAM(R5)(r1);				\
+	ld	r6,STK_PARAM(R6)(r1);				\
+	ld	r7,STK_PARAM(R7)(r1);				\
+	ld	r8,STK_PARAM(R8)(r1);				\
+	ld	r9,STK_PARAM(R9)(r1);				\
+	ld	r10,STK_PARAM(R10)(r1);				\
 	mtlr	r0;						\
 1:
 
@@ -79,8 +77,8 @@ END_FTR_SECTION(0, 1);						\
 	cmpdi	r12,0;						\
 	beq+	1f;						\
 	mflr	r0;						\
-	ld	r6,STK_PARM(R3)(r1);				\
-	std	r3,STK_PARM(R3)(r1);				\
+	ld	r6,STK_PARAM(R3)(r1);				\
+	std	r3,STK_PARAM(R3)(r1);				\
 	mr	r4,r3;						\
 	mr	r3,r6;						\
 	std	r0,16(r1);					\
@@ -88,7 +86,7 @@ END_FTR_SECTION(0, 1);						\
 	bl	.__trace_hcall_exit;				\
 	addi	r1,r1,STACK_FRAME_OVERHEAD;			\
 	ld	r0,16(r1);					\
-	ld	r3,STK_PARM(R3)(r1);				\
+	ld	r3,STK_PARAM(R3)(r1);				\
 	mtlr	r0;						\
 1:
 
@@ -132,7 +130,7 @@ _GLOBAL(plpar_hcall)
 
 	HCALL_INST_PRECALL(R5)
 
-	std     r4,STK_PARM(R4)(r1)     /* Save ret buffer */
+	std     r4,STK_PARAM(R4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
 	mr	r5,r6
@@ -143,7 +141,7 @@ _GLOBAL(plpar_hcall)
 
 	HVSC				/* invoke the hypervisor */
 
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -168,7 +166,7 @@ _GLOBAL(plpar_hcall_raw)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	std     r4,STK_PARM(R4)(r1)     /* Save ret buffer */
+	std     r4,STK_PARAM(R4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
 	mr	r5,r6
@@ -179,7 +177,7 @@ _GLOBAL(plpar_hcall_raw)
 
 	HVSC				/* invoke the hypervisor */
 
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -198,7 +196,7 @@ _GLOBAL(plpar_hcall9)
 
 	HCALL_INST_PRECALL(R5)
 
-	std     r4,STK_PARM(R4)(r1)     /* Save ret buffer */
+	std     r4,STK_PARAM(R4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
 	mr	r5,r6
@@ -206,14 +204,14 @@ _GLOBAL(plpar_hcall9)
 	mr	r7,r8
 	mr	r8,r9
 	mr	r9,r10
-	ld	r10,STK_PARM(R11)(r1)	 /* put arg7 in R10 */
-	ld	r11,STK_PARM(R12)(r1)	 /* put arg8 in R11 */
-	ld	r12,STK_PARM(R13)(r1)    /* put arg9 in R12 */
+	ld	r10,STK_PARAM(R11)(r1)	 /* put arg7 in R10 */
+	ld	r11,STK_PARAM(R12)(r1)	 /* put arg8 in R11 */
+	ld	r12,STK_PARAM(R13)(r1)    /* put arg9 in R12 */
 
 	HVSC				/* invoke the hypervisor */
 
 	mr	r0,r12
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
@@ -238,7 +236,7 @@ _GLOBAL(plpar_hcall9_raw)
 	mfcr	r0
 	stw	r0,8(r1)
 
-	std     r4,STK_PARM(R4)(r1)     /* Save ret buffer */
+	std     r4,STK_PARAM(R4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
 	mr	r5,r6
@@ -246,14 +244,14 @@ _GLOBAL(plpar_hcall9_raw)
 	mr	r7,r8
 	mr	r8,r9
 	mr	r9,r10
-	ld	r10,STK_PARM(R11)(r1)	 /* put arg7 in R10 */
-	ld	r11,STK_PARM(R12)(r1)	 /* put arg8 in R11 */
-	ld	r12,STK_PARM(R13)(r1)    /* put arg9 in R12 */
+	ld	r10,STK_PARAM(R11)(r1)	 /* put arg7 in R10 */
+	ld	r11,STK_PARAM(R12)(r1)	 /* put arg8 in R11 */
+	ld	r12,STK_PARAM(R13)(r1)    /* put arg9 in R12 */
 
 	HVSC				/* invoke the hypervisor */
 
 	mr	r0,r12
-	ld	r12,STK_PARM(R4)(r1)
+	ld	r12,STK_PARAM(R4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
 	std	r6, 16(r12)
