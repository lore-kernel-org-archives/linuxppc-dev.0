Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPf1r3cjXzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 14:40:48 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1H3cUAB019996
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:40:46 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28nnyapvv1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:40:46 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 20:40:45 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH] cxlflash: Enable PCI device ID for future IBM CXL Flash AFU
Date: Thu, 16 Feb 2017 21:39:32 -0600
Message-Id: <1487302772-7683-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>

Add support for a future IBM Coherent Accelerator (CXL) flash
AFU with an ID of 0x0624.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 4 ++++
 drivers/scsi/cxlflash/main.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 7069639..3061d80 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -2259,6 +2259,8 @@ static struct dev_dependent_vals dev_corsa_vals = { CXLFLASH_MAX_SECTORS,
 					0ULL };
 static struct dev_dependent_vals dev_flash_gt_vals = { CXLFLASH_MAX_SECTORS,
 					CXLFLASH_NOTIFY_SHUTDOWN };
+static struct dev_dependent_vals dev_briard_vals = { CXLFLASH_MAX_SECTORS,
+					CXLFLASH_NOTIFY_SHUTDOWN };
 
 /*
  * PCI device binding table
@@ -2268,6 +2270,8 @@ static struct pci_device_id cxlflash_pci_table[] = {
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, (kernel_ulong_t)&dev_corsa_vals},
 	{PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_FLASH_GT,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, (kernel_ulong_t)&dev_flash_gt_vals},
+	{PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_BRIARD,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, (kernel_ulong_t)&dev_briard_vals},
 	{}
 };
 
diff --git a/drivers/scsi/cxlflash/main.h b/drivers/scsi/cxlflash/main.h
index e43545c..0be2261 100644
--- a/drivers/scsi/cxlflash/main.h
+++ b/drivers/scsi/cxlflash/main.h
@@ -25,6 +25,7 @@
 
 #define PCI_DEVICE_ID_IBM_CORSA		0x04F0
 #define PCI_DEVICE_ID_IBM_FLASH_GT	0x0600
+#define PCI_DEVICE_ID_IBM_BRIARD	0x0624
 
 /* Since there is only one target, make it 0 */
 #define CXLFLASH_TARGET		0
-- 
2.1.0
