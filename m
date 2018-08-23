Return-Path: <alexandre.belloni@bootlin.com>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 41xHlz00QyzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 07:36:10 +1000 (AEST)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Li Yang <leoyang.li@nxp.com>
Cc: Roy Pledge <roy.pledge@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman is
 not available
Date: Thu, 23 Aug 2018 23:35:59 +0200
Message-Id: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the qman driver (qman_ccsr) doesn't probe or fail to probe before
qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
unmapped page.

This leads to a crash when probing  qman_portal as the init_pcfg function
calls qman_liodn_fixup that tries to read qman registers.

Assume that qman didn't probe when the pool mask is 0.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index a120002b630e..4fc80d2c8feb 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 
 	pcfg->pools = qm_get_pools_sdqcr();
+	if (pcfg->pools == 0)
+		return -EPROBE_DEFER;
 
 	spin_lock(&qman_lock);
 	cpu = cpumask_next_zero(-1, &portal_cpus);
-- 
2.18.0
