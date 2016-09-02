Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQrbn13P1zDsMC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 06:40:20 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u82KavCx038374
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2016 16:40:19 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2575s3fhmu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Sep 2016 16:40:19 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 2 Sep 2016 14:40:18 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 4/6] cxlflash: Improve EEH recovery time
Date: Fri,  2 Sep 2016 15:40:03 -0500
In-Reply-To: <1472848612-64888-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1472848612-64888-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1472848803-65143-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>

When an EEH occurs during device initialization, the port timeout
logic can cause excessive delays as MMIO reads will fail. Depending
on where they are experienced, these delays can lead to a prolonged
reset, causing an unnecessary triggering of other timeout logic in
the SCSI stack or user applications.

To expedite recovery, the port timeout logic is updated to decay the
timeout at a much faster rate when in the presence of a likely EEH
frozen event.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 4ef5235..42970a4 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1040,6 +1040,8 @@ static int wait_port_online(__be64 __iomem *fc_regs, u32 delay_us, u32 nretry)
 	do {
 		msleep(delay_us / 1000);
 		status = readq_be(&fc_regs[FC_MTIP_STATUS / 8]);
+		if (status == U64_MAX)
+			nretry /= 2;
 	} while ((status & FC_MTIP_STATUS_MASK) != FC_MTIP_STATUS_ONLINE &&
 		 nretry--);
 
@@ -1071,6 +1073,8 @@ static int wait_port_offline(__be64 __iomem *fc_regs, u32 delay_us, u32 nretry)
 	do {
 		msleep(delay_us / 1000);
 		status = readq_be(&fc_regs[FC_MTIP_STATUS / 8]);
+		if (status == U64_MAX)
+			nretry /= 2;
 	} while ((status & FC_MTIP_STATUS_MASK) != FC_MTIP_STATUS_OFFLINE &&
 		 nretry--);
 
-- 
2.1.0
