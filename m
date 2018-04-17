Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QCyl6fdhzF22N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 15:11:27 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3H5ABqM112987
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 01:11:24 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hd7dcq32y-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 01:11:24 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 17 Apr 2018 06:11:22 +0100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
Subject: [PATCH] cxl: Configure PSL to not use APC virtual machines
Date: Tue, 17 Apr 2018 10:41:02 +0530
Message-Id: <20180417051102.7577-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

APC virtual machines arent used on POWER-9 chips and are already
disabled in on-chip CAPP. They also need to be disabled on the PSL via
'PSL Data Send Control Register' by setting bit(47). This forces the
PSL to send commands to CAPP with queue.id == 0.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index c32432168e6b..af30ee848d35 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -516,9 +516,9 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter,
 	cxl_p1_write(adapter, CXL_PSL9_FIR_CNTL, psl_fircntl);
 
 	/* Setup the PSL to transmit packets on the PCIe before the
-	 * CAPP is enabled
+	 * CAPP is enabled. Make sure that CAPP virtual machines are disabled
 	 */
-	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000002A10ULL);
+	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000012A10ULL);
 
 	/*
 	 * A response to an ASB_Notify request is returned by the
-- 
2.14.3
