Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tR80v0YF4zDvs2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 10:14:55 +1100 (AEDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, tglx@linutronix.de,
 Anna-Maria Gleixner <anna-maria@linutronix.de>,
 Alexander Graf <agraf@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 17/22] KVM/PPC/Book3S HV: Convert to hotplug state machine
Date: Sun, 27 Nov 2016 00:13:45 +0100
Message-Id: <20161126231350.10321-18-bigeasy@linutronix.de>
In-Reply-To: <20161126231350.10321-1-bigeasy@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

Install the callbacks via the state machine.

Cc: Alexander Graf <agraf@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kvm-ppc@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kvm/book3s_hv.c | 48 ++++++++++------------------------------=
----
 include/linux/cpuhotplug.h   |  1 +
 2 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3686471be32b..39ef1f4a7b02 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2254,12 +2254,12 @@ static void post_guest_process(struct kvmppc_vcore =
*vc, bool is_master)
  * enter the guest. Only do this if it is the primary thread of the
  * core (not if a subcore) that is entering the guest.
  */
-static inline void kvmppc_clear_host_core(int cpu)
+static inline int kvmppc_clear_host_core(unsigned int cpu)
 {
 	int core;
=20
 	if (!kvmppc_host_rm_ops_hv || cpu_thread_in_core(cpu))
-		return;
+		return 0;
 	/*
 	 * Memory barrier can be omitted here as we will do a smp_wmb()
 	 * later in kvmppc_start_thread and we need ensure that state is
@@ -2267,6 +2267,7 @@ static inline void kvmppc_clear_host_core(int cpu)
 	 */
 	core =3D cpu >> threads_shift;
 	kvmppc_host_rm_ops_hv->rm_core[core].rm_state.in_host =3D 0;
+	return 0;
 }
=20
 /*
@@ -2274,12 +2275,12 @@ static inline void kvmppc_clear_host_core(int cpu)
  * Only need to do this if it is the primary thread of the core that is
  * exiting.
  */
-static inline void kvmppc_set_host_core(int cpu)
+static inline int kvmppc_set_host_core(unsigned int cpu)
 {
 	int core;
=20
 	if (!kvmppc_host_rm_ops_hv || cpu_thread_in_core(cpu))
-		return;
+		return 0;
=20
 	/*
 	 * Memory barrier can be omitted here because we do a spin_unlock
@@ -2287,6 +2288,7 @@ static inline void kvmppc_set_host_core(int cpu)
 	 */
 	core =3D cpu >> threads_shift;
 	kvmppc_host_rm_ops_hv->rm_core[core].rm_state.in_host =3D 1;
+	return 0;
 }
=20
 /*
@@ -3094,36 +3096,6 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu =
*vcpu)
 }
=20
 #ifdef CONFIG_KVM_XICS
-static int kvmppc_cpu_notify(struct notifier_block *self, unsigned long ac=
tion,
-			void *hcpu)
-{
-	unsigned long cpu =3D (long)hcpu;
-
-	switch (action) {
-	case CPU_UP_PREPARE:
-	case CPU_UP_PREPARE_FROZEN:
-		kvmppc_set_host_core(cpu);
-		break;
-
-#ifdef CONFIG_HOTPLUG_CPU
-	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
-	case CPU_UP_CANCELED:
-	case CPU_UP_CANCELED_FROZEN:
-		kvmppc_clear_host_core(cpu);
-		break;
-#endif
-	default:
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block kvmppc_cpu_notifier =3D {
-	    .notifier_call =3D kvmppc_cpu_notify,
-};
-
 /*
  * Allocate a per-core structure for managing state about which cores are
  * running in the host versus the guest and for exchanging data between
@@ -3185,15 +3157,17 @@ void kvmppc_alloc_host_rm_ops(void)
 		return;
 	}
=20
-	register_cpu_notifier(&kvmppc_cpu_notifier);
-
+	cpuhp_setup_state_nocalls(CPUHP_KVM_PPC_BOOK3S_PREPARE,
+				  "ppc/kvm_book3s:prepare",
+				  kvmppc_set_host_core,
+				  kvmppc_clear_host_core);
 	put_online_cpus();
 }
=20
 void kvmppc_free_host_rm_ops(void)
 {
 	if (kvmppc_host_rm_ops_hv) {
-		unregister_cpu_notifier(&kvmppc_cpu_notifier);
+		cpuhp_remove_state_nocalls(CPUHP_KVM_PPC_BOOK3S_PREPARE);
 		kfree(kvmppc_host_rm_ops_hv->rm_core);
 		kfree(kvmppc_host_rm_ops_hv);
 		kvmppc_host_rm_ops_hv =3D NULL;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 853f8176594d..71c6822dd5be 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -68,6 +68,7 @@ enum cpuhp_state {
 	CPUHP_MM_ZS_PREPARE,
 	CPUHP_MM_ZSWP_MEM_PREPARE,
 	CPUHP_MM_ZSWP_POOL_PREPARE,
+	CPUHP_KVM_PPC_BOOK3S_PREPARE,
 	CPUHP_TIMERS_DEAD,
 	CPUHP_NOTF_ERR_INJ_PREPARE,
 	CPUHP_MIPS_SOC_PREPARE,
--=20
2.10.2
