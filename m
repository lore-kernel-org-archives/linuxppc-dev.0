Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT22r1mPjzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 14:52:20 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv3 13/17] powerpc/kvm: KVM-HV HPT resizing stub implementation
Date: Mon, 21 Mar 2016 14:53:20 +1100
Message-Id: <1458532404-21258-14-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a stub (always failing) implementation of the hypercalls
for the HPT resizing PAPR extension.

For now we include a hack which makes it safe for qemu to call ENABLE_HCALL
on these hypercalls, although it will have no effect.  That should go away
once the PAPR change is formalized and we can use "real" hcall numbers.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_book3s.h |  6 ++++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c   | 19 +++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c          |  8 ++++++++
 arch/powerpc/kvm/powerpc.c            |  6 ++++++
 4 files changed, 39 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 8f39796..81f2b77 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -191,6 +191,12 @@ extern void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 				 struct kvm_vcpu *vcpu);
 extern void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 				   struct kvmppc_book3s_shadow_vcpu *svcpu);
+extern unsigned long do_h_resize_hpt_prepare(struct kvm_vcpu *vcpu,
+					     unsigned long flags,
+					     unsigned long shift);
+extern unsigned long do_h_resize_hpt_commit(struct kvm_vcpu *vcpu,
+					    unsigned long flags,
+					    unsigned long shift);
 
 static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 89878a4..0a69b64 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1129,6 +1129,25 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
 }
 
 /*
+ * HPT resizing
+ */
+
+unsigned long do_h_resize_hpt_prepare(struct kvm_vcpu *vcpu,
+				      unsigned long flags,
+				      unsigned long shift)
+{
+	return H_HARDWARE;
+}
+
+unsigned long do_h_resize_hpt_commit(struct kvm_vcpu *vcpu,
+				     unsigned long flags,
+				     unsigned long shift)
+{
+	return H_HARDWARE;
+}
+
+
+/*
  * Functions for reading and writing the hash table via reads and
  * writes on a file descriptor.
  *
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2289ce3..878b4a7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -737,6 +737,14 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 					kvmppc_get_gpr(vcpu, 5),
 					kvmppc_get_gpr(vcpu, 6));
 		break;
+	case H_RESIZE_HPT_PREPARE:
+		ret = do_h_resize_hpt_prepare(vcpu, kvmppc_get_gpr(vcpu, 4),
+					      kvmppc_get_gpr(vcpu, 5));
+		break;
+	case H_RESIZE_HPT_COMMIT:
+		ret = do_h_resize_hpt_commit(vcpu, kvmppc_get_gpr(vcpu, 4),
+					     kvmppc_get_gpr(vcpu, 5));
+		break;
 	case H_RTAS:
 		if (list_empty(&vcpu->kvm->arch.rtas_tokens))
 			return RESUME_HOST;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 55ab059..900393b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1302,6 +1302,12 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		unsigned long hcall = cap->args[0];
 
 		r = -EINVAL;
+		/* Hack: until we have proper hcall numbers allocated */
+		if ((hcall == H_RESIZE_HPT_PREPARE)
+		    || (hcall == H_RESIZE_HPT_COMMIT)) {
+			r = 0;
+			break;
+		}
 		if (hcall > MAX_HCALL_OPCODE || (hcall & 3) ||
 		    cap->args[1] > 1)
 			break;
-- 
2.5.0
