Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpYQZ6vmNzDq8x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 15:26:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 5/5] KVM: PPC: Add MMIO emulation for remaining floating-point
 instructions
Date: Thu, 23 Mar 2017 15:26:03 +1100
Message-Id: <1490243163-19566-6-git-send-email-paulus@ozlabs.org>
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

For completeness, this adds emulation of the lfiwax and lfiwzx
instructions.  With this, all floating-point load and store instructions
as of Power ISA V2.07 are emulated.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/ppc-opcode.h |  2 ++
 arch/powerpc/kvm/emulate_loadstore.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 738bac1..73f06f4 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -122,6 +122,8 @@
 #define OP_31_XOP_STFDX     727
 #define OP_31_XOP_STFDUX    759
 #define OP_31_XOP_LHBRX     790
+#define OP_31_XOP_LFIWAX    855
+#define OP_31_XOP_LFIWZX    887
 #define OP_31_XOP_STHBRX    918
 #define OP_31_XOP_STFIWX    983
 
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index f10ba0c..af83353 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -270,6 +270,20 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
 
+		case OP_31_XOP_LFIWAX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			emulated = kvmppc_handle_loads(run, vcpu,
+				KVM_MMIO_REG_FPR|rt, 4, 1);
+			break;
+
+		case OP_31_XOP_LFIWZX:
+			if (kvmppc_check_fp_disabled(vcpu))
+				return EMULATE_DONE;
+			emulated = kvmppc_handle_load(run, vcpu,
+				KVM_MMIO_REG_FPR|rt, 4, 1);
+			break;
+
 		case OP_31_XOP_STFSX:
 			if (kvmppc_check_fp_disabled(vcpu))
 				return EMULATE_DONE;
-- 
2.7.4
