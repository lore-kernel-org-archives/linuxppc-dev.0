Return-Path: <srs0=lfg8=3i=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvV6L6gkbzDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:18 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vvV6L4wq5z8w5m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:18 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vvV6L0vV4z9s4s
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 16:14:17 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2V5DpXW112289
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:15 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29h4bny2qh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:15 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 23:14:14 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/11] VAS: Define vas_rx_win_open() interface
Date: Thu, 30 Mar 2017 22:13:41 -0700
In-Reply-To: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1490937224-29149-9-git-send-email-sukadev@linux.vnet.ibm.com>
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
a send window that kenrel subsystems can use to access the NX engines.

The interface to open a receive window is expected to be invoked for each
instance of VAS in the system.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

Changelog[v3]:
	- Fault receive windows must enable interrupts and disable
	  notifications. NX Windows are opposite.
	- Use macros rather than enum for threshold-control mode
	- Ignore irq_ports for in-kernel windows. They are needed for
	  user space windows and will be added later
---
 arch/powerpc/include/asm/vas.h              |  45 ++++++
 arch/powerpc/platforms/powernv/vas-window.c | 205 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/vas.h        |  11 ++
 3 files changed, 260 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index e2575d5..09ea6f7 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -31,4 +31,49 @@ enum vas_cop_type {
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
+	bool notify_disable;
+	bool intr_disable;
+	bool notify_early;
+
+	int lnotify_lpid;
+	int lnotify_pid;
+	int lnotify_tid;
+	int pswid;
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
index 0c178fe..04f6bb2 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -477,7 +477,7 @@ void vas_window_free(struct vas_window *window)
 	kfree(window);
 }
 
-struct vas_window *vas_window_alloc(struct vas_instance *vinst, int id)
+static struct vas_window *vas_window_alloc(struct vas_instance *vinst, int id)
 {
 	struct vas_window *window;
 
@@ -503,3 +503,206 @@ int vas_win_close(struct vas_window *window)
 {
 	return -1;
 }
+
+struct vas_window *get_vinstance_rxwin(struct vas_instance *vinst,
+			enum vas_cop_type cop)
+{
+	struct vas_window *rxwin;
+
+	mutex_lock(&vinst->mutex);
+
+	rxwin = vinst->rxwin[cop];
+	if (rxwin)
+		atomic_inc(&rxwin->num_txwins);
+
+	mutex_unlock(&vinst->mutex);
+
+	return rxwin;
+}
+
+static void set_vinstance_rxwin(struct vas_instance *vinst,
+			enum vas_cop_type cop, struct vas_window *window)
+{
+	mutex_lock(&vinst->mutex);
+
+	/*
+	 * There should only be one receive window for a coprocessor type.
+	 */
+	WARN_ON_ONCE(vinst->rxwin[cop]);
+	vinst->rxwin[cop] = window;
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
+	 *	->user_win		No support for user Rx windows yet
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
+	winctx->fault_win_id = fault_winid;
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
+	if (attr->rx_fifo_size < VAS_RX_FIFO_SIZE_MIN)
+		return false;
+
+	if (attr->rx_fifo_size > VAS_RX_FIFO_SIZE_MAX)
+		return false;
+
+	if (attr->nx_win) {
+		/* cannot be both fault and nx */
+		if (attr->fault_win)
+			return false;
+		/*
+		 * Section 3.1.4.32: NX Windows must not disable notification,
+		 *	and must not enable interrupts or early notification.
+		 */
+		if (attr->notify_disable || !attr->intr_disable ||
+				attr->notify_early)
+			return false;
+	} else if (attr->fault_win) {
+		/*
+		 * Section 3.1.4.32: Fault windows must disable notification
+		 *	but not interrupts.
+		 */
+		if (!attr->notify_disable || attr->intr_disable)
+			return false;
+	} else {
+		/* Rx window must be either NX or Fault window for now.  */
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
+	}
+}
+
+struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
+			struct vas_rx_win_attr *rxattr)
+{
+	int rc, winid;
+	struct vas_instance *vinst;
+	struct vas_window *rxwin;
+	struct vas_winctx winctx;
+
+	if (!vas_initialized())
+		return ERR_PTR(-EAGAIN);
+
+	if (!rx_win_args_valid(cop, rxattr))
+		return ERR_PTR(-EINVAL);
+
+	vinst = find_vas_instance(vasid);
+	if (!vinst) {
+		pr_devel("VAS: vasid %d not found!\n", vasid);
+		return ERR_PTR(-EINVAL);
+	}
+	pr_devel("VAS: Found instance %d\n", vasid);
+
+	winid = vas_assign_window_id(&vinst->ida);
+	if (winid < 0)
+		return ERR_PTR(winid);
+
+	rc = -ENOMEM;
+	rxwin = vas_window_alloc(vinst, winid);
+	if (!rxwin) {
+		pr_devel("VAS: Unable to allocate memory for Rx window\n");
+		goto release_winid;
+	}
+
+	rxwin->tx_win = false;
+	rxwin->cop = cop;
+
+	init_winctx_for_rxwin(rxwin, rxattr, &winctx);
+	rxwin->nx_win = winctx.nx_win;
+	init_winctx_regs(rxwin, &winctx);
+
+	set_vinstance_rxwin(vinst, cop, rxwin);
+
+	if (winctx.fault_win)
+		fault_winid = winid;
+
+	return rxwin;
+
+release_winid:
+	vas_release_window_id(&vinst->ida, rxwin->winid);
+	return ERR_PTR(rc);
+}
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index bb7908b..86ed526 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -399,6 +399,16 @@ extern struct vas_instance *find_vas_instance(int vasid);
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
 			void *regptr, uint64_t val)
 {
@@ -411,6 +421,7 @@ static inline void vas_log_write(struct vas_window *win, char *name,
 #else	/* vas_debug */
 
 #define vas_log_write(win, name, reg, val)
+#define dump_rx_win_attr(attr)
 
 #endif	/* vas_debug */
 
-- 
2.7.4
