Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B401B7331
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:32:00 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 06/10] KVM: PPC: Add support for explicit HIOR setting
Date: Tue,  9 Aug 2011 18:31:44 +0200
Message-Id: <1312907508-14599-7-git-send-email-agraf@suse.de>
In-Reply-To: <1312907508-14599-1-git-send-email-agraf@suse.de>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Until now, we always set HIOR based on the PVR, but this is just wrong.
Instead, we should be setting HIOR explicitly, so user space can decide
what the initial HIOR value is - just like on real hardware.

We keep the old PVR based way around for backwards compatibility, but
once user space uses the SREGS based method, we drop the PVR logic.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm.h        |    8 ++++++++
 arch/powerpc/include/asm/kvm_book3s.h |    2 ++
 arch/powerpc/kvm/book3s_pr.c          |   14 ++++++++++++--
 arch/powerpc/kvm/powerpc.c            |    1 +
 include/linux/kvm.h                   |    1 +
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index a4f6c85..a6a253e 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -149,6 +149,12 @@ struct kvm_regs {
 #define KVM_SREGS_E_UPDATE_DBSR		(1 << 3)
 
 /*
+ * Book3S special bits to indicate contents in the struct by maintaining
+ * backwards compatibility with older structs. If adding a new field,
+ * please make sure to add a flag for that new field */
+#define KVM_SREGS_S_HIOR		(1 << 0)
+
+/*
  * In KVM_SET_SREGS, reserved/pad fields must be left untouched from a
  * previous KVM_GET_REGS.
  *
@@ -173,6 +179,8 @@ struct kvm_sregs {
 				__u64 ibat[8]; 
 				__u64 dbat[8]; 
 			} ppc32;
+			__u64 flags; /* KVM_SREGS_S_ */
+			__u64 hior;
 		} s;
 		struct {
 			union {
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 37dd748..472437b 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -90,6 +90,8 @@ struct kvmppc_vcpu_book3s {
 #endif
 	int context_id[SID_CONTEXTS];
 
+	bool hior_sregs;		/* HIOR is set by SREGS, not PVR */
+
 	struct hlist_head hpte_hash_pte[HPTEG_HASH_NUM_PTE];
 	struct hlist_head hpte_hash_pte_long[HPTEG_HASH_NUM_PTE_LONG];
 	struct hlist_head hpte_hash_vpte[HPTEG_HASH_NUM_VPTE];
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 0c0d3f2..78dcf65 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -150,13 +150,15 @@ void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
 #ifdef CONFIG_PPC_BOOK3S_64
 	if ((pvr >= 0x330000) && (pvr < 0x70330000)) {
 		kvmppc_mmu_book3s_64_init(vcpu);
-		to_book3s(vcpu)->hior = 0xfff00000;
+		if (!to_book3s(vcpu)->hior_sregs)
+			to_book3s(vcpu)->hior = 0xfff00000;
 		to_book3s(vcpu)->msr_mask = 0xffffffffffffffffULL;
 	} else
 #endif
 	{
 		kvmppc_mmu_book3s_32_init(vcpu);
-		to_book3s(vcpu)->hior = 0;
+		if (!to_book3s(vcpu)->hior_sregs)
+			to_book3s(vcpu)->hior = 0;
 		to_book3s(vcpu)->msr_mask = 0xffffffffULL;
 	}
 
@@ -770,6 +772,9 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 		}
 	}
 
+	if (sregs->u.s.flags & KVM_SREGS_S_HIOR)
+		sregs->u.s.hior = to_book3s(vcpu)->hior;
+
 	return 0;
 }
 
@@ -806,6 +811,11 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	/* Flush the MMU after messing with the segments */
 	kvmppc_mmu_pte_flush(vcpu, 0, 0);
 
+	if (sregs->u.s.flags & KVM_SREGS_S_HIOR) {
+		to_book3s(vcpu)->hior_sregs = true;
+		to_book3s(vcpu)->hior = sregs->u.s.hior;
+	}
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index a107c9b..17a5c83 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -188,6 +188,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_PPC_BOOKE_SREGS:
 #else
 	case KVM_CAP_PPC_SEGSTATE:
+	case KVM_CAP_PPC_HIOR:
 #endif
 	case KVM_CAP_PPC_UNSET_IRQ:
 	case KVM_CAP_PPC_IRQ_LEVEL:
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 55f5afb..4d33f78 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -554,6 +554,7 @@ struct kvm_ppc_pvinfo {
 #define KVM_CAP_PPC_SMT 64
 #define KVM_CAP_PPC_RMA	65
 #define KVM_CAP_MAX_VCPUS 66       /* returns max vcpus per vm */
+#define KVM_CAP_PPC_HIOR 67
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.6.0.2
