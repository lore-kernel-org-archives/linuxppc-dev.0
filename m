Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54DEC1A0006
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 05:10:07 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v3] KVM: PPC: e500mc: Enhance tlb invalidation condition on
 vcpu schedule
Date: Tue, 17 Jun 2014 22:09:36 +0300
Message-ID: <1403032176-28362-1-git-send-email-mihai.caraman@freescale.com>
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
invalidation condition keeping last_vcpu_on_cpu per logical partition id.

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
v3:
 - use existing logic while keeping last_vcpu_per_cpu per lpid
 
v2:
 - improve patch name and description
 - add performance results


 arch/powerpc/kvm/e500mc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 17e4562..95e33e3 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -110,7 +110,7 @@ void kvmppc_mmu_msr_notify(struct kvm_vcpu *vcpu, u32 old_msr)
 {
 }
 
-static DEFINE_PER_CPU(struct kvm_vcpu *, last_vcpu_on_cpu);
+static DEFINE_PER_CPU(struct kvm_vcpu * [KVMPPC_NR_LPIDS], last_vcpu_on_cpu);
 
 static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
 {
@@ -141,9 +141,9 @@ static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
 	mtspr(SPRN_GESR, vcpu->arch.shared->esr);
 
 	if (vcpu->arch.oldpir != mfspr(SPRN_PIR) ||
-	    __get_cpu_var(last_vcpu_on_cpu) != vcpu) {
+	    __get_cpu_var(last_vcpu_on_cpu)[vcpu->kvm->arch.lpid] != vcpu) {
 		kvmppc_e500_tlbil_all(vcpu_e500);
-		__get_cpu_var(last_vcpu_on_cpu) = vcpu;
+		__get_cpu_var(last_vcpu_on_cpu)[vcpu->kvm->arch.lpid] = vcpu;
 	}
 
 	kvmppc_load_guest_fp(vcpu);
-- 
1.7.11.7
