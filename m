Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFC001A02B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 19:02:34 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v2] KVM: PPC: e500mc: Enhance tlb invalidation condition on
 vcpu schedule
Date: Tue, 17 Jun 2014 12:02:19 +0300
Message-ID: <1402995739-23756-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On vcpu schedule, the condition checked for tlb pollution is too loose.
The tlb entries of a vcpu become polluted (vs stale) only when a different
vcpu within the same logical partition runs in-between. Optimize the tlb
invalidation condition taking into account the logical partition id.

With the new invalidation condition, a guest shows 4% performance improvement
on P5020DS while running a memory stress application with the cpu oversubscribed,
the other guest running a cpu intensive workload.

Guest - old invalidation condition
  real 3.89
  user 3.87
  sys 0.01

Guest - enhanced invalidation condition
  real 3.75
  user 3.73
  sys 0.01

Host
  real 3.70
  user 1.85
  sys 0.00

The memory stress application accesses 4KB pages backed by 75% of available
TLB0 entries:

char foo[ENTRIES][4096] __attribute__ ((aligned (4096)));

int main()
{
	char bar;
	int i, j;

	for (i = 0; i < ITERATIONS; i++)
        	for (j = 0; j < ENTRIES; j++)
            		bar = foo[j][0];

	return 0;
}

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
---
v2:
 - improve patch name and description
 - add performance results

 arch/powerpc/kvm/e500mc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 17e4562..d3b814b0 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -111,10 +111,12 @@ void kvmppc_mmu_msr_notify(struct kvm_vcpu *vcpu, u32 old_msr)
 }
 
 static DEFINE_PER_CPU(struct kvm_vcpu *, last_vcpu_on_cpu);
+static DEFINE_PER_CPU(int, last_lpid_on_cpu);
 
 static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
+	bool update_last = false, inval_tlb = false;
 
 	kvmppc_booke_vcpu_load(vcpu, cpu);
 
@@ -140,12 +142,24 @@ static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
 	mtspr(SPRN_GDEAR, vcpu->arch.shared->dar);
 	mtspr(SPRN_GESR, vcpu->arch.shared->esr);
 
-	if (vcpu->arch.oldpir != mfspr(SPRN_PIR) ||
-	    __get_cpu_var(last_vcpu_on_cpu) != vcpu) {
-		kvmppc_e500_tlbil_all(vcpu_e500);
+	if (vcpu->arch.oldpir != mfspr(SPRN_PIR)) {
+		/* stale tlb entries */
+		inval_tlb = update_last = true;
+	} else if (__get_cpu_var(last_vcpu_on_cpu) != vcpu) {
+		update_last = true;
+		/* polluted tlb entries */
+		inval_tlb = __get_cpu_var(last_lpid_on_cpu) ==
+			    vcpu->kvm->arch.lpid;
+	}
+
+	if (update_last) {
 		__get_cpu_var(last_vcpu_on_cpu) = vcpu;
+		__get_cpu_var(last_lpid_on_cpu) = vcpu->kvm->arch.lpid;
 	}
 
+	if (inval_tlb)
+		kvmppc_e500_tlbil_all(vcpu_e500);
+
 	kvmppc_load_guest_fp(vcpu);
 }
 
-- 
1.7.11.7
