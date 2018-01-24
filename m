Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR7vd345FzDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 13:11:41 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0O2AjIm064657
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 21:11:39 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fpfgwb0ta-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 21:11:38 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 23 Jan 2018 21:11:37 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, hare@suse.de,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info
Date: Tue, 23 Jan 2018 20:11:32 -0600
Message-Id: <1516759892-31245-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The fcp_rsp_info structure as defined in the FC spec has an initial 3 bytes
reserved field. The ibmvfc driver mistakenly defined this field as 4 bytes
resulting in the rsp_code field being defined in what should be the start of
the second reserved field and thus always being reported as zero by the
driver.

Ideally, we should wire ibmvfc up with libfc for the sake of code
deduplication, and ease of maintaining standardized structures in a single
place. However, for now simply fixup the definition in ibmvfc for
backporting to distros on older kernels. Wiring up with libfc will be done
in a followup patch.

Cc: stable@vger.kernel.org
Reported-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index 9a0696f..b81a53c 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -367,7 +367,7 @@ enum ibmvfc_fcp_rsp_info_codes {
 };
 
 struct ibmvfc_fcp_rsp_info {
-	__be16 reserved;
+	u8 reserved[3];
 	u8 rsp_code;
 	u8 reserved2[4];
 }__attribute__((packed, aligned (2)));
-- 
2.7.4
