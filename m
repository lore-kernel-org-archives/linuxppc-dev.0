Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRN801WbzDrvS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:43 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id c11-v6so8417240plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:43 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 26/30] KVM: PPC: move vcpu_load/vcpu_put down to each ioctl
 case in kvm_arch_vcpu_ioctl
Date: Wed, 28 Feb 2018 01:52:34 +0800
Message-Id: <1519753958-11756-16-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Although we already have kvm_arch_vcpu_async_ioctl() which doesn't require
ioctl to load vcpu, the sync ioctl code need to be cleaned up when
CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL is not configured.

This patch moves vcpu_load/vcpu_put down to each ioctl switch case so that
each ioctl can decide to do vcpu_load/vcpu_put or not independently.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2d10314..cf3effd 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1629,16 +1629,16 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	void __user *argp = (void __user *)arg;
 	long r;
 
-	vcpu_load(vcpu);
-
 	switch (ioctl) {
 	case KVM_ENABLE_CAP:
 	{
 		struct kvm_enable_cap cap;
 		r = -EFAULT;
+		vcpu_load(vcpu);
 		if (copy_from_user(&cap, argp, sizeof(cap)))
 			goto out;
 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
+		vcpu_put(vcpu);
 		break;
 	}
 
@@ -1647,12 +1647,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	{
 		struct kvm_one_reg reg;
 		r = -EFAULT;
+		vcpu_load(vcpu);
 		if (copy_from_user(&reg, argp, sizeof(reg)))
 			goto out;
 		if (ioctl == KVM_SET_ONE_REG)
 			r = kvm_vcpu_ioctl_set_one_reg(vcpu, &reg);
 		else
 			r = kvm_vcpu_ioctl_get_one_reg(vcpu, &reg);
+		vcpu_put(vcpu);
 		break;
 	}
 
@@ -1660,9 +1662,11 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_DIRTY_TLB: {
 		struct kvm_dirty_tlb dirty;
 		r = -EFAULT;
+		vcpu_load(vcpu);
 		if (copy_from_user(&dirty, argp, sizeof(dirty)))
 			goto out;
 		r = kvm_vcpu_ioctl_dirty_tlb(vcpu, &dirty);
+		vcpu_put(vcpu);
 		break;
 	}
 #endif
@@ -1671,7 +1675,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 
 out:
-	vcpu_put(vcpu);
 	return r;
 }
 
-- 
1.8.3.1
