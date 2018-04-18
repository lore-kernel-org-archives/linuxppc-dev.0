Return-Path: <jrdr.linux@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RBjC5WJGzDr3t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 05:18:07 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id j11so1313846pgf.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 12:18:07 -0700 (PDT)
Date: Thu, 19 Apr 2018 00:49:58 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: jhogan@kernel.org, ralf@linux-mips.org, paulus@ozlabs.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au,
 borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com,
 david@redhat.com, cohuck@redhat.com, schwidefsky@de.ibm.com,
 pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
 christoffer.dall@linaro.org, marc.zyngier@arm.com
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 willy@infradead.org
Subject: [PATCH] kvm: Change return type to vm_fault_t
Message-ID: <20180418191958.GA25806@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/mips/kvm/mips.c       | 2 +-
 arch/powerpc/kvm/powerpc.c | 2 +-
 arch/s390/kvm/kvm-s390.c   | 2 +-
 arch/x86/kvm/x86.c         | 2 +-
 include/linux/kvm_host.h   | 2 +-
 virt/kvm/arm/arm.c         | 2 +-
 virt/kvm/kvm_main.c        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 2549fdd..03e0e0f 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1076,7 +1076,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	return -ENOIOCTLCMD;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 403e642..3099dee 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1825,7 +1825,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	return r;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ba4c709..24af487 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3941,7 +3941,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	return r;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 #ifdef CONFIG_KVM_S390_UCONTROL
 	if ((vmf->pgoff == KVM_S390_SIE_PAGE_OFFSET)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c8a0b54..95d8102 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3827,7 +3827,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	return r;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ac0062b..8eeb062 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -736,7 +736,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg);
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg);
-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf);
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf);

 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext);

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 86941f6..6c8cc31 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -163,7 +163,7 @@ int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 	return 0;
 }

-int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4501e65..45eb54b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2341,7 +2341,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_on_spin);

-static int kvm_vcpu_fault(struct vm_fault *vmf)
+static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 {
 	struct kvm_vcpu *vcpu = vmf->vma->vm_file->private_data;
 	struct page *page;
--
1.9.1
