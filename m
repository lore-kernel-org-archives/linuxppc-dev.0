Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmTC18wWzDvjM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:27 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmTB1WB0z9tl4
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:25 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGwrqg089080
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:24 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nhv78wxf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:24 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:23 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 04/11] VAS: Define helpers to init window context
Date: Fri, 11 Nov 2016 09:02:49 -0800
In-Reply-To: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1478883776-11121-5-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define helpers to initialize window context registers of the VAS
hardware. These will be used in follow-on patches when opening/closing
VAS windows.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 drivers/misc/vas/vas-internal.h |  55 +++++++
 drivers/misc/vas/vas-window.c   | 330 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 385 insertions(+)

diff --git a/drivers/misc/vas/vas-internal.h b/drivers/misc/vas/vas-internal.h
index 282513b..953b7bb 100644
--- a/drivers/misc/vas/vas-internal.h
+++ b/drivers/misc/vas/vas-internal.h
@@ -367,4 +367,59 @@ extern int vas_initialized;
 extern int vas_window_reset(struct vas_instance *vinst, int winid);
 extern struct vas_instance *find_vas_instance(int node, int chip);
 
+/*
+ * VREG(x):
+ * Expand a register's short name (eg: LPID) into two parameters:
+ *	- the register's short name in string form ("LPID"), and
+ *	- the name of the macro (eg: VAS_LPID_OFFSET), defining the
+ *	  register's offset in the window context
+ */
+#define VREG_SFX(n, s)	__stringify(n), VAS_##n##s
+#define VREG(r)		VREG_SFX(r, _OFFSET)
+
+#ifndef vas_debug
+static inline void vas_log_write(struct vas_window *win, char *name,
+			void *regptr, uint64_t val)
+{
+	if (val)
+		pr_err("%swin #%d: %s reg %p, val 0x%llx\n",
+				win->txwin ? "Tx" : "Rx", win->winid, name,
+				regptr, val);
+}
+
+#else	/* vas_debug */
+
+#define vas_log_write(win, name, reg, val)
+
+#endif	/* vas_debug */
+
+
+static inline void write_uwc_reg(struct vas_window *win, char *name,
+			int32_t reg, uint64_t val)
+{
+	void *regptr;
+
+	regptr = win->uwc_map + reg;
+	vas_log_write(win, name, regptr, val);
+
+	out_be64(regptr, val);
+}
+
+static inline void write_hvwc_reg(struct vas_window *win, char *name,
+			int32_t reg, uint64_t val)
+{
+	void *regptr;
+
+	regptr = win->hvwc_map + reg;
+	vas_log_write(win, name, regptr, val);
+
+	out_be64(regptr, val);
+}
+
+static inline uint64_t read_hvwc_reg(struct vas_window *win,
+			char *name __maybe_unused, int32_t reg)
+{
+	return in_be64(win->hvwc_map+reg);
+}
+
 #endif
diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index 2c220a3..797b4ebd 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -14,6 +14,8 @@
 #include <asm/vas.h>
 #include "vas-internal.h"
 
+static int fault_winid;
+
 /*
  * Using the node, chip and window id for the send winow identified by
  * @window, compute and return the Power Bus address to which a sender
@@ -194,6 +196,334 @@ int map_wc_mmio_bars(struct vas_window *window)
 	return 0;
 }
 
+/*
+ * Reset all valid registers in the HV and OS/User Window Contexts for
+ * the window identified by @window.
+ *
+ * NOTE: We cannot really use a for loop to reset window context. Not all
+ *	 offsets in a window context are valid registers and the valid
+ *	 registers are not sequential. And, we can only write to offsets
+ *	 with valid registers (or is that only in Simics?).
+ */
+void reset_window_regs(struct vas_window *window)
+{
+	write_hvwc_reg(window, VREG(LPID), 0ULL);
+	write_hvwc_reg(window, VREG(PID), 0ULL);
+	write_hvwc_reg(window, VREG(XLATE_MSR), 0ULL);
+	write_hvwc_reg(window, VREG(XLATE_LPCR), 0ULL);
+	write_hvwc_reg(window, VREG(XLATE_CTL), 0ULL);
+	write_hvwc_reg(window, VREG(AMR), 0ULL);
+	write_hvwc_reg(window, VREG(SEIDR), 0ULL);
+	write_hvwc_reg(window, VREG(FAULT_TX_WIN), 0ULL);
+	write_hvwc_reg(window, VREG(OSU_INTR_SRC_RA), 0ULL);
+	write_hvwc_reg(window, VREG(HV_INTR_SRC_RA), 0ULL);
+	write_hvwc_reg(window, VREG(PSWID), 0ULL);
+	write_hvwc_reg(window, VREG(SPARE1), 0ULL);
+	write_hvwc_reg(window, VREG(SPARE2), 0ULL);
+	write_hvwc_reg(window, VREG(SPARE3), 0ULL);
+	write_hvwc_reg(window, VREG(SPARE4), 0ULL);
+	write_hvwc_reg(window, VREG(SPARE5), 0ULL);
+	write_hvwc_reg(window, VREG(SPARE6), 0ULL);
+	write_hvwc_reg(window, VREG(LFIFO_BAR), 0ULL);
+	write_hvwc_reg(window, VREG(LDATA_STAMP_CTL), 0ULL);
+	write_hvwc_reg(window, VREG(LDMA_CACHE_CTL), 0ULL);
+	write_hvwc_reg(window, VREG(LRFIFO_PUSH), 0ULL);
+	write_hvwc_reg(window, VREG(CURR_MSG_COUNT), 0ULL);
+	write_hvwc_reg(window, VREG(LNOTIFY_AFTER_COUNT), 0ULL);
+	write_hvwc_reg(window, VREG(LRX_WCRED), 0ULL);
+	write_hvwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
+	write_hvwc_reg(window, VREG(TX_WCRED), 0ULL);
+	write_hvwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
+	write_hvwc_reg(window, VREG(LFIFO_SIZE), 0ULL);
+	write_hvwc_reg(window, VREG(WINCTL), 0ULL);
+	write_hvwc_reg(window, VREG(WIN_STATUS), 0ULL);
+	write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), 0ULL);
+	write_hvwc_reg(window, VREG(TX_RSVD_BUF_COUNT), 0ULL);
+	write_hvwc_reg(window, VREG(LRFIFO_WIN_PTR), 0ULL);
+	write_hvwc_reg(window, VREG(LNOTIFY_CTL), 0ULL);
+	write_hvwc_reg(window, VREG(LNOTIFY_PID), 0ULL);
+	write_hvwc_reg(window, VREG(LNOTIFY_LPID), 0ULL);
+	write_hvwc_reg(window, VREG(LNOTIFY_TID), 0ULL);
+	write_hvwc_reg(window, VREG(LNOTIFY_SCOPE), 0ULL);
+	write_hvwc_reg(window, VREG(NX_UTIL), 0ULL);
+	write_hvwc_reg(window, VREG(NX_UTIL_SE), 0ULL);
+	write_hvwc_reg(window, VREG(NX_UTIL_ADDER), 0ULL);
+
+	/*
+	 * TODO: The Send and receive window credit adder registers are
+	 *	also accessible from HVWC and have been initialized above.
+	 *	We probably don't need to initialize from the OS/User
+	 *	Window Context? Initialize anyway for now.
+	 */
+	write_uwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
+	write_uwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
+}
+
+/*
+ * Initialize window context registers related to Address Translation.
+ * These registers are common to send/receive windows although they
+ * differ for user/kernel windows. As we resolve the TODOs we may
+ * want to add fields to vas_winctx and move the intialization to
+ * init_vas_winctx_regs().
+ */
+static void init_xlate_regs(struct vas_window *window, bool user_win)
+{
+	uint64_t lpcr, msr, val;
+
+	reset_window_regs(window);
+
+	msr = mfmsr();
+	WARN_ON_ONCE(!(msr & MSR_SF));
+	val = 0ULL;
+	if (user_win) {
+		val = SET_FIELD(VAS_XLATE_MSR_DR, val, true);
+		val = SET_FIELD(VAS_XLATE_MSR_TA, val, false);
+		val = SET_FIELD(VAS_XLATE_MSR_PR, val, true);
+		val = SET_FIELD(VAS_XLATE_MSR_US, val, false);
+		val = SET_FIELD(VAS_XLATE_MSR_HV, val, true);
+		val = SET_FIELD(VAS_XLATE_MSR_SF, val, true);
+		val = SET_FIELD(VAS_XLATE_MSR_UV, val, false);
+	} else {
+		val = SET_FIELD(VAS_XLATE_MSR_DR, val, false);
+		val = SET_FIELD(VAS_XLATE_MSR_TA, val, false);
+		val = SET_FIELD(VAS_XLATE_MSR_PR, val, msr & MSR_PR);
+		val = SET_FIELD(VAS_XLATE_MSR_US, val, false);
+		val = SET_FIELD(VAS_XLATE_MSR_HV, val, true);
+		val = SET_FIELD(VAS_XLATE_MSR_SF, val, true);
+		val = SET_FIELD(VAS_XLATE_MSR_UV, val, false);
+	}
+	write_hvwc_reg(window, VREG(XLATE_MSR), val);
+
+	lpcr = mfspr(SPRN_LPCR);
+	val = 0ULL;
+	/*
+	 * NOTE: From Section 5.7.6.1 Segment Lookaside Buffer of the
+	 *	 Power ISA, v2.07, Page size encoding is 0 = 4KB, 5 = 64KB.
+	 *
+	 * NOTE: From Section 1.3.1, Address Translation Context of the
+	 *	 Nest MMU Workbook, LPCR_SC should be 0 for Power9.
+	 */
+	val = SET_FIELD(VAS_XLATE_LPCR_PAGE_SIZE, val, 5);
+	val = SET_FIELD(VAS_XLATE_LPCR_ISL, val, lpcr & LPCR_ISL);
+	val = SET_FIELD(VAS_XLATE_LPCR_TC, val, lpcr & LPCR_TC);
+	val = SET_FIELD(VAS_XLATE_LPCR_SC, val, 0);
+	write_hvwc_reg(window, VREG(XLATE_LPCR), val);
+
+	/*
+	 * Section 1.3.1 (Address translation Context) of NMMU workbook.
+	 *	0b00	Hashed Page Table mode
+	 *	0b01	Reserved
+	 *	0b10	Radix on HPT - not supported in P9
+	 *	0b11	Radix on Radix (only mode supported in Linux on P9).
+	 */
+	val = 0ULL;
+	val = SET_FIELD(VAS_XLATE_MODE, val, 0x11);
+	write_hvwc_reg(window, VREG(XLATE_CTL), val);
+
+	/*
+	 * TODO: Can we mfspr(AMR) even for user windows?
+	 */
+	val = 0ULL;
+	val = SET_FIELD(VAS_AMR, val, mfspr(SPRN_AMR));
+	write_hvwc_reg(window, VREG(AMR), val);
+
+	/*
+	 * TODO: Assuming Secure Executable ID Register (SEIDR) is only used
+	 *	 in the ultravisor mode. Since MSR(UV) is 0 for now, set SEIDR
+	 *	 to 0 as well, although we should 'mfspr(SEIDR)' at some point.
+	 */
+	val = 0ULL;
+	val = SET_FIELD(VAS_SEIDR, val, 0);
+	write_hvwc_reg(window, VREG(SEIDR), val);
+}
+
+/*
+ * Initialize Reserved Send Buffer Count for the send window. It involves
+ * writing to the register, reading it back to confirm that the hardware
+ * has enough buffers to reserve. See section 1.3.1.2.1 of VAS workbook.
+ *
+ * Since we can only make a best-effort attempt to fulfill the request,
+ * we don't return any errors if we cannot.
+ *
+ * TODO: Reserved (aka dedicated) send buffers are not supported yet.
+ */
+static void init_rsvd_tx_buf_count(struct vas_window *txwin,
+				struct vas_winctx *winctx)
+{
+	write_hvwc_reg(txwin, VREG(TX_RSVD_BUF_COUNT), 0ULL);
+}
+
+/*
+ * Compute the log2() of the FIFO size expressed as kilobytes. It is intended
+ * to be used to initialize the Local FIFO Size Register defined in Section
+ * 3.14.25 of the VAS Workbook.
+ */
+static int map_fifo_size_to_reg(int fifo_size)
+{
+	int kb;
+	int map;
+
+	kb = fifo_size / 1024;
+	if (!kb)
+		kb = 1;
+
+	map = -1;
+	while (kb) {
+		kb >>= 1;
+		map++;
+	}
+
+	return map;
+}
+
+/*
+ * init_winctx_regs()
+ *	Initialize window context registers for a receive window.
+ *	Except for caching control and marking window open, the registers
+ *	are initialized in the order listed in Section 3.1.4 (Window Context
+ *	Cache Register Details) of the VAS workbook although they don't need
+ *	to be.
+ *
+ * Design note: For NX receive windows, NX allocates the FIFO buffer in OPAL
+ *	(so that it can get a large contiguous area) and passes that buffer
+ *	to kernel via device tree. We now write that buffer address to the
+ *	FIFO BAR. Would it make sense to do this all in OPAL? i.e have OPAL
+ *	write the per-chip RX FIFO addresses to the windows during boot-up
+ *	as a one-time task? That could work for NX but what about other
+ *	receivers?  Let the receivers tell us the rx-fifo buffers for now.
+ */
+int init_winctx_regs(struct vas_window *window, struct vas_winctx *winctx)
+{
+	uint64_t val;
+	int fifo_size;
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LPID, val, winctx->lpid);
+	write_hvwc_reg(window, VREG(LPID), val);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_PID_ID, val, winctx->pid);
+	write_hvwc_reg(window, VREG(PID), val);
+
+	init_xlate_regs(window, false);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_FAULT_TX_WIN, val, fault_winid);
+	write_hvwc_reg(window, VREG(FAULT_TX_WIN), val);
+
+	/* In PowerNV, interrupts go to HV. */
+	write_hvwc_reg(window, VREG(OSU_INTR_SRC_RA), 0ULL);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_HV_INTR_SRC_RA, val, window->irq_port);
+	write_hvwc_reg(window, VREG(HV_INTR_SRC_RA), val);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_PSWID_EA_HANDLE, val, winctx->pswid);
+	write_hvwc_reg(window, VREG(PSWID), val);
+
+	write_hvwc_reg(window, VREG(SPARE1), 0ULL);
+	write_hvwc_reg(window, VREG(SPARE2), 0ULL);
+	write_hvwc_reg(window, VREG(SPARE3), 0ULL);
+
+	/* See also: Design note in function header */
+	val = 0ULL;
+	val = SET_FIELD(VAS_LFIFO_BAR, val, __pa(winctx->rx_fifo));
+	val = SET_FIELD(VAS_PAGE_MIGRATION_SELECT, val, 0);
+	write_hvwc_reg(window, VREG(LFIFO_BAR), val);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LDATA_STAMP, val, winctx->data_stamp);
+	write_hvwc_reg(window, VREG(LDATA_STAMP_CTL), val);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LDMA_TYPE, val, winctx->dma_type);
+	write_hvwc_reg(window, VREG(LDMA_CACHE_CTL), val);
+
+	write_hvwc_reg(window, VREG(LRFIFO_PUSH), 0ULL);
+	write_hvwc_reg(window, VREG(CURR_MSG_COUNT), 0ULL);
+	write_hvwc_reg(window, VREG(LNOTIFY_AFTER_COUNT), 0ULL);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LRX_WCRED, val, winctx->wcreds_max);
+	write_hvwc_reg(window, VREG(LRX_WCRED), val);
+
+	write_hvwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
+	write_hvwc_reg(window, VREG(TX_WCRED), 0ULL);
+	write_hvwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
+
+	val = 0ULL;
+	fifo_size = winctx->rx_fifo_size;
+	val = SET_FIELD(VAS_LFIFO_SIZE, val, map_fifo_size_to_reg(fifo_size));
+	write_hvwc_reg(window, VREG(LFIFO_SIZE), val);
+
+	/* Update window control and caching control registers last so
+	 * we mark the window open only after fully initializing it and
+	 * pushing context to cache.
+	 */
+
+	write_hvwc_reg(window, VREG(WIN_STATUS), 0ULL);
+
+	init_rsvd_tx_buf_count(window, winctx);
+
+	/* for a send window, point to the matching receive window */
+	val = 0ULL;
+	val = SET_FIELD(VAS_LRX_WIN_ID, val, winctx->rx_win_id);
+	write_hvwc_reg(window, VREG(LRFIFO_WIN_PTR), val);
+
+	write_hvwc_reg(window, VREG(SPARE4), 0ULL);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_NOTIFY_DISABLE, val, winctx->notify_disable);
+	val = SET_FIELD(VAS_INTR_DISABLE, val, winctx->intr_disable);
+	val = SET_FIELD(VAS_NOTIFY_EARLY, val, winctx->notify_early);
+	val = SET_FIELD(VAS_NOTIFY_OSU_INTR, val, winctx->notify_os_intr_reg);
+	write_hvwc_reg(window, VREG(LNOTIFY_CTL), val);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LNOTIFY_PID, val, winctx->lnotify_pid);
+	write_hvwc_reg(window, VREG(LNOTIFY_PID), val);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LNOTIFY_LPID, val, winctx->lnotify_lpid);
+	write_hvwc_reg(window, VREG(LNOTIFY_LPID), val);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LNOTIFY_TID, val, winctx->lnotify_tid);
+	write_hvwc_reg(window, VREG(LNOTIFY_TID), val);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LNOTIFY_MIN_SCOPE, val, winctx->min_scope);
+	val = SET_FIELD(VAS_LNOTIFY_MAX_SCOPE, val, winctx->max_scope);
+	write_hvwc_reg(window, VREG(LNOTIFY_SCOPE), val);
+
+	write_hvwc_reg(window, VREG(SPARE5), 0ULL);
+	write_hvwc_reg(window, VREG(NX_UTIL), 0ULL);
+	write_hvwc_reg(window, VREG(NX_UTIL_SE), 0ULL);
+	write_hvwc_reg(window, VREG(NX_UTIL_ADDER), 0ULL);
+	write_hvwc_reg(window, VREG(SPARE6), 0ULL);
+
+	/* Finally, push window context to memory and... */
+	val = 0ULL;
+	val = SET_FIELD(VAS_PUSH_TO_MEM, val, 1);
+	write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), val);
+
+	/* ... mark the window open for business */
+	val = 0ULL;
+	val = SET_FIELD(VAS_WINCTL_REJ_NO_CREDIT, val, winctx->rej_no_credit);
+	val = SET_FIELD(VAS_WINCTL_PIN, val, winctx->pin_win);
+	val = SET_FIELD(VAS_WINCTL_TX_WCRED_MODE, val, winctx->tx_wcred_mode);
+	val = SET_FIELD(VAS_WINCTL_RX_WCRED_MODE, val, winctx->rx_wcred_mode);
+	val = SET_FIELD(VAS_WINCTL_TXWIN_ORD_MODE, val, winctx->tx_win_ord_mode);
+	val = SET_FIELD(VAS_WINCTL_RXWIN_ORD_MODE, val, winctx->rx_win_ord_mode);
+	val = SET_FIELD(VAS_WINCTL_FAULT_WIN, val, winctx->fault_win);
+	val = SET_FIELD(VAS_WINCTL_NX_WIN, val, winctx->nx_win);
+	val = SET_FIELD(VAS_WINCTL_OPEN, val, 1);
+	write_hvwc_reg(window, VREG(WINCTL), val);
+
+	return 0;
+}
+
 /* stub for now */
 int vas_window_reset(struct vas_instance *vinst, int winid)
 {
-- 
1.8.3.1
