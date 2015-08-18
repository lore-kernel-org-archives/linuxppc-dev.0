Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 272FF1A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 17:56:28 +1000 (AEST)
Received: by ykll84 with SMTP id l84so87131907ykl.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 00:56:25 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/e6500: hw tablewalk: make sure we invalidate and
 write to the same tlb entry
Date: Tue, 18 Aug 2015 15:55:56 +0800
Message-Id: <1439884556-11291-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <20150817111914.GB26870@pek-khao-d1.corp.ad.wrs.com>
References: <20150817111914.GB26870@pek-khao-d1.corp.ad.wrs.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to workaround Erratum A-008139, we have to invalidate the
tlb entry with tlbilx before overwriting. Due to the performance
consideration, we don't add any memory barrier when acquire/release
the tcd lock. This means the two load instructions for esel_next do
have the possibility to return different value. This is definitely
not acceptable due to the Erratum A-008139. We have two options to
fix this issue:
  a) Add memory barrier when acquire/release tcd lock to order the
     load/store to esel_next.
  b) Just make sure to invalidate and write to the same tlb entry and
     tolerate the race that we may get the wrong value and overwrite
     the tlb entry just updated by the other thread.

We observe better performance using option b. So reserve an additional
register to save the value of the esel_next.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Use an additional register for saving the value of esel_next instead of lwsync.

 arch/powerpc/include/asm/exception-64e.h | 11 ++++++-----
 arch/powerpc/mm/tlb_low_64e.S            | 26 ++++++++++++++++++--------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index a8b52b61043f..d53575becbed 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -69,13 +69,14 @@
 #define EX_TLB_ESR	( 9 * 8) /* Level 0 and 2 only */
 #define EX_TLB_SRR0	(10 * 8)
 #define EX_TLB_SRR1	(11 * 8)
+#define EX_TLB_R7	(12 * 8)
 #ifdef CONFIG_BOOK3E_MMU_TLB_STATS
-#define EX_TLB_R8	(12 * 8)
-#define EX_TLB_R9	(13 * 8)
-#define EX_TLB_LR	(14 * 8)
-#define EX_TLB_SIZE	(15 * 8)
+#define EX_TLB_R8	(13 * 8)
+#define EX_TLB_R9	(14 * 8)
+#define EX_TLB_LR	(15 * 8)
+#define EX_TLB_SIZE	(16 * 8)
 #else
-#define EX_TLB_SIZE	(12 * 8)
+#define EX_TLB_SIZE	(13 * 8)
 #endif
 
 #define	START_EXCEPTION(label)						\
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index e4185581c5a7..3a5b89dfb5a1 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -68,11 +68,21 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	ld	r14,PACAPGD(r13)
 	std	r15,EX_TLB_R15(r12)
 	std	r10,EX_TLB_CR(r12)
+#ifdef CONFIG_PPC_FSL_BOOK3E
+BEGIN_FTR_SECTION
+	std	r7,EX_TLB_R7(r12)
+END_FTR_SECTION_IFSET(CPU_FTR_SMT)
+#endif
 	TLB_MISS_PROLOG_STATS
 .endm
 
 .macro tlb_epilog_bolted
 	ld	r14,EX_TLB_CR(r12)
+#ifdef CONFIG_PPC_FSL_BOOK3E
+BEGIN_FTR_SECTION
+	ld	r7,EX_TLB_R7(r12)
+END_FTR_SECTION_IFSET(CPU_FTR_SMT)
+#endif
 	ld	r10,EX_TLB_R10(r12)
 	ld	r11,EX_TLB_R11(r12)
 	ld	r13,EX_TLB_R13(r12)
@@ -297,6 +307,7 @@ itlb_miss_fault_bolted:
  * r13 = PACA
  * r11 = tlb_per_core ptr
  * r10 = crap (free to use)
+ * r7  = esel_next
  */
 tlb_miss_common_e6500:
 	crmove	cr2*4+2,cr0*4+2		/* cr2.eq != 0 if kernel address */
@@ -334,8 +345,8 @@ BEGIN_FTR_SECTION		/* CPU_FTR_SMT */
 	 * with tlbilx before overwriting.
 	 */
 
-	lbz	r15,TCD_ESEL_NEXT(r11)
-	rlwinm	r10,r15,16,0xff0000
+	lbz	r7,TCD_ESEL_NEXT(r11)
+	rlwinm	r10,r7,16,0xff0000
 	oris	r10,r10,MAS0_TLBSEL(1)@h
 	mtspr	SPRN_MAS0,r10
 	isync
@@ -429,15 +440,14 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_SMT)
 	mtspr	SPRN_MAS2,r15
 
 tlb_miss_huge_done_e6500:
-	lbz	r15,TCD_ESEL_NEXT(r11)
 	lbz	r16,TCD_ESEL_MAX(r11)
 	lbz	r14,TCD_ESEL_FIRST(r11)
-	rlwimi	r10,r15,16,0x00ff0000	/* insert esel_next into MAS0 */
-	addi	r15,r15,1		/* increment esel_next */
+	rlwimi	r10,r7,16,0x00ff0000	/* insert esel_next into MAS0 */
+	addi	r7,r7,1			/* increment esel_next */
 	mtspr	SPRN_MAS0,r10
-	cmpw	r15,r16
-	iseleq	r15,r14,r15		/* if next == last use first */
-	stb	r15,TCD_ESEL_NEXT(r11)
+	cmpw	r7,r16
+	iseleq	r7,r14,r7		/* if next == last use first */
+	stb	r7,TCD_ESEL_NEXT(r11)
 
 	tlbwe
 
-- 
2.1.0
