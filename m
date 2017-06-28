Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyTtd4RbtzDr4c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:14:49 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5SHDlf4135229
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 13:14:48 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bcfq6jr6u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 13:14:47 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 13:14:46 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Hannes Reinecke <hare@suse.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Subject: [PATCH 3/3] cxlflash: Update debug prints in reset handlers
Date: Wed, 28 Jun 2017 12:14:37 -0500
In-Reply-To: <1498669929-39684-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1498669929-39684-1-git-send-email-mrochs@linux.vnet.ibm.com>
Message-Id: <1498670077-39845-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The device and host reset handler contain debug prints to help
identify the entities being reset. Today these reset handlers
are based on a SCSI EH design that uses a SCSI command reference
as a means of identifying the target entity. As such, the debug
trace includes the SCSI command pointer and associated CDB. This
is not necessary as the SCSI command is simply the messenger in
these scenarios.

Refactor the debug prints in the host and reset handlers to only
present information that is applicable given the function scope.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 7054e11..077f62e 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -2435,14 +2435,8 @@ static int cxlflash_eh_device_reset_handler(struct scsi_cmnd *scp)
 	struct device *dev = &cfg->dev->dev;
 	int rcr = 0;
 
-	dev_dbg(dev, "%s: (scp=%p) %d/%d/%d/%llu "
-		"cdb=(%08x-%08x-%08x-%08x)\n", __func__, scp, host->host_no,
-		sdev->channel, sdev->id, sdev->lun,
-		get_unaligned_be32(&((u32 *)scp->cmnd)[0]),
-		get_unaligned_be32(&((u32 *)scp->cmnd)[1]),
-		get_unaligned_be32(&((u32 *)scp->cmnd)[2]),
-		get_unaligned_be32(&((u32 *)scp->cmnd)[3]));
-
+	dev_dbg(dev, "%s: %d/%d/%d/%llu\n", __func__,
+		host->host_no, sdev->channel, sdev->id, sdev->lun);
 retry:
 	switch (cfg->state) {
 	case STATE_NORMAL:
@@ -2483,13 +2477,7 @@ static int cxlflash_eh_host_reset_handler(struct scsi_cmnd *scp)
 	struct cxlflash_cfg *cfg = shost_priv(host);
 	struct device *dev = &cfg->dev->dev;
 
-	dev_dbg(dev, "%s: (scp=%p) %d/%d/%d/%llu "
-		"cdb=(%08x-%08x-%08x-%08x)\n", __func__, scp, host->host_no,
-		scp->device->channel, scp->device->id, scp->device->lun,
-		get_unaligned_be32(&((u32 *)scp->cmnd)[0]),
-		get_unaligned_be32(&((u32 *)scp->cmnd)[1]),
-		get_unaligned_be32(&((u32 *)scp->cmnd)[2]),
-		get_unaligned_be32(&((u32 *)scp->cmnd)[3]));
+	dev_dbg(dev, "%s: %d\n", __func__, host->host_no);
 
 	switch (cfg->state) {
 	case STATE_NORMAL:
-- 
2.1.0
