Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4q5n53pmzDr18
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 05:30:53 +1100 (AEDT)
Subject: [PATCH 11/11] KVM: PPC: Return directly after a failed
 copy_from_user() in two functions
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <0547e88f-34c7-da48-3bb2-57f01e596132@users.sourceforge.net>
Date: Fri, 20 Jan 2017 19:29:50 +0100
MIME-Version: 1.0
In-Reply-To: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Jan 2017 18:00:35 +0100

* Return directly after a call of the function "copy_from_user"
  (or two other checks) failed in a case block.

  This issue was detected by using the Coccinelle software.

* Delete the jump label "out" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kvm/powerpc.c | 48 ++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index efd1183a6b16..7083a680f5fb 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1256,19 +1256,19 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_INTERRUPT: {
 		struct kvm_interrupt irq;
-		r = -EFAULT;
+
 		if (copy_from_user(&irq, argp, sizeof(irq)))
-			goto out;
+			return -EFAULT;
 		r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
-		goto out;
+		break;
 	}
 
 	case KVM_ENABLE_CAP:
 	{
 		struct kvm_enable_cap cap;
-		r = -EFAULT;
+
 		if (copy_from_user(&cap, argp, sizeof(cap)))
-			goto out;
+			return -EFAULT;
 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
 		break;
 	}
@@ -1277,9 +1277,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_GET_ONE_REG:
 	{
 		struct kvm_one_reg reg;
-		r = -EFAULT;
+
 		if (copy_from_user(&reg, argp, sizeof(reg)))
-			goto out;
+			return -EFAULT;
 		if (ioctl == KVM_SET_ONE_REG)
 			r = kvm_vcpu_ioctl_set_one_reg(vcpu, &reg);
 		else
@@ -1290,9 +1290,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 #if defined(CONFIG_KVM_E500V2) || defined(CONFIG_KVM_E500MC)
 	case KVM_DIRTY_TLB: {
 		struct kvm_dirty_tlb dirty;
-		r = -EFAULT;
+
 		if (copy_from_user(&dirty, argp, sizeof(dirty)))
-			goto out;
+			return -EFAULT;
 		r = kvm_vcpu_ioctl_dirty_tlb(vcpu, &dirty);
 		break;
 	}
@@ -1300,8 +1300,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	default:
 		r = -EINVAL;
 	}
-
-out:
 	return r;
 }
 
@@ -1405,19 +1403,16 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		struct kvm_ppc_pvinfo pvinfo;
 		memset(&pvinfo, 0, sizeof(pvinfo));
 		r = kvm_vm_ioctl_get_pvinfo(&pvinfo);
-		if (copy_to_user(argp, &pvinfo, sizeof(pvinfo))) {
-			r = -EFAULT;
-			goto out;
-		}
-
+		if (copy_to_user(argp, &pvinfo, sizeof(pvinfo)))
+			return -EFAULT;
 		break;
 	}
 	case KVM_ENABLE_CAP:
 	{
 		struct kvm_enable_cap cap;
-		r = -EFAULT;
+
 		if (copy_from_user(&cap, argp, sizeof(cap)))
-			goto out;
+			return -EFAULT;
 		r = kvm_vm_ioctl_enable_cap(kvm, &cap);
 		break;
 	}
@@ -1425,23 +1420,19 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	case KVM_CREATE_SPAPR_TCE_64: {
 		struct kvm_create_spapr_tce_64 create_tce_64;
 
-		r = -EFAULT;
 		if (copy_from_user(&create_tce_64, argp, sizeof(create_tce_64)))
-			goto out;
-		if (create_tce_64.flags) {
-			r = -EINVAL;
-			goto out;
-		}
+			return -EFAULT;
+		if (create_tce_64.flags)
+			return -EINVAL;
 		r = kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce_64);
-		goto out;
+		break;
 	}
 	case KVM_CREATE_SPAPR_TCE: {
 		struct kvm_create_spapr_tce create_tce;
 		struct kvm_create_spapr_tce_64 create_tce_64;
 
-		r = -EFAULT;
 		if (copy_from_user(&create_tce, argp, sizeof(create_tce)))
-			goto out;
+			return -EFAULT;
 
 		create_tce_64.liobn = create_tce.liobn;
 		create_tce_64.page_shift = IOMMU_PAGE_SHIFT_4K;
@@ -1450,7 +1441,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 				IOMMU_PAGE_SHIFT_4K;
 		create_tce_64.flags = 0;
 		r = kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce_64);
-		goto out;
+		break;
 	}
 	case KVM_PPC_GET_SMMU_INFO: {
 		struct kvm_ppc_smmu_info info;
@@ -1477,7 +1468,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = -ENOTTY;
 #endif
 	}
-out:
 	return r;
 }
 
-- 
2.11.0
