Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCcVs6yrhzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 20:57:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 benh@kernel.crashing.org, ego@linux.vnet.ibm.com
Subject: [PATCH] powerpc/powernv: Fix oops on P9 DD1 in cause_ipi()
Date: Wed, 26 Apr 2017 20:57:47 +1000
Message-Id: <1493204267-5752-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently we merged the native xive support for Power9, and then separately some
reworks for doorbell IPI support. In isolation both series were OK, but the
merged result had a bug in one case.

On P9 DD1 we use pnv_p9_dd1_cause_ipi() which tries to use doorbells, and then
falls back to the interrupt controller. However the fallback is implemented by
calling icp_ops->cause_ipi. But now that xive support is merged we might be
using xive, in which case icp_ops is not initialised, it's a xics specific
structure. This leads to an oops such as:

  Unable to handle kernel paging request for data at address 0x00000028
  Oops: Kernel access of bad area, sig: 11 [#1]
  NIP pnv_p9_dd1_cause_ipi+0x74/0xe0
  LR smp_muxed_ipi_message_pass+0x54/0x70

To fix it, rather than using icp_ops which might be NULL, have both xics and
xive set smp_ops->cause_ipi, and then in the powernv code we save that as
ic_cause_ipi before overriding smp_ops->cause_ipi. For paranoia add a WARN_ON()
to check if somehow smp_ops->cause_ipi is NULL.

Fixes: b866cc2199d6 ("powerpc: Change the doorbell IPI calling convention")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/smp.c   | 12 ++++++++----
 arch/powerpc/sysdev/xics/xics-common.c |  3 +++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 951a2e230cfa..5189445db164 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -249,12 +249,15 @@ static int pnv_smp_prepare_cpu(int cpu)
 	return 0;
 }
 
+/* Cause IPI as setup by the interrupt controller (xics or xive) */
+static void (*ic_cause_ipi)(int cpu);
+
 static void pnv_cause_ipi(int cpu)
 {
 	if (doorbell_try_core_ipi(cpu))
 		return;
 
-	icp_ops->cause_ipi(cpu);
+	ic_cause_ipi(cpu);
 }
 
 static void pnv_p9_dd1_cause_ipi(int cpu)
@@ -269,7 +272,7 @@ static void pnv_p9_dd1_cause_ipi(int cpu)
 	if (cpumask_test_cpu(cpu, cpu_sibling_mask(this_cpu)))
 		doorbell_global_ipi(cpu);
 	else
-		icp_ops->cause_ipi(cpu);
+		ic_cause_ipi(cpu);
 
 	put_cpu();
 }
@@ -282,6 +285,9 @@ static void __init pnv_smp_probe(void)
 		xics_smp_probe();
 
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
+		ic_cause_ipi = smp_ops->cause_ipi;
+		WARN_ON(!ic_cause_ipi);
+
 		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 			if (cpu_has_feature(CPU_FTR_POWER9_DD1))
 				smp_ops->cause_ipi = pnv_p9_dd1_cause_ipi;
@@ -290,8 +296,6 @@ static void __init pnv_smp_probe(void)
 		} else {
 			smp_ops->cause_ipi = pnv_cause_ipi;
 		}
-	} else {
-		smp_ops->cause_ipi = icp_ops->cause_ipi;
 	}
 }
 
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 2eb53c12ee6e..ffe138b8b9dc 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -145,6 +145,9 @@ void __init xics_smp_probe(void)
 {
 	/* Register all the IPIs */
 	xics_request_ipi();
+
+	/* Setup cause_ipi callback based on which ICP is used */
+	smp_ops->cause_ipi = icp_ops->cause_ipi;
 }
 
 #endif /* CONFIG_SMP */
-- 
2.7.4
