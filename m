Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpYQZ6Fm7zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 15:26:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 4/5] KVM: PPC: Emulation for more integer loads and stores
Date: Thu, 23 Mar 2017 15:26:02 +1100
Message-Id: <1490243163-19566-5-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1490243163-19566-1-git-send-email-paulus@ozlabs.org>
References: <1490243163-19566-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds emulation for the following integer loads and stores,
thus enabling them to be used in a guest for accessing emulated
MMIO locations.

- lhaux
- lwaux
- lwzux
- ldu
- lwa
- stdux
- stwux
- stdu
- ldbrx
- stdbrx

Previously, most of these would cause an emulation failure exit to
userspace, though ldu and lwa got treated incorrectly as ld, and
stdu got treated incorrectly as std.

This also tidies up some of the formatting and updates the comment
listing instructions that still need to be implemented.

With this, all integer loads and stores that are defined in the Power
ISA v2.07 are emulated, except for those that are permitted to trap
when used on cache-inhibited or write-through mappings (and which do
in fact trap on POWER8), that is, lmw/stmw, lswi/stswi, lswx/stswx,
lq/stq, and l[bhwdq]arx/st[bhwdq]cx.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/ppc-opcode.h |   5 ++
 arch/powerpc/kvm/emulate_loadstore.c  | 135 ++++++++++++++++++++++------------
 2 files changed, 91 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 94e7df2..738bac1 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -96,6 +96,8 @@
 #define OP_31_XOP_LBZX      87
 #define OP_31_XOP_STDX      149
 #define OP_31_XOP_STWX      151
+#define OP_31_XOP_STDUX     181
+#define OP_31_XOP_STWUX     183
 #define OP_31_XOP_STBX      215
 #define OP_31_XOP_LBZUX     119
 #define OP_31_XOP_STBUX     247
@@ -104,13 +106,16 @@
 #define OP_31_XOP_MFSPR     339
 #define OP_31_XOP_LWAX      341
 #define OP_31_XOP_LHAX      343
+#define OP_31_XOP_LWAUX     373
 #define OP_31_XOP_LHAUX     375
 #define OP_31_XOP_STHX      407
 #define OP_31_XOP_STHUX     439
 #define OP_31_XOP_MTSPR     467
 #define OP_31_XOP_DCBI      470
+#define OP_31_XOP_LDBRX     532
 #define OP_31_XOP_LWBRX     534
 #define OP_31_XOP_TLBSYNC   566
+#define OP_31_XOP_STDBRX    660
 #define OP_31_XOP_STWBRX    662
 #define OP_31_XOP_STFSX	    663
 #define OP_31_XOP_STFSUX    695
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index a0f27a3..f10ba0c 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -58,18 +58,14 @@ static bool kvmppc_check_vsx_disabled(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_VSX */
 
-/* XXX to do:
- * lhax
- * lhaux
- * lswx
- * lswi
- * stswx
- * stswi
- * lha
- * lhau
- * lmw
- * stmw
+/*
+ * XXX to do:
+ * lfiwax, lfiwzx
+ * vector loads and stores
  *
+ * Instructions that trap when used on cache-inhibited mappings
+ * are not emulated here: multiple and string instructions,
+ * lq/stq, and the load-reserve/store-conditional instructions.
  */
 int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 {
@@ -110,6 +106,11 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
 			break;
 
+		case OP_31_XOP_LWZUX:
+			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+
 		case OP_31_XOP_LBZX:
 			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
 			break;
@@ -121,26 +122,34 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 		case OP_31_XOP_STDX:
 			emulated = kvmppc_handle_store(run, vcpu,
-						       kvmppc_get_gpr(vcpu, rs),
-							8, 1);
+					kvmppc_get_gpr(vcpu, rs), 8, 1);
+			break;
+
+		case OP_31_XOP_STDUX:
+			emulated = kvmppc_handle_store(run, vcpu,
+					kvmppc_get_gpr(vcpu, rs), 8, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
 
 		case OP_31_XOP_STWX:
 			emulated = kvmppc_handle_store(run, vcpu,
-						       kvmppc_get_gpr(vcpu, rs),
-			                               4, 1);
+					kvmppc_get_gpr(vcpu, rs), 4, 1);
+			break;
+
+		case OP_31_XOP_STWUX:
+			emulated = kvmppc_handle_store(run, vcpu,
+					kvmppc_get_gpr(vcpu, rs), 4, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
 
 		case OP_31_XOP_STBX:
 			emulated = kvmppc_handle_store(run, vcpu,
-						       kvmppc_get_gpr(vcpu, rs),
-			                               1, 1);
+					kvmppc_get_gpr(vcpu, rs), 1, 1);
 			break;
 
 		case OP_31_XOP_STBUX:
 			emulated = kvmppc_handle_store(run, vcpu,
-						       kvmppc_get_gpr(vcpu, rs),
-			                               1, 1);
+					kvmppc_get_gpr(vcpu, rs), 1, 1);
 			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
 
@@ -148,6 +157,11 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
 			break;
 
+		case OP_31_XOP_LHAUX:
+			emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+
 		case OP_31_XOP_LHZX:
 			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
 			break;
@@ -159,14 +173,12 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 		case OP_31_XOP_STHX:
 			emulated = kvmppc_handle_store(run, vcpu,
-						       kvmppc_get_gpr(vcpu, rs),
-			                               2, 1);
+					kvmppc_get_gpr(vcpu, rs), 2, 1);
 			break;
 
 		case OP_31_XOP_STHUX:
 			emulated = kvmppc_handle_store(run, vcpu,
-						       kvmppc_get_gpr(vcpu, rs),
-			                               2, 1);
+					kvmppc_get_gpr(vcpu, rs), 2, 1);
 			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
 
@@ -186,8 +198,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 		case OP_31_XOP_STWBRX:
 			emulated = kvmppc_handle_store(run, vcpu,
-						       kvmppc_get_gpr(vcpu, rs),
-			                               4, 0);
+					kvmppc_get_gpr(vcpu, rs), 4, 0);
 			break;
 
 		case OP_31_XOP_LHBRX:
@@ -196,8 +207,16 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 		case OP_31_XOP_STHBRX:
 			emulated = kvmppc_handle_store(run, vcpu,
-						       kvmppc_get_gpr(vcpu, rs),
-			                               2, 0);
+					kvmppc_get_gpr(vcpu, rs), 2, 0);
+			break;
+
+		case OP_31_XOP_LDBRX:
+			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 0);
+			break;
+
+		case OP_31_XOP_STDBRX:
+			emulated = kvmppc_handle_store(run, vcpu,
+					kvmppc_get_gpr(vcpu, rs), 8, 0);
 			break;
 
 		case OP_31_XOP_LDX:
@@ -213,6 +232,11 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
 			break;
 
+		case OP_31_XOP_LWAUX:
+			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+
 #ifdef CONFIG_PPC_FPU
 		case OP_31_XOP_LFSX:
 			if (kvmppc_check_fp_disabled(vcpu))
@@ -267,16 +291,14 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			if (kvmppc_check_fp_disabled(vcpu))
 				return EMULATE_DONE;
 			emulated = kvmppc_handle_store(run, vcpu,
-				VCPU_FPR(vcpu, rs),
-		                               8, 1);
+				VCPU_FPR(vcpu, rs), 8, 1);
 			break;
 
 		case OP_31_XOP_STFDUX:
 			if (kvmppc_check_fp_disabled(vcpu))
 				return EMULATE_DONE;
 			emulated = kvmppc_handle_store(run, vcpu,
-				VCPU_FPR(vcpu, rs),
-		                               8, 1);
+				VCPU_FPR(vcpu, rs), 8, 1);
 			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
 
@@ -284,8 +306,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			if (kvmppc_check_fp_disabled(vcpu))
 				return EMULATE_DONE;
 			emulated = kvmppc_handle_store(run, vcpu,
-				VCPU_FPR(vcpu, rs),
-		                               4, 1);
+				VCPU_FPR(vcpu, rs), 4, 1);
 			break;
 #endif
 
@@ -472,10 +493,22 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		break;
 #endif
 
-	/* TBD: Add support for other 64 bit load variants like ldu etc. */
 	case OP_LD:
 		rt = get_rt(inst);
-		emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
+		switch (inst & 3) {
+		case 0:	/* ld */
+			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
+			break;
+		case 1: /* ldu */
+			emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+		case 2:	/* lwa */
+			emulated = kvmppc_handle_loads(run, vcpu, rt, 4, 1);
+			break;
+		default:
+			emulated = EMULATE_FAIL;
+		}
 		break;
 
 	case OP_LWZU:
@@ -498,31 +531,37 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		                               4, 1);
 		break;
 
-	/* TBD: Add support for other 64 bit store variants like stdu, stdux, stdx etc. */
 	case OP_STD:
 		rs = get_rs(inst);
-		emulated = kvmppc_handle_store(run, vcpu,
-					       kvmppc_get_gpr(vcpu, rs),
-		                               8, 1);
+		switch (inst & 3) {
+		case 0:	/* std */
+			emulated = kvmppc_handle_store(run, vcpu,
+				kvmppc_get_gpr(vcpu, rs), 8, 1);
+			break;
+		case 1: /* stdu */
+			emulated = kvmppc_handle_store(run, vcpu,
+				kvmppc_get_gpr(vcpu, rs), 8, 1);
+			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
+			break;
+		default:
+			emulated = EMULATE_FAIL;
+		}
 		break;
 
 	case OP_STWU:
 		emulated = kvmppc_handle_store(run, vcpu,
-					       kvmppc_get_gpr(vcpu, rs),
-		                               4, 1);
+				kvmppc_get_gpr(vcpu, rs), 4, 1);
 		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 		break;
 
 	case OP_STB:
 		emulated = kvmppc_handle_store(run, vcpu,
-					       kvmppc_get_gpr(vcpu, rs),
-		                               1, 1);
+				kvmppc_get_gpr(vcpu, rs), 1, 1);
 		break;
 
 	case OP_STBU:
 		emulated = kvmppc_handle_store(run, vcpu,
-					       kvmppc_get_gpr(vcpu, rs),
-		                               1, 1);
+				kvmppc_get_gpr(vcpu, rs), 1, 1);
 		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 		break;
 
@@ -546,14 +585,12 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 	case OP_STH:
 		emulated = kvmppc_handle_store(run, vcpu,
-					       kvmppc_get_gpr(vcpu, rs),
-		                               2, 1);
+				kvmppc_get_gpr(vcpu, rs), 2, 1);
 		break;
 
 	case OP_STHU:
 		emulated = kvmppc_handle_store(run, vcpu,
-					       kvmppc_get_gpr(vcpu, rs),
-		                               2, 1);
+				kvmppc_get_gpr(vcpu, rs), 2, 1);
 		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 		break;
 
-- 
2.7.4
