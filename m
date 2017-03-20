Return-Path: <srs0=i+vg=25=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmlj3WmDzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:49:53 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vmmlj31gcz8t4P
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:49:53 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vmmlh5gwlz9s2s
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2017 17:49:52 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 08/12] powerpc/kvm: Make kvmppc_xics_create_icp static
Date: Mon, 20 Mar 2017 17:49:10 +1100
Message-Id: <20170320064914.4437-8-benh@kernel.crashing.org>
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

It's only used within the same file it's defined

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/kvm_ppc.h | 4 ----
 arch/powerpc/kvm/book3s_xics.c     | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index dd11c4c..bfef1ae 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -478,7 +478,6 @@ extern void kvmppc_free_host_rm_ops(void);
 extern void kvmppc_free_pimap(struct kvm *kvm);
 extern int kvmppc_xics_rm_complete(struct kvm_vcpu *vcpu, u32 hcall);
 extern void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu);
-extern int kvmppc_xics_create_icp(struct kvm_vcpu *vcpu, unsigned long server);
 extern int kvm_vm_ioctl_xics_irq(struct kvm *kvm, struct kvm_irq_level *args);
 extern int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd);
 extern u64 kvmppc_xics_get_icp(struct kvm_vcpu *vcpu);
@@ -507,9 +506,6 @@ static inline int kvmppc_xics_rm_complete(struct kvm_vcpu *vcpu, u32 hcall)
 static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 	{ return 0; }
 static inline void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu) { }
-static inline int kvmppc_xics_create_icp(struct kvm_vcpu *vcpu,
-					 unsigned long server)
-	{ return -EINVAL; }
 static inline int kvm_vm_ioctl_xics_irq(struct kvm *kvm,
 					struct kvm_irq_level *args)
 	{ return -ENOTTY; }
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index e48803e..ef4fd52 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1084,7 +1084,7 @@ static struct kvmppc_ics *kvmppc_xics_create_ics(struct kvm *kvm,
 	return xics->ics[icsid];
 }
 
-int kvmppc_xics_create_icp(struct kvm_vcpu *vcpu, unsigned long server_num)
+static int kvmppc_xics_create_icp(struct kvm_vcpu *vcpu, unsigned long server_num)
 {
 	struct kvmppc_icp *icp;
 
-- 
2.9.3
