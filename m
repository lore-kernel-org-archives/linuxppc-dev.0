Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D17BB1A1748
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 08:08:21 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 14:08:19 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 21B1AC40001
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 13:56:28 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBEL8HVN32112680
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 14:08:17 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBEL8Gln010147
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 14:08:17 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>
Subject: [PATCH v2 6/6] cxlflash: Enable device id for future IBM CXL adapter
Date: Mon, 14 Dec 2015 15:07:43 -0600
Message-Id: <1450127263-48261-1-git-send-email-ukrishn@linux.vnet.ibm.com>
In-Reply-To: <1450126293-47440-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1450126293-47440-1-git-send-email-ukrishn@linux.vnet.ibm.com>
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

As per the design, the Accelerator Function Unit (AFU)
for this new IBM CXL Flash Adapter retains the same
host interface as the previous generation. For the early
prototypes of the new card, the driver with this change
behaves exactly as the driver prior to this behaved with
the earlier generation card. Therefore, no card specific
programming has been added. These card specific changes
can be staged in later if needed.

Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 3 +++
 drivers/scsi/cxlflash/main.h | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 30542ca..f6d90ce 100644
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
index 7e2d0e1..0faed42 100644
--- a/drivers/scsi/cxlflash/main.h
+++ b/drivers/scsi/cxlflash/main.h
@@ -23,8 +23,8 @@
 #define CXLFLASH_NAME		"cxlflash"
 #define CXLFLASH_ADAPTER_NAME	"IBM POWER CXL Flash Adapter"
 
-#define PCI_DEVICE_ID_IBM_CORSA	0x04F0
-#define CXLFLASH_SUBS_DEV_ID	0x04F0
+#define PCI_DEVICE_ID_IBM_CORSA		0x04F0
+#define PCI_DEVICE_ID_IBM_FLASH_GT	0x0600
 
 /* Since there is only one target, make it 0 */
 #define CXLFLASH_TARGET		0
-- 
2.1.0
