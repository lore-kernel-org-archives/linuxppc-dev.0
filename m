Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpf2c1xPJzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 18:54:16 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id o126so30494561pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 00:54:16 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v2] powerpc/powernv: de-deuplicate OPAL call wrappers
Date: Thu, 23 Mar 2017 18:54:01 +1100
Message-Id: <20170323075401.4371-1-oohall@gmail.com>
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
v1 -> v2:
	slight rework due to the real mode opal call changes
---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 53 +++++++++++---------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index da8a0f7a035c..ebf6719d241a 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -50,21 +50,13 @@ END_FTR_SECTION(0, 1);						\
 #define OPAL_BRANCH(LABEL)
 #endif
 
-/* TODO:
- *
- * - Trace irqs in/off (needs saving/restoring all args, argh...)
- * - Get r11 feed up by Dave so I can have better register usage
+/*
+ * DO_OPAL_CALL assumes:
+ * r0  = opal call token
+ * r12 = msr
+ * LR has been saved
  */
-
-#define OPAL_CALL(name, token)		\
- _GLOBAL_TOC(name);			\
-	mfmsr	r12;			\
-	mflr	r0;			\
-	andi.	r11,r12,MSR_IR|MSR_DR; 	\
-	std	r0,PPC_LR_STKOFF(r1);	\
-	li	r0,token;		\
-	beq	opal_real_call;         \
-	OPAL_BRANCH(opal_tracepoint_entry) \
+#define DO_OPAL_CALL()			\
 	mfcr	r11;			\
 	stw	r11,8(r1);		\
 	li	r11,0;			\
@@ -83,6 +75,18 @@ END_FTR_SECTION(0, 1);						\
 	mtspr	SPRN_HSRR0,r12;		\
 	hrfid
 
+#define OPAL_CALL(name, token)		\
+ _GLOBAL_TOC(name);			\
+	mfmsr	r12;			\
+	mflr	r0;			\
+	andi.	r11,r12,MSR_IR|MSR_DR; 	\
+	std	r0,PPC_LR_STKOFF(r1);	\
+	li	r0,token;		\
+	beq	opal_real_call;         \
+	OPAL_BRANCH(opal_tracepoint_entry) \
+	DO_OPAL_CALL()
+
+
 opal_return:
 	/*
 	 * Fixup endian on OPAL return... we should be able to simplify
@@ -148,26 +152,13 @@ opal_tracepoint_entry:
 	ld	r8,STK_REG(R29)(r1)
 	ld	r9,STK_REG(R30)(r1)
 	ld	r10,STK_REG(R31)(r1)
+
+	/* setup LR so we return via tracepoint_return */
 	LOAD_REG_ADDR(r11,opal_tracepoint_return)
-	mfcr	r12
 	std	r11,16(r1)
-	stw	r12,8(r1)
-	li	r11,0
+
 	mfmsr	r12
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
+	DO_OPAL_CALL()
 
 opal_tracepoint_return:
 	std	r3,STK_REG(R31)(r1)
-- 
2.9.3
