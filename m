Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSss50ylbzDrpn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 13:43:52 +1000 (AEST)
Message-ID: <1473133425.2313.58.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/xics/opal: Fix processor numbers in OPAL ICP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <michaele@au1.ibm.com>
Date: Tue, 06 Sep 2016 13:43:45 +1000
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

When using the OPAL ICP backend we incorrectly pass Linux CPU numbers
rather than HW CPU numbers to OPAL.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: d74361881f0dfe5f9dcac37d1b753a15a2345d8c

---
diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index 57d72f1..9114243 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -23,10 +23,10 @@
 
 static void icp_opal_teardown_cpu(void)
 {
-	int cpu = smp_processor_id();
+	int hw_cpu = hard_smp_processor_id();
 
 	/* Clear any pending IPI */
-	opal_int_set_mfrr(cpu, 0xff);
+	opal_int_set_mfrr(hw_cpu, 0xff);
 }
 
 static void icp_opal_flush_ipi(void)
@@ -101,14 +101,16 @@ static void icp_opal_eoi(struct irq_data *d)
 
 static void icp_opal_cause_ipi(int cpu, unsigned long data)
 {
-	opal_int_set_mfrr(cpu, IPI_PRIORITY);
+	int hw_cpu = get_hard_smp_processor_id(cpu);
+
+	opal_int_set_mfrr(hw_cpu, IPI_PRIORITY);
 }
 
 static irqreturn_t icp_opal_ipi_action(int irq, void *dev_id)
 {
-	int cpu = smp_processor_id();
+	int hw_cpu = hard_smp_processor_id();
 
-	opal_int_set_mfrr(cpu, 0xff);
+	opal_int_set_mfrr(hw_cpu, 0xff);
 
 	return smp_ipi_demux();
 }
