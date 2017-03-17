Return-Path: <srs0=ey7g=22=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkrYz0qB6zDqcJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:34:47 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vkrYy67Ntz8xX3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:34:46 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vkrYy2SkYz9s2Q
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 14:34:46 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2H3TkGt057847
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 23:34:42 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2980w6qh4w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 23:34:42 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 23:34:41 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org
Subject: [PATCH v3 09/10] VAS: Define vas_tx_win_open()
Date: Thu, 16 Mar 2017 20:34:01 -0700
In-Reply-To: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1489721642-5657-10-git-send-email-sukadev@linux.vnet.ibm.com>
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

The receive window, identified by the [node, chip, cop] parameters,
must already be open in VAS (i.e connected to an NX engine).

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

---
Changelog [v3]:
- Distinguish between hardware PID (SPRN_PID) and Linux pid.
- Use macros rather than enum for threshold-control mode
- Set the pid of send window from attr (needed for user space
  send windows).
- Ignore irq port setting for now. They are needed for user space
  windows and will be added later
---
 arch/powerpc/include/asm/vas.h |  42 +++++++++++
 drivers/misc/vas/vas-window.c  | 157 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index fc00249..ff8da98 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -67,6 +67,29 @@ struct vas_rx_win_attr {
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
@@ -83,6 +106,25 @@ extern struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
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
diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index 40e4f7d..9caf10b 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -756,6 +756,163 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 	return ERR_PTR(rc);
 }
 
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
+	}
+}
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
+	winctx->fault_win_id = fault_winid;
+
+	winctx->dma_type = VAS_DMA_TYPE_INJECT;
+	winctx->tc_mode = txattr->tc_mode;
+	winctx->min_scope = VAS_SCOPE_LOCAL;
+	winctx->max_scope = VAS_SCOPE_VECTORED_GROUP;
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
+	if (attr->user_win) {
+		if (cop != VAS_COP_TYPE_GZIP && cop != VAS_COP_TYPE_GZIP_HIPRI)
+			return false;
+
+		if (attr->rsvd_txbuf_count != 0)
+			return false;
+	}
+
+	return true;
+}
+
+struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
+			struct vas_tx_win_attr *attr)
+{
+	int rc, winid;
+	struct vas_instance *vinst;
+	struct vas_window *txwin;
+	struct vas_window *rxwin;
+	struct vas_winctx winctx;
+	int size;
+	char *name;
+	uint64_t paste_busaddr;
+
+	if (!vas_initialized)
+		return ERR_PTR(-EAGAIN);
+
+	if (!tx_win_args_valid(cop, attr))
+		return ERR_PTR(-EINVAL);
+
+	vinst = find_vas_instance(vasid);
+	if (!vinst) {
+		pr_devel("VAS: vasid %d not found!\n", vasid);
+		return ERR_PTR(-EINVAL);
+	}
+
+	rxwin = get_vinstance_rxwin(vinst, cop);
+	if (!rxwin) {
+		pr_devel("VAS: No RxWin for vasid %d, cop %d\n", vasid, cop);
+		return ERR_PTR(-EINVAL);
+	}
+
+	rc = -EAGAIN;
+	winid = vas_assign_window_id(&vinst->ida);
+	if (winid < 0)
+		goto put_rxwin;
+
+	rc = -ENOMEM;
+	txwin = vas_window_alloc(vinst, winid);
+	if (!txwin)
+		goto release_winid;
+
+	txwin->tx_win = 1;
+	txwin->rxwin = rxwin;
+	txwin->nx_win = txwin->rxwin->nx_win;
+	txwin->pid = attr->pid;
+
+	init_winctx_for_txwin(txwin, attr, &winctx);
+
+	init_winctx_regs(txwin, &winctx);
+
+	name = kasprintf(GFP_KERNEL, "window-v%d-w%d", vasid, winid);
+	if (!name)
+		goto release_winid;
+
+	txwin->paste_addr_name = name;
+	compute_paste_address(txwin, &paste_busaddr, &size);
+
+	txwin->paste_kaddr = map_mmio_region(name, paste_busaddr, size);
+	if (!txwin->paste_kaddr)
+		goto free_name;
+
+	pr_devel("VAS: mapped paste addr 0x%llx to kaddr 0x%p\n",
+				paste_busaddr, txwin->paste_kaddr);
+	return txwin;
+
+free_name:
+	kfree(txwin->paste_addr_name);
+
+release_winid:
+	vas_release_window_id(&vinst->ida, txwin->winid);
+
+put_rxwin:
+	put_rx_win(rxwin);
+	return ERR_PTR(rc);
+
+}
+
 static void poll_window_busy_state(struct vas_window *window)
 {
 	int busy;
-- 
2.7.4
