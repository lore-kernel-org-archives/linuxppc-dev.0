Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C9C81A0AD3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 07:15:32 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 14:15:30 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1E77E3E40048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 14:15:28 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9LKFStV8782186
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:15:28 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9LKFQXx003188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 14:15:27 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 19/37] cxlflash: Correct usage of scsi_host_put()
Date: Wed, 21 Oct 2015 15:14:09 -0500
Message-Id: <1445458449-22858-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
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
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index c1d5c88..6b8b159 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -733,7 +733,6 @@ static void cxlflash_remove(struct pci_dev *pdev)
 	case INIT_STATE_SCSI:
 		cxlflash_term_local_luns(cfg);
 		scsi_remove_host(cfg->host);
-		scsi_host_put(cfg->host);
 		/* Fall through */
 	case INIT_STATE_AFU:
 		term_afu(cfg);
@@ -743,6 +742,7 @@ static void cxlflash_remove(struct pci_dev *pdev)
 	case INIT_STATE_NONE:
 		flush_work(&cfg->work_q);
 		free_mem(cfg);
+		scsi_host_put(cfg->host);
 		break;
 	}
 
@@ -2404,6 +2404,7 @@ static int cxlflash_probe(struct pci_dev *pdev,
 		dev_err(&pdev->dev, "%s: call to scsi_host_alloc failed!\n",
 			__func__);
 		rc = -ENOMEM;
+		scsi_host_put(cfg->host);
 		goto out;
 	}
 
-- 
2.1.0
