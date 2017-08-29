Return-Path: <srs0=4uxs=77=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhJWP6DQFzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:17 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xhJWN1tPNz8vDS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xhJWM09GFz9t3w
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 16:24:14 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7T6OC1T130634
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:24:13 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cn0dtakfk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:24:12 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 02:24:05 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 07/10] powerpc/vas: Define vas_rx_win_open() interface
Date: Mon, 28 Aug 2017 23:23:37 -0700
In-Reply-To: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503987820-31933-8-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define the vas_rx_win_open() interface. This interface is intended to be
used by the Nest Accelerator (NX) driver(s) to setup receive windows for
one or more NX engines (which implement compression/encryption algorithms
in the hardware).

Follow-on patches will provide an interface to close the window and to open
a send window that kernel subsystems can use to access the NX engines.

The interface to open a receive window is expected to be invoked for each
instance of VAS in the system.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

Changelog[v8]:
	- [Michael Ellerman] Drop vas_initialized() check; use pr_fmt;
	  user kernel integer types (u32,64 etc);
	- Dropped (deferred) code that handles user rx windows.

Changelog[v7]:
	- vas_rx_win_open() is simplified because API for FTW windows
	  are simplified. We expect the driver to open an rxwin and txwin
	  one after the other and we don't get back an rx_win_handle from
	  user space so don't have to validate the pid permissions.

Changelog[v6]:
	- Add support for FTW windows

Changelog[v4]:
	- Export the symbols

Changelog[v3]:
	- Fault receive windows must enable interrupts and disable
	  notifications. NX Windows are opposite.
	- Use macros rather than enum for threshold-control mode
	- Ignore irq_ports for in-kernel windows. They are needed for
	  user space windows and will be added later
---
 arch/powerpc/include/asm/vas.h              |  46 +++++
 arch/powerpc/platforms/powernv/vas-window.c | 283 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/vas.h        |  14 ++
 3 files changed, 342 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 33e93ca..5ce800a 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -50,4 +50,50 @@ enum vas_cop_type {
 	VAS_COP_TYPE_MAX,
 };
 
+/*
+ * Receive window attributes specified by the (in-kernel) owner of window.
+ */
+struct vas_rx_win_attr {
+	void *rx_fifo;
+	int rx_fifo_size;
+	int wcreds_max;
+
+	bool pin_win;
+	bool rej_no_credit;
+	bool tx_wcred_mode;
+	bool rx_wcred_mode;
+	bool tx_win_ord_mode;
+	bool rx_win_ord_mode;
+	bool data_stamp;
+	bool nx_win;
+	bool fault_win;
+	bool user_win;
+	bool notify_disable;
+	bool intr_disable;
+	bool notify_early;
+
+	int lnotify_lpid;
+	int lnotify_pid;
+	int lnotify_tid;
+	u32 pswid;
+
+	int tc_mode;
+};
+
+/*
+ * Helper to initialize receive window attributes to defaults for an
+ * NX window.
+ */
+extern void vas_init_rx_win_attr(struct vas_rx_win_attr *rxattr,
+				enum vas_cop_type cop);
+
+/*
+ * Open a VAS receive window for the instance of VAS identified by @vasid
+ * Use @attr to initialize the attributes of the window.
+ *
+ * Return a handle to the window or ERR_PTR() on error.
+ */
+extern struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
+			struct vas_rx_win_attr *attr);
+
 #endif /* _MISC_VAS_H */
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index bfc9dba..783c8c6 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -14,6 +14,8 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/log2.h>
+#include <linux/rcupdate.h>
+#include <linux/cred.h>
 
 #include "vas.h"
 
@@ -531,7 +533,7 @@ void vas_window_free(struct vas_window *window)
 	vas_release_window_id(&vinst->ida, winid);
 }
 
-struct vas_window *vas_window_alloc(struct vas_instance *vinst)
+static struct vas_window *vas_window_alloc(struct vas_instance *vinst)
 {
 	int winid;
 	struct vas_window *window;
@@ -558,6 +560,285 @@ struct vas_window *vas_window_alloc(struct vas_instance *vinst)
 	return ERR_PTR(-ENOMEM);
 }
 
+/*
+ * Get the VAS receive window associated with NX engine identified
+ * by @cop and if applicable, @pswid.
+ *
+ * See also function header of set_vinst_win().
+ */
+struct vas_window *get_vinst_rxwin(struct vas_instance *vinst,
+			enum vas_cop_type cop, u32 pswid)
+{
+	struct vas_window *rxwin;
+
+	mutex_lock(&vinst->mutex);
+
+	if (cop == VAS_COP_TYPE_842 || cop == VAS_COP_TYPE_842_HIPRI)
+		rxwin = vinst->rxwin[cop] ?: ERR_PTR(-EINVAL);
+	else
+		rxwin = ERR_PTR(-EINVAL);
+
+	if (!IS_ERR(rxwin))
+		atomic_inc(&rxwin->num_txwins);
+
+	mutex_unlock(&vinst->mutex);
+
+	return rxwin;
+}
+
+/*
+ * We have two tables of windows in a VAS instance. The first one,
+ * ->windows[], contains all the windows in the instance and allows
+ * looking up a window by its id. It is used to look up send windows
+ * during fault handling and receive windows when pairing user space
+ * send/receive windows.
+ *
+ * The second table, ->rxwin[], contains receive windows that are
+ * associated with NX engines. This table has VAS_COP_TYPE_MAX
+ * entries and is used to look up a receive window by its
+ * coprocessor type.
+ *
+ * Here, we save @window in the ->windows[] table. If it is a receive
+ * window, we also save the window in the ->rxwin[] table.
+ */
+static void set_vinst_win(struct vas_instance *vinst,
+			struct vas_window *window)
+{
+	int id = window->winid;
+
+	mutex_lock(&vinst->mutex);
+
+	/*
+	 * There should only be one receive window for a coprocessor type
+	 * unless its a user (FTW) window.
+	 */
+	if (!window->user_win && !window->tx_win) {
+		WARN_ON_ONCE(vinst->rxwin[window->cop]);
+		vinst->rxwin[window->cop] = window;
+	}
+
+	WARN_ON_ONCE(vinst->windows[id] != NULL);
+	vinst->windows[id] = window;
+
+	mutex_unlock(&vinst->mutex);
+}
+
+/*
+ * Clear this window from the table(s) of windows for this VAS instance.
+ * See also function header of set_vinst_win().
+ */
+void clear_vinst_win(struct vas_window *window)
+{
+	int id = window->winid;
+	struct vas_instance *vinst = window->vinst;
+
+	mutex_lock(&vinst->mutex);
+
+	if (!window->user_win && !window->tx_win) {
+		WARN_ON_ONCE(!vinst->rxwin[window->cop]);
+		vinst->rxwin[window->cop] = NULL;
+	}
+
+	WARN_ON_ONCE(vinst->windows[id] != window);
+	vinst->windows[id] = NULL;
+
+	mutex_unlock(&vinst->mutex);
+}
+
+static void init_winctx_for_rxwin(struct vas_window *rxwin,
+			struct vas_rx_win_attr *rxattr,
+			struct vas_winctx *winctx)
+{
+	/*
+	 * We first zero (memset()) all fields and only set non-zero fields.
+	 * Following fields are 0/false but maybe deserve a comment:
+	 *
+	 *	->notify_os_intr_reg	In powerNV, send intrs to HV
+	 *	->notify_disable	False for NX windows
+	 *	->intr_disable		False for Fault Windows
+	 *	->xtra_write		False for NX windows
+	 *	->notify_early		NA for NX windows
+	 *	->rsvd_txbuf_count	NA for Rx windows
+	 *	->lpid, ->pid, ->tid	NA for Rx windows
+	 */
+
+	memset(winctx, 0, sizeof(struct vas_winctx));
+
+	winctx->rx_fifo = rxattr->rx_fifo;
+	winctx->rx_fifo_size = rxattr->rx_fifo_size;
+	winctx->wcreds_max = rxattr->wcreds_max ?: VAS_WCREDS_DEFAULT;
+	winctx->pin_win = rxattr->pin_win;
+
+	winctx->nx_win = rxattr->nx_win;
+	winctx->fault_win = rxattr->fault_win;
+	winctx->rx_word_mode = rxattr->rx_win_ord_mode;
+	winctx->tx_word_mode = rxattr->tx_win_ord_mode;
+	winctx->rx_wcred_mode = rxattr->rx_wcred_mode;
+	winctx->tx_wcred_mode = rxattr->tx_wcred_mode;
+
+	if (winctx->nx_win) {
+		winctx->data_stamp = true;
+		winctx->intr_disable = true;
+		winctx->pin_win = true;
+
+		WARN_ON_ONCE(winctx->fault_win);
+		WARN_ON_ONCE(!winctx->rx_word_mode);
+		WARN_ON_ONCE(!winctx->tx_word_mode);
+		WARN_ON_ONCE(winctx->notify_after_count);
+	} else if (winctx->fault_win) {
+		winctx->notify_disable = true;
+	} else if (winctx->user_win) {
+		/*
+		 * Section 1.8.1 Low Latency Core-Core Wake up of
+		 * the VAS workbook:
+		 *
+		 *      - disable credit checks ([tr]x_wcred_mode = false)
+		 *      - disable FIFO writes
+		 *      - enable ASB_Notify, disable interrupt
+		 */
+		winctx->fifo_disable = true;
+		winctx->intr_disable = true;
+		winctx->rx_fifo = NULL;
+	}
+
+	winctx->lnotify_lpid = rxattr->lnotify_lpid;
+	winctx->lnotify_pid = rxattr->lnotify_pid;
+	winctx->lnotify_tid = rxattr->lnotify_tid;
+	winctx->pswid = rxattr->pswid;
+	winctx->dma_type = VAS_DMA_TYPE_INJECT;
+	winctx->tc_mode = rxattr->tc_mode;
+
+	winctx->min_scope = VAS_SCOPE_LOCAL;
+	winctx->max_scope = VAS_SCOPE_VECTORED_GROUP;
+}
+
+static bool rx_win_args_valid(enum vas_cop_type cop,
+			struct vas_rx_win_attr *attr)
+{
+	dump_rx_win_attr(attr);
+
+	if (cop >= VAS_COP_TYPE_MAX)
+		return false;
+
+	if (cop != VAS_COP_TYPE_FTW &&
+				attr->rx_fifo_size < VAS_RX_FIFO_SIZE_MIN)
+		return false;
+
+	if (attr->rx_fifo_size > VAS_RX_FIFO_SIZE_MAX)
+		return false;
+
+	if (attr->nx_win) {
+		/* cannot be fault or user window if it is nx */
+		if (attr->fault_win || attr->user_win)
+			return false;
+		/*
+		 * Section 3.1.4.32: NX Windows must not disable notification,
+		 *	and must not enable interrupts or early notification.
+		 */
+		if (attr->notify_disable || !attr->intr_disable ||
+				attr->notify_early)
+			return false;
+	} else if (attr->fault_win) {
+		/* cannot be both fault and user window */
+		if (attr->user_win)
+			return false;
+
+		/*
+		 * Section 3.1.4.32: Fault windows must disable notification
+		 *	but not interrupts.
+		 */
+		if (!attr->notify_disable || attr->intr_disable)
+			return false;
+
+	} else if (attr->user_win) {
+		/*
+		 * User receive windows are only for fast-thread-wakeup
+		 * (FTW). They don't need a FIFO and must disable interrupts
+		 */
+		if (attr->rx_fifo || attr->rx_fifo_size || !attr->intr_disable)
+			return false;
+	} else {
+		/* Rx window must be one of NX or Fault or User window. */
+		return false;
+	}
+
+	return true;
+}
+
+void vas_init_rx_win_attr(struct vas_rx_win_attr *rxattr, enum vas_cop_type cop)
+{
+	memset(rxattr, 0, sizeof(*rxattr));
+
+	if (cop == VAS_COP_TYPE_842 || cop == VAS_COP_TYPE_842_HIPRI) {
+		rxattr->pin_win = true;
+		rxattr->nx_win = true;
+		rxattr->fault_win = false;
+		rxattr->intr_disable = true;
+		rxattr->rx_wcred_mode = true;
+		rxattr->tx_wcred_mode = true;
+		rxattr->rx_win_ord_mode = true;
+		rxattr->tx_win_ord_mode = true;
+	} else if (cop == VAS_COP_TYPE_FAULT) {
+		rxattr->pin_win = true;
+		rxattr->fault_win = true;
+		rxattr->notify_disable = true;
+		rxattr->rx_wcred_mode = true;
+		rxattr->tx_wcred_mode = true;
+		rxattr->rx_win_ord_mode = true;
+		rxattr->tx_win_ord_mode = true;
+	} else if (cop == VAS_COP_TYPE_FTW) {
+		rxattr->user_win = true;
+		rxattr->intr_disable = true;
+
+		/*
+		 * As noted in the VAS Workbook we disable credit checks.
+		 * If we enable credit checks in the future, we must also
+		 * implement a mechanism to return the user credits or new
+		 * paste operations will fail.
+		 */
+	}
+}
+EXPORT_SYMBOL_GPL(vas_init_rx_win_attr);
+
+struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
+			struct vas_rx_win_attr *rxattr)
+{
+	struct vas_window *rxwin;
+	struct vas_winctx winctx;
+	struct vas_instance *vinst;
+
+	if (!rx_win_args_valid(cop, rxattr))
+		return ERR_PTR(-EINVAL);
+
+	vinst = find_vas_instance(vasid);
+	if (!vinst) {
+		pr_devel("vasid %d not found!\n", vasid);
+		return ERR_PTR(-EINVAL);
+	}
+	pr_devel("Found instance %d\n", vasid);
+
+	rxwin = vas_window_alloc(vinst);
+	if (IS_ERR(rxwin)) {
+		pr_devel("Unable to allocate memory for Rx window\n");
+		return rxwin;
+	}
+
+	rxwin->tx_win = false;
+	rxwin->nx_win = rxattr->nx_win;
+	rxwin->user_win = rxattr->user_win;
+	rxwin->cop = cop;
+	if (rxattr->user_win)
+		rxwin->pid = task_pid_vnr(current);
+
+	init_winctx_for_rxwin(rxwin, rxattr, &winctx);
+	init_winctx_regs(rxwin, &winctx);
+
+	set_vinst_win(vinst, rxwin);
+
+	return rxwin;
+}
+EXPORT_SYMBOL_GPL(vas_rx_win_open);
+
 /* stub for now */
 int vas_win_close(struct vas_window *window)
 {
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 60a3c3c..d3e4f55 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -289,6 +289,9 @@ enum vas_notify_after_count {
 /*
  * One per instance of VAS. Each instance will have a separate set of
  * receive windows, one per coprocessor type.
+ *
+ * See also function header of set_vinst_win() for details on ->windows[]
+ * and ->rxwin[] tables.
  */
 struct vas_instance {
 	int vas_id;
@@ -393,6 +396,16 @@ extern struct vas_instance *find_vas_instance(int vasid);
 #define VREG(r)		VREG_SFX(r, _OFFSET)
 
 #ifdef vas_debug
+static inline void dump_rx_win_attr(struct vas_rx_win_attr *attr)
+{
+	pr_err("VAS: fault %d, notify %d, intr %d early %d\n",
+			attr->fault_win, attr->notify_disable,
+			attr->intr_disable, attr->notify_early);
+
+	pr_err("VAS: rx_fifo_size %d, max value %d\n",
+				attr->rx_fifo_size, VAS_RX_FIFO_SIZE_MAX);
+}
+
 static inline void vas_log_write(struct vas_window *win, char *name,
 			void *regptr, u64 val)
 {
@@ -405,6 +418,7 @@ static inline void vas_log_write(struct vas_window *win, char *name,
 #else	/* vas_debug */
 
 #define vas_log_write(win, name, reg, val)
+#define dump_rx_win_attr(attr)
 
 #endif	/* vas_debug */
 
-- 
2.7.4
