Return-Path: <roy.pledge@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0079.outbound.protection.outlook.com [104.47.36.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYgtf3qvyzDql7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 06:32:41 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: <oss@buserror.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH] soc/fsl/qbman: Check if CPU is offline when initializing
 portals
Date: Thu, 25 May 2017 16:32:32 -0400
Message-ID: <1495744352-22476-1-git-send-email-roy.pledge@nxp.com>
Reply-To: <roy.pledge@nxp.com>
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
index 1fa9099..b72a92c 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -560,10 +560,19 @@ static int bman_create_portal(struct bman_portal *portal,
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
index aebcf16..b1b1268 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -941,7 +941,6 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
 			break;
 		udelay(1);
 	} while (--timeout);
-
 	return timeout;
 }
 
@@ -1218,10 +1217,19 @@ static int qman_create_portal(struct qman_portal *portal,
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
