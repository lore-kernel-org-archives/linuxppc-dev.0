Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 147E71A1A1A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 07:59:49 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 23812140BA8
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2015 07:59:47 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 13:59:46 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D49AEC40004
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:47:42 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHKxV2B25428028
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:31 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHKxUG3015150
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:31 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v3 5/9] KVM: PPC: Book3S HV: Manage core host state
Date: Thu, 17 Dec 2015 14:59:07 -0600
Message-Id: <1450385951-25128-6-git-send-email-warrier@linux.vnet.ibm.com>
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

Update the core host state in kvmppc_host_rm_ops whenever
the primary thread of the core enters the guest or returns
back.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4042623..95a2ed3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2261,6 +2261,46 @@ static void post_guest_process(struct kvmppc_vcore *vc, bool is_master)
 }
 
 /*
+ * Clear core from the list of active host cores as we are about to
+ * enter the guest. Only do this if it is the primary thread of the
+ * core (not if a subcore) that is entering the guest.
+ */
+static inline void kvmppc_clear_host_core(int cpu)
+{
+	int core;
+
+	if (!kvmppc_host_rm_ops_hv || cpu_thread_in_core(cpu))
+		return;
+	/*
+	 * Memory barrier can be omitted here as we will do a smp_wmb()
+	 * later in kvmppc_start_thread and we need ensure that state is
+	 * visible to other CPUs only after we enter guest.
+	 */
+	core = cpu >> threads_shift;
+	kvmppc_host_rm_ops_hv->rm_core[core].rm_state.in_host = 0;
+}
+
+/*
+ * Advertise this core as an active host core since we exited the guest
+ * Only need to do this if it is the primary thread of the core that is
+ * exiting.
+ */
+static inline void kvmppc_set_host_core(int cpu)
+{
+	int core;
+
+	if (!kvmppc_host_rm_ops_hv || cpu_thread_in_core(cpu))
+		return;
+
+	/*
+	 * Memory barrier can be omitted here because we do a spin_unlock
+	 * immediately after this which provides the memory barrier.
+	 */
+	core = cpu >> threads_shift;
+	kvmppc_host_rm_ops_hv->rm_core[core].rm_state.in_host = 1;
+}
+
+/*
  * Run a set of guest threads on a physical core.
  * Called with vc->lock held.
  */
@@ -2372,6 +2412,8 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 		}
 	}
 
+	kvmppc_clear_host_core(pcpu);
+
 	/* Start all the threads */
 	active = 0;
 	for (sub = 0; sub < core_info.n_subcores; ++sub) {
@@ -2468,6 +2510,8 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 			kvmppc_ipi_thread(pcpu + i);
 	}
 
+	kvmppc_set_host_core(pcpu);
+
 	spin_unlock(&vc->lock);
 
 	/* make sure updates to secondary vcpu structs are visible now */
-- 
1.8.3.4
