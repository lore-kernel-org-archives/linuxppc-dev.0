Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w51m66VfzzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Apr 2017 03:31:34 +1000 (AEST)
Message-Id: <20170415171651.824802220@linutronix.de>
Date: Sat, 15 Apr 2017 19:01:14 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Siewior <bigeasy@linutronix.de>, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [patch 07/20] KVM/PPC/Book3S HV: Use
 cpuhp_setup_state_nocalls_locked()
References: <20170415170107.643253702@linutronix.de>
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

Use cpuhp_setup_state_nocalls_locked() to avoid the nested call.

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
+	cpuhp_setup_state_nocalls_locked(CPUHP_KVM_PPC_BOOK3S_PREPARE,
+					 "ppc/kvm_book3s:prepare",
+					 kvmppc_set_host_core,
+					 kvmppc_clear_host_core);
 	put_online_cpus();
 }
 
