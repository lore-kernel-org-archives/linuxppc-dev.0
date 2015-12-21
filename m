Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA00D1A1284
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 09:34:05 +1100 (AEDT)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 025BE14099F
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2015 09:34:04 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Mon, 21 Dec 2015 15:34:03 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2E33E3E4003E
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 15:34:00 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBLMY00K21037252
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 15:34:00 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBLMXx4G008983
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2015 15:34:00 -0700
Subject: Re: [PATCH v3 9/9] KVM: PPC: Book3S HV: Add tunable to control H_IPI
 redirection
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
References: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
 <1450385951-25128-10-git-send-email-warrier@linux.vnet.ibm.com>
Cc: paulus@samba.org, agraf@suse.de, mpe@ellerman.id.au
From: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Message-ID: <56787E55.8030200@linux.vnet.ibm.com>
Date: Mon, 21 Dec 2015 16:33:57 -0600
MIME-Version: 1.0
In-Reply-To: <1450385951-25128-10-git-send-email-warrier@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
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
Resending the updated patch with the updated diff since an 
earlier patch (patch 8/9) had to be resent to fix a build
break.

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
index e673fb9..980d8a6 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -24,6 +24,9 @@
 
 #define DEBUG_PASSUP
 
+int h_ipi_redirect = 1;
+EXPORT_SYMBOL(h_ipi_redirect);
+
 static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 			    u32 new_irq);
 
@@ -148,7 +151,7 @@ static void icp_rm_set_vcpu_irq(struct kvm_vcpu *vcpu,
 	cpu = vcpu->arch.thread_cpu;
 	if (cpu < 0 || cpu >= nr_cpu_ids) {
 		hcore = -1;
-		if (kvmppc_host_rm_ops_hv)
+		if (kvmppc_host_rm_ops_hv && h_ipi_redirect)
 			hcore = find_available_hostcore(XICS_RM_KICK_VCPU);
 		if (hcore != -1) {
 			icp_send_hcore_msg(hcore, vcpu);
-- 
1.8.3.4
