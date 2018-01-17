Return-Path: <srs0=4i2n=em=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLs6F29DYzF0YS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 13:51:01 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zLs6D1C8wz8tHL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 13:51:00 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zLs6B3VQJz9sPk
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 13:50:58 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0H2n8rH118975
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 21:50:56 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fhs4g2hqe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 21:50:56 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 21:50:55 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] powerpc/ftw: Add a couple of trace points
Date: Tue, 16 Jan 2018 18:50:42 -0800
In-Reply-To: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1516157443-17716-5-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a couple of trace points in the FTW driver

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 drivers/misc/ftw/ftw-trace.h | 75 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/ftw/ftw.c       |  6 ++++
 2 files changed, 81 insertions(+)
 create mode 100644 drivers/misc/ftw/ftw-trace.h

diff --git a/drivers/misc/ftw/ftw-trace.h b/drivers/misc/ftw/ftw-trace.h
new file mode 100644
index 0000000..0d96046
--- /dev/null
+++ b/drivers/misc/ftw/ftw-trace.h
@@ -0,0 +1,75 @@
+/*
+ * Copyright 2018 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	ftw
+
+#if !defined(_FTW_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+
+#define _FTW_TRACE_H
+#include <linux/tracepoint.h>
+#include <linux/sched.h>
+
+TRACE_EVENT(	ftw_open_event,
+
+		TP_PROTO(struct task_struct *tsk,
+			 int instid),
+
+		TP_ARGS(tsk, instid),
+
+		TP_STRUCT__entry(
+			__field(struct task_struct *, tsk)
+			__field(int, instid)
+			__field(int, pid)
+		),
+
+		TP_fast_assign(
+			__entry->pid = tsk->pid;
+			__entry->instid = instid;
+		),
+
+		TP_printk("pid=%d, inst=%d", __entry->pid, __entry->instid)
+);
+
+TRACE_EVENT(	ftw_mmap_event,
+
+		TP_PROTO(struct task_struct *tsk,
+			 int instid,
+			 unsigned long paste_addr,
+			 unsigned long vma_start),
+
+		TP_ARGS(tsk, instid, paste_addr, vma_start),
+
+		TP_STRUCT__entry(
+			__field(struct task_struct *, tsk)
+			__field(int, pid)
+			__field(int, instid)
+			__field(unsigned long, paste_addr)
+			__field(unsigned long, vma_start)
+		),
+
+		TP_fast_assign(
+			__entry->pid = tsk->pid;
+			__entry->instid = instid;
+			__entry->paste_addr = paste_addr;
+			__entry->vma_start = vma_start;
+		),
+
+		TP_printk(
+			"pid=%d, inst=%d, pasteaddr=0x%16lx, vma_start=0x%16lx",
+			__entry->pid, __entry->instid, __entry->paste_addr,
+			__entry->vma_start)
+);
+
+#endif /* _FTW_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE ftw-trace
+#include <trace/define_trace.h>
diff --git a/drivers/misc/ftw/ftw.c b/drivers/misc/ftw/ftw.c
index 6fcb4e2..a01c9e6 100644
--- a/drivers/misc/ftw/ftw.c
+++ b/drivers/misc/ftw/ftw.c
@@ -21,6 +21,9 @@
 #include <asm/vas.h>
 #include <uapi/misc/ftw.h>
 
+#define CREATE_TRACE_POINTS
+#include "ftw-trace.h"
+
 /*
  * FTW is a device driver used to provide user space access to the
  * Core-to-Core aka Fast Thread Wakeup (FTW) functionality provided by
@@ -81,6 +84,8 @@ static int ftw_open(struct inode *inode, struct file *fp)
 
 	fp->private_data = instance;
 
+	trace_ftw_open_event(current, instance->id);
+
 	return 0;
 }
 
@@ -234,6 +239,7 @@ static int ftw_mmap(struct file *fp, struct vm_area_struct *vma)
 
 	pr_devel("paste addr %llx at %lx, rc %d\n", paste_addr, vma->vm_start,
 			rc);
+	trace_ftw_mmap_event(current, instance->id, paste_addr, vma->vm_start);
 
 	set_thread_uses_vas();
 
-- 
2.7.4
