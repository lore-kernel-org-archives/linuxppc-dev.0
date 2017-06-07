Return-Path: <srs0=/zb/=5m=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjB2s1tk4zDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 11:35:49 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wjB2s1C80z8sXB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 11:35:49 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wjB2r4Yfgz9s8P
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2017 11:35:48 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v571YKxH067263
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2017 21:35:44 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ax7hcgrqv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 06 Jun 2017 21:35:43 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 6 Jun 2017 21:35:43 -0400
Date: Tue, 6 Jun 2017 18:35:36 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 stewart@linux.vnet.ibm.com, mikey@neuling.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, apopple@au1.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v5 09/10] VAS: Define vas_tx_win_open()
References: <1495690790-12172-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1495690790-12172-10-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495690790-12172-10-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <20170607013535.GB25281@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
> +static void *map_paste_region(char *name, uint64_t start, int len)
> +{
> +	void *map;
> +
> +	if (!request_mem_region(start, len, name)) {
> +		pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
> +				__func__, start, len);
> +		return NULL;
> +	}
> +
> +	map = __ioremap(start, len, pgprot_val(pgprot_cached(__pgprot(0))));
> +	if (!map) {
> +		pr_devel("%s(): ioremap(0x%llx, %d) failed\n", __func__, start,
> +				len);
> +		return NULL;
> +	}
> +
> +	return map;
> +}

Based on Ben Herrenschmidt and Michael Ellerman's comments, replaced the
__ioremap() call above with ioremap_cache(start, len). Here is the updated
patch.

---
>From 6975948dba82007d15ee6003116db15a4c942297 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Wed, 15 Mar 2017 20:44:21 -0400
Subject: [PATCH 1/1] VAS: Define vas_tx_win_open()

Define an interface to open a VAS send window. This interface is
intended to be used the Nest Accelerator (NX) driver(s) to open
a send window and use it to submit compression/encryption requests
to a VAS receive window.

The receive window, identified by the [vasid, cop] parameters, must
already be open in VAS (i.e connected to an NX engine).

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

---
Changelog[v5]:
	- [Ben Herrenschmidt] MMIO regions must be mapped non-cached and
	  paste regions must be mapped cached. Define/use map_paste_region().
	- [Michael Ellerman, Ben Herrenschmidt] use ioremap_cache() rather
	  than messing with pgprot flags.

Changelog [v3]:
	- Distinguish between hardware PID (SPRN_PID) and Linux pid.
	- Use macros rather than enum for threshold-control mode
	- Set the pid of send window from attr (needed for user space
	  send windows).
	- Ignore irq port setting for now. They are needed for user space
	  windows and will be added later
---
 arch/powerpc/include/asm/vas.h              |  42 +++++++
 arch/powerpc/platforms/powernv/vas-window.c | 183 ++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index c923b8f..944bb4b 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -61,6 +61,29 @@ struct vas_rx_win_attr {
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
@@ -77,6 +100,25 @@ extern struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
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
index caacc28..fb8ccf9 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -56,6 +56,30 @@ static inline void get_uwc_mmio_bar(struct vas_window *window,
 	*len = VAS_UWC_SIZE;
 }
 
+/*
+ * Unlike MMIO regions (map_mmio_region() below), paste region must be mapped
+ * cache-able.
+ */
+static void *map_paste_region(char *name, uint64_t start, int len)
+{
+	void *map;
+
+	if (!request_mem_region(start, len, name)) {
+		pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
+				__func__, start, len);
+		return NULL;
+	}
+
+	map = ioremap_cache(start, len);
+	if (!map) {
+		pr_devel("%s(): ioremap_cache(0x%llx, %d) failed\n",
+				__func__, start, len);
+		return NULL;
+	}
+
+	return map;
+}
+
 static void *map_mmio_region(char *name, uint64_t start, int len)
 {
 	void *map;
@@ -718,6 +742,165 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
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
+	if (!vas_initialized())
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
+	txwin->paste_kaddr = map_paste_region(name, paste_busaddr, size);
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
+EXPORT_SYMBOL_GPL(vas_tx_win_open);
+
 static void poll_window_busy_state(struct vas_window *window)
 {
 	int busy;
-- 
1.8.3.1
