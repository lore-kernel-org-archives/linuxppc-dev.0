Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0067.outbound.protection.outlook.com [104.47.40.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4M3NJgzDvVl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:51 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 08/17] soc/qman: Don't add a new platform device for dma
 mapping
Date: Wed, 16 Nov 2016 16:40:21 +0200
Message-ID: <1479307230-16650-9-git-send-email-claudiu.manoil@nxp.com>
In-Reply-To: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
References: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
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

The qman portals are platform devices themselves, so they should
handle dma mappings.  Creating a dummy platform device in order to
support dma mapping operations is not justified (and not portable).
Instead, do the mapping against the first portal that has been
initialised.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c        | 31 ++++++++++---------------------
 drivers/soc/fsl/qbman/qman_portal.c | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_priv.h   |  1 +
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index b4ef4a3..a0020d2 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -962,8 +962,6 @@ struct qman_portal {
 	u32 sdqcr;
 	/* probing time config params for cpu-affine portals */
 	const struct qm_portal_config *config;
-	/* needed for providing a non-NULL device to dma_map_***() */
-	struct platform_device *pdev;
 	/* 2-element array. cgrs[0] is mask, cgrs[1] is snapshot. */
 	struct qman_cgrs *cgrs;
 	/* linked-list of CSCN handlers. */
@@ -1133,7 +1131,6 @@ static int qman_create_portal(struct qman_portal *portal,
 			      const struct qman_cgrs *cgrs)
 {
 	struct qm_portal *p;
-	char buf[16];
 	int ret;
 	u32 isdr;
 
@@ -1196,15 +1193,6 @@ static int qman_create_portal(struct qman_portal *portal,
 	portal->sdqcr = QM_SDQCR_SOURCE_CHANNELS | QM_SDQCR_COUNT_UPTO3 |
 			QM_SDQCR_DEDICATED_PRECEDENCE | QM_SDQCR_TYPE_PRIO_QOS |
 			QM_SDQCR_TOKEN_SET(0xab) | QM_SDQCR_CHANNELS_DEDICATED;
-	sprintf(buf, "qportal-%d", c->channel);
-	portal->pdev = platform_device_alloc(buf, -1);
-	if (!portal->pdev)
-		goto fail_devalloc;
-	if (dma_set_mask(&portal->pdev->dev, DMA_BIT_MASK(40)))
-		goto fail_devadd;
-	ret = platform_device_add(portal->pdev);
-	if (ret)
-		goto fail_devadd;
 	isdr = 0xffffffff;
 	qm_out(p, QM_REG_ISDR, isdr);
 	portal->irq_sources = 0;
@@ -1256,10 +1244,6 @@ static int qman_create_portal(struct qman_portal *portal,
 fail_affinity:
 	free_irq(c->irq, portal);
 fail_irq:
-	platform_device_del(portal->pdev);
-fail_devadd:
-	platform_device_put(portal->pdev);
-fail_devalloc:
 	kfree(portal->cgrs);
 fail_cgrs:
 	qm_mc_finish(p);
@@ -1321,9 +1305,6 @@ static void qman_destroy_portal(struct qman_portal *qm)
 	qm_dqrr_finish(&qm->p);
 	qm_eqcr_finish(&qm->p);
 
-	platform_device_del(qm->pdev);
-	platform_device_put(qm->pdev);
-
 	qm->config = NULL;
 }
 
@@ -1817,8 +1798,16 @@ int qman_init_fq(struct qman_fq *fq, u32 flags, struct qm_mcc_initfq *opts)
 			memset(&mcc->initfq.fqd.context_a, 0,
 				sizeof(mcc->initfq.fqd.context_a));
 		} else {
-			phys_fq = dma_map_single(&p->pdev->dev, fq, sizeof(*fq),
-						 DMA_TO_DEVICE);
+			struct qman_portal *p = qman_dma_portal;
+
+			phys_fq = dma_map_single(p->config->dev, fq,
+						 sizeof(*fq), DMA_TO_DEVICE);
+			if (dma_mapping_error(p->config->dev, phys_fq)) {
+				dev_err(p->config->dev, "dma_mapping failed\n");
+				ret = -EIO;
+				goto out;
+			}
+
 			qm_fqd_stashing_set64(&mcc->initfq.fqd, phys_fq);
 		}
 	}
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index 6651168..e6da2ea 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -30,6 +30,8 @@
 
 #include "qman_priv.h"
 
+struct qman_portal *qman_dma_portal;
+
 /* Enable portal interupts (as opposed to polling mode) */
 #define CONFIG_FSL_DPA_PIRQ_SLOW  1
 #define CONFIG_FSL_DPA_PIRQ_FAST  1
@@ -150,6 +152,10 @@ static struct qman_portal *init_pcfg(struct qm_portal_config *pcfg)
 		/* all assigned portals are initialized now */
 		qman_init_cgr_all();
 	}
+
+	if (!qman_dma_portal)
+		qman_dma_portal = p;
+
 	spin_unlock(&qman_lock);
 
 	dev_info(pcfg->dev, "Portal initialised, cpu %d\n", pcfg->cpu);
@@ -310,6 +316,11 @@ static int qman_portal_probe(struct platform_device *pdev)
 	spin_unlock(&qman_lock);
 	pcfg->cpu = cpu;
 
+	if (dma_set_mask(dev, DMA_BIT_MASK(40))) {
+		dev_err(dev, "dma_set_mask() failed\n");
+		goto err_portal_init;
+	}
+
 	if (!init_pcfg(pcfg)) {
 		dev_err(dev, "portal init failed\n");
 		goto err_portal_init;
diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
index 5cf821e..59b4b46 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -367,5 +367,6 @@ struct qman_portal *qman_create_affine_portal(
 #define QM_PIRQ_VISIBLE	(QM_PIRQ_SLOW | QM_PIRQ_DQRI)
 
 extern struct qman_portal *affine_portals[NR_CPUS];
+extern struct qman_portal *qman_dma_portal;
 const struct qm_portal_config *qman_get_qm_portal_config(
 						struct qman_portal *portal);
-- 
1.7.11.7
