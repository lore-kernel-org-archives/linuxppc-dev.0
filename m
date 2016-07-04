Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjdWY2S4YzDqp7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:12:41 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6479LmG064875
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 03:12:38 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23yfe85er6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 03:12:37 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 4 Jul 2016 17:12:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DDC7F357805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:12:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u647CVrj15138990
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 17:12:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u647CVU9025852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 17:12:31 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, mrochs@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
 manoj@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com
Subject: [PATCH] cxl: remove dead Kconfig options
Date: Mon,  4 Jul 2016 17:12:14 +1000
Message-Id: <1467616334-20977-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the CXL_KERNEL_API and CXL_EEH Kconfig options, as they were only
needed to coordinate the merging of the cxlflash driver. Also remove the
stub implementation of cxl_perst_reloads_same_image() in cxlflash which is
only used if CXL_EEH isn't defined (i.e. never).

Suggested-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Applies on top of powerpc#next
---
 drivers/misc/cxl/Kconfig     | 10 ----------
 drivers/scsi/cxlflash/main.h |  4 ----
 2 files changed, 14 deletions(-)

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index 560412c..0cb10cf 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -7,14 +7,6 @@ config CXL_BASE
 	default n
 	select PPC_COPRO_BASE
 
-config CXL_KERNEL_API
-	bool
-	default n
-
-config CXL_EEH
-	bool
-	default n
-
 config CXL_AFU_DRIVER_OPS
 	bool
 	default n
@@ -23,8 +15,6 @@ config CXL
 	tristate "Support for IBM Coherent Accelerators (CXL)"
 	depends on PPC_POWERNV && PCI_MSI && EEH
 	select CXL_BASE
-	select CXL_KERNEL_API
-	select CXL_EEH
 	select CXL_AFU_DRIVER_OPS
 	default m
 	help
diff --git a/drivers/scsi/cxlflash/main.h b/drivers/scsi/cxlflash/main.h
index eb9d8f7..a893408 100644
--- a/drivers/scsi/cxlflash/main.h
+++ b/drivers/scsi/cxlflash/main.h
@@ -100,8 +100,4 @@ struct asyc_intr_info {
 #define SCAN_HOST	0x04
 };
 
-#ifndef CONFIG_CXL_EEH
-#define cxl_perst_reloads_same_image(_a, _b) do { } while (0)
-#endif
-
 #endif /* _CXLFLASH_MAIN_H */
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
