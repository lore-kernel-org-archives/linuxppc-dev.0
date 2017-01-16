Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v1xkt2lXjzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 13:19:34 +1100 (AEDT)
Message-ID: <1484533171.11927.24.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/icp-opal: Fix missing KVM case and harden replay
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <pmac@au1.ibm.com>
Date: Sun, 15 Jan 2017 20:19:31 -0600
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The icp-opal call is missing the code from icp-native to recover
interrupts snatched by KVM. Without that, when running KVM, we can
get into a situation where an interrupt is lost and the CPU stuck
with an elevated CPPR.

Also harden replay by always checking the return from opal_int_eoi

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xics/icp-opal.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index d38e86f..60c5765 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -20,6 +20,7 @@
 #include 
 #include 
 #include 
+#include 
 
 static void icp_opal_teardown_cpu(void)
 {
@@ -39,7 +40,26 @@ static void icp_opal_flush_ipi(void)
 	 * Should we be flagging idle loop instead?
 	 * Or creating some task to be scheduled?
 	 */
-	opal_int_eoi((0x00 << 24) | XICS_IPI);
+	if (opal_int_eoi((0x00 << 24) | XICS_IPI) > 0)
+		force_external_irq_replay();
+}
+
+static unsigned int icp_opal_get_xirr(void)
+{
+	unsigned int kvm_xirr;
+	__be32 hw_xirr;
+	int64_t rc;
+
+	/* Handle an interrupt latched by KVM first */
+	kvm_xirr = kvmppc_get_xics_latch();
+	if (kvm_xirr)
+		return kvm_xirr;
+
+	/* Then ask OPAL */
+	rc = opal_int_get_xirr(&hw_xirr, false);
+	if (rc < 0)
+		return 0;
+	return be32_to_cpu(hw_xirr);
 }
 
 static unsigned int icp_opal_get_irq(void)
@@ -47,12 +67,8 @@ static unsigned int icp_opal_get_irq(void)
 	unsigned int xirr;
 	unsigned int vec;
 	unsigned int irq;
-	int64_t rc;
 
-	rc = opal_int_get_xirr(&xirr, false);
-	if (rc < 0)
-		return 0;
-	xirr = be32_to_cpu(xirr);
+	xirr = icp_opal_get_xirr();
 	vec = xirr & 0x00ffffff;
 	if (vec == XICS_IRQ_SPURIOUS)
 		return 0;
@@ -67,7 +83,8 @@ static unsigned int icp_opal_get_irq(void)
 	xics_mask_unknown_vec(vec);
 
 	/* We might learn about it later, so EOI it */
-	opal_int_eoi(xirr);
+	if (opal_int_eoi(xirr) > 0)
+		force_external_irq_replay();
 
 	return 0;
 }
