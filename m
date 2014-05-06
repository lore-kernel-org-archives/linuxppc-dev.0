Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A80E61402B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 00:30:34 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 May 2014 20:00:32 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7D54F1258053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 19:59:26 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s46EUc5666781390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 20:00:38 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s46EUSvD007570
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 20:00:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH V5] KVM: PPC: BOOK3S: Use the saved dar value and generic
 make_dsisr
Date: Tue,  6 May 2014 20:00:22 +0530
Message-Id: <1399386622-21407-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Although it's optional IBM POWER cpus always had DAR value set on
alignment interrupt. So don't try to compute these values.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
* Changes from V4
 * Update comments around using fault_dar

 arch/powerpc/include/asm/disassemble.h | 34 +++++++++++++++++++++++++
 arch/powerpc/kernel/align.c            | 34 +------------------------
 arch/powerpc/kvm/book3s_emulate.c      | 46 ++++++----------------------------
 3 files changed, 43 insertions(+), 71 deletions(-)

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
index 99d40f8977e8..6bbdb3d1ec77 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -569,48 +569,17 @@ unprivileged:
 
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
 {
+#ifdef CONFIG_PPC_BOOK3S_64
+	/*
+	 * Linux's fix_alignment() assumes that DAR is valid, so can we
+	 */
+	return vcpu->arch.fault_dar;
+#else
 	ulong dar = 0;
 	ulong ra = get_ra(inst);
 	ulong rb = get_rb(inst);
@@ -635,4 +604,5 @@ ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
 	}
 
 	return dar;
+#endif
 }
-- 
1.9.1
