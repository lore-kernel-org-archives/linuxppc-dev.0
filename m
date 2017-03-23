Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpYQZ3zPBzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 15:26:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 3/5] KVM: PPC: Add MMIO emulation for stdx (store doubleword
 indexed)
Date: Thu, 23 Mar 2017 15:26:01 +1100
Message-Id: <1490243163-19566-4-git-send-email-paulus@ozlabs.org>
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

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds missing stdx emulation for emulated MMIO accesses by KVM
guests.  This allows the Mellanox mlx5_core driver from recent kernels
to work when MMIO emulation is enforced by userspace.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/ppc-opcode.h | 1 +
 arch/powerpc/kvm/emulate_loadstore.c  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 1e37c3c..94e7df2 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -94,6 +94,7 @@
 #define OP_31_XOP_TRAP_64   68
 #define OP_31_XOP_DCBF      86
 #define OP_31_XOP_LBZX      87
+#define OP_31_XOP_STDX      149
 #define OP_31_XOP_STWX      151
 #define OP_31_XOP_STBX      215
 #define OP_31_XOP_LBZUX     119
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 9cda1b9..a0f27a3 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -119,6 +119,12 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
 
+		case OP_31_XOP_STDX:
+			emulated = kvmppc_handle_store(run, vcpu,
+						       kvmppc_get_gpr(vcpu, rs),
+							8, 1);
+			break;
+
 		case OP_31_XOP_STWX:
 			emulated = kvmppc_handle_store(run, vcpu,
 						       kvmppc_get_gpr(vcpu, rs),
-- 
2.7.4
