Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjRgD0mCtzDwRZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 16:49:12 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	sjitindarsingh@gmail.com
Cc: benh@kernel.crashing.org, thuth@redhat.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCHv2 07/11] powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl() to
 change HPT size
Date: Tue, 20 Dec 2016 16:49:03 +1100
Message-Id: <20161220054907.9204-8-david@gibson.dropbear.id.au>
In-Reply-To: <20161220054907.9204-1-david@gibson.dropbear.id.au>
References: <20161220054907.9204-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The KVM_PPC_ALLOCATE_HTAB ioctl() is used to set the size of hashed page
table (HPT) that userspace expects a guest VM to have, and is also used to
clear that HPT when necessary (e.g. guest reboot).

At present, once the ioctl() is called for the first time, the HPT size can
never be changed thereafter - it will be cleared but always sized as from
the first call.

With upcoming HPT resize implementation, we're going to need to allow
userspace to resize the HPT at reset (to change it back to the default size
if the guest changed it).

So, we need to allow this ioctl() to change the HPT size.

This patch also updates Documentation/virtual/kvm/api.txt to reflect
the new behaviour.  In fact the documentation was already slightly
incorrect since 572abd5 "KVM: PPC: Book3S HV: Don't fall back to
smaller HPT size in allocation ioctl"

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 Documentation/virtual/kvm/api.txt   | 14 ++++++++------
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 29 ++++++++++++++++-------------
 arch/powerpc/kvm/book3s_hv.c        |  5 +----
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index f452c72..c12da23 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2443,18 +2443,20 @@ are, it will do nothing and return an EBUSY error.
 The parameter is a pointer to a 32-bit unsigned integer variable
 containing the order (log base 2) of the desired size of the hash
 table, which must be between 18 and 46.  On successful return from the
-ioctl, it will have been updated with the order of the hash table that
-was allocated.
+ioctl, the value will not be changed by the kernel.
 
 If no hash table has been allocated when any vcpu is asked to run
 (with the KVM_RUN ioctl), the host kernel will allocate a
 default-sized hash table (16 MB).
 
 If this ioctl is called when a hash table has already been allocated,
-the kernel will clear out the existing hash table (zero all HPTEs) and
-return the hash table order in the parameter.  (If the guest is using
-the virtualized real-mode area (VRMA) facility, the kernel will
-re-create the VMRA HPTEs on the next KVM_RUN of any vcpu.)
+with a different order from the existing hash table, the existing hash
+table will be freed and a new one allocated.  If this is ioctl is
+called when a hash table has already been allocated of the same order
+as specified, the kernel will clear out the existing hash table (zero
+all HPTEs).  In either case, if the guest is using the virtualized
+real-mode area (VRMA) facility, the kernel will re-create the VMRA
+HPTEs on the next KVM_RUN of any vcpu.
 
 4.77 KVM_S390_INTERRUPT
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 41575b8..3b837bc 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -157,7 +157,7 @@ extern void kvmppc_map_magic(struct kvm_vcpu *vcpu);
 
 extern int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order);
 extern void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info);
-extern long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp);
+extern long kvmppc_alloc_reset_hpt(struct kvm *kvm, int order);
 extern void kvmppc_free_hpt(struct kvm_hpt_info *info);
 extern long kvmppc_prepare_vrma(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 4683d87..2765d04 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -102,10 +102,10 @@ void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info)
 		info->virt, (long)info->order, kvm->arch.lpid);
 }
 
-long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
+long kvmppc_alloc_reset_hpt(struct kvm *kvm, int order)
 {
 	long err = -EBUSY;
-	long order;
+	struct kvm_hpt_info info;
 
 	mutex_lock(&kvm->lock);
 	if (kvm->arch.hpte_setup_done) {
@@ -117,8 +117,9 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
 			goto out;
 		}
 	}
-	if (kvm->arch.hpt.virt) {
-		order = kvm->arch.hpt.order;
+	if (kvm->arch.hpt.order == order) {
+		/* We already have a suitable HPT */
+
 		/* Set the entire HPT to 0, i.e. invalid HPTEs */
 		memset((void *)kvm->arch.hpt.virt, 0, 1ul << order);
 		/*
@@ -127,17 +128,19 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
 		kvmppc_rmap_reset(kvm);
 		/* Ensure that each vcpu will flush its TLB on next entry. */
 		cpumask_setall(&kvm->arch.need_tlb_flush);
-		*htab_orderp = order;
 		err = 0;
-	} else {
-		struct kvm_hpt_info info;
-
-		err = kvmppc_allocate_hpt(&info, *htab_orderp);
-		if (err < 0)
-			goto out;
-		kvmppc_set_hpt(kvm, &info);
+		goto out;
 	}
- out:
+
+	if (kvm->arch.hpt.virt)
+		kvmppc_free_hpt(&kvm->arch.hpt);
+
+	err = kvmppc_allocate_hpt(&info, order);
+	if (err < 0)
+		goto out;
+	kvmppc_set_hpt(kvm, &info);
+
+out:
 	mutex_unlock(&kvm->lock);
 	return err;
 }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 436508e..9ebb9e6 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3600,12 +3600,9 @@ static long kvm_arch_vm_ioctl_hv(struct file *filp,
 		r = -EFAULT;
 		if (get_user(htab_order, (u32 __user *)argp))
 			break;
-		r = kvmppc_alloc_reset_hpt(kvm, &htab_order);
+		r = kvmppc_alloc_reset_hpt(kvm, htab_order);
 		if (r)
 			break;
-		r = -EFAULT;
-		if (put_user(htab_order, (u32 __user *)argp))
-			break;
 		r = 0;
 		break;
 	}
-- 
2.9.3
