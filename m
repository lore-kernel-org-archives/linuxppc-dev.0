Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRNF6HkkzF1XC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:49 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id w17so7807955pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:49 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 29/30] KVM: PPC: add KVM_SET_ONE_REG/KVM_GET_ONE_REG to
 async ioctl
Date: Wed, 28 Feb 2018 01:52:37 +0800
Message-Id: <1519753958-11756-19-git-send-email-wei.guo.simon@gmail.com>
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

In both HV/PR KVM, the KVM_SET_ONE_REG/KVM_GET_ONE_REG ioctl should
be able to perform without load vcpu. This patch adds
KVM_SET_ONE_REG/KVM_GET_ONE_REG implementation to async ioctl
function.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 7987fa3..6afd004 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1619,6 +1619,19 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
 			return -EFAULT;
 		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
 	}
+
+	if ((ioctl == KVM_SET_ONE_REG) || (ioctl == KVM_GET_ONE_REG)) {
+		struct kvm_one_reg reg;
+
+		if (copy_from_user(&reg, argp, sizeof(reg)))
+			return -EFAULT;
+
+		if (ioctl == KVM_SET_ONE_REG)
+			return kvm_vcpu_ioctl_set_one_reg(vcpu, &reg);
+		else
+			return kvm_vcpu_ioctl_get_one_reg(vcpu, &reg);
+	}
+
 	return -ENOIOCTLCMD;
 }
 
-- 
1.8.3.1
