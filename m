Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA3B12C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:55 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:48:55 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0688A2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97Gmgt89240880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:42 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97Gmr9C025204
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:53 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 12/14] kvm: Add struct kvm arg to memslot APIs
Date: Mon,  7 Oct 2013 22:18:00 +0530
Message-Id: <1381164482-31001-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We will use that in the later patch to find the kvm ops handler

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/arm/kvm/arm.c                 |  5 +++--
 arch/ia64/kvm/kvm-ia64.c           |  5 +++--
 arch/mips/kvm/kvm_mips.c           |  5 +++--
 arch/powerpc/include/asm/kvm_ppc.h |  6 ++++--
 arch/powerpc/kvm/book3s.c          |  4 ++--
 arch/powerpc/kvm/booke.c           |  4 ++--
 arch/powerpc/kvm/powerpc.c         |  9 +++++----
 arch/s390/kvm/kvm-s390.c           |  5 +++--
 arch/x86/kvm/x86.c                 |  5 +++--
 include/linux/kvm_host.h           |  5 +++--
 virt/kvm/kvm_main.c                | 12 ++++++------
 11 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9c697db..e96c48f 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -152,12 +152,13 @@ int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
-void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
 }
 
-int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages)
 {
 	return 0;
 }
diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
index bdfd878..985bf80 100644
--- a/arch/ia64/kvm/kvm-ia64.c
+++ b/arch/ia64/kvm/kvm-ia64.c
@@ -1550,12 +1550,13 @@ int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
-void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
 }
 
-int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages)
 {
 	return 0;
 }
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index a7b0445..73b3482 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -198,12 +198,13 @@ kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	return -ENOIOCTLCMD;
 }
 
-void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
 }
 
-int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages)
 {
 	return 0;
 }
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index c13f15d..20f4616 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -134,9 +134,11 @@ extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
 extern void kvm_release_hpt(struct page *page, unsigned long nr_pages);
 extern int kvmppc_core_init_vm(struct kvm *kvm);
 extern void kvmppc_core_destroy_vm(struct kvm *kvm);
-extern void kvmppc_core_free_memslot(struct kvm_memory_slot *free,
+extern void kvmppc_core_free_memslot(struct kvm *kvm,
+				     struct kvm_memory_slot *free,
 				     struct kvm_memory_slot *dont);
-extern int kvmppc_core_create_memslot(struct kvm_memory_slot *slot,
+extern int kvmppc_core_create_memslot(struct kvm *kvm,
+				      struct kvm_memory_slot *slot,
 				      unsigned long npages);
 extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *memslot,
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 39d2994..130fe1d 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -761,13 +761,13 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	return kvmppc_ops->get_dirty_log(kvm, log);
 }
 
-void kvmppc_core_free_memslot(struct kvm_memory_slot *free,
+void kvmppc_core_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			      struct kvm_memory_slot *dont)
 {
 	kvmppc_ops->free_memslot(free, dont);
 }
 
-int kvmppc_core_create_memslot(struct kvm_memory_slot *slot,
+int kvmppc_core_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 			       unsigned long npages)
 {
 	return kvmppc_ops->create_memslot(slot, npages);
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 1769354..cb2d986 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1662,12 +1662,12 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	return -ENOTSUPP;
 }
 
-void kvmppc_core_free_memslot(struct kvm_memory_slot *free,
+void kvmppc_core_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			      struct kvm_memory_slot *dont)
 {
 }
 
-int kvmppc_core_create_memslot(struct kvm_memory_slot *slot,
+int kvmppc_core_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 			       unsigned long npages)
 {
 	return 0;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1258c1f..db48a7f 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -417,15 +417,16 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	return -EINVAL;
 }
 
-void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
-	kvmppc_core_free_memslot(free, dont);
+	kvmppc_core_free_memslot(kvm, free, dont);
 }
 
-int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages)
 {
-	return kvmppc_core_create_memslot(slot, npages);
+	return kvmppc_core_create_memslot(kvm, slot, npages);
 }
 
 void kvm_arch_memslots_updated(struct kvm *kvm)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ac8e667..09ceea0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1053,12 +1053,13 @@ int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
-void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
 }
 
-int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages)
 {
 	return 0;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e5ca72a..73b23a2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7065,7 +7065,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kfree(rcu_dereference_check(kvm->arch.apic_map, 1));
 }
 
-void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
 	int i;
@@ -7086,7 +7086,8 @@ void kvm_arch_free_memslot(struct kvm_memory_slot *free,
 	}
 }
 
-int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages)
 {
 	int i;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ca645a0..28bfed9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -508,9 +508,10 @@ int kvm_set_memory_region(struct kvm *kvm,
 			  struct kvm_userspace_memory_region *mem);
 int __kvm_set_memory_region(struct kvm *kvm,
 			    struct kvm_userspace_memory_region *mem);
-void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont);
-int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages);
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages);
 void kvm_arch_memslots_updated(struct kvm *kvm);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *memslot,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 482b9c5..42cba68 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -541,13 +541,13 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 /*
  * Free any memory in @free but not in @dont.
  */
-static void kvm_free_physmem_slot(struct kvm_memory_slot *free,
+static void kvm_free_physmem_slot(struct kvm *kvm, struct kvm_memory_slot *free,
 				  struct kvm_memory_slot *dont)
 {
 	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
 		kvm_destroy_dirty_bitmap(free);
 
-	kvm_arch_free_memslot(free, dont);
+	kvm_arch_free_memslot(kvm, free, dont);
 
 	free->npages = 0;
 }
@@ -558,7 +558,7 @@ void kvm_free_physmem(struct kvm *kvm)
 	struct kvm_memory_slot *memslot;
 
 	kvm_for_each_memslot(memslot, slots)
-		kvm_free_physmem_slot(memslot, NULL);
+		kvm_free_physmem_slot(kvm, memslot, NULL);
 
 	kfree(kvm->memslots);
 }
@@ -822,7 +822,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	if (change == KVM_MR_CREATE) {
 		new.userspace_addr = mem->userspace_addr;
 
-		if (kvm_arch_create_memslot(&new, npages))
+		if (kvm_arch_create_memslot(kvm, &new, npages))
 			goto out_free;
 	}
 
@@ -898,7 +898,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	kvm_arch_commit_memory_region(kvm, mem, &old, change);
 
-	kvm_free_physmem_slot(&old, &new);
+	kvm_free_physmem_slot(kvm, &old, &new);
 	kfree(old_memslots);
 
 	return 0;
@@ -906,7 +906,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 out_slots:
 	kfree(slots);
 out_free:
-	kvm_free_physmem_slot(&new, &old);
+	kvm_free_physmem_slot(kvm, &new, &old);
 out:
 	return r;
 }
-- 
1.8.1.2
