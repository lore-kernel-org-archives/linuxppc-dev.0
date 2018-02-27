Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRNC6wm8zDrvS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:47 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id g12so7812984pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:47 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 28/30] KVM: PPC: remove load/put vcpu for
 KVM_GET_REGS/KVM_SET_REGS
Date: Wed, 28 Feb 2018 01:52:36 +0800
Message-Id: <1519753958-11756-18-git-send-email-wei.guo.simon@gmail.com>
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

In both HV/PR KVM, the KVM_SET_REGS/KVM_GET_REGS ioctl should
be able to perform without load vcpu. This patch adds
KVM_SET_ONE_REG/KVM_GET_ONE_REG implementation to async ioctl
function.

Due to the vcpu mutex locking/unlock has been moved out of vcpu_load()
/vcpu_put(), KVM_SET_REGS/KVM_GET_REGS don't need to do
ioctl with loading vcpu anymore. This patch removes vcpu_load()/vcpu_put()
from KVM_SET_REGS/KVM_GET_REGS ioctl.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/book3s.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 234531d..10b2a21 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -509,8 +509,6 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
-	vcpu_load(vcpu);
-
 	regs->pc = kvmppc_get_pc(vcpu);
 	regs->cr = kvmppc_get_cr(vcpu);
 	regs->ctr = kvmppc_get_ctr(vcpu);
@@ -532,7 +530,6 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
 
-	vcpu_put(vcpu);
 	return 0;
 }
 
@@ -540,8 +537,6 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
-	vcpu_load(vcpu);
-
 	kvmppc_set_pc(vcpu, regs->pc);
 	kvmppc_set_cr(vcpu, regs->cr);
 	kvmppc_set_ctr(vcpu, regs->ctr);
@@ -562,7 +557,6 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
 
-	vcpu_put(vcpu);
 	return 0;
 }
 
-- 
1.8.3.1
