Return-Path: <srs0=4uxs=77=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhJW26Kn7zDqR9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:23:58 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xhJW25Z49z8vDS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:23:58 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xhJW22kQyz9t3P
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 16:23:58 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7T6KVpK109602
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:23:56 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmwgaky3p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:23:55 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 02:23:54 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 01/10] powerpc/vas: Define macros,
 register fields and structures
Date: Mon, 28 Aug 2017 23:23:31 -0700
In-Reply-To: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503987820-31933-2-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define macros for the VAS hardware registers and bit-fields as well
as couple of data structures needed by the VAS driver.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v8]
	- Use u64/u32 instead of the uintXX versions.

Changelog[v7]
	- Move the threshold control macros from uapi/asm/vas.h to
	  asm/vas.h for now. When we actually have an user space need for
	  them, we can move them to uapi/asm/vas.h. With this change,
	  uapi/asm/vas.h is empty and can be dropped from this patch.

Changelog[v6]
	- Add some fields for FTW windows

Changelog[v4]
	- [Michael Neuling] Move VAS code to arch/powerpc; Reorg vas.h and
	  vas-internal.h to kernel and uapi versions; rather than creating
	  separate properties for window context/address entries in device
	  tree, combine them into "reg" properties; drop ->hwirq and irq_port
	  fields from vas_window as they are only needed with user space
	  windows.
	- Drop the error check for CONFIG_PPC_4K_PAGES. Instead in a
	  follow-on patch add a "depends on CONFIG_PPC_64K_PAGES".

Changelog[v3]
	- Rename winctx->pid to winctx->pidr to reflect that its a value
	  from the PID register (SPRN_PID), not the linux process id.
	- Make it easier to split header into kernel/user parts
	- To keep user interface simple, use macros rather than enum for
	  the threshold-control modes.
	- Add a pid field to struct vas_window - needed for user space
	  send windows.

Changelog[v2]
	- Add an overview of VAS in vas-internal.h
	- Get window context parameters from device tree and drop
	  unnecessary macros.
---
 arch/powerpc/include/asm/vas.h       |  45 +++++
 arch/powerpc/platforms/powernv/vas.h | 382 +++++++++++++++++++++++++++++++++++
 2 files changed, 427 insertions(+)
 create mode 100644 arch/powerpc/include/asm/vas.h
 create mode 100644 arch/powerpc/platforms/powernv/vas.h

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
new file mode 100644
index 0000000..ff87e44
--- /dev/null
+++ b/arch/powerpc/include/asm/vas.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2016-17 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _MISC_VAS_H
+#define _MISC_VAS_H
+
+/*
+ * Min and max FIFO sizes are based on Version 1.05 Section 3.1.4.25
+ * (Local FIFO Size Register) of the VAS workbook.
+ */
+#define VAS_RX_FIFO_SIZE_MIN	(1 << 10)	/* 1KB */
+#define VAS_RX_FIFO_SIZE_MAX	(8 << 20)	/* 8MB */
+
+/*
+ * Threshold Control Mode: Have paste operation fail if the number of
+ * requests in receive FIFO exceeds a threshold.
+ *
+ * NOTE: No special error code yet if paste is rejected because of these
+ *	 limits. So users can't distinguish between this and other errors.
+ */
+#define VAS_THRESH_DISABLED		0
+#define VAS_THRESH_FIFO_GT_HALF_FULL	1
+#define VAS_THRESH_FIFO_GT_QTR_FULL	2
+#define VAS_THRESH_FIFO_GT_EIGHTH_FULL	3
+
+/*
+ * Co-processor Engine type.
+ */
+enum vas_cop_type {
+	VAS_COP_TYPE_FAULT,
+	VAS_COP_TYPE_842,
+	VAS_COP_TYPE_842_HIPRI,
+	VAS_COP_TYPE_GZIP,
+	VAS_COP_TYPE_GZIP_HIPRI,
+	VAS_COP_TYPE_FTW,
+	VAS_COP_TYPE_MAX,
+};
+
+#endif /* _MISC_VAS_H */
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
new file mode 100644
index 0000000..abb545f
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -0,0 +1,382 @@
+/*
+ * Copyright 2016-17 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _VAS_H
+#define _VAS_H
+#include <linux/atomic.h>
+#include <linux/idr.h>
+#include <asm/vas.h>
+
+/*
+ * Overview of Virtual Accelerator Switchboard (VAS).
+ *
+ * VAS is a hardware "switchboard" that allows senders and receivers to
+ * exchange messages with _minimal_ kernel involvment. The receivers are
+ * typically NX coprocessor engines that perform compression or encryption
+ * in hardware, but receivers can also be other software threads.
+ *
+ * Senders are user/kernel threads that submit compression/encryption or
+ * other requests to the receivers. Senders must format their messages as
+ * Coprocessor Request Blocks (CRB)s and submit them using the "copy" and
+ * "paste" instructions which were introduced in Power9.
+ *
+ * A Power node can have (upto?) 8 Power chips. There is one instance of
+ * VAS in each Power9 chip. Each instance of VAS has 64K windows or ports,
+ * Senders and receivers must each connect to a separate window before they
+ * can exchange messages through the switchboard.
+ *
+ * Each window is described by two types of window contexts:
+ *
+ *	Hypervisor Window Context (HVWC) of size VAS_HVWC_SIZE bytes
+ *
+ *	OS/User Window Context (UWC) of size VAS_UWC_SIZE bytes.
+ *
+ * A window context can be viewed as a set of 64-bit registers. The settings
+ * in these registers configure/control/determine the behavior of the VAS
+ * hardware when messages are sent/received through the window. The registers
+ * in the HVWC are configured by the kernel while the registers in the UWC can
+ * be configured by the kernel or by the user space application that is using
+ * the window.
+ *
+ * The HVWCs for all windows on a specific instance of VAS are in a contiguous
+ * range of hardware addresses or Base address region (BAR) referred to as the
+ * HVWC BAR for the instance. Similarly the UWCs for all windows on an instance
+ * are referred to as the UWC BAR for the instance.
+ *
+ * The two BARs for each instance are defined Power9 MMIO Ranges spreadsheet
+ * and available to the kernel in the VAS node's "reg" property in the device
+ * tree:
+ *
+ *	/proc/device-tree/vasm@.../reg
+ *
+ * (see vas_probe() for details on the reg property).
+ *
+ * The kernel maps the HVWC and UWC BAR regions into the kernel address
+ * space (hvwc_map and uwc_map). The kernel can then access the window
+ * contexts of a specific window using:
+ *
+ *	 hvwc = hvwc_map + winid * VAS_HVWC_SIZE.
+ *	 uwc = uwc_map + winid * VAS_UWC_SIZE.
+ *
+ * where winid is the window index (0..64K).
+ *
+ * As mentioned, a window context is used to "configure" a window. Besides
+ * this configuration address, each _send_ window also has a unique hardware
+ * "paste" address that is used to submit requests/CRBs (see vas_paste_crb()).
+ *
+ * The hardware paste address for a window is computed using the "paste
+ * base address" and "paste win id shift" reg properties in the VAS device
+ * tree node using:
+ *
+ *	paste_addr = paste_base + ((winid << paste_win_id_shift))
+ *
+ * (again, see vas_probe() for ->paste_base_addr and ->paste_win_id_shift).
+ *
+ * The kernel maps this hardware address into the sender's address space
+ * after which they can use the 'paste' instruction (new in Power9) to
+ * send a message (submit a request aka CRB) to the coprocessor.
+ *
+ * NOTE: In the initial version, senders can only in-kernel drivers/threads.
+ *	 Support for user space threads will be added in follow-on patches.
+ *
+ * TODO: Do we need to map the UWC into user address space so they can return
+ *	 credits? Its NA for NX but may be needed for other receive windows.
+ *
+ */
+
+#define VAS_WINDOWS_PER_CHIP		(64 << 10)
+
+/*
+ * Hypervisor and OS/USer Window Context sizes
+ */
+#define VAS_HVWC_SIZE			512
+#define VAS_UWC_SIZE			PAGE_SIZE
+
+/*
+ * Initial per-process credits.
+ * Max send window credits:    4K-1 (12-bits in VAS_TX_WCRED)
+ * Max receive window credits: 64K-1 (16 bits in VAS_LRX_WCRED)
+ *
+ * TODO: Needs tuning for per-process credits
+ */
+#define VAS_WCREDS_MIN			16
+#define VAS_WCREDS_MAX			((64 << 10) - 1)
+#define VAS_WCREDS_DEFAULT		(1 << 10)
+
+/*
+ * VAS Window Context Register Offsets and bitmasks.
+ * See Section 3.1.4 of VAS Work book
+ */
+#define VAS_LPID_OFFSET			0x010
+#define VAS_LPID			PPC_BITMASK(0, 11)
+
+#define VAS_PID_OFFSET			0x018
+#define VAS_PID_ID			PPC_BITMASK(0, 19)
+
+#define VAS_XLATE_MSR_OFFSET		0x020
+#define VAS_XLATE_MSR_DR		PPC_BIT(0)
+#define VAS_XLATE_MSR_TA		PPC_BIT(1)
+#define VAS_XLATE_MSR_PR		PPC_BIT(2)
+#define VAS_XLATE_MSR_US		PPC_BIT(3)
+#define VAS_XLATE_MSR_HV		PPC_BIT(4)
+#define VAS_XLATE_MSR_SF		PPC_BIT(5)
+
+#define VAS_XLATE_LPCR_OFFSET		0x028
+#define VAS_XLATE_LPCR_PAGE_SIZE	PPC_BITMASK(0, 2)
+#define VAS_XLATE_LPCR_ISL		PPC_BIT(3)
+#define VAS_XLATE_LPCR_TC		PPC_BIT(4)
+#define VAS_XLATE_LPCR_SC		PPC_BIT(5)
+
+#define VAS_XLATE_CTL_OFFSET		0x030
+#define VAS_XLATE_MODE			PPC_BITMASK(0, 1)
+
+#define VAS_AMR_OFFSET			0x040
+#define VAS_AMR				PPC_BITMASK(0, 63)
+
+#define VAS_SEIDR_OFFSET		0x048
+#define VAS_SEIDR			PPC_BITMASK(0, 63)
+
+#define VAS_FAULT_TX_WIN_OFFSET		0x050
+#define VAS_FAULT_TX_WIN		PPC_BITMASK(48, 63)
+
+#define VAS_OSU_INTR_SRC_RA_OFFSET	0x060
+#define VAS_OSU_INTR_SRC_RA		PPC_BITMASK(8, 63)
+
+#define VAS_HV_INTR_SRC_RA_OFFSET	0x070
+#define VAS_HV_INTR_SRC_RA		PPC_BITMASK(8, 63)
+
+#define VAS_PSWID_OFFSET		0x078
+#define VAS_PSWID_EA_HANDLE		PPC_BITMASK(0, 31)
+
+#define VAS_SPARE1_OFFSET		0x080
+#define VAS_SPARE2_OFFSET		0x088
+#define VAS_SPARE3_OFFSET		0x090
+#define VAS_SPARE4_OFFSET		0x130
+#define VAS_SPARE5_OFFSET		0x160
+#define VAS_SPARE6_OFFSET		0x188
+
+#define VAS_LFIFO_BAR_OFFSET		0x0A0
+#define VAS_LFIFO_BAR			PPC_BITMASK(8, 53)
+#define VAS_PAGE_MIGRATION_SELECT	PPC_BITMASK(54, 56)
+
+#define VAS_LDATA_STAMP_CTL_OFFSET	0x0A8
+#define VAS_LDATA_STAMP			PPC_BITMASK(0, 1)
+#define VAS_XTRA_WRITE			PPC_BIT(2)
+
+#define VAS_LDMA_CACHE_CTL_OFFSET	0x0B0
+#define VAS_LDMA_TYPE			PPC_BITMASK(0, 1)
+#define VAS_LDMA_FIFO_DISABLE		PPC_BIT(2)
+
+#define VAS_LRFIFO_PUSH_OFFSET		0x0B8
+#define VAS_LRFIFO_PUSH			PPC_BITMASK(0, 15)
+
+#define VAS_CURR_MSG_COUNT_OFFSET	0x0C0
+#define VAS_CURR_MSG_COUNT		PPC_BITMASK(0, 7)
+
+#define VAS_LNOTIFY_AFTER_COUNT_OFFSET	0x0C8
+#define VAS_LNOTIFY_AFTER_COUNT		PPC_BITMASK(0, 7)
+
+#define VAS_LRX_WCRED_OFFSET		0x0E0
+#define VAS_LRX_WCRED			PPC_BITMASK(0, 15)
+
+#define VAS_LRX_WCRED_ADDER_OFFSET	0x190
+#define VAS_LRX_WCRED_ADDER		PPC_BITMASK(0, 15)
+
+#define VAS_TX_WCRED_OFFSET		0x0F0
+#define VAS_TX_WCRED			PPC_BITMASK(4, 15)
+
+#define VAS_TX_WCRED_ADDER_OFFSET	0x1A0
+#define VAS_TX_WCRED_ADDER		PPC_BITMASK(4, 15)
+
+#define VAS_LFIFO_SIZE_OFFSET		0x100
+#define VAS_LFIFO_SIZE			PPC_BITMASK(0, 3)
+
+#define VAS_WINCTL_OFFSET		0x108
+#define VAS_WINCTL_OPEN			PPC_BIT(0)
+#define VAS_WINCTL_REJ_NO_CREDIT	PPC_BIT(1)
+#define VAS_WINCTL_PIN			PPC_BIT(2)
+#define VAS_WINCTL_TX_WCRED_MODE	PPC_BIT(3)
+#define VAS_WINCTL_RX_WCRED_MODE	PPC_BIT(4)
+#define VAS_WINCTL_TX_WORD_MODE		PPC_BIT(5)
+#define VAS_WINCTL_RX_WORD_MODE		PPC_BIT(6)
+#define VAS_WINCTL_RSVD_TXBUF		PPC_BIT(7)
+#define VAS_WINCTL_THRESH_CTL		PPC_BITMASK(8, 9)
+#define VAS_WINCTL_FAULT_WIN		PPC_BIT(10)
+#define VAS_WINCTL_NX_WIN		PPC_BIT(11)
+
+#define VAS_WIN_STATUS_OFFSET		0x110
+#define VAS_WIN_BUSY			PPC_BIT(1)
+
+#define VAS_WIN_CTX_CACHING_CTL_OFFSET	0x118
+#define VAS_CASTOUT_REQ			PPC_BIT(0)
+#define VAS_PUSH_TO_MEM			PPC_BIT(1)
+#define VAS_WIN_CACHE_STATUS		PPC_BIT(4)
+
+#define VAS_TX_RSVD_BUF_COUNT_OFFSET	0x120
+#define VAS_RXVD_BUF_COUNT		PPC_BITMASK(58, 63)
+
+#define VAS_LRFIFO_WIN_PTR_OFFSET	0x128
+#define VAS_LRX_WIN_ID			PPC_BITMASK(0, 15)
+
+/*
+ * Local Notification Control Register controls what happens in _response_
+ * to a paste command and hence applies only to receive windows.
+ */
+#define VAS_LNOTIFY_CTL_OFFSET		0x138
+#define VAS_NOTIFY_DISABLE		PPC_BIT(0)
+#define VAS_INTR_DISABLE		PPC_BIT(1)
+#define VAS_NOTIFY_EARLY		PPC_BIT(2)
+#define VAS_NOTIFY_OSU_INTR		PPC_BIT(3)
+
+#define VAS_LNOTIFY_PID_OFFSET		0x140
+#define VAS_LNOTIFY_PID			PPC_BITMASK(0, 19)
+
+#define VAS_LNOTIFY_LPID_OFFSET		0x148
+#define VAS_LNOTIFY_LPID		PPC_BITMASK(0, 11)
+
+#define VAS_LNOTIFY_TID_OFFSET		0x150
+#define VAS_LNOTIFY_TID			PPC_BITMASK(0, 15)
+
+#define VAS_LNOTIFY_SCOPE_OFFSET	0x158
+#define VAS_LNOTIFY_MIN_SCOPE		PPC_BITMASK(0, 1)
+#define VAS_LNOTIFY_MAX_SCOPE		PPC_BITMASK(2, 3)
+
+#define VAS_NX_UTIL_OFFSET		0x1B0
+#define VAS_NX_UTIL			PPC_BITMASK(0, 63)
+
+/* SE: Side effects */
+#define VAS_NX_UTIL_SE_OFFSET		0x1B8
+#define VAS_NX_UTIL_SE			PPC_BITMASK(0, 63)
+
+#define VAS_NX_UTIL_ADDER_OFFSET	0x180
+#define VAS_NX_UTIL_ADDER		PPC_BITMASK(32, 63)
+
+/*
+ * Local Notify Scope Control Register. (Receive windows only).
+ */
+enum vas_notify_scope {
+	VAS_SCOPE_LOCAL,
+	VAS_SCOPE_GROUP,
+	VAS_SCOPE_VECTORED_GROUP,
+	VAS_SCOPE_UNUSED,
+};
+
+/*
+ * Local DMA Cache Control Register (Receive windows only).
+ */
+enum vas_dma_type {
+	VAS_DMA_TYPE_INJECT,
+	VAS_DMA_TYPE_WRITE,
+};
+
+/*
+ * Local Notify Scope Control Register. (Receive windows only).
+ * Not applicable to NX receive windows.
+ */
+enum vas_notify_after_count {
+	VAS_NOTIFY_AFTER_256 = 0,
+	VAS_NOTIFY_NONE,
+	VAS_NOTIFY_AFTER_2
+};
+
+/*
+ * One per instance of VAS. Each instance will have a separate set of
+ * receive windows, one per coprocessor type.
+ */
+struct vas_instance {
+	int vas_id;
+	struct ida ida;
+	struct list_head node;
+	struct platform_device *pdev;
+
+	u64 hvwc_bar_start;
+	u64 uwc_bar_start;
+	u64 paste_base_addr;
+	u64 paste_win_id_shift;
+
+	struct mutex mutex;
+	struct vas_window *rxwin[VAS_COP_TYPE_MAX];
+	struct vas_window *windows[VAS_WINDOWS_PER_CHIP];
+};
+
+/*
+ * In-kernel state a VAS window. One per window.
+ */
+struct vas_window {
+	/* Fields common to send and receive windows */
+	struct vas_instance *vinst;
+	int winid;
+	bool tx_win;		/* True if send window */
+	bool nx_win;		/* True if NX window */
+	bool user_win;		/* True if user space window */
+	void *hvwc_map;		/* HV window context */
+	void *uwc_map;		/* OS/User window context */
+	pid_t pid;		/* Linux process id of owner */
+
+	/* Fields applicable only to send windows */
+	void *paste_kaddr;
+	char *paste_addr_name;
+	struct vas_window *rxwin;
+
+	/* Feilds applicable only to receive windows */
+	enum vas_cop_type cop;
+	atomic_t num_txwins;
+};
+
+/*
+ * Container for the hardware state of a window. One per-window.
+ *
+ * A VAS Window context is a 512-byte area in the hardware that contains
+ * a set of 64-bit registers. Individual bit-fields in these registers
+ * determine the configuration/operation of the hardware. struct vas_winctx
+ * is a container for the register fields in the window context.
+ */
+struct vas_winctx {
+	void *rx_fifo;
+	int rx_fifo_size;
+	int wcreds_max;
+	int rsvd_txbuf_count;
+
+	bool user_win;
+	bool nx_win;
+	bool fault_win;
+	bool rsvd_txbuf_enable;
+	bool pin_win;
+	bool rej_no_credit;
+	bool tx_wcred_mode;
+	bool rx_wcred_mode;
+	bool tx_word_mode;
+	bool rx_word_mode;
+	bool data_stamp;
+	bool xtra_write;
+	bool notify_disable;
+	bool intr_disable;
+	bool fifo_disable;
+	bool notify_early;
+	bool notify_os_intr_reg;
+
+	int lpid;
+	int pidr;		/* value from SPRN_PID, not linux pid */
+	int lnotify_lpid;
+	int lnotify_pid;
+	int lnotify_tid;
+	u32 pswid;
+	int rx_win_id;
+	int fault_win_id;
+	int tc_mode;
+
+	u64 irq_port;
+
+	enum vas_dma_type dma_type;
+	enum vas_notify_scope min_scope;
+	enum vas_notify_scope max_scope;
+	enum vas_notify_after_count notify_after_count;
+};
+
+#endif /* _VAS_H */
-- 
2.7.4
