Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>,
	<kvm-ppc@vger.kernel.org>
Subject: [PATCH] kvm/powerpc: Handle errors in secondary thread grabbing
Date: Tue, 16 Oct 2012 11:15:50 +1100
Message-Id: <1350346550-32539-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the Book3s HV code, kvmppc_run_core() has logic to grab the secondary
threads of the physical core.

If for some reason a thread is stuck, kvmppc_grab_hwthread() can fail,
but currently we ignore the failure and continue into the guest. If the
stuck thread is in the kernel badness ensues.

Instead we should check for failure and bail out.

I've moved the grabbing prior to the startup of runnable threads, to simplify
the error case. AFAICS this is harmless, but I could be missing something
subtle.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

Or we could just BUG_ON() ?
---
 arch/powerpc/kvm/book3s_hv.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 721d460..55925cd 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -884,16 +884,30 @@ static int kvmppc_run_core(struct kvmppc_vcore *vc)
 		if (vcpu->arch.ceded)
 			vcpu->arch.ptid = ptid++;
 
+	/*
+	 * Grab any remaining hw threads so they can't go into the kernel.
+	 * Do this early to simplify the cleanup path if it fails.
+	 */
+	for (i = ptid; i < threads_per_core; ++i) {
+		int j, rc = kvmppc_grab_hwthread(vc->pcpu + i);
+		if (rc) {
+			for (j = i - 1; j ; j--)
+				kvmppc_release_hwthread(vc->pcpu + j);
+
+			list_for_each_entry(vcpu, &vc->runnable_threads,
+					    arch.run_list)
+				vcpu->arch.ret = -EBUSY;
+
+			goto out;
+		}
+	}
+
 	vc->stolen_tb += mftb() - vc->preempt_tb;
 	vc->pcpu = smp_processor_id();
 	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list) {
 		kvmppc_start_thread(vcpu);
 		kvmppc_create_dtl_entry(vcpu, vc);
 	}
-	/* Grab any remaining hw threads so they can't go into the kernel */
-	for (i = ptid; i < threads_per_core; ++i)
-		kvmppc_grab_hwthread(vc->pcpu + i);
-
 	preempt_disable();
 	spin_unlock(&vc->lock);
 
-- 
1.7.9.5
