Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 266211A0A24
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 20:35:51 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v2 15/17] cxl: Userspace header file.
Date: Tue, 30 Sep 2014 20:35:04 +1000
Message-Id: <1412073306-13812-16-git-send-email-mikey@neuling.org>
In-Reply-To: <1412073306-13812-1-git-send-email-mikey@neuling.org>
References: <1412073306-13812-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
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

This defines structs and magic numbers required for userspace to interact with
the kernel cxl driver via /dev/cxl/afu0.0.

It adds this header file Kbuild so it's exported when doing make
headers_installs.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 include/uapi/Kbuild      |  1 +
 include/uapi/misc/Kbuild |  2 ++
 include/uapi/misc/cxl.h  | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 include/uapi/misc/Kbuild
 create mode 100644 include/uapi/misc/cxl.h

diff --git a/include/uapi/Kbuild b/include/uapi/Kbuild
index 81d2106..245aa6e 100644
--- a/include/uapi/Kbuild
+++ b/include/uapi/Kbuild
@@ -12,3 +12,4 @@ header-y += video/
 header-y += drm/
 header-y += xen/
 header-y += scsi/
+header-y += misc/
diff --git a/include/uapi/misc/Kbuild b/include/uapi/misc/Kbuild
new file mode 100644
index 0000000..e96cae7
--- /dev/null
+++ b/include/uapi/misc/Kbuild
@@ -0,0 +1,2 @@
+# misc Header export list
+header-y += cxl.h
diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
new file mode 100644
index 0000000..6a394b5
--- /dev/null
+++ b/include/uapi/misc/cxl.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright 2014 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _UAPI_ASM_CXL_H
+#define _UAPI_ASM_CXL_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* ioctls */
+struct cxl_ioctl_start_work {
+	__u64 wed;
+	__u64 amr;
+	__u64 reserved1;
+	__u32 reserved2;
+	__s16 num_interrupts; /* -1 = use value from afu descriptor */
+	__u16 process_element; /* returned from kernel */
+	__u64 reserved3;
+	__u64 reserved4;
+	__u64 reserved5;
+	__u64 reserved6;
+};
+
+#define CXL_MAGIC 0xCA
+#define CXL_IOCTL_START_WORK      _IOWR(CXL_MAGIC, 0x00, struct cxl_ioctl_start_work)
+#define CXL_IOCTL_CHECK_ERROR     _IO(CXL_MAGIC,   0x02)
+
+/* events from read() */
+
+enum cxl_event_type {
+	CXL_EVENT_READ_FAIL     = -1,
+	CXL_EVENT_RESERVED      = 0,
+	CXL_EVENT_AFU_INTERRUPT = 1,
+	CXL_EVENT_DATA_STORAGE  = 2,
+	CXL_EVENT_AFU_ERROR     = 3,
+};
+
+struct cxl_event_header {
+	__u32 type;
+	__u16 size;
+	__u16 process_element;
+	__u64 reserved1;
+	__u64 reserved2;
+	__u64 reserved3;
+};
+
+struct cxl_event_afu_interrupt {
+	struct cxl_event_header header;
+	__u16 irq; /* Raised AFU interrupt number */
+	__u16 reserved1;
+	__u32 reserved2;
+	__u64 reserved3;
+	__u64 reserved4;
+	__u64 reserved5;
+};
+
+struct cxl_event_data_storage {
+	struct cxl_event_header header;
+	__u64 addr;
+	__u64 reserved1;
+	__u64 reserved2;
+	__u64 reserved3;
+};
+
+struct cxl_event_afu_error {
+	struct cxl_event_header header;
+	__u64 err;
+	__u64 reserved1;
+	__u64 reserved2;
+	__u64 reserved3;
+};
+
+struct cxl_event {
+	union {
+		struct cxl_event_header header;
+		struct cxl_event_afu_interrupt irq;
+		struct cxl_event_data_storage fault;
+		struct cxl_event_afu_error afu_err;
+	};
+};
+
+#endif
-- 
1.9.1
