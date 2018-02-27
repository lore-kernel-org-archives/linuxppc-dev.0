Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRN96KHYzDr0b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:45 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id ay8so11817984plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:45 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 27/30] KVM: PPC: remove load/put vcpu for
 KVM_GET/SET_ONE_REG ioctl
Date: Wed, 28 Feb 2018 01:52:35 +0800
Message-Id: <1519753958-11756-17-git-send-email-wei.guo.simon@gmail.com>
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

Due to the vcpu mutex locking/unlock has been moved out of vcpu_load()
/vcpu_put(), KVM_GET_ONE_REG and KVM_SET_ONE_REG doesn't need to do
ioctl with loading vcpu anymore. This patch removes vcpu_load()/vcpu_put()
from KVM_GET_ONE_REG and KVM_SET_ONE_REG ioctl.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cf3effd..7987fa3 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1647,14 +1647,12 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
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
