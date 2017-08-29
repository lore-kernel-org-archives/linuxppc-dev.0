Return-Path: <srs0=4uxs=77=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhJWP5H88zDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xhJWN4Hgjz8vLq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xhJWM68Zwz9t48
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 16:24:15 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7T6OCN6118644
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:24:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmur5gvw7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:24:13 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 02:24:09 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 09/10] powerpc/vas: Define vas_tx_win_open()
Date: Mon, 28 Aug 2017 23:23:39 -0700
In-Reply-To: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503987820-31933-10-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define an interface to open a VAS send window. This interface is
intended to be used the Nest Accelerator (NX) driver(s) to open
a send window and use it to submit compression/encryption requests
to a VAS receive window.

The receive window, identified by the [vasid, cop] parameters, must
already be open in VAS (i.e connected to an NX engine).

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

---
Changelog[v8]:
	- [Michael Ellerman] Drop vas_initialized() check; defer code
	  that sets pswid;

Changelog[v7]:
	- Initialize txwin->user_win field for FTW windows.

Changelog[v6]:
	- Add support for FTW windows

Changelog[v4]:
	- [Ben Herrenschmidt] MMIO regions must be mapped non-cached and
	  paste regions must be mapped cached. Define/use map_paste_region().

Changelog [v3]:
	- Distinguish between hardware PID (SPRN_PID) and Linux pid.
	- Use macros rather than enum for threshold-control mode
	- Set the pid of send window from attr (needed for user space
	  send windows).
	- Ignore irq port setting for now. They are needed for user space
	  windows and will be added later
---
 arch/powerpc/include/asm/vas.h              |  42 ++++++++
 arch/powerpc/platforms/powernv/vas-window.c | 156 +++++++++++++++++++++++++++-
 2 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index e124856..efbdde5 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -81,6 +81,29 @@ struct vas_rx_win_attr {
 };
 
 /*
+ * Window attributes specified by the in-kernel owner of a send window.
+ */
+struct vas_tx_win_attr {
+	enum vas_cop_type cop;
+	int wcreds_max;
+	int lpid;
+	int pidr;		/* hardware PID (from SPRN_PID) */
+	int pid;		/* linux process id */
+	int pswid;
+	int rsvd_txbuf_count;
+	int tc_mode;
+
+	bool user_win;
+	bool pin_win;
+	bool rej_no_credit;
+	bool rsvd_txbuf_enable;
+	bool tx_wcred_mode;
+	bool rx_wcred_mode;
+	bool tx_win_ord_mode;
+	bool rx_win_ord_mode;
+};
+
+/*
  * Helper to initialize receive window attributes to defaults for an
  * NX window.
  */
@@ -97,6 +120,25 @@ extern struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 			struct vas_rx_win_attr *attr);
 
 /*
+ * Helper to initialize send window attributes to defaults for an NX window.
+ */
+extern void vas_init_tx_win_attr(struct vas_tx_win_attr *txattr,
+			enum vas_cop_type cop);
+
+/*
+ * Open a VAS send window for the instance of VAS identified by @vasid
+ * and the co-processor type @cop. Use @attr to initialize attributes
+ * of the window.
+ *
+ * Note: The instance of VAS must already have an open receive window for
+ * the coprocessor type @cop.
+ *
+ * Return a handle to the send window or ERR_PTR() on error.
+ */
+struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
+			struct vas_tx_win_attr *attr);
+
+/*
  * Close the send or receive window identified by @win. For receive windows
  * return -EAGAIN if there are active send windows attached to this receive
  * window.
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 39aa0e4..cd12e44 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -64,7 +64,7 @@ static inline void get_uwc_mmio_bar(struct vas_window *window,
  * space. Unlike MMIO regions (map_mmio_region() below), paste region must
  * be mapped cache-able and is only applicable to send windows.
  */
-void *map_paste_region(struct vas_window *txwin)
+static void *map_paste_region(struct vas_window *txwin)
 {
 	int len;
 	void *map;
@@ -100,7 +100,6 @@ void *map_paste_region(struct vas_window *txwin)
 	return ERR_PTR(-ENOMEM);
 }
 
-
 static void *map_mmio_region(char *name, u64 start, int len)
 {
 	void *map;
@@ -574,7 +573,7 @@ static void put_rx_win(struct vas_window *rxwin)
  *
  * See also function header of set_vinst_win().
  */
-struct vas_window *get_vinst_rxwin(struct vas_instance *vinst,
+static struct vas_window *get_vinst_rxwin(struct vas_instance *vinst,
 			enum vas_cop_type cop, u32 pswid)
 {
 	struct vas_window *rxwin;
@@ -847,6 +846,157 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 }
 EXPORT_SYMBOL_GPL(vas_rx_win_open);
 
+void vas_init_tx_win_attr(struct vas_tx_win_attr *txattr, enum vas_cop_type cop)
+{
+	memset(txattr, 0, sizeof(*txattr));
+
+	if (cop == VAS_COP_TYPE_842 || cop == VAS_COP_TYPE_842_HIPRI) {
+		txattr->rej_no_credit = false;
+		txattr->rx_wcred_mode = true;
+		txattr->tx_wcred_mode = true;
+		txattr->rx_win_ord_mode = true;
+		txattr->tx_win_ord_mode = true;
+	} else if (cop == VAS_COP_TYPE_FTW) {
+		txattr->user_win = true;
+	}
+}
+EXPORT_SYMBOL_GPL(vas_init_tx_win_attr);
+
+static void init_winctx_for_txwin(struct vas_window *txwin,
+			struct vas_tx_win_attr *txattr,
+			struct vas_winctx *winctx)
+{
+	/*
+	 * We first zero all fields and only set non-zero ones. Following
+	 * are some fields set to 0/false for the stated reason:
+	 *
+	 *	->notify_os_intr_reg	In powerNV, send intrs to HV
+	 *	->rsvd_txbuf_count	Not supported yet.
+	 *	->notify_disable	False for NX windows
+	 *	->xtra_write		False for NX windows
+	 *	->notify_early		NA for NX windows
+	 *	->lnotify_lpid		NA for Tx windows
+	 *	->lnotify_pid		NA for Tx windows
+	 *	->lnotify_tid		NA for Tx windows
+	 *	->tx_win_cred_mode	Ignore for now for NX windows
+	 *	->rx_win_cred_mode	Ignore for now for NX windows
+	 */
+	memset(winctx, 0, sizeof(struct vas_winctx));
+
+	winctx->wcreds_max = txattr->wcreds_max ?: VAS_WCREDS_DEFAULT;
+
+	winctx->user_win = txattr->user_win;
+	winctx->nx_win = txwin->rxwin->nx_win;
+	winctx->pin_win = txattr->pin_win;
+
+	winctx->rx_wcred_mode = txattr->rx_wcred_mode;
+	winctx->tx_wcred_mode = txattr->tx_wcred_mode;
+	winctx->rx_word_mode = txattr->rx_win_ord_mode;
+	winctx->tx_word_mode = txattr->tx_win_ord_mode;
+
+	if (winctx->nx_win) {
+		winctx->data_stamp = true;
+		winctx->intr_disable = true;
+	}
+
+	winctx->lpid = txattr->lpid;
+	winctx->pidr = txattr->pidr;
+	winctx->rx_win_id = txwin->rxwin->winid;
+
+	winctx->dma_type = VAS_DMA_TYPE_INJECT;
+	winctx->tc_mode = txattr->tc_mode;
+	winctx->min_scope = VAS_SCOPE_LOCAL;
+	winctx->max_scope = VAS_SCOPE_VECTORED_GROUP;
+
+	winctx->pswid = 0;
+}
+
+static bool tx_win_args_valid(enum vas_cop_type cop,
+			struct vas_tx_win_attr *attr)
+{
+	if (attr->tc_mode != VAS_THRESH_DISABLED)
+		return false;
+
+	if (cop > VAS_COP_TYPE_MAX)
+		return false;
+
+	if (attr->user_win &&
+			(cop != VAS_COP_TYPE_FTW || attr->rsvd_txbuf_count))
+		return false;
+
+	return true;
+}
+
+struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
+			struct vas_tx_win_attr *attr)
+{
+	int rc;
+	struct vas_window *txwin;
+	struct vas_window *rxwin;
+	struct vas_winctx winctx;
+	struct vas_instance *vinst;
+
+	if (!tx_win_args_valid(cop, attr))
+		return ERR_PTR(-EINVAL);
+
+	vinst = find_vas_instance(vasid);
+	if (!vinst) {
+		pr_devel("vasid %d not found!\n", vasid);
+		return ERR_PTR(-EINVAL);
+	}
+
+	rxwin = get_vinst_rxwin(vinst, cop, attr->pswid);
+	if (IS_ERR(rxwin)) {
+		pr_devel("No RxWin for vasid %d, cop %d\n", vasid, cop);
+		return rxwin;
+	}
+
+	txwin = vas_window_alloc(vinst);
+	if (IS_ERR(txwin)) {
+		rc = PTR_ERR(txwin);
+		goto put_rxwin;
+	}
+
+	txwin->tx_win = 1;
+	txwin->rxwin = rxwin;
+	txwin->nx_win = txwin->rxwin->nx_win;
+	txwin->pid = attr->pid;
+	txwin->user_win = attr->user_win;
+
+	init_winctx_for_txwin(txwin, attr, &winctx);
+
+	init_winctx_regs(txwin, &winctx);
+
+	/*
+	 * If its a kernel send window, map the window address into the
+	 * kernel's address space. For user windows, user must issue an
+	 * mmap() to map the window into their address space.
+	 *
+	 * NOTE: If kernel ever resubmits a user CRB after handling a page
+	 *	 fault, we will need to map this into kernel as well.
+	 */
+	if (!txwin->user_win) {
+		txwin->paste_kaddr = map_paste_region(txwin);
+		if (IS_ERR(txwin->paste_kaddr)) {
+			rc = PTR_ERR(txwin->paste_kaddr);
+			goto free_window;
+		}
+	}
+
+	set_vinst_win(vinst, txwin);
+
+	return txwin;
+
+free_window:
+	vas_window_free(txwin);
+
+put_rxwin:
+	put_rx_win(rxwin);
+	return ERR_PTR(rc);
+
+}
+EXPORT_SYMBOL_GPL(vas_tx_win_open);
+
 static void poll_window_busy_state(struct vas_window *window)
 {
 	int busy;
-- 
2.7.4
