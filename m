Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E90681A1700
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 09:55:17 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 10 Dec 2015 17:55:15 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2CA4F6E804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 17:43:23 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBAMtDEc25034762
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 22:55:13 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBAMtC4k013186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 17:55:13 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH 6/6] cxlflash: Enable device id for future IBM CXL adapter
Date: Thu, 10 Dec 2015 16:54:47 -0600
Message-Id: <1449788087-23282-1-git-send-email-ukrishn@linux.vnet.ibm.com>
In-Reply-To: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1449787867-23015-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Manoj Kumar <manoj@linux.vnet.ibm.com>

This drop enables a future card with a device id
of 0x0600 to be recognized by the cxlflash driver.
No card specific programming has been added. These
card specific changes will be staged in later.

Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 3 +++
 drivers/scsi/cxlflash/main.h | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 021b526..ec26b12 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -2309,6 +2309,7 @@ static struct scsi_host_template driver_template = {
  * Device dependent values
  */
 static struct dev_dependent_vals dev_corsa_vals = { CXLFLASH_MAX_SECTORS };
+static struct dev_dependent_vals dev_flash_gt_vals = { CXLFLASH_MAX_SECTORS };
 
 /*
  * PCI device binding table
@@ -2316,6 +2317,8 @@ static struct dev_dependent_vals dev_corsa_vals = { CXLFLASH_MAX_SECTORS };
 static struct pci_device_id cxlflash_pci_table[] = {
 	{PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_CORSA,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, (kernel_ulong_t)&dev_corsa_vals},
+	{PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_FLASH_GT,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, (kernel_ulong_t)&dev_flash_gt_vals},
 	{}
 };
 
diff --git a/drivers/scsi/cxlflash/main.h b/drivers/scsi/cxlflash/main.h
index ddc4a97..5d2c7ae 100644
--- a/drivers/scsi/cxlflash/main.h
+++ b/drivers/scsi/cxlflash/main.h
@@ -24,8 +24,8 @@
 #define CXLFLASH_ADAPTER_NAME	"IBM POWER CXL Flash Adapter"
 #define CXLFLASH_DRIVER_DATE	"(October 26, 2015)"
 
-#define PCI_DEVICE_ID_IBM_CORSA	0x04F0
-#define CXLFLASH_SUBS_DEV_ID	0x04F0
+#define PCI_DEVICE_ID_IBM_CORSA		0x04F0
+#define PCI_DEVICE_ID_IBM_FLASH_GT	0x0600
 
 /* Since there is only one target, make it 0 */
 #define CXLFLASH_TARGET		0
-- 
2.1.0
