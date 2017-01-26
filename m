Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v84MF2dvTzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 12:38:49 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3v84MD6BK3z9t14
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2017 12:38:48 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0Q1cV9L037626
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2017 20:38:47 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2872hs1vag-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2017 20:38:47 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 18:38:46 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org
Subject: [PATCH v2 09/10] VAS: Define vas_tx_win_open()
Date: Wed, 25 Jan 2017 17:38:07 -0800
In-Reply-To: <1485394688-31129-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1485394688-31129-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1485394688-31129-10-git-send-email-sukadev@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/vas.h |  33 ++++++++++
 drivers/misc/vas/vas-window.c  | 142 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index bda851a..a841084 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -67,6 +67,26 @@ struct vas_rx_win_attr {
 };
 
 /*
+ * Window attributes specified by the in-kernel owner of a send window.
+ */
+struct vas_tx_win_attr {
+	enum vas_cop_type cop;
+	int wcreds_max;
+	int lpid;
+	int pid;
+	int pswid;
+	int rsvd_txbuf_count;
+
+	bool user_win;
+	bool pin_win;
+	bool rej_no_credit;
+	bool rsvd_txbuf_enable;
+	bool tx_win_ord_mode;
+	bool rx_win_ord_mode;
+	enum vas_thresh_ctl tc_mode;
+};
+
+/*
  * Open a VAS receive window for the instance of VAS identified by @vasid
  * Use @attr to initialize the attributes of the window.
  *
@@ -76,6 +96,19 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 			struct vas_rx_win_attr *attr);
 
 /*
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
index 4b06780..3b4b801 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -712,6 +712,148 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 	return ERR_PTR(rc);
 }
 
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
+	winctx->rx_word_mode = true;
+	winctx->tx_word_mode = true;
+
+	if (winctx->nx_win) {
+		winctx->data_stamp = true;
+		winctx->intr_disable = true;
+	}
+
+	winctx->lpid = txattr->lpid;
+	winctx->pid = txattr->pid;
+	winctx->rx_win_id = txwin->rxwin->winid;
+	winctx->fault_win_id = fault_winid;
+
+	winctx->dma_type = VAS_DMA_TYPE_INJECT;
+	winctx->tc_mode = txattr->tc_mode;
+	winctx->min_scope = VAS_SCOPE_LOCAL;
+	winctx->max_scope = VAS_SCOPE_VECTORED_GROUP;
+	winctx->irq_port = txwin->irq_port;
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
 int vas_win_close(struct vas_window *window)
 {
 	uint64_t val;
-- 
2.7.4
