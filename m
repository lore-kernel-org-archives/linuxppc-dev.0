Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPlK4SZWzDrbj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:48:29 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id ay10-v6so12520474plb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:48:29 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 27/29] KVM: PPC: remove load/put vcpu for
 KVM_GET/SET_ONE_REG ioctl
Date: Wed, 23 May 2018 15:02:10 +0800
Message-Id: <1527058932-7434-28-git-send-email-wei.guo.simon@gmail.com>
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

Due to the vcpu mutex locking/unlock has been moved out of vcpu_load()
/vcpu_put(), KVM_GET_ONE_REG and KVM_SET_ONE_REG doesn't need to do
ioctl with loading vcpu anymore. This patch removes vcpu_load()/vcpu_put()
from KVM_GET_ONE_REG and KVM_SET_ONE_REG ioctl.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index c9098ff..5def68d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1801,14 +1801,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	{
 		struct kvm_one_reg reg;
 		r = -EFAULT;
-		vcpu_load(vcpu);
 		if (copy_from_user(&reg, argp, sizeof(reg)))
 			goto out;
 		if (ioctl == KVM_SET_ONE_REG)
 			r = kvm_vcpu_ioctl_set_one_reg(vcpu, &reg);
 		else
 			r = kvm_vcpu_ioctl_get_one_reg(vcpu, &reg);
-		vcpu_put(vcpu);
 		break;
 	}
 
-- 
1.8.3.1
