Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmT95mf6zDvjP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:25 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmT91XKRz9vDS
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:24 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGx5ar001962
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:22 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nbwnguxc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:22 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:21 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 03/11] VAS: Define helpers for access MMIO regions
Date: Fri, 11 Nov 2016 09:02:48 -0800
In-Reply-To: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1478883776-11121-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define some helper functions to access the MMIO regions. We use these
in a follow-on patches to read/write VAS hardware registers. These
helpers are also used to later issue 'paste' instructions to submit
requests to the NX hardware engines.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 drivers/misc/vas/vas-window.c | 182 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index 468f3bf..2c220a3 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -9,9 +9,191 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/io.h>
 #include <asm/vas.h>
 #include "vas-internal.h"
 
+/*
+ * Using the node, chip and window id for the send winow identified by
+ * @window, compute and return the Power Bus address to which a sender
+ * could issue a paste instruction for this window.
+ *
+ * Refer to Tables 1.1 through 1.4 in Section 1.3.3.1 (Send Message w/Paste
+ * Commands (cl_rma_w)) of VAS P9 Workbook for the PowerBus Address usage
+ * in VAS.
+ *
+ * With 64K mode and Large SMP Mode the bits are used as follows:
+ *
+ *	Bits	Values		Comments
+ *	--------------------------------------
+ *	0:7     0b 0000_0000    Reserved
+ *	8:12    0b 0000_1       System id/Foreign Index 0:4
+ *	13:14   0b 00           Foreign Index 5:6
+ *
+ *	15:18   0 throuh 15     Node id (0 through 15)
+ *	19:21   0 through 7     Chip id (0 throuh 7)
+ *	22:23   0b 00           Unused, Foreign index 7:8
+ *
+ *	24:31   0b 0000_0000    RPN 0:7, Reserved
+ *	32:47   0 through 64K   Send Window Id
+ *	48:51   0b 0000         Spare
+ *
+ *	52      0b 0            Reserved
+ *	53      0b 1            Report Enable (Set to 1 for NX).
+ *	54      0b 0            Reserved
+ *
+ *	55:56   0b 00           Snoop Bus
+ *	57:63   0b 0000_000     Reserved
+ *
+ * Except for a few bits, the small SMP mode computation is similar.
+ *
+ * TODO: Detect and compute address for small SMP mode.
+ *
+ * Example: For Node 0, Chip 0, Window id 4, Report Enable 1:
+ *
+ *     Byte0    Byte1    Byte2    Byte3    Byte4    Byte5    Byte6    Byte7
+ *     00000000 00001000 00000000 00000000 00000000 00000100 00000100 00000000
+ *                                         |               |      |
+ *                                         +-------+-------+      v
+ *                                                 |          Report Enable
+ *                                                 v
+ *                                             Window id 4
+ *
+ *     Thus, the paste address is 0x00080000_00040400.
+ */
+#define RMA_LSMP_64K_SYS_ID	PPC_BITMASK(8, 12)
+#define RMA_LSMP_64K_NODE_ID	PPC_BITMASK(15, 18)
+#define RMA_LSMP_64K_CHIP_ID	PPC_BITMASK(19, 21)
+#define RMA_LSMP_64K_TX_WIN_ID	PPC_BITMASK(32, 47)
+#define RMA_LSMP_REPORT_ENABLE	PPC_BIT(53)
+
+uint64_t compute_paste_address(struct vas_window *window, int *size)
+{
+	int node, chip, winid;
+	uint64_t val = 0ULL;
+
+	node = window->vinst->node;
+	chip = window->vinst->chip;
+	winid = window->winid;
+
+	*size = PAGE_SIZE;
+
+	val = SET_FIELD(RMA_LSMP_64K_SYS_ID, val, 1);
+	val = SET_FIELD(RMA_LSMP_64K_NODE_ID, val, node);
+	val = SET_FIELD(RMA_LSMP_64K_CHIP_ID, val, chip);
+	val = SET_FIELD(RMA_LSMP_64K_TX_WIN_ID, val, winid);
+	val = SET_FIELD(RMA_LSMP_REPORT_ENABLE, val, 1);
+	pr_debug("%swin #%d: Paste address 0x%llx\n",
+			window->txwin ? "Tx" : "Rx",  winid, val);
+	return val;
+}
+
+static void get_hvwc_mmio_bar(struct vas_window *window,
+			uint64_t *start, int *len)
+{
+	uint64_t pbaddr;
+	int instance;
+
+	instance = window->vinst->node * 8 + window->vinst->chip;
+	pbaddr = VAS_HVWC_MMIO_BAR_BASE + instance * VAS_HVWC_MMIO_BAR_SIZE;
+
+	*start = pbaddr + window->winid * VAS_HVWC_SIZE;
+	*len = VAS_HVWC_SIZE;
+}
+
+static void get_uwc_mmio_bar(struct vas_window *window,
+			uint64_t *start, int *len)
+{
+	uint64_t pbaddr;
+	int instance;
+
+	instance = window->vinst->node * 8 + window->vinst->chip;
+	pbaddr = VAS_UWC_MMIO_BAR_BASE + instance * VAS_UWC_MMIO_BAR_SIZE;
+
+	*start = pbaddr + window->winid * VAS_UWC_SIZE;
+	*len = VAS_UWC_SIZE;
+}
+
+static void *map_mmio_region(char *name, uint64_t start, int len)
+{
+	void *map;
+
+	if (!request_mem_region(start, len, name)) {
+		pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
+				__func__, start, len);
+		return NULL;
+	}
+
+	map = __ioremap(start, len, pgprot_val(pgprot_cached(__pgprot(0))));
+	if (!map) {
+		pr_devel("%s(): ioremap(0x%llx, %d) failed\n", __func__, start,
+				len);
+		return NULL;
+	}
+
+	return map;
+}
+
+/*
+ * Unmap the MMIO regions for a window.
+ */
+void unmap_wc_mmio_bars(struct vas_window *window)
+{
+	int len;
+	uint64_t busaddr_start;
+
+	if (window->paste_kaddr) {
+		iounmap(window->paste_kaddr);
+		busaddr_start = compute_paste_address(window, &len);
+		pr_debug("Releasing pbaddr region [0x%llx, %d]\n",
+				busaddr_start, len);
+		release_mem_region((phys_addr_t)busaddr_start, len);
+	}
+
+	if (window->hvwc_map) {
+		iounmap(window->hvwc_map);
+		get_hvwc_mmio_bar(window, &busaddr_start, &len);
+		release_mem_region((phys_addr_t)busaddr_start, len);
+	}
+
+	if (window->uwc_map) {
+		iounmap(window->uwc_map);
+		get_uwc_mmio_bar(window, &busaddr_start, &len);
+		release_mem_region((phys_addr_t)busaddr_start, len);
+	}
+}
+
+/*
+ * Find the Hypervisor Window Context (HVWC) MMIO Base Address Region and the
+ * OS/User Window Context (UWC) MMIO Base Address Region for the given window.
+ * Map these bus addresses and save the mapped kernel addresses in @window.
+ */
+int map_wc_mmio_bars(struct vas_window *window)
+{
+	int len;
+	uint64_t start;
+
+	window->hvwc_map = window->uwc_map = NULL;
+
+	get_hvwc_mmio_bar(window, &start, &len);
+	window->hvwc_map = map_mmio_region("HVWCM_Window", start, len);
+
+	pr_debug("Win #%d: Map hvwc 0x%p -> [0x%llx,%d]\n", window->winid,
+			window->hvwc_map, start, len);
+
+	get_uwc_mmio_bar(window, &start, &len);
+	window->uwc_map = map_mmio_region("UWCM_Window", start, len);
+
+	pr_debug("Win #%d: Map uvwc 0x%p -> [0x%llx,%d]\n", window->winid,
+			window->uwc_map, start, len);
+
+	if (!window->hvwc_map || !window->uwc_map)
+		return -1;
+
+	return 0;
+}
+
 /* stub for now */
 int vas_window_reset(struct vas_instance *vinst, int winid)
 {
-- 
1.8.3.1
