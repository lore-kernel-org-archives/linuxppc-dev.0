Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9CBA1A0BBE
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 08:57:35 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 16:57:33 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DA3C8C90042
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 16:57:26 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24LvUNF26411070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 21:57:30 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24LrCKF028934
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 16:53:12 -0500
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
Subject: [PATCH 2/7] cxlflash: Unmap problem state area before detaching
 master context
Date: Fri,  4 Mar 2016 15:55:15 -0600
Message-Id: <1457128520-53056-2-git-send-email-ukrishn@linux.vnet.ibm.com>
In-Reply-To: <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When operating in the PowerVM environment, the cxlflash module can
receive an error from the hypervisor indicating that there are
existing mappings in the page table for the process MMIO space.

This issue exists because term_afu() currently invokes term_mc()
before stop_afu(), allowing for the master context to be detached
first and the problem state area to be unmapped second.

To resolve this issue, stop_afu() should be called before term_mc().

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 3dbb9fa..ca702d8 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -726,11 +726,11 @@ static void term_mc(struct cxlflash_cfg *cfg, enum undo_level level)
  */
 static void term_afu(struct cxlflash_cfg *cfg)
 {
-	term_mc(cfg, UNDO_START);
-
 	if (cfg->afu)
 		stop_afu(cfg);
 
+	term_mc(cfg, UNDO_START);
+
 	pr_debug("%s: returning\n", __func__);
 }
 
@@ -2492,8 +2492,8 @@ static pci_ers_result_t cxlflash_pci_error_detected(struct pci_dev *pdev,
 		if (unlikely(rc))
 			dev_err(dev, "%s: Failed to mark user contexts!(%d)\n",
 				__func__, rc);
-		term_mc(cfg, UNDO_START);
 		stop_afu(cfg);
+		term_mc(cfg, UNDO_START);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		cfg->state = STATE_FAILTERM;
-- 
2.1.0
