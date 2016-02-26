Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BED71A0BA6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:42:04 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2DF47140307
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:42:02 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:42:01 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 016F01FF0027
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:30:08 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIfw4E43909174
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:58 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIfvge020104
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:58 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 14/14] KVM: PPC: Book3S HV: Counters for passthrough IRQ stats
Date: Fri, 26 Feb 2016 12:40:32 -0600
Message-Id: <1456512032-31286-15-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add VCPU stat counters to track affinity for passthrough
interrupts.

pthru_all: Counts all passthrough interrupts whose IRQ mappings have
           been cached in the kvmppc_passthru_irq_map cache.
pthru_host: Counts all cached passthrough interrupts that were injected
	    from the host through kvm_set_irq.
pthru_bad_aff: Counts how many cached passthrough interrupts have
               bad affinity (receiving CPU is not running VCPU that is
	       the target of the virtual interrupt in the guest).

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h  | 3 +++
 arch/powerpc/kvm/book3s.c            | 3 +++
 arch/powerpc/kvm/book3s_hv_rm_xics.c | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 558d195..9230b1a 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -128,6 +128,9 @@ struct kvm_vcpu_stat {
 	u32 ld_slow;
 	u32 st_slow;
 #endif
+	u32 pthru_all;
+	u32 pthru_host;
+	u32 pthru_bad_aff;
 };
 
 enum kvm_exit_types {
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 1b4f5bd..b3d44b1 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -65,6 +65,9 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "ld_slow",     VCPU_STAT(ld_slow) },
 	{ "st",          VCPU_STAT(st) },
 	{ "st_slow",     VCPU_STAT(st_slow) },
+	{ "pthru_all",       VCPU_STAT(pthru_all) },
+	{ "pthru_host",      VCPU_STAT(pthru_host) },
+	{ "pthru_bad_aff",   VCPU_STAT(pthru_bad_aff) },
 	{ NULL }
 };
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index e2bbfdf..4004a35 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -696,6 +696,7 @@ static struct kvmppc_irq_map *get_irqmap_gsi(
 unsigned long irq_map_err;
 
 /*
+ * Count affinity for passthrough IRQs.
  * Change affinity to CPU running the target VCPU.
  */
 static void ics_set_affinity_passthru(struct ics_irq_state *state,
@@ -708,17 +709,23 @@ static void ics_set_affinity_passthru(struct ics_irq_state *state,
 	s16 intr_cpu;
 	u32 pcpu;
 
+	vcpu->stat.pthru_all++;
+
 	intr_cpu = state->intr_cpu;
 
 	if  (intr_cpu == -1)
 		return;
 
+	vcpu->stat.pthru_host++;
+
 	state->intr_cpu = -1;
 
 	pcpu = cpu_first_thread_sibling(raw_smp_processor_id());
 	if (intr_cpu == pcpu)
 		return;
 
+	vcpu->stat.pthru_bad_aff++;
+
 	pimap = kvmppc_get_passthru_irqmap(vcpu);
 	if (likely(pimap)) {
 		irq_map = get_irqmap_gsi(pimap, irq);
-- 
1.8.3.4
