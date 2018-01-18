Return-Path: <srs0=dwtk=en=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMqTk2Y1XzF0lR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 03:41:14 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zMqTj6xdwz8tNH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 03:41:13 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zMqTj3FgQz9sNx
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2018 03:41:13 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0IGf7ql066504
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2018 11:41:10 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fjw30fuw5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2018 11:41:09 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 18 Jan 2018 09:41:05 -0700
Date: Thu, 18 Jan 2018 08:41:00 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] powerpc/ftw: Define FTW_SETUP ioctl API
References: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1516157443-17716-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <2eb418ec-afaf-3f03-40a2-ff9220e3d91f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2eb418ec-afaf-3f03-40a2-ff9220e3d91f@infradead.org>
Message-Id: <20180118164100.GC5314@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Randy Dunlap [rdunlap@infradead.org] wrote:

> > +#define FTW_FLAGS_PIN_WINDOW	0x1
> > +
> > +#define FTW_SETUP		_IOW('v', 1, struct ftw_setup_attr)
> 
> ioctls should be documented in Documentation/ioctl/ioctl-number.txt.
> Please update that file.

Ok. Here is the updated patch.

Thanks for the review.

Sukadev
---
>From 1f347c199a0b1bbc528705c8e9ddd11c825a80fc Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Thu, 2 Feb 2017 06:20:07 -0500
Subject: [PATCH 2/5] powerpc/ftw: Define FTW_SETUP ioctl API

Define the FTW_SETUP ioctl interface for fast thread wakeup (FTW). A
follow-on patch will implement the FTW driver and ioctl.

Thanks to input from Ben Herrenschmidt, Michael Neuling, Michael Ellerman.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v2]
	- [Michael Neuling] Use a single VAS_FTW_SETUP ioctl and simplify
	  the interface.
	- [Randy Dunlap] Reserve/document the ioctl number used.
---
 Documentation/ioctl/ioctl-number.txt |  1 +
 include/uapi/misc/ftw.h              | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/uapi/misc/ftw.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 3e3fdae..b0f323c 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -277,6 +277,7 @@ Code  Seq#(hex)	Include File		Comments
 'v'	00-1F	linux/fs.h		conflict!
 'v'	00-0F	linux/sonypi.h		conflict!
 'v'	C0-FF	linux/meye.h		conflict!
+'v'	20-27	include/uapi/misc/ftw.h
 'w'	all				CERN SCI driver
 'y'	00-1F				packet based user level communications
 					<mailto:zapman@interlan.net>
diff --git a/include/uapi/misc/ftw.h b/include/uapi/misc/ftw.h
new file mode 100644
index 0000000..99676b2
--- /dev/null
+++ b/include/uapi/misc/ftw.h
@@ -0,0 +1,35 @@
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
+/*
+ * Note: The range 0x20-27 for letter 'v' are reserved for FTW ioctls in
+ *	 Documentation/ioctl/ioctl-number.txt.
+ */
+#define FTW_SETUP		_IOW('v', 0x20, struct ftw_setup_attr)
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
