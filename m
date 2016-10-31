Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6b3X6TDCzDvNG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 11:34:48 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id y68so1306591pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 17:34:48 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] powerpc/powernv: de-deuplicate OPAL call wrappers
Date: Mon, 31 Oct 2016 11:34:35 +1100
Message-Id: <1477874075-23178-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the code to perform an OPAL call is duplicated between the
normal path and path taken when tracepoints are enabled. There's no
real need for this and combining them makes opal_tracepoint_entry
considerably easier to understand.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 44 ++++++++++----------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 44d2d842cee7..3ebe0db7ffeb 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -50,18 +50,14 @@ END_FTR_SECTION(0, 1);						\
 #define OPAL_BRANCH(LABEL)
 #endif
 
-/* TODO:
+/*
+ * DO_OPAL_CALL assumes:
  *
- * - Trace irqs in/off (needs saving/restoring all args, argh...)
- * - Get r11 feed up by Dave so I can have better register usage
+ * r0 = OPAL call token
+ * LR has been saved on the stack
  */
 
-#define OPAL_CALL(name, token)		\
- _GLOBAL_TOC(name);			\
-	mflr	r0;			\
-	std	r0,PPC_LR_STKOFF(r1);	\
-	li	r0,token;		\
-	OPAL_BRANCH(opal_tracepoint_entry) \
+#define DO_OPAL_CALL() 			\
 	mfcr	r12;			\
 	stw	r12,8(r1);		\
 	li	r11,0;			\
@@ -81,6 +77,14 @@ END_FTR_SECTION(0, 1);						\
 	mtspr	SPRN_HSRR0,r12;		\
 	hrfid
 
+#define OPAL_CALL(name, token)		\
+ _GLOBAL_TOC(name);			\
+	mflr	r0;			\
+	std	r0,PPC_LR_STKOFF(r1);	\
+	li	r0,token;		\
+	OPAL_BRANCH(opal_tracepoint_entry) \
+	DO_OPAL_CALL()
+
 opal_return:
 	/*
 	 * Fixup endian on OPAL return... we should be able to simplify
@@ -122,26 +126,12 @@ opal_tracepoint_entry:
 	ld	r8,STK_REG(R29)(r1)
 	ld	r9,STK_REG(R30)(r1)
 	ld	r10,STK_REG(R31)(r1)
+
+	/* return from the opal call via tracepoint_return */
 	LOAD_REG_ADDR(r11,opal_tracepoint_return)
-	mfcr	r12
 	std	r11,16(r1)
-	stw	r12,8(r1)
-	li	r11,0
-	mfmsr	r12
-	ori	r11,r11,MSR_EE
-	std	r12,PACASAVEDMSR(r13)
-	andc	r12,r12,r11
-	mtmsrd	r12,1
-	LOAD_REG_ADDR(r11,opal_return)
-	mtlr	r11
-	li	r11,MSR_DR|MSR_IR|MSR_LE
-	andc	r12,r12,r11
-	mtspr	SPRN_HSRR1,r12
-	LOAD_REG_ADDR(r11,opal)
-	ld	r12,8(r11)
-	ld	r2,0(r11)
-	mtspr	SPRN_HSRR0,r12
-	hrfid
+
+	DO_OPAL_CALL()
 
 opal_tracepoint_return:
 	std	r3,STK_REG(R31)(r1)
-- 
2.5.5
