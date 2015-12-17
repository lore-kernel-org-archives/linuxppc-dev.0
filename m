Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E21DE1A1A1C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 07:59:41 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 06BE914090A
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2015 07:59:40 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 13:59:39 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2593319D8059
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:47:42 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHKxbss27263202
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:37 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHKxb3v015700
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:37 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v3 9/9] KVM: PPC: Book3S HV: Add tunable to control H_IPI
 redirection
Date: Thu, 17 Dec 2015 14:59:11 -0600
Message-Id: <1450385951-25128-10-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Redirecting the wakeup of a VCPU from the H_IPI hypercall to
a core running in the host is usually a good idea, most workloads
seemed to benefit. However, in one heavily interrupt-driven SMT1
workload, some regression was observed. This patch adds a kvm_hv
module parameter called h_ipi_redirect to control this feature.

The default value for this tunable is 1 - that is enable the feature.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h   |  1 +
 arch/powerpc/kvm/book3s_hv.c         | 11 +++++++++++
 arch/powerpc/kvm/book3s_hv_rm_xics.c |  5 ++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 1b93519..29d1442 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -448,6 +448,7 @@ extern int kvmppc_xics_set_icp(struct kvm_vcpu *vcpu, u64 icpval);
 extern int kvmppc_xics_connect_vcpu(struct kvm_device *dev,
 			struct kvm_vcpu *vcpu, u32 cpu);
 extern void kvmppc_xics_ipi_action(void);
+extern int h_ipi_redirect;
 #else
 static inline void kvmppc_alloc_host_rm_ops(void) {};
 static inline void kvmppc_free_host_rm_ops(void) {};
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d6280ed..182ec84 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -81,6 +81,17 @@ static int target_smt_mode;
 module_param(target_smt_mode, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(target_smt_mode, "Target threads per core (0 = max)");
 
+#ifdef CONFIG_KVM_XICS
+static struct kernel_param_ops module_param_ops = {
+	.set = param_set_int,
+	.get = param_get_int,
+};
+
+module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect,
+							S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
+#endif
+
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index a8ca3ed..4c062e7 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -24,6 +24,9 @@
 
 #define DEBUG_PASSUP
 
+int h_ipi_redirect = 1;
+EXPORT_SYMBOL(h_ipi_redirect);
+
 static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 			    u32 new_irq);
 
@@ -134,7 +137,7 @@ static void icp_rm_set_vcpu_irq(struct kvm_vcpu *vcpu,
 	cpu = vcpu->arch.thread_cpu;
 	if (cpu < 0 || cpu >= nr_cpu_ids) {
 		hcore = -1;
-		if (kvmppc_host_rm_ops_hv)
+		if (kvmppc_host_rm_ops_hv && h_ipi_redirect)
 			hcore = find_available_hostcore(XICS_RM_KICK_VCPU);
 		if (hcore != -1) {
 			hcpu = hcore << threads_shift;
-- 
1.8.3.4
