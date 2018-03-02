Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zt5jC1Z6SzF1qq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 21:52:14 +1100 (AEDT)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Fix guest time accounting with
 VIRT_CPU_ACCOUNTING_GEN
Date: Fri,  2 Mar 2018 11:51:56 +0100
Message-Id: <20180302105156.19506-1-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 8b24e69fc47e ("KVM: PPC: Book3S HV: Close race with testing
for signals on guest entry"), if CONFIG_VIRT_CPU_ACCOUNTING_GEN is set, the
guest time is not accounted to guest time and user time, but instead to
system time.

This is because guest_enter()/guest_exit() are called while interrupts
are disabled and the tick counter cannot be updated between them.

To fix that, move guest_exit() after local_irq_enable(), and as
guest_enter() is called with IRQ disabled, calls guest_enter_irqoff()
instead.

Fixes: 8b24e69fc47e
("KVM: PPC: Book3S HV: Close race with testing for signals on guest entry")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/kvm/book3s_hv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 89707354c2ef..8274c2807202 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2885,7 +2885,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	 */
 	trace_hardirqs_on();
 
-	guest_enter();
+	guest_enter_irqoff();
 
 	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
 
@@ -2893,8 +2893,6 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 
 	srcu_read_unlock(&vc->kvm->srcu, srcu_idx);
 
-	guest_exit();
-
 	trace_hardirqs_off();
 	set_irq_happened(trap);
 
@@ -2937,6 +2935,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	kvmppc_set_host_core(pcpu);
 
 	local_irq_enable();
+	guest_exit();
 
 	/* Let secondaries go back to the offline loop */
 	for (i = 0; i < controlled_threads; ++i) {
-- 
2.14.3
