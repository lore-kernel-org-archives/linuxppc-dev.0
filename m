Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26A531A1A0D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 07:59:37 +1100 (AEDT)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 646D3140BA4
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2015 07:59:36 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 13:59:34 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C432A3E4003F
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:32 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHKxW6R25428118
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:32 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHKxWCV015269
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:32 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v3 6/9] KVM: PPC: Book3S HV: kvmppc_host_rm_ops - handle
 offlining CPUs
Date: Thu, 17 Dec 2015 14:59:08 -0600
Message-Id: <1450385951-25128-7-git-send-email-warrier@linux.vnet.ibm.com>
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

The kvmppc_host_rm_ops structure keeps track of which cores are
are in the host by maintaining a bitmask of active/runnable
online CPUs that have not entered the guest. This patch adds
support to manage the bitmask when a CPU is offlined or onlined
in the host.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 95a2ed3..da2cc56 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3012,6 +3012,36 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 }
 
 #ifdef CONFIG_KVM_XICS
+static int kvmppc_cpu_notify(struct notifier_block *self, unsigned long action,
+			void *hcpu)
+{
+	unsigned long cpu = (long)hcpu;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+	case CPU_UP_PREPARE_FROZEN:
+		kvmppc_set_host_core(cpu);
+		break;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+	case CPU_DEAD_FROZEN:
+	case CPU_UP_CANCELED:
+	case CPU_UP_CANCELED_FROZEN:
+		kvmppc_clear_host_core(cpu);
+		break;
+#endif
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kvmppc_cpu_notifier = {
+	    .notifier_call = kvmppc_cpu_notify,
+};
+
 /*
  * Allocate a per-core structure for managing state about which cores are
  * running in the host versus the guest and for exchanging data between
@@ -3045,6 +3075,8 @@ void kvmppc_alloc_host_rm_ops(void)
 		return;
 	}
 
+	get_online_cpus();
+
 	for (cpu = 0; cpu < nr_cpu_ids; cpu += threads_per_core) {
 		if (!cpu_online(cpu))
 			continue;
@@ -3063,14 +3095,21 @@ void kvmppc_alloc_host_rm_ops(void)
 	l_ops = (unsigned long) ops;
 
 	if (cmpxchg64((unsigned long *)&kvmppc_host_rm_ops_hv, 0, l_ops)) {
+		put_online_cpus();
 		kfree(ops->rm_core);
 		kfree(ops);
+		return;
 	}
+
+	register_cpu_notifier(&kvmppc_cpu_notifier);
+
+	put_online_cpus();
 }
 
 void kvmppc_free_host_rm_ops(void)
 {
 	if (kvmppc_host_rm_ops_hv) {
+		unregister_cpu_notifier(&kvmppc_cpu_notifier);
 		kfree(kvmppc_host_rm_ops_hv->rm_core);
 		kfree(kvmppc_host_rm_ops_hv);
 		kvmppc_host_rm_ops_hv = NULL;
-- 
1.8.3.4
