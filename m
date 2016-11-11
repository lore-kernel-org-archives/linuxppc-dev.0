Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmTG1KmXzDvjP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:30 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmTD52sLz9tB1
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:28 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGwrYc048461
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:27 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nd2rwng6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:26 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:26 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 06/11] VAS: Define vas_rx_win_open() and vas_win_close()
Date: Fri, 11 Nov 2016 09:02:51 -0800
In-Reply-To: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1478883776-11121-7-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define interfaces to open/close a VAS receive window. This interface
is intended to be used by the Nest Accelerator (NX) driver(s) to
setup receive windows for one or more NX engines (which implement
compression or encryption algorithms in the hardware).

A follow-on patch will provide an interface to open a send window
that subsystems in the kernel can use to access the NX engines.

While the hardware configurations required to open send and receive
windows differ, the configuration to close a window is the same for
both types of windows. So define a single interface to close the window.

The interface to open a receive window is expected to be invoked for
each instance (node, chip) of VAS in the system.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/vas.h  |  48 +++++++++
 drivers/misc/vas/vas-internal.h |  11 ++
 drivers/misc/vas/vas-window.c   | 234 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 1c10437..99bcc30 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -37,4 +37,52 @@ enum vas_thresh_ctl {
 	VAS_THRESH_FIFO_GT_EIGHTH_FULL,
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
+	enum vas_thresh_ctl tc_mode;
+};
+
+/*
+ * Open a VAS receive window for the instance of VAS identified by @chipid.
+ * Use @attr to initialize the attributes of the window.
+ *
+ * Each chip can have a MAX_WINDOWS_PER_CHIP. If no free window is available,
+ * return -EAGAIN.
+ *
+ * Return a handle to the window or ERR_PTR() on error.
+ */
+struct vas_window *vas_rx_win_open(int node, int chip, enum vas_cop_type cop,
+			struct vas_rx_win_attr *attr);
+
+/*
+ * Close the send or receive window identified by @win. For receive windows
+ * return -EAGAIN if there are active send windows attached to this receive
+ * window.
+ */
+int vas_win_close(struct vas_window *win);
+
 #endif
diff --git a/drivers/misc/vas/vas-internal.h b/drivers/misc/vas/vas-internal.h
index 953b7bb..7234ff6 100644
--- a/drivers/misc/vas/vas-internal.h
+++ b/drivers/misc/vas/vas-internal.h
@@ -378,6 +378,16 @@ extern struct vas_instance *find_vas_instance(int node, int chip);
 #define VREG(r)		VREG_SFX(r, _OFFSET)
 
 #ifndef vas_debug
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
@@ -390,6 +400,7 @@ static inline void vas_log_write(struct vas_window *win, char *name,
 #else	/* vas_debug */
 
 #define vas_log_write(win, name, reg, val)
+#define dump_rx_win_attr(attr)
 
 #endif	/* vas_debug */
 
diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index 056cfe9..dc35947 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -601,3 +601,237 @@ int vas_window_reset(struct vas_instance *vinst, int winid)
 
 	return 0;
 }
+
+static void put_rx_win(struct vas_window *rxwin)
+{
+	/* Better not be a send window! */
+	WARN_ON_ONCE(rxwin->txwin);
+
+	atomic_dec(&rxwin->num_txwins);
+}
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
+	winctx->rx_win_ord_mode = true;
+	winctx->tx_win_ord_mode = true;
+
+	winctx->fault_win_id = fault_winid;
+
+	if (winctx->nx_win) {
+		winctx->data_stamp = true;
+		winctx->intr_disable = true;
+
+		WARN_ON_ONCE(!winctx->pin_win);
+		WARN_ON_ONCE(winctx->fault_win);
+		WARN_ON_ONCE(!winctx->rx_win_ord_mode);
+		WARN_ON_ONCE(!winctx->tx_win_ord_mode);
+		WARN_ON_ONCE(winctx->notify_after_count);
+	}
+
+	/* TODO: Are irq ports required for NX receive windows? */
+	winctx->irq_port = rxwin->irq_port;
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
+struct vas_window *vas_rx_win_open(int node, int chip, enum vas_cop_type cop,
+			struct vas_rx_win_attr *rxattr)
+{
+	int rc, winid;
+	struct vas_instance *vinst;
+	struct vas_window *rxwin;
+	struct vas_winctx winctx;
+
+	if (!vas_initialized)
+		return ERR_PTR(-EAGAIN);
+
+	if (!rx_win_args_valid(cop, rxattr))
+		return ERR_PTR(-EINVAL);
+
+	vinst = find_vas_instance(node, chip);
+	if (!vinst) {
+		pr_devel("VAS: No instance found [%d, %d]!\n", node, chip);
+		return ERR_PTR(-EINVAL);
+	}
+	pr_devel("VAS: Found instance [%d, %d]\n", vinst->node, vinst->chip);
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
+	rxwin->txwin = false;
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
+
+int vas_win_close(struct vas_window *window)
+{
+	uint64_t val;
+	int cached;
+
+	if (!window)
+		return 0;
+
+	if (!window->txwin && atomic_read(&window->num_txwins) != 0) {
+		pr_devel("VAS: Attempting to close an active Rx window!\n");
+		WARN_ON_ONCE(1);
+		return -EAGAIN;
+	}
+
+	/* Unpin window from cache and close it */
+	val = 0ULL;
+	val = SET_FIELD(VAS_WINCTL_PIN, val, 0);
+	val = SET_FIELD(VAS_WINCTL_OPEN, val, 0);
+	write_hvwc_reg(window, VREG(WINCTL), val);
+
+	/*
+	 * See Section 1.11.1 for details on closing window, including
+	 *	- disable new paste operations
+	 *	- block till pending requests are completed
+	 *	- If Rx window, ensure FIFO is empty.
+	 */
+
+	/* Cast window context out of the cache */
+retry:
+	val = read_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL));
+	cached = GET_FIELD(val, VAS_WIN_CACHE_STATUS);
+	if (cached) {
+		val = 0ULL;
+		val = SET_FIELD(VAS_CASTOUT_REQ, val, 1);
+		val = SET_FIELD(VAS_PUSH_TO_MEM, val, 0);
+		write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), val);
+
+		schedule_timeout(2000);
+		goto retry;
+	}
+
+	/* if send window, drop reference to matching receive window */
+	if (window->txwin)
+		put_rx_win(window->rxwin);
+
+	vas_release_window_id(&window->vinst->ida, window->winid);
+
+	vas_window_free(window);
+
+	return 0;
+}
-- 
1.8.3.1
