Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmTN4SVNzDvjf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:36 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmTM72ZDz9tB1
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:35 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGx5b1001955
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:34 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nbwngvbh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:34 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:33 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 10/11] VAS: Create a thread to monitor fault-window
Date: Fri, 11 Nov 2016 09:02:55 -0800
In-Reply-To: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1478883776-11121-11-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The VAS hardware requires kernel to setup a "fault window" to which
the hardware will paste a CRB in case of address translation faults.

Create a fault window (which is basically a special receive window)
and a kernel thread that processes the CRBs that arrive at the fault
window.  A follow-on patch will implement IRQ handling and the
interrupt handler will wake up the fault thread.

The fault window and thread will be used when we support user-space
access to the VAS/NX hardware. For now the fault window thread simply
dumps/logs the CRB and the fault isolation registers. Including these
in this RFC patchset for review/comments.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 drivers/misc/vas/vas-internal.h |   1 +
 drivers/misc/vas/vas.c          | 157 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vas/vas-internal.h b/drivers/misc/vas/vas-internal.h
index a58ffb2..e3ceb74 100644
--- a/drivers/misc/vas/vas-internal.h
+++ b/drivers/misc/vas/vas-internal.h
@@ -366,6 +366,7 @@ extern int vas_initialized;
 
 extern int vas_window_reset(struct vas_instance *vinst, int winid);
 extern struct vas_instance *find_vas_instance(int node, int chip);
+extern void vas_wakeup_fault_win_thread(void);
 
 /*
  * VREG(x):
diff --git a/drivers/misc/vas/vas.c b/drivers/misc/vas/vas.c
index 785e7a1..448d7f9 100644
--- a/drivers/misc/vas/vas.c
+++ b/drivers/misc/vas/vas.c
@@ -12,15 +12,29 @@
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 #include <linux/io.h>
 #include <asm/vas.h>
 #include "vas-internal.h"
 #include <asm/opal-api.h>
 #include <asm/opal.h>
 
+#define VAS_FAULT_WIN_FIFO_SIZE		(64 << 10)
+#define VAS_FAULT_WIN_WCREDS		64
+
 int vas_initialized;
 struct vas_instance *vas_instances;
 
+struct fault_win_thread_arg {
+	int notified;
+	wait_queue_head_t wq;
+	void *rx_fifo;
+	int rx_fifo_size;
+} fwta;
+
+struct task_struct *fwt_thr;		/* Fault window thread */
+struct vas_window *fault_win;
+
 /*
  * Read the Fault Isolation Registers (FIR) from skiboot into @fir.
  */
@@ -56,6 +70,135 @@ void vas_print_regs(int chip)
 	}
 }
 
+void vas_wakeup_fault_win_thread(void)
+{
+	fwta.notified = 1;
+	wake_up(&fwta.wq);
+}
+
+/*
+ * Process a CRB that we receive on the fault window.
+ *
+ * TODO: Since we only support in-kernel compression requests for now,
+ *	 we should not get a fault. If we do, dump the CRB and the FIR
+ *	 and return - VAS may enter a checkstop :-(
+ */
+static void process_fault_crb(struct fault_win_thread_arg *fwt)
+{
+	u64 buf[16];
+
+	/* TODO: Dump FIRs for all chips for now. We should detect the
+	 *	 current chip id and dump only for that chip?
+	 */
+	vas_print_regs(-1);
+
+	memcpy(buf, fwt->rx_fifo, sizeof(buf));
+	memset(fwt->rx_fifo, 0, sizeof(buf));
+	pr_debug("VAS: FaultWin Rx-fifo: 0x%llx 0x%llx 0x%llx 0x%llx\n",
+				buf[0], buf[1], buf[2], buf[3]);
+}
+
+static int fault_win_thread(void *arg)
+{
+	struct fault_win_thread_arg *fwta = arg;
+
+	do {
+		if (signal_pending(current))
+			flush_signals(current);
+
+		fwta->notified = 0;
+		wait_event_interruptible(fwta->wq, fwta->notified ||
+				kthread_should_stop());
+
+		process_fault_crb(fwta);
+
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+static int create_fault_win(void)
+{
+	char *name = "VAS-FaultWin-Thread";
+	struct vas_rx_win_attr attr;
+
+	init_waitqueue_head(&fwta.wq);
+	fwta.notified = 0;
+	fwta.rx_fifo_size = VAS_FAULT_WIN_FIFO_SIZE;
+	fwta.rx_fifo = kmalloc(fwta.rx_fifo_size, GFP_KERNEL);
+	if (!fwta.rx_fifo) {
+		pr_err("VAS: Unable to alloc %d bytes for rx_fifo\n",
+				fwta.rx_fifo_size);
+		return -1;
+	}
+
+	/*
+	 * Create a worker thread that processes the fault CRBs.
+	 */
+	fwt_thr = kthread_create_on_node(fault_win_thread, &fwta, 0, name, 0);
+	if (IS_ERR(fwt_thr))
+		goto free_mem;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.rx_fifo_size = fwta.rx_fifo_size;
+	attr.rx_fifo = fwta.rx_fifo;
+
+	attr.wcreds_max = VAS_FAULT_WIN_WCREDS;
+	attr.tc_mode = VAS_THRESH_DISABLED;
+	attr.pin_win = true;
+	attr.tx_win_ord_mode = true;
+	attr.rx_win_ord_mode = true;
+	attr.fault_win = true;
+
+	/*
+	 * 3.1.4.32: Local Notification Control Register. notify_disable is
+	 * true and interrupt disable is false for Fault windows
+	 */
+	attr.notify_disable = true;
+
+	attr.lnotify_lpid = 0;
+	attr.lnotify_pid = task_pid_nr(fwt_thr);
+	attr.lnotify_tid = task_pid_nr(fwt_thr);
+
+	fault_win = vas_rx_win_open(0, 0, VAS_COP_TYPE_FAULT, &attr);
+	if (IS_ERR(fault_win)) {
+		pr_err("VAS: Error %ld opening fault window\n",
+					PTR_ERR(fault_win));
+		goto stop_thread;
+	}
+
+	/*
+	 * Wakeup fault thread after fault rx window is opened.
+	 */
+	wake_up_process(fwt_thr);
+
+	pr_err("VAS: Created fault window, %d, LPID/PID/TID [%d/%d/%d]\n",
+			fault_win->winid, attr.lnotify_lpid, attr.lnotify_pid,
+			attr.lnotify_tid);
+
+	return 0;
+
+stop_thread:
+	kthread_stop(fwt_thr);
+
+free_mem:
+	kfree(attr.rx_fifo);
+	return -1;
+}
+
+static void destroy_fault_win(void)
+{
+	if (vas_win_close(fault_win) < 0)
+		pr_err("VAS: error closing fault window\n");
+
+	/*
+	 * TODO: fault_win_thread() does not exit unless stopped
+	 *	 but check if there can be any race here.
+	 */
+	kthread_stop(fwt_thr);
+	kfree(fwta.rx_fifo);
+	pr_err("VAS: Fault thread stopped\n");
+}
 
 static void init_vas_chip(struct vas_instance *vinst)
 {
@@ -93,7 +236,7 @@ static void init_vas_instance(int node, int chip)
 
 int vas_init(void)
 {
-	int n, c;
+	int n, c, rc;
 
 	vas_instances = kmalloc_array(VAS_MAX_NODES * VAS_MAX_CHIPS_PER_NODE,
 				sizeof(struct vas_instance), GFP_KERNEL);
@@ -110,12 +253,24 @@ int vas_init(void)
 
 	vas_initialized = 1;
 
+	/*
+	 * Create fault handler thread and window.
+	 */
+	rc = create_fault_win();
+	if (rc < 0)
+		goto cleanup;
+
 	return 0;
+
+cleanup:
+	kfree(vas_instances);
+	return rc;
 }
 
 void vas_exit(void)
 {
 	vas_initialized = 0;
+	destroy_fault_win();
 	kfree(vas_instances);
 }
 
-- 
1.8.3.1
