Return-Path: <srs0=ecaq=47=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYJ4z5QngzDqgp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 15:40:19 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wYJ4z4hL1z8wTf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 15:40:19 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wYJ4y5WzQz9s7p
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 15:40:18 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4P5dNwp060637
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 01:40:16 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2anh770pbs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 01:40:15 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 25 May 2017 01:40:14 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 05/10] VAS: Define helpers to init window context
Date: Wed, 24 May 2017 22:39:45 -0700
In-Reply-To: <1495690790-12172-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1495690790-12172-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1495690790-12172-6-git-send-email-sukadev@linux.vnet.ibm.com>
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
Changelog[v5]
	- Fix: Copy the FIFO address into LFIFO_BAR register as is (don't
	  shift address into bits 8:53).

Changelog[v4]
	- Michael Neuling] Use ilog2(), radix_enabled() helpers;
	  drop warning when 32-bit app uses VAS (a follow-on patch
	  will check and return error). Set MSR_PR state to 0 for
	  kernel (rather than reading from MSR).

Changelog[v3]
	- Have caller, rather than init_xlate_regs() reset window regs
	  so we don't reset any settings caller may already have set.
	- Translation mode should be 0x3 (0b11) not 0x11.
	- Skip initilaizing read-only registers NX_UTIL and NX_UTIL_SE
	- Skip initializing adder registers from UWC - they are already
	  initialized from the HVWC.
	- Check winctx->user_win when setting translation registers
---
 arch/powerpc/platforms/powernv/vas-window.c | 306 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.h        |  55 +++++
 2 files changed, 361 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 588aad7..4135ab0 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -11,9 +11,12 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/log2.h>
 
 #include "vas.h"
 
+static int fault_winid;
+
 /*
  * Compute the paste address region for the window @window using the
  * ->paste_base_addr and ->paste_win_id_shift we got from device tree.
@@ -138,6 +141,309 @@ int map_winctx_mmio_bars(struct vas_window *window)
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
+	write_hvwc_reg(window, VREG(NX_UTIL_ADDER), 0ULL);
+
+	/* Skip read-only registers: NX_UTIL and NX_UTIL_SE */
+
+	/*
+	 * The send and receive window credit adder registers are also
+	 * accessible from HVWC and have been initialized above. We don't
+	 * need to initialize from the OS/User Window Context, so skip
+	 * following calls:
+	 *
+	 *	write_uwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
+	 *	write_uwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
+	 */
+}
+
+/*
+ * Initialize window context registers related to Address Translation.
+ * These registers are common to send/receive windows although they
+ * differ for user/kernel windows. As we resolve the TODOs we may
+ * want to add fields to vas_winctx and move the initialization to
+ * init_vas_winctx_regs().
+ */
+static void init_xlate_regs(struct vas_window *window, bool user_win)
+{
+	uint64_t lpcr, val;
+
+	/*
+	 * MSR_TA, MSR_US are false for both kernel and user.
+	 * MSR_DR and MSR_PR are false for kernel.
+	 */
+	val = 0ULL;
+	val = SET_FIELD(VAS_XLATE_MSR_HV, val, true);
+	val = SET_FIELD(VAS_XLATE_MSR_SF, val, true);
+	if (user_win) {
+		val = SET_FIELD(VAS_XLATE_MSR_DR, val, true);
+		val = SET_FIELD(VAS_XLATE_MSR_PR, val, true);
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
+	 *	0b10	Radix on HPT
+	 *	0b11	Radix on Radix
+	 */
+	val = 0ULL;
+	val = SET_FIELD(VAS_XLATE_MODE, val, radix_enabled() ? 3 : 2);
+	write_hvwc_reg(window, VREG(XLATE_CTL), val);
+
+	/*
+	 * TODO: Can we mfspr(AMR) even for user windows?
+	 */
+	val = 0ULL;
+	val = SET_FIELD(VAS_AMR, val, mfspr(SPRN_AMR));
+	write_hvwc_reg(window, VREG(AMR), val);
+
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
+	reset_window_regs(window);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LPID, val, winctx->lpid);
+	write_hvwc_reg(window, VREG(LPID), val);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_PID_ID, val, winctx->pidr);
+	write_hvwc_reg(window, VREG(PID), val);
+
+	init_xlate_regs(window, winctx->user_win);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_FAULT_TX_WIN, val, fault_winid);
+	write_hvwc_reg(window, VREG(FAULT_TX_WIN), val);
+
+	/* In PowerNV, interrupts go to HV. */
+	write_hvwc_reg(window, VREG(OSU_INTR_SRC_RA), 0ULL);
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_HV_INTR_SRC_RA, val, winctx->irq_port);
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
+	/* 
+	 * NOTE: VAS expects the FIFO address to be copied into the LFIFO_BAR
+	 * 	 register as is - do NOT shift the address into VAS_LFIFO_BAR
+	 * 	 bit fields! Ok to set the page migration select fields -
+	 * 	 VAS ignores the lower 10+ bits in the address anyway, because
+	 * 	 the minimum FIFO size is 1K?
+	 *
+	 * See also: Design note in function header.
+	 */
+	val = __pa(winctx->rx_fifo);
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
+	val = 0ULL;
+	val = SET_FIELD(VAS_TX_WCRED, val, winctx->wcreds_max);
+	write_hvwc_reg(window, VREG(TX_WCRED), val);
+
+	write_hvwc_reg(window, VREG(LRX_WCRED_ADDER), 0ULL);
+	write_hvwc_reg(window, VREG(TX_WCRED_ADDER), 0ULL);
+
+	fifo_size = winctx->rx_fifo_size / 1024;
+
+	val = 0ULL;
+	val = SET_FIELD(VAS_LFIFO_SIZE, val, ilog2(fifo_size));
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
+	/* Skip read-only registers NX_UTIL and NX_UTIL_SE */
+
+	write_hvwc_reg(window, VREG(SPARE5), 0ULL);
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
+	val = SET_FIELD(VAS_WINCTL_TX_WORD_MODE, val, winctx->tx_word_mode);
+	val = SET_FIELD(VAS_WINCTL_RX_WORD_MODE, val, winctx->rx_word_mode);
+	val = SET_FIELD(VAS_WINCTL_FAULT_WIN, val, winctx->fault_win);
+	val = SET_FIELD(VAS_WINCTL_NX_WIN, val, winctx->nx_win);
+	val = SET_FIELD(VAS_WINCTL_OPEN, val, 1);
+	write_hvwc_reg(window, VREG(WINCTL), val);
+
+	return 0;
+}
+
 /* stub for now */
 int vas_win_close(struct vas_window *window)
 {
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 12c6380..895bdec 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -12,6 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/idr.h>
 #include <asm/vas.h>
+#include <linux/io.h>
 
 /*
  * Overview of Virtual Accelerator Switchboard (VAS).
@@ -382,4 +383,58 @@ struct vas_winctx {
 extern bool vas_initialized(void);
 extern struct vas_instance *find_vas_instance(int vasid);
 
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
+		pr_err("%swin #%d: %s reg %p, val 0x%016llx\n",
+				win->tx_win ? "Tx" : "Rx", win->winid, name,
+				regptr, val);
+}
+
+#else	/* vas_debug */
+
+#define vas_log_write(win, name, reg, val)
+
+#endif	/* vas_debug */
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
 #endif /* _VAS_H */
-- 
2.7.4
