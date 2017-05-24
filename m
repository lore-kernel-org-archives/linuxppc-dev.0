Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXlqT06KHzDqcd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 18:26:45 +1000 (AEST)
Message-Id: <20170524081547.809616236@linutronix.de>
Date: Wed, 24 May 2017 10:15:21 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, kvm-ppc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.com>
Subject: [patch V3 10/32] KVM/PPC/Book3S HV: Use
 cpuhp_setup_state_nocalls_cpuslocked()
References: <20170524081511.203800767@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

kvmppc_alloc_host_rm_ops() holds get_online_cpus() while invoking
cpuhp_setup_state_nocalls().

cpuhp_setup_state_nocalls() invokes get_online_cpus() as well. This is
correct, but prevents the conversion of the hotplug locking to a percpu
rwsem.

Use cpuhp_setup_state_nocalls_cpuslocked() to avoid the nested
call. Convert *_online_cpus() to the new interfaces while at it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: kvm-ppc@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <agraf@suse.com>

---
 arch/powerpc/kvm/book3s_hv.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3317,7 +3317,7 @@ void kvmppc_alloc_host_rm_ops(void)
 		return;
 	}
 
-	get_online_cpus();
+	cpus_read_lock();
 
 	for (cpu = 0; cpu < nr_cpu_ids; cpu += threads_per_core) {
 		if (!cpu_online(cpu))
@@ -3339,17 +3339,17 @@ void kvmppc_alloc_host_rm_ops(void)
 	l_ops = (unsigned long) ops;
 
 	if (cmpxchg64((unsigned long *)&kvmppc_host_rm_ops_hv, 0, l_ops)) {
-		put_online_cpus();
+		cpus_read_unlock();
 		kfree(ops->rm_core);
 		kfree(ops);
 		return;
 	}
 
-	cpuhp_setup_state_nocalls(CPUHP_KVM_PPC_BOOK3S_PREPARE,
-				  "ppc/kvm_book3s:prepare",
-				  kvmppc_set_host_core,
-				  kvmppc_clear_host_core);
-	put_online_cpus();
+	cpuhp_setup_state_nocalls_cpuslocked(CPUHP_KVM_PPC_BOOK3S_PREPARE,
+					     "ppc/kvm_book3s:prepare",
+					     kvmppc_set_host_core,
+					     kvmppc_clear_host_core);
+	cpus_read_unlock();
 }
 
 void kvmppc_free_host_rm_ops(void)
