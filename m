Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KJg80gSnzDqlJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:25:56 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id y12-v6so4375434plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:25:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 8/9] powerpc/xive: standardise OPAL_BUSY delays
Date: Mon,  9 Apr 2018 15:24:30 +1000
Message-Id: <20180409052431.26405-9-npiggin@gmail.com>
In-Reply-To: <20180409052431.26405-1-npiggin@gmail.com>
References: <20180409052431.26405-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert to using the standard delay poll/delay form.

The XIVE driver:

- Did not previously loop on the OPAL_BUSY_EVENT case.
- Used a 1ms sleep.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/sysdev/xive/native.c | 193 +++++++++++++++++-------------
 1 file changed, 111 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index d22aeb0b69e1..682f79dabb4a 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -103,14 +103,18 @@ EXPORT_SYMBOL_GPL(xive_native_populate_irq_data);
 
 int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
 {
-	s64 rc;
+	s64 rc = OPAL_BUSY;
 
-	for (;;) {
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_xive_set_irq_config(hw_irq, target, prio, sw_irq);
-		if (rc != OPAL_BUSY)
-			break;
-		msleep(1);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
+
 	return rc == 0 ? 0 : -ENXIO;
 }
 EXPORT_SYMBOL_GPL(xive_native_configure_irq);
@@ -159,12 +163,17 @@ int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
 	}
 
 	/* Configure and enable the queue in HW */
-	for (;;) {
+	rc = OPAL_BUSY;
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_xive_set_queue_info(vp_id, prio, qpage_phys, order, flags);
-		if (rc != OPAL_BUSY)
-			break;
-		msleep(1);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
+
 	if (rc) {
 		pr_err("Error %lld setting queue for prio %d\n", rc, prio);
 		rc = -EIO;
@@ -183,14 +192,17 @@ EXPORT_SYMBOL_GPL(xive_native_configure_queue);
 
 static void __xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio)
 {
-	s64 rc;
+	s64 rc = OPAL_BUSY;
 
 	/* Disable the queue in HW */
-	for (;;) {
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_xive_set_queue_info(vp_id, prio, 0, 0, 0);
-		if (rc != OPAL_BUSY)
-			break;
-		msleep(1);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 	if (rc)
 		pr_err("Error %lld disabling queue for prio %d\n", rc, prio);
@@ -240,7 +252,7 @@ static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 {
 	struct device_node *np;
 	unsigned int chip_id;
-	s64 irq;
+	s64 rc = OPAL_BUSY;
 
 	/* Find the chip ID */
 	np = of_get_cpu_node(cpu, NULL);
@@ -250,33 +262,39 @@ static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 	}
 
 	/* Allocate an IPI and populate info about it */
-	for (;;) {
-		irq = opal_xive_allocate_irq(chip_id);
-		if (irq == OPAL_BUSY) {
-			msleep(1);
-			continue;
-		}
-		if (irq < 0) {
-			pr_err("Failed to allocate IPI on CPU %d\n", cpu);
-			return -ENXIO;
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_xive_allocate_irq(chip_id);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
 		}
-		xc->hw_ipi = irq;
-		break;
 	}
+	if (rc < 0) {
+		pr_err("Failed to allocate IPI on CPU %d\n", cpu);
+		return -ENXIO;
+	}
+	xc->hw_ipi = rc;
+
 	return 0;
 }
 #endif /* CONFIG_SMP */
 
 u32 xive_native_alloc_irq(void)
 {
-	s64 rc;
+	s64 rc = OPAL_BUSY;
 
-	for (;;) {
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_xive_allocate_irq(OPAL_XIVE_ANY_CHIP);
-		if (rc != OPAL_BUSY)
-			break;
-		msleep(1);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
+
 	if (rc < 0)
 		return 0;
 	return rc;
@@ -285,11 +303,16 @@ EXPORT_SYMBOL_GPL(xive_native_alloc_irq);
 
 void xive_native_free_irq(u32 irq)
 {
-	for (;;) {
-		s64 rc = opal_xive_free_irq(irq);
-		if (rc != OPAL_BUSY)
-			break;
-		msleep(1);
+	s64 rc = OPAL_BUSY;
+
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+		rc = opal_xive_free_irq(irq);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(xive_native_free_irq);
@@ -297,20 +320,11 @@ EXPORT_SYMBOL_GPL(xive_native_free_irq);
 #ifdef CONFIG_SMP
 static void xive_native_put_ipi(unsigned int cpu, struct xive_cpu *xc)
 {
-	s64 rc;
-
 	/* Free the IPI */
 	if (!xc->hw_ipi)
 		return;
-	for (;;) {
-		rc = opal_xive_free_irq(xc->hw_ipi);
-		if (rc == OPAL_BUSY) {
-			msleep(1);
-			continue;
-		}
-		xc->hw_ipi = 0;
-		break;
-	}
+	xive_native_free_irq(xc->hw_ipi);
+	xc->hw_ipi = 0;
 }
 #endif /* CONFIG_SMP */
 
@@ -381,7 +395,7 @@ static void xive_native_eoi(u32 hw_irq)
 
 static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
 {
-	s64 rc;
+	s64 rc = OPAL_BUSY;
 	u32 vp;
 	__be64 vp_cam_be;
 	u64 vp_cam;
@@ -392,12 +406,16 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
 	/* Enable the pool VP */
 	vp = xive_pool_vps + cpu;
 	pr_debug("CPU %d setting up pool VP 0x%x\n", cpu, vp);
-	for (;;) {
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_xive_set_vp_info(vp, OPAL_XIVE_VP_ENABLED, 0);
-		if (rc != OPAL_BUSY)
-			break;
-		msleep(1);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
+
 	if (rc) {
 		pr_err("Failed to enable pool VP on CPU %d\n", cpu);
 		return;
@@ -425,7 +443,7 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
 
 static void xive_native_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
 {
-	s64 rc;
+	s64 rc = OPAL_BUSY;
 	u32 vp;
 
 	if (xive_pool_vps == XIVE_INVALID_VP)
@@ -436,11 +454,14 @@ static void xive_native_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
 
 	/* Disable it */
 	vp = xive_pool_vps + cpu;
-	for (;;) {
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_xive_set_vp_info(vp, 0, 0);
-		if (rc != OPAL_BUSY)
-			break;
-		msleep(1);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 }
 
@@ -627,7 +648,7 @@ static bool xive_native_provision_pages(void)
 
 u32 xive_native_alloc_vp_block(u32 max_vcpus)
 {
-	s64 rc;
+	s64 rc = OPAL_BUSY;
 	u32 order;
 
 	order = fls(max_vcpus) - 1;
@@ -637,25 +658,25 @@ u32 xive_native_alloc_vp_block(u32 max_vcpus)
 	pr_debug("VP block alloc, for max VCPUs %d use order %d\n",
 		 max_vcpus, order);
 
-	for (;;) {
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_xive_alloc_vp_block(order);
-		switch (rc) {
-		case OPAL_BUSY:
-			msleep(1);
-			break;
-		case OPAL_XIVE_PROVISIONING:
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		} else if (rc == OPAL_XIVE_PROVISIONING) {
 			if (!xive_native_provision_pages())
 				return XIVE_INVALID_VP;
-			break;
-		default:
-			if (rc < 0) {
-				pr_err("OPAL failed to allocate VCPUs order %d, err %lld\n",
-				       order, rc);
-				return XIVE_INVALID_VP;
-			}
-			return rc;
+			rc = OPAL_BUSY; /* go around again */
 		}
 	}
+	if (rc < 0) {
+		pr_err("OPAL failed to allocate VCPUs order %d, err %lld\n",
+		       order, rc);
+		return XIVE_INVALID_VP;
+	}
+	return rc;
 }
 EXPORT_SYMBOL_GPL(xive_native_alloc_vp_block);
 
@@ -674,30 +695,38 @@ EXPORT_SYMBOL_GPL(xive_native_free_vp_block);
 
 int xive_native_enable_vp(u32 vp_id, bool single_escalation)
 {
-	s64 rc;
+	s64 rc = OPAL_BUSY;
 	u64 flags = OPAL_XIVE_VP_ENABLED;
 
 	if (single_escalation)
 		flags |= OPAL_XIVE_VP_SINGLE_ESCALATION;
-	for (;;) {
+
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_xive_set_vp_info(vp_id, flags, 0);
-		if (rc != OPAL_BUSY)
-			break;
-		msleep(1);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
+
 	return rc ? -EIO : 0;
 }
 EXPORT_SYMBOL_GPL(xive_native_enable_vp);
 
 int xive_native_disable_vp(u32 vp_id)
 {
-	s64 rc;
+	s64 rc = OPAL_BUSY;
 
-	for (;;) {
+	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_xive_set_vp_info(vp_id, 0, 0);
-		if (rc != OPAL_BUSY)
-			break;
-		msleep(1);
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
+			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 	return rc ? -EIO : 0;
 }
-- 
2.17.0
