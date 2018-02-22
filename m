Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTPm2ZGKzF1h3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:22:52 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MMLl0F143259
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:22:50 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ga268hqvk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:22:50 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 15:22:49 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 04/38] cxlflash: Introduce OpenCXL backend
Date: Thu, 22 Feb 2018 16:22:43 -0600
In-Reply-To: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519338163-51928-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add initial infrastructure to support a new cxlflash transport, OpenCXL.

Claim a dependency on OpenCXL (OCXL) and add a new file, ocxl_hw.c, which
will host the backend routines that are specific to OpenCXL.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/Kconfig   |  2 +-
 drivers/scsi/cxlflash/Makefile  |  2 +-
 drivers/scsi/cxlflash/backend.h |  1 +
 drivers/scsi/cxlflash/ocxl_hw.c | 22 ++++++++++++++++++++++
 4 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 drivers/scsi/cxlflash/ocxl_hw.c

diff --git a/drivers/scsi/cxlflash/Kconfig b/drivers/scsi/cxlflash/Kconfig
index a011c5d..e2a3a1b 100644
--- a/drivers/scsi/cxlflash/Kconfig
+++ b/drivers/scsi/cxlflash/Kconfig
@@ -4,7 +4,7 @@
 
 config CXLFLASH
 	tristate "Support for IBM CAPI Flash"
-	depends on PCI && SCSI && CXL && EEH
+	depends on PCI && SCSI && CXL && OCXL && EEH
 	select IRQ_POLL
 	default m
 	help
diff --git a/drivers/scsi/cxlflash/Makefile b/drivers/scsi/cxlflash/Makefile
index 7ec3f6b..5124c68 100644
--- a/drivers/scsi/cxlflash/Makefile
+++ b/drivers/scsi/cxlflash/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_CXLFLASH) += cxlflash.o
-cxlflash-y += main.o superpipe.o lunmgt.o vlun.o cxl_hw.o
+cxlflash-y += main.o superpipe.o lunmgt.o vlun.o cxl_hw.o ocxl_hw.o
diff --git a/drivers/scsi/cxlflash/backend.h b/drivers/scsi/cxlflash/backend.h
index 7b72149..a60f051 100644
--- a/drivers/scsi/cxlflash/backend.h
+++ b/drivers/scsi/cxlflash/backend.h
@@ -13,6 +13,7 @@
  */
 
 extern const struct cxlflash_backend_ops cxlflash_cxl_ops;
+extern const struct cxlflash_backend_ops cxlflash_ocxl_ops;
 
 struct cxlflash_backend_ops {
 	struct module *module;
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
new file mode 100644
index 0000000..58a3182
--- /dev/null
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -0,0 +1,22 @@
+/*
+ * CXL Flash Device Driver
+ *
+ * Written by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>, IBM Corporation
+ *             Uma Krishnan <ukrishn@linux.vnet.ibm.com>, IBM Corporation
+ *
+ * Copyright (C) 2018 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <misc/ocxl.h>
+
+#include "backend.h"
+
+/* Backend ops to ocxlflash services */
+const struct cxlflash_backend_ops cxlflash_ocxl_ops = {
+	.module			= THIS_MODULE,
+};
-- 
2.1.0
