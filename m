Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA11B1A1174
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 08:07:30 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 14:07:28 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9C61A1FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 13:55:36 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBEL7PKe29819054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 14:07:25 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBEL7Oap030755
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 14:07:25 -0700
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
Subject: [PATCH v2 3/6] cxlflash: Removed driver date print
Date: Mon, 14 Dec 2015 15:06:33 -0600
Message-Id: <1450127193-48109-1-git-send-email-ukrishn@linux.vnet.ibm.com>
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

Having a date for the driver requires it to be updated quite
often. Removing the date which is not necessary. Also made
use of the existing symbol to print the driver name.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 3 +--
 drivers/scsi/cxlflash/main.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 09fe252..35a3202 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -2585,8 +2585,7 @@ static struct pci_driver cxlflash_driver = {
  */
 static int __init init_cxlflash(void)
 {
-	pr_info("%s: IBM Power CXL Flash Adapter: %s\n",
-		__func__, CXLFLASH_DRIVER_DATE);
+	pr_info("%s: %s\n", __func__, CXLFLASH_ADAPTER_NAME);
 
 	cxlflash_list_init();
 
diff --git a/drivers/scsi/cxlflash/main.h b/drivers/scsi/cxlflash/main.h
index 6032456..7e2d0e1 100644
--- a/drivers/scsi/cxlflash/main.h
+++ b/drivers/scsi/cxlflash/main.h
@@ -22,7 +22,6 @@
 
 #define CXLFLASH_NAME		"cxlflash"
 #define CXLFLASH_ADAPTER_NAME	"IBM POWER CXL Flash Adapter"
-#define CXLFLASH_DRIVER_DATE	"(August 13, 2015)"
 
 #define PCI_DEVICE_ID_IBM_CORSA	0x04F0
 #define CXLFLASH_SUBS_DEV_ID	0x04F0
-- 
2.1.0
