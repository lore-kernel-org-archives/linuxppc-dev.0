Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDCSG15MrzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 20:12:46 +1000 (AEST)
Date: Thu, 27 Apr 2017 20:12:30 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Native usage of the XIVE
 interrupt controller
Message-ID: <20170427101230.GA22113@fergus.ozlabs.ibm.com>
References: <1493172450-19636-1-git-send-email-mpe@ellerman.id.au>
 <20170426121330.GA12057@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170426121330.GA12057@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To get this to compile for all my test configs takes this additional
patch.  I test-build configs with PR KVM and not HV (both modular and
built-in) and a config with HV enabled but CONFIG_KVM_XICS=n.  Please
squash this into your topic branch.

Paul.

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index c56939ecc554..24de532c1736 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -200,7 +200,7 @@ config KVM_XICS
 config KVM_XIVE
 	bool
 	default y
-	depends on KVM_XICS && PPC_XIVE_NATIVE
+	depends on KVM_XICS && PPC_XIVE_NATIVE && KVM_BOOK3S_HV_POSSIBLE
 
 source drivers/vhost/Kconfig
 
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 5c00813e1e0e..846b40cb3a62 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -513,6 +513,7 @@ static long kvmppc_read_one_intr(bool *again)
 	return kvmppc_check_passthru(xisr, xirr, again);
 }
 
+#ifdef CONFIG_KVM_XICS
 static inline bool is_rm(void)
 {
 	return !(mfmsr() & MSR_DR);
@@ -591,3 +592,4 @@ int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 	} else
 		return xics_rm_h_eoi(vcpu, xirr);
 }
+#endif /* CONFIG_KVM_XICS */
diff --git a/arch/powerpc/kvm/book3s_xics.h b/arch/powerpc/kvm/book3s_xics.h
index 5016676847c9..453c9e518c19 100644
--- a/arch/powerpc/kvm/book3s_xics.h
+++ b/arch/powerpc/kvm/book3s_xics.h
@@ -10,6 +10,7 @@
 #ifndef _KVM_PPC_BOOK3S_XICS_H
 #define _KVM_PPC_BOOK3S_XICS_H
 
+#ifdef CONFIG_KVM_XICS
 /*
  * We use a two-level tree to store interrupt source information.
  * There are up to 1024 ICS nodes, each of which can represent
@@ -150,4 +151,5 @@ extern int xics_rm_h_ipi(struct kvm_vcpu *vcpu, unsigned long server,
 extern int xics_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
 extern int xics_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
 
+#endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index fcccfbc2c4f4..5938f7644dc1 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -9,6 +9,7 @@
 #ifndef _KVM_PPC_BOOK3S_XIVE_H
 #define _KVM_PPC_BOOK3S_XIVE_H
 
+#ifdef CONFIG_KVM_XICS
 #include "book3s_xics.h"
 
 /*
@@ -251,4 +252,5 @@ extern int (*__xive_vm_h_ipi)(struct kvm_vcpu *vcpu, unsigned long server,
 extern int (*__xive_vm_h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr);
 extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
 
+#endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 9d312c96a897..6feac0a758e1 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -267,6 +267,7 @@ static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 	}
 	return 0;
 }
+#endif /* CONFIG_SMP */
 
 u32 xive_native_alloc_irq(void)
 {
@@ -295,6 +296,7 @@ void xive_native_free_irq(u32 irq)
 }
 EXPORT_SYMBOL_GPL(xive_native_free_irq);
 
+#ifdef CONFIG_SMP
 static void xive_native_put_ipi(unsigned int cpu, struct xive_cpu *xc)
 {
 	s64 rc;
