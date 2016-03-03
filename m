Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45D951A035C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 12:59:55 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC 15/18] powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl() to
 change HPT size
Date: Thu,  3 Mar 2016 12:59:46 +1100
Message-Id: <1456970389-28802-16-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
References: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
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

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 52 ++++++++++++++++++++-----------------
 arch/powerpc/kvm/book3s_hv.c        |  5 +---
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index f77d0a0..bc7a104 100644
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
index eb1aa3a..4547b6e 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -103,10 +103,22 @@ void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info)
 		info->virt, (long)info->order, kvm->arch.lpid);
 }
 
-long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
+void kvmppc_free_hpt(struct kvm_hpt_info *info)
+{
+	vfree(info->rev);
+	if (info->cma)
+		kvm_free_hpt_cma(virt_to_page(info->virt),
+				 1 << (info->order - PAGE_SHIFT));
+	else
+		free_pages(info->virt, info->order - PAGE_SHIFT);
+	info->virt = 0;
+	info->order = 0;
+}
+
+long kvmppc_alloc_reset_hpt(struct kvm *kvm, int order)
 {
 	long err = -EBUSY;
-	long order;
+	struct kvm_hpt_info info;
 
 	mutex_lock(&kvm->lock);
 	if (kvm->arch.hpte_setup_done) {
@@ -118,8 +130,9 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
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
@@ -128,33 +141,24 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
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
+
+	if (kvm->arch.hpt.virt)
+		kvmppc_free_hpt(&kvm->arch.hpt);
+
+	
+	err = kvmppc_allocate_hpt(&info, order);
+	if (err < 0)
+		goto out;
+	kvmppc_set_hpt(kvm, &info);
+	
  out:
 	mutex_unlock(&kvm->lock);
 	return err;
 }
 
-void kvmppc_free_hpt(struct kvm_hpt_info *info)
-{
-	vfree(info->rev);
-	if (info->cma)
-		kvm_free_hpt_cma(virt_to_page(info->virt),
-				 1 << (info->order - PAGE_SHIFT));
-	else
-		free_pages(info->virt, info->order - PAGE_SHIFT);
-	info->virt = 0;
-	info->order = 0;
-}
-
 /* Bits in first HPTE dword for pagesize 4k, 64k or 16M */
 static inline unsigned long hpte0_pgsize_encoding(unsigned long pgsize)
 {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1199fb5..a2730ca 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3113,12 +3113,9 @@ static long kvm_arch_vm_ioctl_hv(struct file *filp,
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
2.5.0
