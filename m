Return-Path: <srs0=bna+=fe=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zddGs5MNKzF0b8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 14:49:41 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zddGs2jx8z8wJY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 14:49:41 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zddGr6ZT8z9sRm
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2018 14:49:40 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1A3mgB9041896
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2018 22:49:39 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1j06cr4d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 09 Feb 2018 22:49:39 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 22:49:37 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] powerpc/vas: Add a couple of trace points
Date: Fri,  9 Feb 2018 19:49:27 -0800
In-Reply-To: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1518234567-24869-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a couple of trace points in the VAS driver

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog [v2]
	- Make TRACE_INCLUDE_PATH relative to <trace/define_trace.h>
---
 arch/powerpc/platforms/powernv/vas-trace.h  | 112 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas-window.c |   9 +++
 2 files changed, 121 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/vas-trace.h

diff --git a/arch/powerpc/platforms/powernv/vas-trace.h b/arch/powerpc/platforms/powernv/vas-trace.h
new file mode 100644
index 0000000..939d85d
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas-trace.h
@@ -0,0 +1,112 @@
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	vas
+
+#if !defined(_VAS_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+
+#define _VAS_TRACE_H
+#include <linux/tracepoint.h>
+#include <linux/sched.h>
+#include <asm/vas.h>
+
+TRACE_EVENT(	vas_rx_win_open,
+
+		TP_PROTO(struct task_struct *tsk,
+			 int vasid,
+			 int cop,
+			 struct vas_rx_win_attr *rxattr),
+
+		TP_ARGS(tsk, vasid, cop, rxattr),
+
+		TP_STRUCT__entry(
+			__field(struct task_struct *, tsk)
+			__field(int, pid)
+			__field(int, cop)
+			__field(int, vasid)
+			__field(struct vas_rx_win_attr *, rxattr)
+			__field(int, lnotify_lpid)
+			__field(int, lnotify_pid)
+			__field(int, lnotify_tid)
+		),
+
+		TP_fast_assign(
+			__entry->pid = tsk->pid;
+			__entry->vasid = vasid;
+			__entry->cop = cop;
+			__entry->lnotify_lpid = rxattr->lnotify_lpid;
+			__entry->lnotify_pid = rxattr->lnotify_pid;
+			__entry->lnotify_tid = rxattr->lnotify_tid;
+		),
+
+		TP_printk("pid=%d, vasid=%d, cop=%d, lpid=%d, pid=%d, tid=%d",
+			__entry->pid, __entry->vasid, __entry->cop,
+			__entry->lnotify_lpid, __entry->lnotify_pid,
+			__entry->lnotify_tid)
+);
+
+TRACE_EVENT(	vas_tx_win_open,
+
+		TP_PROTO(struct task_struct *tsk,
+			 int vasid,
+			 int cop,
+			 struct vas_tx_win_attr *txattr),
+
+		TP_ARGS(tsk, vasid, cop, txattr),
+
+		TP_STRUCT__entry(
+			__field(struct task_struct *, tsk)
+			__field(int, pid)
+			__field(int, cop)
+			__field(int, vasid)
+			__field(struct vas_tx_win_attr *, txattr)
+			__field(int, lpid)
+			__field(int, pidr)
+		),
+
+		TP_fast_assign(
+			__entry->pid = tsk->pid;
+			__entry->vasid = vasid;
+			__entry->cop = cop;
+			__entry->lpid = txattr->lpid;
+			__entry->pidr = txattr->pidr;
+		),
+
+		TP_printk("pid=%d, vasid=%d, cop=%d, lpid=%d, pidr=%d",
+			__entry->pid, __entry->vasid, __entry->cop,
+			__entry->lpid, __entry->pidr)
+);
+
+TRACE_EVENT(	vas_paste_crb,
+
+		TP_PROTO(struct task_struct *tsk,
+			struct vas_window *win),
+
+		TP_ARGS(tsk, win),
+
+		TP_STRUCT__entry(
+			__field(struct task_struct *, tsk)
+			__field(struct vas_window *, win)
+			__field(int, pid)
+			__field(int, vasid)
+			__field(int, winid)
+			__field(unsigned long, paste_kaddr)
+		),
+
+		TP_fast_assign(
+			__entry->pid = tsk->pid;
+			__entry->vasid = win->vinst->vas_id;
+			__entry->winid = win->winid;
+			__entry->paste_kaddr = (unsigned long)win->paste_kaddr
+		),
+
+		TP_printk("pid=%d, vasid=%d, winid=%d, paste_kaddr=0x%016lx\n",
+			__entry->pid, __entry->vasid, __entry->winid,
+			__entry->paste_kaddr)
+);
+
+#endif /* _VAS_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../arch/powerpc/platforms/powernv
+#define TRACE_INCLUDE_FILE vas-trace
+#include <trace/define_trace.h>
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 2b3eb01..6b2de9e 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -21,6 +21,9 @@
 #include "vas.h"
 #include "copy-paste.h"
 
+#define CREATE_TRACE_POINTS
+#include "vas-trace.h"
+
 /*
  * Compute the paste address region for the window @window using the
  * ->paste_base_addr and ->paste_win_id_shift we got from device tree.
@@ -880,6 +883,8 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 	struct vas_winctx winctx;
 	struct vas_instance *vinst;
 
+	trace_vas_rx_win_open(current, vasid, cop, rxattr);
+
 	if (!rx_win_args_valid(cop, rxattr))
 		return ERR_PTR(-EINVAL);
 
@@ -1008,6 +1013,8 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 	struct vas_winctx winctx;
 	struct vas_instance *vinst;
 
+	trace_vas_tx_win_open(current, vasid, cop, attr);
+
 	if (!tx_win_args_valid(cop, attr))
 		return ERR_PTR(-EINVAL);
 
@@ -1100,6 +1107,8 @@ int vas_paste_crb(struct vas_window *txwin, int offset, bool re)
 	void *addr;
 	uint64_t val;
 
+	trace_vas_paste_crb(current, txwin);
+
 	/*
 	 * Only NX windows are supported for now and hardware assumes
 	 * report-enable flag is set for NX windows. Ensure software
-- 
2.7.4
