Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2277100821
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 06/26] KVM: PPC: Convert SPRG[0-4] to shared page
Date: Sat, 26 Jun 2010 01:24:54 +0200
Message-Id: <1277508314-915-7-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When in kernel mode there are 4 additional registers available that are
simple data storage. Instead of exiting to the hypervisor to read and
write those, we can just share them with the guest using the page.

This patch converts all users of the current field to the shared page.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h |    4 ----
 arch/powerpc/include/asm/kvm_para.h |    4 ++++
 arch/powerpc/kvm/book3s.c           |   16 ++++++++--------
 arch/powerpc/kvm/booke.c            |   16 ++++++++--------
 arch/powerpc/kvm/emulate.c          |   24 ++++++++++++++++--------
 5 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 6bcf62f..83c45ea 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -216,10 +216,6 @@ struct kvm_vcpu_arch {
 	ulong guest_owned_ext;
 #endif
 	u32 mmucr;
-	ulong sprg0;
-	ulong sprg1;
-	ulong sprg2;
-	ulong sprg3;
 	ulong sprg4;
 	ulong sprg5;
 	ulong sprg6;
diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index d7fc6c2..e402999 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -23,6 +23,10 @@
 #include <linux/types.h>
 
 struct kvm_vcpu_arch_shared {
+	__u64 sprg0;
+	__u64 sprg1;
+	__u64 sprg2;
+	__u64 sprg3;
 	__u64 srr0;
 	__u64 srr1;
 	__u64 dar;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b144697..5a6f055 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -1062,10 +1062,10 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->srr0 = vcpu->arch.shared->srr0;
 	regs->srr1 = vcpu->arch.shared->srr1;
 	regs->pid = vcpu->arch.pid;
-	regs->sprg0 = vcpu->arch.sprg0;
-	regs->sprg1 = vcpu->arch.sprg1;
-	regs->sprg2 = vcpu->arch.sprg2;
-	regs->sprg3 = vcpu->arch.sprg3;
+	regs->sprg0 = vcpu->arch.shared->sprg0;
+	regs->sprg1 = vcpu->arch.shared->sprg1;
+	regs->sprg2 = vcpu->arch.shared->sprg2;
+	regs->sprg3 = vcpu->arch.shared->sprg3;
 	regs->sprg5 = vcpu->arch.sprg4;
 	regs->sprg6 = vcpu->arch.sprg5;
 	regs->sprg7 = vcpu->arch.sprg6;
@@ -1088,10 +1088,10 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	kvmppc_set_msr(vcpu, regs->msr);
 	vcpu->arch.shared->srr0 = regs->srr0;
 	vcpu->arch.shared->srr1 = regs->srr1;
-	vcpu->arch.sprg0 = regs->sprg0;
-	vcpu->arch.sprg1 = regs->sprg1;
-	vcpu->arch.sprg2 = regs->sprg2;
-	vcpu->arch.sprg3 = regs->sprg3;
+	vcpu->arch.shared->sprg0 = regs->sprg0;
+	vcpu->arch.shared->sprg1 = regs->sprg1;
+	vcpu->arch.shared->sprg2 = regs->sprg2;
+	vcpu->arch.shared->sprg3 = regs->sprg3;
 	vcpu->arch.sprg5 = regs->sprg4;
 	vcpu->arch.sprg6 = regs->sprg5;
 	vcpu->arch.sprg7 = regs->sprg6;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 8b546fe..984c461 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -495,10 +495,10 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->srr0 = vcpu->arch.shared->srr0;
 	regs->srr1 = vcpu->arch.shared->srr1;
 	regs->pid = vcpu->arch.pid;
-	regs->sprg0 = vcpu->arch.sprg0;
-	regs->sprg1 = vcpu->arch.sprg1;
-	regs->sprg2 = vcpu->arch.sprg2;
-	regs->sprg3 = vcpu->arch.sprg3;
+	regs->sprg0 = vcpu->arch.shared->sprg0;
+	regs->sprg1 = vcpu->arch.shared->sprg1;
+	regs->sprg2 = vcpu->arch.shared->sprg2;
+	regs->sprg3 = vcpu->arch.shared->sprg3;
 	regs->sprg5 = vcpu->arch.sprg4;
 	regs->sprg6 = vcpu->arch.sprg5;
 	regs->sprg7 = vcpu->arch.sprg6;
@@ -521,10 +521,10 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	kvmppc_set_msr(vcpu, regs->msr);
 	vcpu->arch.shared->srr0 = regs->srr0;
 	vcpu->arch.shared->srr1 = regs->srr1;
-	vcpu->arch.sprg0 = regs->sprg0;
-	vcpu->arch.sprg1 = regs->sprg1;
-	vcpu->arch.sprg2 = regs->sprg2;
-	vcpu->arch.sprg3 = regs->sprg3;
+	vcpu->arch.shared->sprg0 = regs->sprg0;
+	vcpu->arch.shared->sprg1 = regs->sprg1;
+	vcpu->arch.shared->sprg2 = regs->sprg2;
+	vcpu->arch.shared->sprg3 = regs->sprg3;
 	vcpu->arch.sprg5 = regs->sprg4;
 	vcpu->arch.sprg6 = regs->sprg5;
 	vcpu->arch.sprg7 = regs->sprg6;
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index ad0fa4f..454869b 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -263,13 +263,17 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 				kvmppc_set_gpr(vcpu, rt, get_tb()); break;
 
 			case SPRN_SPRG0:
-				kvmppc_set_gpr(vcpu, rt, vcpu->arch.sprg0); break;
+				kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->sprg0);
+				break;
 			case SPRN_SPRG1:
-				kvmppc_set_gpr(vcpu, rt, vcpu->arch.sprg1); break;
+				kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->sprg1);
+				break;
 			case SPRN_SPRG2:
-				kvmppc_set_gpr(vcpu, rt, vcpu->arch.sprg2); break;
+				kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->sprg2);
+				break;
 			case SPRN_SPRG3:
-				kvmppc_set_gpr(vcpu, rt, vcpu->arch.sprg3); break;
+				kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->sprg3);
+				break;
 			/* Note: SPRG4-7 are user-readable, so we don't get
 			 * a trap. */
 
@@ -341,13 +345,17 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 				break;
 
 			case SPRN_SPRG0:
-				vcpu->arch.sprg0 = kvmppc_get_gpr(vcpu, rs); break;
+				vcpu->arch.shared->sprg0 = kvmppc_get_gpr(vcpu, rs);
+				break;
 			case SPRN_SPRG1:
-				vcpu->arch.sprg1 = kvmppc_get_gpr(vcpu, rs); break;
+				vcpu->arch.shared->sprg1 = kvmppc_get_gpr(vcpu, rs);
+				break;
 			case SPRN_SPRG2:
-				vcpu->arch.sprg2 = kvmppc_get_gpr(vcpu, rs); break;
+				vcpu->arch.shared->sprg2 = kvmppc_get_gpr(vcpu, rs);
+				break;
 			case SPRN_SPRG3:
-				vcpu->arch.sprg3 = kvmppc_get_gpr(vcpu, rs); break;
+				vcpu->arch.shared->sprg3 = kvmppc_get_gpr(vcpu, rs);
+				break;
 
 			default:
 				emulated = kvmppc_core_emulate_mtspr(vcpu, sprn, rs);
-- 
1.6.0.2
