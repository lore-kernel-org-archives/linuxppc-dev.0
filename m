Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B1221A0B51
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 22:27:28 +1100 (AEDT)
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:27:24 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 77F0E2190023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:26:51 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24BR8aF7930156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:27:08 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24BR784007860
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 04:27:07 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 20/20] cxl: Remove cxl_get_phys_dev() kernel API
Date: Fri,  4 Mar 2016 12:26:44 +0100
Message-Id: <1457090804-9719-21-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cxl_get_phys_dev() API returns a struct device pointer which could
belong to either a struct pci_dev (bare-metal) or platform_device
(powerVM). To avoid potential problems in drivers, remove that API. It
was introduced to allow drivers to read the VPD of the adapter, but
the cxl driver now provides the cxl_pci_read_adapter_vpd() API for
that purpose.

Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c | 1 -
 include/misc/cxl.h     | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 75ec2f9..2107c94 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -76,7 +76,6 @@ struct device *cxl_get_phys_dev(struct pci_dev *dev)
 
 	return afu->adapter->dev.parent;
 }
-EXPORT_SYMBOL_GPL(cxl_get_phys_dev);
 
 int cxl_release_context(struct cxl_context *ctx)
 {
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 5bcf11a..7d5e261 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -30,9 +30,6 @@ struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev);
 /* Get the AFU conf record number associated with a pci_dev */
 unsigned int cxl_pci_to_cfg_record(struct pci_dev *dev);
 
-/* Get the physical device (ie. the PCIe card) which the AFU is attached */
-struct device *cxl_get_phys_dev(struct pci_dev *dev);
-
 
 /*
  * Context lifetime overview:
-- 
1.9.1
