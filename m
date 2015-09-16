Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0F831A2EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 03:00:35 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 11:00:34 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D2DA119D8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 10:51:25 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GGxFbJ3408146
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 09:59:23 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GGxwel005481
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 10:59:58 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 nab@linux-iscsi.org, brking@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 dja@ozlabs.au.ibm.com, andrew.donnellan@au1.ibm.com
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 20/30] cxlflash: Correct usage of scsi_host_put()
Date: Wed, 16 Sep 2015 11:59:09 -0500
Message-Id: <1442422749-41768-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, scsi_host_put() is being called prematurely in the
remove path and is missing entirely in an error cleanup path.
The former can lead to memory being freed too early with
subsequent access potentially corrupting data whilst the former
would result in a memory leak.

Move the usage on remove to be the last cleanup action taken
and introduce a call to scsi_host_put() in the one initialization
error path that does not use remove to cleanup.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index fc77cd4..1856a73 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -734,7 +734,6 @@ static void cxlflash_remove(struct pci_dev *pdev)
 	case INIT_STATE_SCSI:
 		cxlflash_term_local_luns(cfg);
 		scsi_remove_host(cfg->host);
-		scsi_host_put(cfg->host);
 		/* Fall through */
 	case INIT_STATE_AFU:
 		term_afu(cfg);
@@ -744,6 +743,7 @@ static void cxlflash_remove(struct pci_dev *pdev)
 	case INIT_STATE_NONE:
 		flush_work(&cfg->work_q);
 		free_mem(cfg);
+		scsi_host_put(cfg->host);
 		break;
 	}
 
@@ -2415,6 +2415,7 @@ static int cxlflash_probe(struct pci_dev *pdev,
 		dev_err(&pdev->dev, "%s: call to scsi_host_alloc failed!\n",
 			__func__);
 		rc = -ENOMEM;
+		scsi_host_put(cfg->host);
 		goto out;
 	}
 
-- 
2.1.0
