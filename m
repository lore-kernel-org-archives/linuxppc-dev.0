Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 268971A1E34
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 09:17:58 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 25 Sep 2015 19:17:56 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 93852C90045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 19:08:57 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8PNHsYF62783572
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 23:17:54 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8PNHr8K029977
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 19:17:54 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v4 20/32] cxlflash: Fix to prevent workq from accessing freed
 memory
Date: Fri, 25 Sep 2015 18:17:16 -0500
Message-Id: <1443223036-9694-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The workq can process work in parallel with a remove event, leading
to a condition where the workq handler can access freed memory.

To remedy, the workq should be terminated prior to freeing memory. Move
the termination call earlier in remove and use cancel_work_sync() instead
of flush_work() as there is not a need to process any scheduled work when
shutting down.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 0bb6629..fada355 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -736,11 +736,11 @@ static void cxlflash_remove(struct pci_dev *pdev)
 		/* Fall through */
 	case INIT_STATE_AFU:
 		term_afu(cfg);
+		cancel_work_sync(&cfg->work_q);
 	case INIT_STATE_PCI:
 		pci_release_regions(cfg->dev);
 		pci_disable_device(pdev);
 	case INIT_STATE_NONE:
-		flush_work(&cfg->work_q);
 		free_mem(cfg);
 		scsi_host_put(cfg->host);
 		break;
-- 
2.1.0
