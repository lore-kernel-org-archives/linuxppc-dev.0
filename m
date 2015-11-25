Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ED641A0331
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 10:45:33 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 13EE5140322
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 10:45:31 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 16:45:30 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A2E3A3E40044
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:45:19 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAPNjJb218939980
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:45:19 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAPNjJH4023239
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:45:19 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v2 7/9] KVM: PPC: Book3S HV: Host side kick VCPU when poked by
 real-mode KVM
Date: Wed, 25 Nov 2015 17:44:54 -0600
Message-Id: <1448495096-24759-8-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1448495096-24759-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1448495096-24759-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the support for the kick VCPU operation for
kvmppc_host_rm_ops. The kvmppc_xics_ipi_action() function
provides the function to be invoked for a host side operation
when poked by the real mode KVM. This is initiated by KVM by
sending an IPI to any free host core.

KVM real mode must set the rm_action to XICS_RM_KICK_VCPU and
rm_data to point to the VCPU to be woken up before sending the IPI.
Note that we have allocated one kvmppc_host_rm_core structure
per core. The above values need to be set in the structure
corresponding to the core to which the IPI will be sent.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h   |  1 +
 arch/powerpc/kvm/book3s_hv.c         |  2 ++
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 47cd441..1b93519 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -447,6 +447,7 @@ extern u64 kvmppc_xics_get_icp(struct kvm_vcpu *vcpu);
 extern int kvmppc_xics_set_icp(struct kvm_vcpu *vcpu, u64 icpval);
 extern int kvmppc_xics_connect_vcpu(struct kvm_device *dev,
 			struct kvm_vcpu *vcpu, u32 cpu);
+extern void kvmppc_xics_ipi_action(void);
 #else
 static inline void kvmppc_alloc_host_rm_ops(void) {};
 static inline void kvmppc_free_host_rm_ops(void) {};
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index da2cc56..d6280ed 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3085,6 +3085,8 @@ void kvmppc_alloc_host_rm_ops(void)
 		ops->rm_core[core].rm_state.in_host = 1;
 	}
 
+	ops->vcpu_kick = kvmppc_fast_vcpu_kick_hv;
+
 	/*
 	 * Make the contents of the kvmppc_host_rm_ops structure visible
 	 * to other CPUs before we assign it to the global variable.
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 24f5807..43ffbfe 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -17,6 +17,7 @@
 #include <asm/xics.h>
 #include <asm/debug.h>
 #include <asm/synch.h>
+#include <asm/cputhreads.h>
 #include <asm/ppc-opcode.h>
 
 #include "book3s_xics.h"
@@ -623,3 +624,38 @@ int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
  bail:
 	return check_too_hard(xics, icp);
 }
+
+/*  --- Non-real mode XICS-related built-in routines ---  */
+
+/**
+ * Host Operations poked by RM KVM
+ */
+static void rm_host_ipi_action(int action, void *data)
+{
+	switch (action) {
+	case XICS_RM_KICK_VCPU:
+		kvmppc_host_rm_ops_hv->vcpu_kick(data);
+		break;
+	default:
+		WARN(1, "Unexpected rm_action=%d data=%p\n", action, data);
+		break;
+	}
+
+}
+
+void kvmppc_xics_ipi_action(void)
+{
+	int core;
+	unsigned int cpu = smp_processor_id();
+	struct kvmppc_host_rm_core *rm_corep;
+
+	core = cpu >> threads_shift;
+	rm_corep = &kvmppc_host_rm_ops_hv->rm_core[core];
+
+	if (rm_corep->rm_data) {
+		rm_host_ipi_action(rm_corep->rm_state.rm_action,
+							rm_corep->rm_data);
+		rm_corep->rm_data = NULL;
+		rm_corep->rm_state.rm_action = 0;
+	}
+}
-- 
1.8.3.4
