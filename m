Return-Path: <madalin.bucur@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GL1h2MsKzF3P8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 01:17:12 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: leoyang.li@nxp.com
Cc: roy.pledge@nxp.com, claudiu.manoil@nxp.com, catalin.marinas@arm.com,
 oss@buserror.net, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 1/4] soc/fsl/qbman: Check if CPU is offline when initializing
 portals
Date: Thu, 20 Sep 2018 18:06:48 +0300
Message-Id: <1537456011-10769-2-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roy Pledge <roy.pledge@nxp.com>

If the affine portal for a specific CPU is offline at boot time
affine its interrupt to CPU 0. If the CPU is later brought online
the hotplug handler will correctly adjust the affinity.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c | 17 +++++++++++++----
 drivers/soc/fsl/qbman/qman.c | 18 +++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index f9485cedc648..2e6e682bf16b 100644
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
index ecb22749df0b..7dbcb475a59c 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -935,7 +935,6 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
 			break;
 		udelay(1);
 	} while (--timeout);
-
 	return timeout;
 }
 
@@ -1210,10 +1209,19 @@ static int qman_create_portal(struct qman_portal *portal,
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
2.1.0
