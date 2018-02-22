Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTS95jgSzF1k8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:24:57 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MMO3Sb000978
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:24:55 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ga268hsf5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:24:55 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 15:24:54 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 16/38] cxlflash: MMIO map the AFU
Date: Thu, 22 Feb 2018 16:24:48 -0600
In-Reply-To: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519338288-52362-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the AFU is configured, the global and per process MMIO regions
are presented by the configuration space. Save these regions and
map the global MMIO region that is used to access all of the control
and provisioning data in the AFU.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 74 ++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/cxlflash/ocxl_hw.h |  4 +++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 6f78e71..824d789 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -264,6 +264,18 @@ static void ocxlflash_perst_reloads_same_image(void *afu_cookie, bool image)
 }
 
 /**
+ * ocxlflash_unconfig_afu() - unconfigure the AFU
+ * @afu: AFU associated with the host.
+ */
+static void ocxlflash_unconfig_afu(struct ocxl_hw_afu *afu)
+{
+	if (afu->gmmio_virt) {
+		iounmap(afu->gmmio_virt);
+		afu->gmmio_virt = NULL;
+	}
+}
+
+/**
  * ocxlflash_destroy_afu() - destroy the AFU structure
  * @afu_cookie:	AFU to be freed.
  */
@@ -276,6 +288,7 @@ static void ocxlflash_destroy_afu(void *afu_cookie)
 
 	ocxlflash_release_context(afu->ocxl_ctx);
 	idr_destroy(&afu->idr);
+	ocxlflash_unconfig_afu(afu);
 	kfree(afu);
 }
 
@@ -324,6 +337,56 @@ static int ocxlflash_config_fn(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
 }
 
 /**
+ * ocxlflash_map_mmio() - map the AFU MMIO space
+ * @afu: AFU associated with the host.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int ocxlflash_map_mmio(struct ocxl_hw_afu *afu)
+{
+	struct ocxl_afu_config *acfg = &afu->acfg;
+	struct pci_dev *pdev = afu->pdev;
+	struct device *dev = afu->dev;
+	phys_addr_t gmmio, ppmmio;
+	int rc = 0;
+
+	rc = pci_request_region(pdev, acfg->global_mmio_bar, "ocxlflash");
+	if (unlikely(rc)) {
+		dev_err(dev, "%s: pci_request_region for global failed rc=%d\n",
+			__func__, rc);
+		goto out;
+	}
+	gmmio = pci_resource_start(pdev, acfg->global_mmio_bar);
+	gmmio += acfg->global_mmio_offset;
+
+	rc = pci_request_region(pdev, acfg->pp_mmio_bar, "ocxlflash");
+	if (unlikely(rc)) {
+		dev_err(dev, "%s: pci_request_region for pp bar failed rc=%d\n",
+			__func__, rc);
+		goto err1;
+	}
+	ppmmio = pci_resource_start(pdev, acfg->pp_mmio_bar);
+	ppmmio += acfg->pp_mmio_offset;
+
+	afu->gmmio_virt = ioremap(gmmio, acfg->global_mmio_size);
+	if (unlikely(!afu->gmmio_virt)) {
+		dev_err(dev, "%s: MMIO mapping failed\n", __func__);
+		rc = -ENOMEM;
+		goto err2;
+	}
+
+	afu->gmmio_phys = gmmio;
+	afu->ppmmio_phys = ppmmio;
+out:
+	return rc;
+err2:
+	pci_release_region(pdev, acfg->pp_mmio_bar);
+err1:
+	pci_release_region(pdev, acfg->global_mmio_bar);
+	goto out;
+}
+
+/**
  * ocxlflash_config_afu() - configure the host AFU
  * @pdev:	PCI device associated with the host.
  * @afu:	AFU associated with the host.
@@ -362,6 +425,13 @@ static int ocxlflash_config_afu(struct pci_dev *pdev, struct ocxl_hw_afu *afu)
 	afu->max_pasid = 1 << acfg->pasid_supported_log;
 
 	ocxl_config_set_afu_pasid(pdev, pos, 0, acfg->pasid_supported_log);
+
+	rc = ocxlflash_map_mmio(afu);
+	if (unlikely(rc)) {
+		dev_err(dev, "%s: ocxlflash_map_mmio failed rc=%d\n",
+			__func__, rc);
+		goto out;
+	}
 out:
 	return rc;
 }
@@ -407,13 +477,15 @@ static void *ocxlflash_create_afu(struct pci_dev *pdev)
 		rc = PTR_ERR(ctx);
 		dev_err(dev, "%s: ocxlflash_dev_context_init failed rc=%d\n",
 			__func__, rc);
-		goto err1;
+		goto err2;
 	}
 
 	idr_init(&afu->idr);
 	afu->ocxl_ctx = ctx;
 out:
 	return afu;
+err2:
+	ocxlflash_unconfig_afu(afu);
 err1:
 	kfree(afu);
 	afu = NULL;
diff --git a/drivers/scsi/cxlflash/ocxl_hw.h b/drivers/scsi/cxlflash/ocxl_hw.h
index 6d6e323..fbe9741 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.h
+++ b/drivers/scsi/cxlflash/ocxl_hw.h
@@ -27,6 +27,10 @@ struct ocxl_hw_afu {
 	int afu_actag_base;		/* AFU acTag base */
 	int afu_actag_enabled;		/* AFU acTag number enabled */
 
+	phys_addr_t ppmmio_phys;	/* Per process MMIO space */
+	phys_addr_t gmmio_phys;		/* Global AFU MMIO space */
+	void __iomem *gmmio_virt;	/* Global MMIO map */
+
 	struct idr idr;			/* IDR to manage contexts */
 	int max_pasid;			/* Maximum number of contexts */
 };
-- 
2.1.0
