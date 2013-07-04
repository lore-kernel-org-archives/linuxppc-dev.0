Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B4E22C0332
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:55:00 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 2/8] powerpc/fsl_booke: introduce get_phys_addr function
Date: Thu, 4 Jul 2013 20:54:08 +0800
Message-ID: <1372942454-25191-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the codes which translate a effective address to physical address
to a separate function. So it can be reused by other code.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
A new patch in v2.

 arch/powerpc/kernel/head_fsl_booke.S | 54 +++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index a04a48d..dab091e 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -65,28 +65,9 @@ _ENTRY(_start);
 	nop
 
 	/* Translate device tree address to physical, save in r30/r31 */
-	mfmsr	r16
-	mfspr	r17,SPRN_PID
-	rlwinm	r17,r17,16,0x3fff0000	/* turn PID into MAS6[SPID] */
-	rlwimi	r17,r16,28,0x00000001	/* turn MSR[DS] into MAS6[SAS] */
-	mtspr	SPRN_MAS6,r17
-
-	tlbsx	0,r3			/* must succeed */
-
-	mfspr	r16,SPRN_MAS1
-	mfspr	r20,SPRN_MAS3
-	rlwinm	r17,r16,25,0x1f		/* r17 = log2(page size) */
-	li	r18,1024
-	slw	r18,r18,r17		/* r18 = page size */
-	addi	r18,r18,-1
-	and	r19,r3,r18		/* r19 = page offset */
-	andc	r31,r20,r18		/* r31 = page base */
-	or	r31,r31,r19		/* r31 = devtree phys addr */
-BEGIN_MMU_FTR_SECTION
-	mfspr	r30,SPRN_MAS7
-MMU_FTR_SECTION_ELSE
-	li	r30,0
-ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)
+	bl	get_phys_addr
+	mr	r30,r3
+	mr	r31,r4
 
 	li	r25,0			/* phys kernel start (low) */
 	li	r24,0			/* CPU number */
@@ -860,6 +841,35 @@ KernelSPE:
 #endif /* CONFIG_SPE */
 
 /*
+ * Translate the effec addr in r3 to phys addr. The phys addr will be put
+ * into r3(higher 32bit) and r4(lower 32bit)
+ */
+get_phys_addr:
+	mfmsr	r8
+	mfspr	r9,SPRN_PID
+	rlwinm	r9,r9,16,0x3fff0000	/* turn PID into MAS6[SPID] */
+	rlwimi	r9,r8,28,0x00000001	/* turn MSR[DS] into MAS6[SAS] */
+	mtspr	SPRN_MAS6,r9
+
+	tlbsx	0,r3			/* must succeed */
+
+	mfspr	r8,SPRN_MAS1
+	mfspr	r12,SPRN_MAS3
+	rlwinm	r9,r8,25,0x1f		/* r9 = log2(page size) */
+	li	r10,1024
+	slw	r10,r10,r9		/* r10 = page size */
+	addi	r10,r10,-1
+	and	r11,r3,r10		/* r11 = page offset */
+	andc	r4,r12,r10		/* r4 = page base */
+	or	r4,r4,r11		/* r4 = devtree phys addr */
+BEGIN_MMU_FTR_SECTION
+	mfspr	r3,SPRN_MAS7
+MMU_FTR_SECTION_ELSE
+	li	r3,0
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)
+	blr
+
+/*
  * Global functions
  */
 
-- 
1.8.1.4
