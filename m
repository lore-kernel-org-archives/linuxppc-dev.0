Return-Path: <srs0=4i2n=em=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLs675khFzF0W9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 13:50:55 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zLs673pWtz8tHL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 13:50:55 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zLs665cfrz9sP1
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 13:50:54 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0H2n4r0093519
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 21:50:52 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fhsgchf3q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 21:50:52 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 21:50:51 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] powerpc/ftw: Define FTW_SETUP ioctl API
Date: Tue, 16 Jan 2018 18:50:40 -0800
In-Reply-To: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1516157443-17716-3-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define the FTW_SETUP ioctl interface for fast thread wakeup (FTW). A
follow-on patch will implement the FTW driver and ioctl.

Thanks to input from Ben Herrenschmidt, Michael Neuling, Michael Ellerman.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v2]
	- [Michael Neuling] Use a single VAS_FTW_SETUP ioctl and simplify
	  the interface.
---
 include/uapi/misc/ftw.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/uapi/misc/ftw.h

diff --git a/include/uapi/misc/ftw.h b/include/uapi/misc/ftw.h
new file mode 100644
index 0000000..f233f51
--- /dev/null
+++ b/include/uapi/misc/ftw.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2018 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _UAPI_MISC_FTW_H
+#define _UAPI_MISC_FTW_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define FTW_FLAGS_PIN_WINDOW	0x1
+
+#define FTW_SETUP		_IOW('v', 1, struct ftw_setup_attr)
+
+struct ftw_setup_attr {
+	__s16	version;
+	__s16	vas_id;		/* specific instance of vas or -1 for default */
+	__u32	reserved;
+
+	__u64	reserved1;
+
+	__u64	flags;
+	__u64	reserved2;
+};
+
+#endif /* _UAPI_MISC_FTW_H */
-- 
2.7.4
