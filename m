Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3A5A8B6FD2
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:21 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p356AQvb023677
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:10:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356EKrB1155076
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EK7j011066
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/15] powerpc/xics: Make sure we have a sensible default
	distribution server
Date: Tue,  5 Apr 2011 16:13:59 +1000
Message-Id: <1301984051-18413-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Even when nothing is specified in the device tree, and despite the
fact that we don't setup links properly yet, we still need a reasonable
value in there or some interrupts won't be setup properly to point to
an existing processor.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xics/xics-common.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index ac26866..7c9cba3 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -57,7 +57,9 @@ void xics_update_irq_servers(void)
 	BUG_ON(!np);
 
 	hcpuid = get_hard_smp_processor_id(boot_cpuid);
-	xics_default_server = hcpuid;
+	xics_default_server = xics_default_distrib_server = hcpuid;
+
+	pr_devel("xics: xics_default_server = 0x%x\n", xics_default_server);
 
 	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
 	if (!ireg) {
@@ -75,9 +77,11 @@ void xics_update_irq_servers(void)
 	for (j = 0; j < i; j += 2) {
 		if (ireg[j] == hcpuid) {
 			xics_default_distrib_server = ireg[j+1];
+			break;
 		}
 	}
-
+	pr_devel("xics: xics_default_distrib_server = 0x%x\n",
+		 xics_default_distrib_server);
 	of_node_put(np);
 }
 
@@ -113,7 +117,7 @@ void xics_mask_unknown_vec(unsigned int vec)
 {
 	struct ics *ics;
 
-	pr_err("Interrupt %u (real) is invalid, disabling it.\n", vec);
+	pr_err("Interrupt 0x%x (real) is invalid, disabling it.\n", vec);
 
 	list_for_each_entry(ics, &ics_list, link)
 		ics->mask_unknown(ics, vec);
@@ -293,6 +297,8 @@ unlock:
  * If not we set it to the first cpu in the mask, even if multiple cpus
  * are set. This is so things like irqbalance (which set core and package
  * wide affinities) do the right thing.
+ *
+ * We need to fix this to implement support for the links
  */
 int xics_get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 			unsigned int strict_check)
-- 
1.7.1
