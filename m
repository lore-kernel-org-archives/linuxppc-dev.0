Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB8681A0311
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 08:57:19 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 14:57:17 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E86383E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 14:57:14 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24LvEfm29098010
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 21:57:14 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24LqtXl028522
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 16:52:57 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 1/7] cxlflash: Simplify PCI registration
Date: Fri,  4 Mar 2016 15:55:14 -0600
Message-Id: <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
In-Reply-To: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>

The calls to pci_request_regions(), pci_resource_start(),
pci_set_dma_mask(), pci_set_master() and pci_save_state() are all
unnecessary for the IBM CXL flash adapter since data buffers
are not required to be mapped to the device's memory.

The use of services such as pci_set_dma_mask() are problematic on
hypervisor managed systems as the IBM CXL flash adapter is operating
under a virtual PCI Host Bridge (virtual PHB) which does not support
these services.

cxlflash 0001:00:00.0: init_pci: Failed to set PCI DMA mask rc=-5

The resolution is to simplify init_pci(), to a point where it does the
bare minimum (pci_enable_device). Similarly, remove the call the
pci_release_regions() from cxlflash_remove().

Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 54 +-------------------------------------------
 1 file changed, 1 insertion(+), 53 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index f6d90ce..3dbb9fa 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -767,7 +767,6 @@ static void cxlflash_remove(struct pci_dev *pdev)
 		cancel_work_sync(&cfg->work_q);
 		term_afu(cfg);
 	case INIT_STATE_PCI:
-		pci_release_regions(cfg->dev);
 		pci_disable_device(pdev);
 	case INIT_STATE_NONE:
 		free_mem(cfg);
@@ -840,15 +839,6 @@ static int init_pci(struct cxlflash_cfg *cfg)
 	struct pci_dev *pdev = cfg->dev;
 	int rc = 0;
 
-	cfg->cxlflash_regs_pci = pci_resource_start(pdev, 0);
-	rc = pci_request_regions(pdev, CXLFLASH_NAME);
-	if (rc < 0) {
-		dev_err(&pdev->dev,
-			"%s: Couldn't register memory range of registers\n",
-			__func__);
-		goto out;
-	}
-
 	rc = pci_enable_device(pdev);
 	if (rc || pci_channel_offline(pdev)) {
 		if (pci_channel_offline(pdev)) {
@@ -860,55 +850,13 @@ static int init_pci(struct cxlflash_cfg *cfg)
 			dev_err(&pdev->dev, "%s: Cannot enable adapter\n",
 				__func__);
 			cxlflash_wait_for_pci_err_recovery(cfg);
-			goto out_release_regions;
-		}
-	}
-
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (rc < 0) {
-		dev_dbg(&pdev->dev, "%s: Failed to set 64 bit PCI DMA mask\n",
-			__func__);
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	}
-
-	if (rc < 0) {
-		dev_err(&pdev->dev, "%s: Failed to set PCI DMA mask\n",
-			__func__);
-		goto out_disable;
-	}
-
-	pci_set_master(pdev);
-
-	if (pci_channel_offline(pdev)) {
-		cxlflash_wait_for_pci_err_recovery(cfg);
-		if (pci_channel_offline(pdev)) {
-			rc = -EIO;
-			goto out_msi_disable;
+			goto out;
 		}
 	}
 
-	rc = pci_save_state(pdev);
-
-	if (rc != PCIBIOS_SUCCESSFUL) {
-		dev_err(&pdev->dev, "%s: Failed to save PCI config space\n",
-			__func__);
-		rc = -EIO;
-		goto cleanup_nolog;
-	}
-
 out:
 	pr_debug("%s: returning rc=%d\n", __func__, rc);
 	return rc;
-
-cleanup_nolog:
-out_msi_disable:
-	cxlflash_wait_for_pci_err_recovery(cfg);
-out_disable:
-	pci_disable_device(pdev);
-out_release_regions:
-	pci_release_regions(pdev);
-	goto out;
-
 }
 
 /**
-- 
2.1.0
