Return-Path: <anton@samba.org>
Date: Fri, 21 Mar 2014 00:03:45 +1100
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org, benh@kernel.crashing.org, Andreas Schwab
 <schwab@linux-m68k.org>, Alexander Graf <agraf@suse.de>
Subject: [PATCH] powerpc: Fix KVM hang with CONFIG_KVM_XICS=n
Message-ID: <20140321000345.3b9d8c11@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I noticed KVM is broken when KVM in-kernel XICS emulation
(CONFIG_KVM_XICS) is disabled.

The problem was introduced in 48eaef05 (KVM: PPC: Book3S HV: use
xics_wake_cpu only when defined). It used CONFIG_KVM_XICS to wrap
xics_wake_cpu, where CONFIG_PPC_ICP_NATIVE should have been
used.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 17fc949..7a25d92 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -86,7 +86,7 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 
 	/* CPU points to the first thread of the core */
 	if (cpu != me && cpu >= 0 && cpu < nr_cpu_ids) {
-#ifdef CONFIG_KVM_XICS
+#ifdef CONFIG_PPC_ICP_NATIVE
 		int real_cpu = cpu + vcpu->arch.ptid;
 		if (paca[real_cpu].kvm_hstate.xics_phys)
 			xics_wake_cpu(real_cpu);
@@ -1360,9 +1360,7 @@ static void kvmppc_start_thread(struct kvm_vcpu *vcpu)
 	smp_wmb();
 #if defined(CONFIG_PPC_ICP_NATIVE) && defined(CONFIG_SMP)
 	if (cpu != smp_processor_id()) {
-#ifdef CONFIG_KVM_XICS
 		xics_wake_cpu(cpu);
-#endif
 		if (vcpu->arch.ptid)
 			++vc->n_woken;
 	}
