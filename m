Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPlH07RqzDsC1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:48:27 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id a20-v6so10076293pfo.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:48:26 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 26/29] KVM: PPC: move vcpu_load/vcpu_put down to each ioctl
 case in kvm_arch_vcpu_ioctl
Date: Wed, 23 May 2018 15:02:09 +0800
Message-Id: <1527058932-7434-27-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
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
index 1fa5bbe..c9098ff 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1783,16 +1783,16 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
 
@@ -1801,12 +1801,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
 
@@ -1814,9 +1816,11 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
@@ -1825,7 +1829,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 
 out:
-	vcpu_put(vcpu);
 	return r;
 }
 
-- 
1.8.3.1
