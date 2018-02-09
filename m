Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd1mb52ZVzF193
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:09:51 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1948hH5081442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 23:09:49 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1108p902-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 23:09:48 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 04:09:44 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
Subject: [PATCH] cxl: Enable NORST bit in PSL_DEBUG register for PSL9
Date: Fri,  9 Feb 2018 09:39:16 +0530
Message-Id: <20180209040916.14250-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We enable the NORST bit by default for debug afu images to prevent
reset of AFU trace-data on a PCI link drop. For production AFU images
this bit is always ignored and PSL gets reconfigured anyways thereby
resetting the trace data. So setting this bit for non-debug images
doesn't have any impact.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 758842f65a1b..c983f23cc2ed 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -503,8 +503,12 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
 	if (cxl_is_power9_dd1()) {
 		/* Disabling deadlock counter CAR */
 		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0020000000000001ULL);
-	} else
-		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x4000000000000000ULL);
+		/* Enable NORST */
+		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x8000000000000000ULL);
+	} else {
+		/* Enable NORST and DD2 features */
+		cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0xC000000000000000ULL);
+	}
 
 	return 0;
 }
-- 
2.14.3
