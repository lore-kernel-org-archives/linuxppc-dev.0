Return-Path: <roy.pledge@nxp.com>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03on0628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe09::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVg6k74mCzDr6N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 06:48:28 +1100 (AEDT)
From: Roy Pledge <roy.pledge@nxp.com>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com
Cc: madalin.bucur@nxp.com,
	Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH] soc/fsl/qbman: Check if CPU is offline when initializing
 portals
Date: Mon, 29 Jan 2018 14:47:53 -0500
Message-Id: <1517255273-10178-1-git-send-email-roy.pledge@nxp.com>
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the affine portal for a specific CPU is offline at boot time
affine its interrupt to CPU 0. If the CPU is later brought online
the hotplug handler will correctly adjust the affinity.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c | 17 +++++++++++++----
 drivers/soc/fsl/qbman/qman.c | 18 +++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index f9485ce..2e6e682 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -562,10 +562,19 @@ static int bman_create_portal(struct bman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
-		goto fail_affinity;
+	if (cpu_online(c->cpu) && c->cpu != -1 &&
+	    irq_can_set_affinity(c->irq)) {
+		if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
+			dev_err(c->dev, "irq_set_affinity() failed %d\n",
+				c->cpu);
+			goto fail_affinity;
+		}
+	} else {
+		/* CPU is offline, direct IRQ to CPU 0 */
+		if (irq_set_affinity(c->irq, cpumask_of(0))) {
+			dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
+			goto fail_affinity;
+		}
 	}
 
 	/* Need RCR to be empty before continuing */
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index e4f5bb0..463e65d 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -935,7 +935,6 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
 			break;
 		udelay(1);
 	} while (--timeout);
-
 	return timeout;
 }
 
@@ -1209,10 +1208,19 @@ static int qman_create_portal(struct qman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
-		goto fail_affinity;
+	if (cpu_online(c->cpu) && c->cpu != -1 &&
+	    irq_can_set_affinity(c->irq)) {
+		if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
+			dev_err(c->dev, "irq_set_affinity() failed %d\n",
+				c->cpu);
+			goto fail_affinity;
+		}
+	} else {
+		/* CPU is offline, direct IRQ to CPU 0 */
+		if (irq_set_affinity(c->irq, cpumask_of(0))) {
+			dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
+			goto fail_affinity;
+		}
 	}
 
 	/* Need EQCR to be empty before continuing */
-- 
2.7.4
