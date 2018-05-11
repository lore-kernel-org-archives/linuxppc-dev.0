Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jKKt6cTszF2rx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 05:05:22 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4BIxwlL008264
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:05:20 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hwdkq8rvj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:05:19 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 11 May 2018 15:05:19 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 2/7] cxlflash: Limit the debug logs in the IO path
Date: Fri, 11 May 2018 14:05:08 -0500
In-Reply-To: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1526065508-38897-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel log can get filled with debug messages from send_cmd_ioarrin()
when dynamic debug is enabled for the cxlflash module and there is a lot
of legacy I/O traffic.

While these messages are necessary to debug issues that involve command
tracking, the abundance of data can overwrite other useful data in the
log. The best option available is to limit the messages that should
serve most of the common use cases.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index dad2be6..cf0b407 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -339,8 +339,8 @@ static int send_cmd_ioarrin(struct afu *afu, struct afu_cmd *cmd)
 	writeq_be((u64)&cmd->rcb, &hwq->host_map->ioarrin);
 out:
 	spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
-	dev_dbg(dev, "%s: cmd=%p len=%u ea=%016llx rc=%d\n", __func__,
-		cmd, cmd->rcb.data_len, cmd->rcb.data_ea, rc);
+	dev_dbg_ratelimited(dev, "%s: cmd=%p len=%u ea=%016llx rc=%d\n",
+		__func__, cmd, cmd->rcb.data_len, cmd->rcb.data_ea, rc);
 	return rc;
 }
 
-- 
2.1.0
