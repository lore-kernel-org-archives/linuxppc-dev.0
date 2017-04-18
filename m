Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6wjK748mzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 05:50:45 +1000 (AEST)
Message-Id: <20170418170552.946155801@linutronix.de>
Date: Tue, 18 Apr 2017 19:04:49 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Siewior <bigeasy@linutronix.de>, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [patch V2 07/24] KVM/PPC/Book3S HV: Use
 cpuhp_setup_state_nocalls_cpuslocked()
References: <20170418170442.665445272@linutronix.de>
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

Use cpuhp_setup_state_nocalls_cpuslocked() to avoid the nested call.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Graf <agraf@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kvm@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

---
 arch/powerpc/kvm/book3s_hv.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3336,10 +3336,10 @@ void kvmppc_alloc_host_rm_ops(void)
 		return;
 	}
 
-	cpuhp_setup_state_nocalls(CPUHP_KVM_PPC_BOOK3S_PREPARE,
-				  "ppc/kvm_book3s:prepare",
-				  kvmppc_set_host_core,
-				  kvmppc_clear_host_core);
+	cpuhp_setup_state_nocalls_cpuslocked(CPUHP_KVM_PPC_BOOK3S_PREPARE,
+					     "ppc/kvm_book3s:prepare",
+					     kvmppc_set_host_core,
+					     kvmppc_clear_host_core);
 	put_online_cpus();
 }
 
