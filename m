Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYsxr75P8zDvk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 09:05:36 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB7M06Xj084697
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 17:05:34 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 276tc39cm1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 17:05:34 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 7 Dec 2016 15:05:33 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 2/2] ibmvscsi: log bad SRP response opcode in hex format
Date: Wed,  7 Dec 2016 16:04:36 -0600
In-Reply-To: <1481148276-5083-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1481148276-5083-1-git-send-email-tyreld@linux.vnet.ibm.com>
Message-Id: <1481148276-5083-2-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An unrecogonized or unsupported SRP response has its opcode currently
logged in decimal format. Log it in hex format instead so it can easily
be validated against the SRP specs values which are in hex.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index a0ee16f..7752656 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -993,7 +993,7 @@ static void handle_cmd_rsp(struct srp_event_struct *evt_struct)
 	if (unlikely(rsp->opcode != SRP_RSP)) {
 		if (printk_ratelimit())
 			dev_warn(evt_struct->hostdata->dev,
-				 "bad SRP RSP type %d\n", rsp->opcode);
+				 "bad SRP RSP type %#02x\n", rsp->opcode);
 	}
 	
 	if (cmnd) {
-- 
1.8.3.1
