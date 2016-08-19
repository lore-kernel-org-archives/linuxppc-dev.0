Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBy2yXbzDrBG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:10 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 13/13] KVM: PPC: Book3S HV: Counters for passthrough IRQ stats
Date: Fri, 19 Aug 2016 15:35:57 +1000
Message-Id: <1471584957-21484-14-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
References: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suresh Warrier <warrier@linux.vnet.ibm.com>

Add VCPU stat counters to track affinity for passthrough
interrupts.

pthru_all: Counts all passthrough interrupts whose IRQ mappings are
           in the kvmppc_passthru_irq_map structure.
pthru_host: Counts all cached passthrough interrupts that were injected
	    from the host through kvm_set_irq (i.e. not handled in
	    real mode).
pthru_bad_aff: Counts how many cached passthrough interrupts have
               bad affinity (receiving CPU is not running VCPU that is
	       the target of the virtual interrupt in the guest).

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_host.h  |  3 +++
 arch/powerpc/kvm/book3s.c            |  3 +++
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 18 +++++++++++++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3eb5092..f371a23 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -131,6 +131,9 @@ struct kvm_vcpu_stat {
 	u32 ld_slow;
 	u32 st_slow;
 #endif
+	u32 pthru_all;
+	u32 pthru_host;
+	u32 pthru_bad_aff;
 };
 
 enum kvm_exit_types {
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 47018fc..6d0c45b 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -64,6 +64,9 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "ld_slow",     VCPU_STAT(ld_slow) },
 	{ "st",          VCPU_STAT(st) },
 	{ "st_slow",     VCPU_STAT(st_slow) },
+	{ "pthru_all",       VCPU_STAT(pthru_all) },
+	{ "pthru_host",      VCPU_STAT(pthru_host) },
+	{ "pthru_bad_aff",   VCPU_STAT(pthru_bad_aff) },
 	{ NULL }
 };
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 5f7527e..82ff5de 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -716,11 +716,19 @@ int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 		icp->rm_eoied_irq = irq;
 	}
 
-	if (state->host_irq && state->intr_cpu != -1) {
-		int pcpu = cpu_first_thread_sibling(raw_smp_processor_id());
-		if (state->intr_cpu != pcpu)
-			xics_opal_rm_set_server(state->host_irq, pcpu);
-		state->intr_cpu = -1;
+	if (state->host_irq) {
+		++vcpu->stat.pthru_all;
+		if (state->intr_cpu != -1) {
+			int pcpu = raw_smp_processor_id();
+
+			pcpu = cpu_first_thread_sibling(pcpu);
+			++vcpu->stat.pthru_host;
+			if (state->intr_cpu != pcpu) {
+				++vcpu->stat.pthru_bad_aff;
+				xics_opal_rm_set_server(state->host_irq, pcpu);
+			}
+			state->intr_cpu = -1;
+		}
 	}
  bail:
 	return check_too_hard(xics, icp);
-- 
2.8.1
