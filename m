Return-Path: <srs0=i+vg=25=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmm41JNSzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:12 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vmmm40Q3Fz8wQw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:12 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vmmm31pxFz9s2s
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2017 17:50:10 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 09/12] powerpc/kvm: Remove obsolete kvm_vm_ioctl_xics_irq
 declaration
Date: Mon, 20 Mar 2017 17:49:11 +1100
Message-Id: <20170320064914.4437-9-benh@kernel.crashing.org>
In-Reply-To: <20170320064914.4437-1-benh@kernel.crashing.org>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function doesn't exist anymore

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/kvm_ppc.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index bfef1ae..0c41865 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -478,7 +478,6 @@ extern void kvmppc_free_host_rm_ops(void);
 extern void kvmppc_free_pimap(struct kvm *kvm);
 extern int kvmppc_xics_rm_complete(struct kvm_vcpu *vcpu, u32 hcall);
 extern void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu);
-extern int kvm_vm_ioctl_xics_irq(struct kvm *kvm, struct kvm_irq_level *args);
 extern int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd);
 extern u64 kvmppc_xics_get_icp(struct kvm_vcpu *vcpu);
 extern int kvmppc_xics_set_icp(struct kvm_vcpu *vcpu, u64 icpval);
@@ -506,9 +505,6 @@ static inline int kvmppc_xics_rm_complete(struct kvm_vcpu *vcpu, u32 hcall)
 static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 	{ return 0; }
 static inline void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu) { }
-static inline int kvm_vm_ioctl_xics_irq(struct kvm *kvm,
-					struct kvm_irq_level *args)
-	{ return -ENOTTY; }
 static inline int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd)
 	{ return 0; }
 #endif
-- 
2.9.3
