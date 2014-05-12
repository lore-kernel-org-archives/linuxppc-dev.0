Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53E2C14007D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:34:34 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 12 May 2014 21:34:32 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 18CCA3578048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:34:31 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4CBYFPm8716388
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:34:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4CBYUYC010667
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 21:34:30 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH V6 2/2] KVM: PPC: BOOK3S: Remove open coded make_dsisr in
 alignment handler
Date: Mon, 12 May 2014 17:04:06 +0530
Message-Id: <1399894447-11322-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1399894447-11322-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1399894447-11322-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use make_dsisr instead of open coding it. This also have
the added benefit of handling alignment interrupt on additional
instructions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/disassemble.h | 34 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/align.c            | 34 +----------------------------
 arch/powerpc/kvm/book3s_emulate.c      | 39 +---------------------------------
 3 files changed, 36 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/include/asm/disassemble.h b/arch/powerpc/include/asm/disassemble.h
index 856f8deb557a..6330a61b875a 100644
--- a/arch/powerpc/include/asm/disassemble.h
+++ b/arch/powerpc/include/asm/disassemble.h
@@ -81,4 +81,38 @@ static inline unsigned int get_oc(u32 inst)
 {
 	return (inst >> 11) & 0x7fff;
 }
+
+#define IS_XFORM(inst)	(get_op(inst)  == 31)
+#define IS_DSFORM(inst)	(get_op(inst) >= 56)
+
+/*
+ * Create a DSISR value from the instruction
+ */
+static inline unsigned make_dsisr(unsigned instr)
+{
+	unsigned dsisr;
+
+
+	/* bits  6:15 --> 22:31 */
+	dsisr = (instr & 0x03ff0000) >> 16;
+
+	if (IS_XFORM(instr)) {
+		/* bits 29:30 --> 15:16 */
+		dsisr |= (instr & 0x00000006) << 14;
+		/* bit     25 -->    17 */
+		dsisr |= (instr & 0x00000040) << 8;
+		/* bits 21:24 --> 18:21 */
+		dsisr |= (instr & 0x00000780) << 3;
+	} else {
+		/* bit      5 -->    17 */
+		dsisr |= (instr & 0x04000000) >> 12;
+		/* bits  1: 4 --> 18:21 */
+		dsisr |= (instr & 0x78000000) >> 17;
+		/* bits 30:31 --> 12:13 */
+		if (IS_DSFORM(instr))
+			dsisr |= (instr & 0x00000003) << 18;
+	}
+
+	return dsisr;
+}
 #endif /* __ASM_PPC_DISASSEMBLE_H__ */
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 94908af308d8..34f55524d456 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -25,14 +25,13 @@
 #include <asm/cputable.h>
 #include <asm/emulated_ops.h>
 #include <asm/switch_to.h>
+#include <asm/disassemble.h>
 
 struct aligninfo {
 	unsigned char len;
 	unsigned char flags;
 };
 
-#define IS_XFORM(inst)	(((inst) >> 26) == 31)
-#define IS_DSFORM(inst)	(((inst) >> 26) >= 56)
 
 #define INVALID	{ 0, 0 }
 
@@ -192,37 +191,6 @@ static struct aligninfo aligninfo[128] = {
 };
 
 /*
- * Create a DSISR value from the instruction
- */
-static inline unsigned make_dsisr(unsigned instr)
-{
-	unsigned dsisr;
-
-
-	/* bits  6:15 --> 22:31 */
-	dsisr = (instr & 0x03ff0000) >> 16;
-
-	if (IS_XFORM(instr)) {
-		/* bits 29:30 --> 15:16 */
-		dsisr |= (instr & 0x00000006) << 14;
-		/* bit     25 -->    17 */
-		dsisr |= (instr & 0x00000040) << 8;
-		/* bits 21:24 --> 18:21 */
-		dsisr |= (instr & 0x00000780) << 3;
-	} else {
-		/* bit      5 -->    17 */
-		dsisr |= (instr & 0x04000000) >> 12;
-		/* bits  1: 4 --> 18:21 */
-		dsisr |= (instr & 0x78000000) >> 17;
-		/* bits 30:31 --> 12:13 */
-		if (IS_DSFORM(instr))
-			dsisr |= (instr & 0x00000003) << 18;
-	}
-
-	return dsisr;
-}
-
-/*
  * The dcbz (data cache block zero) instruction
  * gives an alignment fault if used on non-cacheable
  * memory.  We handle the fault mainly for the
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 5d0f71663b99..6bbdb3d1ec77 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -569,44 +569,7 @@ unprivileged:
 
 u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst)
 {
-	u32 dsisr = 0;
-
-	/*
-	 * This is what the spec says about DSISR bits (not mentioned = 0):
-	 *
-	 * 12:13		[DS]	Set to bits 30:31
-	 * 15:16		[X]	Set to bits 29:30
-	 * 17			[X]	Set to bit 25
-	 *			[D/DS]	Set to bit 5
-	 * 18:21		[X]	Set to bits 21:24
-	 *			[D/DS]	Set to bits 1:4
-	 * 22:26			Set to bits 6:10 (RT/RS/FRT/FRS)
-	 * 27:31			Set to bits 11:15 (RA)
-	 */
-
-	switch (get_op(inst)) {
-	/* D-form */
-	case OP_LFS:
-	case OP_LFD:
-	case OP_STFD:
-	case OP_STFS:
-		dsisr |= (inst >> 12) & 0x4000;	/* bit 17 */
-		dsisr |= (inst >> 17) & 0x3c00; /* bits 18:21 */
-		break;
-	/* X-form */
-	case 31:
-		dsisr |= (inst << 14) & 0x18000; /* bits 15:16 */
-		dsisr |= (inst << 8)  & 0x04000; /* bit 17 */
-		dsisr |= (inst << 3)  & 0x03c00; /* bits 18:21 */
-		break;
-	default:
-		printk(KERN_INFO "KVM: Unaligned instruction 0x%x\n", inst);
-		break;
-	}
-
-	dsisr |= (inst >> 16) & 0x03ff; /* bits 22:31 */
-
-	return dsisr;
+	return make_dsisr(inst);
 }
 
 ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
-- 
1.9.1
