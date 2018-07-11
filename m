Return-Path: <eleon@br3ak3r.de>
Received: from Br3ak3r.de (unknown [IPv6:2a01:4f8:190:13a5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QtP24QvLzF35W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 08:03:18 +1000 (AEST)
From: Daniel Klamt <eleon@ele0n.de>
To: benh@kernel.crashing.org
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
 Daniel Klamt <eleon@ele0n.de>, Bjoern Noetel <bjoern@br3ak3r.de>
Subject: [PATCH] powerpc: Replaced msleep(x) with msleep(OPAL_BUSY_DELAY_MS)
Date: Thu, 12 Jul 2018 00:03:04 +0200
Message-Id: <1531346584-9157-1-git-send-email-eleon@ele0n.de>
In-Reply-To: <878t6hami4.fsf@concordia.ellerman.id.au>
References: <878t6hami4.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replaced msleep(x) with with msleep(OPAL_BUSY_DELAY_MS)
to diocument these sleep is to wait for opal.

Signed-off-by: Daniel Klamt <eleon@ele0n.de>
Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>
---
 arch/powerpc/sysdev/xive/native.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 311185b9960a..39ab5ad58297 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -109,7 +109,7 @@ int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
 		rc = opal_xive_set_irq_config(hw_irq, target, prio, sw_irq);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		msleep(OPAL_BUSY_DELAY_MS);
 	}
 	return rc == 0 ? 0 : -ENXIO;
 }
@@ -163,7 +163,7 @@ int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
 		rc = opal_xive_set_queue_info(vp_id, prio, qpage_phys, order, flags);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		msleep(OPAL_BUSY_DELAY_MS);
 	}
 	if (rc) {
 		pr_err("Error %lld setting queue for prio %d\n", rc, prio);
@@ -190,7 +190,7 @@ static void __xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio)
 		rc = opal_xive_set_queue_info(vp_id, prio, 0, 0, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		msleep(OPAL_BUSY_DELAY_MS);
 	}
 	if (rc)
 		pr_err("Error %lld disabling queue for prio %d\n", rc, prio);
@@ -253,7 +253,7 @@ static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
 	for (;;) {
 		irq = opal_xive_allocate_irq(chip_id);
 		if (irq == OPAL_BUSY) {
-			msleep(1);
+			msleep(OPAL_BUSY_DELAY_MS);
 			continue;
 		}
 		if (irq < 0) {
@@ -275,7 +275,7 @@ u32 xive_native_alloc_irq(void)
 		rc = opal_xive_allocate_irq(OPAL_XIVE_ANY_CHIP);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		msleep(OPAL_BUSY_DELAY_MS);
 	}
 	if (rc < 0)
 		return 0;
@@ -289,7 +289,7 @@ void xive_native_free_irq(u32 irq)
 		s64 rc = opal_xive_free_irq(irq);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		msleep(OPAL_BUSY_DELAY_MS);
 	}
 }
 EXPORT_SYMBOL_GPL(xive_native_free_irq);
@@ -305,7 +305,7 @@ static void xive_native_put_ipi(unsigned int cpu, struct xive_cpu *xc)
 	for (;;) {
 		rc = opal_xive_free_irq(xc->hw_ipi);
 		if (rc == OPAL_BUSY) {
-			msleep(1);
+			msleep(OPAL_BUSY_DELAY_MS);
 			continue;
 		}
 		xc->hw_ipi = 0;
@@ -400,7 +400,7 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
 		rc = opal_xive_set_vp_info(vp, OPAL_XIVE_VP_ENABLED, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		msleep(OPAL_BUSY_DELAY_MS);
 	}
 	if (rc) {
 		pr_err("Failed to enable pool VP on CPU %d\n", cpu);
@@ -444,7 +444,7 @@ static void xive_native_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
 		rc = opal_xive_set_vp_info(vp, 0, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		msleep(OPAL_BUSY_DELAY_MS);
 	}
 }
 
@@ -645,7 +645,7 @@ u32 xive_native_alloc_vp_block(u32 max_vcpus)
 		rc = opal_xive_alloc_vp_block(order);
 		switch (rc) {
 		case OPAL_BUSY:
-			msleep(1);
+			msleep(OPAL_BUSY_DELAY_MS);
 			break;
 		case OPAL_XIVE_PROVISIONING:
 			if (!xive_native_provision_pages())
@@ -687,7 +687,7 @@ int xive_native_enable_vp(u32 vp_id, bool single_escalation)
 		rc = opal_xive_set_vp_info(vp_id, flags, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		msleep(OPAL_BUSY_DELAY_MS);
 	}
 	return rc ? -EIO : 0;
 }
@@ -701,7 +701,7 @@ int xive_native_disable_vp(u32 vp_id)
 		rc = opal_xive_set_vp_info(vp_id, 0, 0);
 		if (rc != OPAL_BUSY)
 			break;
-		msleep(1);
+		msleep(OPAL_BUSY_DELAY_MS);
 	}
 	return rc ? -EIO : 0;
 }
-- 
2.11.0
