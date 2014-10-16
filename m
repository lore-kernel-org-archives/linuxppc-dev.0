Return-Path: <kernelfans@gmail.com>
Received: from mail-pd0-x232.google.com (mail-pd0-x232.google.com
 [IPv6:2607:f8b0:400e:c02::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 600B01A03A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:25:46 +1100 (AEDT)
Received: by mail-pd0-f178.google.com with SMTP id y10so2740870pdj.37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:25:44 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 02/11] powerpc: kvm: ensure vcpu-thread run only on primary
 hwthread
Date: Thu, 16 Oct 2014 15:29:51 -0400
Message-Id: <1413487800-7162-3-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When vcpu thread runs at the first time, it will ensure to stick
to the primary thread.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |  3 +++
 arch/powerpc/kvm/book3s_hv.c        | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 98d9dd5..9a3355e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -666,6 +666,9 @@ struct kvm_vcpu_arch {
 	spinlock_t tbacct_lock;
 	u64 busy_stolen;
 	u64 busy_preempt;
+#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
+	bool cpu_selected;
+#endif
 #endif
 };
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 27cced9..ba258c8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1909,6 +1909,23 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int r;
 	int srcu_idx;
+#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
+	int cpu = smp_processor_id();
+	int target_cpu;
+	unsigned int cpu;
+	struct task_struct *p = current;
+
+	if (unlikely(!vcpu->arch.cpu_selected)) {
+		vcpu->arch.cpu_selected = true;
+		for (cpu = 0; cpu < NR_CPUS; cpu+=threads_per_core) {
+			cpumask_set_cpu(cpu, &p->sys_allowed);
+		}
+		if (cpu%threads_per_core != 0) {
+			target_cpu = cpu/threads_per_core*threads_per_core;
+			migrate_task_to(current, target_cpu);
+		}
+	}
+#endif
 
 	if (!vcpu->arch.sane) {
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-- 
1.8.3.1
