Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DA0952C00F3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 18:13:15 +1100 (EST)
Received: by mail-pa0-f52.google.com with SMTP id ld10so6187469pab.25
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 23:13:13 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 02/10] powerpc/fsl_booke: introduce get_phys_addr function
Date: Tue, 24 Dec 2013 15:12:04 +0800
Message-Id: <1387869132-12650-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
References: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
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
v4: No change.

v3: Use ifdef CONFIG_PHYS_64BIT to protect the access to MAS7

v2: A new patch in v2.

 arch/powerpc/kernel/head_fsl_booke.S | 50 +++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 09921a5197c6..196950f29c00 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -65,26 +65,9 @@ _ENTRY(_start);
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
-#ifdef CONFIG_PHYS_64BIT
-	mfspr	r30,SPRN_MAS7
-#endif
+	bl	get_phys_addr
+	mr	r30,r3
+	mr	r31,r4
 
 	li	r25,0			/* phys kernel start (low) */
 	li	r24,0			/* CPU number */
@@ -858,6 +841,33 @@ KernelSPE:
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
+#ifdef CONFIG_PHYS_64BIT
+	mfspr	r3,SPRN_MAS7
+#endif
+	blr
+
+/*
  * Global functions
  */
 
-- 
1.8.3.1
