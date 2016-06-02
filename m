Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKvQw13YvzDqcY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 14:30:16 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id di3so2180766pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jun 2016 21:30:16 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/asm: Add STACK_INT_OFFSET macro in asm-offsets.c
Date: Thu,  2 Jun 2016 14:29:48 +1000
Message-Id: <1464841788-17465-3-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1464841788-17465-1-git-send-email-rashmicy@gmail.com>
References: <1464841788-17465-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are quite a few entries in asm-offests.c look like this:
DEFINE(REG, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, reg));

So define a local MACRO to clean this up:
STACK_INT_OFFSET(sym, val) DEFINE(sym, STACK_INT_FRAME_SIZE + \
               offsetof(struct exception_regs, val))

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/kernel/asm-offsets.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 3dbd3bd016ba..5efe5e297256 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -70,6 +70,8 @@
 
 #define STACK_OFFSET(sym, val) DEFINE(sym, STACK_FRAME_OVERHEAD + \
 		offsetof(struct pt_regs, val))
+#define STACK_INT_OFFSET(sym, val)	DEFINE(sym, \
+		STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, val))
 
 int main(void)
 {
@@ -308,21 +310,21 @@ int main(void)
 #if defined(CONFIG_PPC32)
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 	DEFINE(EXC_LVL_SIZE, STACK_EXC_LVL_FRAME_SIZE);
-	DEFINE(MAS0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas0));
+	STACK_INT_OFFSET(MAS0, mas0);
 	/* we overload MMUCR for 44x on MAS0 since they are mutually exclusive */
-	DEFINE(MMUCR, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas0));
-	DEFINE(MAS1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas1));
-	DEFINE(MAS2, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas2));
-	DEFINE(MAS3, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas3));
-	DEFINE(MAS6, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas6));
-	DEFINE(MAS7, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas7));
-	DEFINE(_SRR0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, srr0));
-	DEFINE(_SRR1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, srr1));
-	DEFINE(_CSRR0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, csrr0));
-	DEFINE(_CSRR1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, csrr1));
-	DEFINE(_DSRR0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, dsrr0));
-	DEFINE(_DSRR1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, dsrr1));
-	DEFINE(SAVED_KSP_LIMIT, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, saved_ksp_limit));
+	STACK_INT_OFFSET(MMUCR, mas0);
+	STACK_INT_OFFSET(MAS1, mas1);
+	STACK_INT_OFFSET(MAS2, mas2);
+	STACK_INT_OFFSET(MAS3, mas3);
+	STACK_INT_OFFSET(MAS6, mas6);
+	STACK_INT_OFFSET(MAS7, mas7);
+	STACK_INT_OFFSET(_SRR0, srr0);
+	STACK_INT_OFFSET(_SRR1, srr1);
+	STACK_INT_OFFSET(_CSRR0, csrr0);
+	STACK_INT_OFFSET(_CSRR1, csrr1);
+	STACK_INT_OFFSET(_DSRR0, dsrr0);
+	STACK_INT_OFFSET(_DSRR1, dsrr1);
+	STACK_INT_OFFSET(SAVED_KSP_LIMIT, saved_ksp_limit);
 #endif
 #endif
 
-- 
2.5.0
