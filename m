Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM2RK4ZHmzF0PQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 20:51:25 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 3/6] KVM: PPC: Book3S HV: Allow HPT and radix on the same core
 for POWER9 v2.2
Date: Wed, 17 Jan 2018 20:51:12 +1100
Message-Id: <1516182675-25331-4-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1516182675-25331-1-git-send-email-paulus@ozlabs.org>
References: <1516182675-25331-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 chip versions starting with v2.2 can support running with some
threads of a core in HPT mode and others in radix mode.  This means
that we don't have to prohibit independent-threads mode when running
a HPT guest on a radix host, and we don't have to do any of the
synchronization between threads that was introduced in commit
c01015091a77 ("KVM: PPC: Book3S HV: Run HPT guests on POWER9 radix
hosts", 2017-10-19).

Rather than using up another CPU feature bit, we just do an
explicit test on the PVR (processor version register) at module
startup time to determine whether we have to take steps to avoid
having some threads in HPT mode and some in radix mode (so-called
"mixed mode").

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index b2d448c..99ed374 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -118,6 +118,9 @@ module_param_cb(h_ipi_redirect, &module_param_ops, &h_ipi_redirect,
 MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
 #endif
 
+/* If set, the threads on each CPU core have to be in the same MMU mode */
+static bool no_mixing_hpt_and_radix;
+
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
 
@@ -2386,8 +2389,8 @@ static void init_core_info(struct core_info *cip, struct kvmppc_vcore *vc)
 static bool subcore_config_ok(int n_subcores, int n_threads)
 {
 	/*
-	 * POWER9 "SMT4" cores are permanently in what is effectively a 4-way split-core
-	 * mode, with one thread per subcore.
+	 * POWER9 "SMT4" cores are permanently in what is effectively a 4-way
+	 * split-core mode, with one thread per subcore.
 	 */
 	if (cpu_has_feature(CPU_FTR_ARCH_300))
 		return n_subcores <= 4 && n_threads == 1;
@@ -2423,8 +2426,8 @@ static bool can_dynamic_split(struct kvmppc_vcore *vc, struct core_info *cip)
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		return false;
 
-	/* POWER9 currently requires all threads to be in the same MMU mode */
-	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+	/* Some POWER9 chips require all threads to be in the same MMU mode */
+	if (no_mixing_hpt_and_radix &&
 	    kvm_is_radix(vc->kvm) != kvm_is_radix(cip->vc[0]->kvm))
 		return false;
 
@@ -2687,9 +2690,11 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	 * threads are offline.  Also check if the number of threads in this
 	 * guest are greater than the current system threads per guest.
 	 * On POWER9, we need to be not in independent-threads mode if
-	 * this is a HPT guest on a radix host.
+	 * this is a HPT guest on a radix host machine where the
+	 * CPU threads may not be in different MMU modes.
 	 */
-	hpt_on_radix = radix_enabled() && !kvm_is_radix(vc->kvm);
+	hpt_on_radix = no_mixing_hpt_and_radix && radix_enabled() &&
+		!kvm_is_radix(vc->kvm);
 	if (((controlled_threads > 1) &&
 	     ((vc->num_threads > threads_per_subcore) || !on_primary_thread())) ||
 	    (hpt_on_radix && vc->kvm->arch.threads_indep)) {
@@ -4446,6 +4451,17 @@ static int kvmppc_book3s_init_hv(void)
 
 	if (kvmppc_radix_possible())
 		r = kvmppc_radix_init();
+
+	/*
+	 * POWER9 chips before version 2.02 can't have some threads in
+	 * HPT mode and some in radix mode on the same core.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		unsigned int pvr = mfspr(SPRN_PVR);
+		if ((pvr >> 16) == PVR_POWER9 && (pvr & 0xfff) < 0x202)
+			no_mixing_hpt_and_radix = true;
+	}
+
 	return r;
 }
 
-- 
2.7.4
