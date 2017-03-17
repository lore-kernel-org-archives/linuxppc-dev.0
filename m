Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vkz9B08F4zDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 19:32:13 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org
Subject: [PATCH kernel] KVM: PPC: Add MMIO emulation for stdx (store
 doubleword indexed)
Date: Fri, 17 Mar 2017 19:31:38 +1100
Message-Id: <20170317083138.36527-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds missing stdx emulation which allow Mellanox driver from
recent kernels work when MMIO emulation is enforced in the userspace.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/ppc-opcode.h | 1 +
 arch/powerpc/kvm/emulate_loadstore.c  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index e7d6d86563ee..ca1bbe49590b 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -92,6 +92,7 @@
 #define OP_31_XOP_TRAP_64   68
 #define OP_31_XOP_DCBF      86
 #define OP_31_XOP_LBZX      87
+#define OP_31_XOP_STDX      149
 #define OP_31_XOP_STWX      151
 #define OP_31_XOP_STBX      215
 #define OP_31_XOP_LBZUX     119
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 6d3c0ee1d744..9fdbeb8ea86c 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -82,6 +82,12 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
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
2.11.0
