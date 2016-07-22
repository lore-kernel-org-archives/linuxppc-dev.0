Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwl8Z4vKtzDrKf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 19:04:45 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6M945Hr142168
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 05:04:43 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24athdue22-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 05:04:43 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 22 Jul 2016 19:04:41 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1094A2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 19:04:39 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6M94cWp26083450
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 19:04:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6M94cJh004374
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 19:04:38 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 clombard@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com
Subject: [PATCH] cxl: fix sparse warnings
Date: Fri, 22 Jul 2016 19:01:36 +1000
Message-Id: <1469178096-8510-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make native_irq_wait() static and use NULL rather than 0 to initialise
phb->cfg_data in cxl_pci_vphb_add() to remove sparse warnings.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/native.c | 2 +-
 drivers/misc/cxl/vphb.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 3bcdaee..e606fdc 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -924,7 +924,7 @@ static irqreturn_t native_irq_multiplexed(int irq, void *data)
 	return fail_psl_irq(afu, &irq_info);
 }
 
-void native_irq_wait(struct cxl_context *ctx)
+static void native_irq_wait(struct cxl_context *ctx)
 {
 	u64 dsisr;
 	int timeout = 1000;
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index dee8def..7ada5f1 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -221,7 +221,7 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
 	/* Setup the PHB using arch provided callback */
 	phb->ops = &cxl_pcie_pci_ops;
 	phb->cfg_addr = NULL;
-	phb->cfg_data = 0;
+	phb->cfg_data = NULL;
 	phb->private_data = afu;
 	phb->controller_ops = cxl_pci_controller_ops;
 
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
