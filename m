Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4F641A003D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 18:27:19 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 06/15] cxl: Add new header for call backs and structs
Date: Thu, 18 Sep 2014 18:26:51 +1000
Message-Id: <1411028820-29933-7-git-send-email-mikey@neuling.org>
In-Reply-To: <1411028820-29933-1-git-send-email-mikey@neuling.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This new header add defines for callbacks and structs needed by the rest of the
kernel to hook into the cxl infrastructure.

Empty functions are provided when CONFIG CXL_BASE is not enabled.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 include/misc/cxl.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/misc/cxl.h

diff --git a/include/misc/cxl.h b/include/misc/cxl.h
new file mode 100644
index 0000000..bde46a3
--- /dev/null
+++ b/include/misc/cxl.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2014 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _MISC_ASM_CXL_H
+#define _MISC_ASM_CXL_H
+
+#define CXL_IRQ_RANGES 4
+
+struct cxl_irq_ranges {
+	irq_hw_number_t offset[CXL_IRQ_RANGES];
+	irq_hw_number_t range[CXL_IRQ_RANGES];
+};
+
+#ifdef CONFIG_CXL_BASE
+
+void cxl_slbia(struct mm_struct *mm);
+void cxl_ctx_get(void);
+void cxl_ctx_put(void);
+bool cxl_ctx_in_use(void);
+
+#else /* CONFIG_CXL_BASE */
+
+#define cxl_slbia(...) do { } while (0)
+#define cxl_ctx_in_use(...) false
+
+#endif /* CONFIG_CXL_BASE */
+
+#endif
-- 
1.9.1
