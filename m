Return-Path: <srs0=4uxs=77=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhJW71KQ7zDqVg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xhJW670QQz8vLq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xhJW60Gljz9t3J
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 16:24:01 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7T6KDf7119831
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:24:00 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cn0dtak9g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:23:59 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 02:23:59 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 04/10] powerpc/vas: Define helpers to access MMIO regions
Date: Mon, 28 Aug 2017 23:23:34 -0700
In-Reply-To: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503987820-31933-5-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define some helper functions to access the MMIO regions. We use these
in follow-on patches to read/write VAS hardware registers. They are
also used to later issue 'paste' instructions to submit requests to
the NX hardware engines.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog [v8]:
	Minor cleanup of error/debug messages

Changelog [v6]:
	- Minor reorg to make setup/cleanup functions more symmetric

Changelog [v5]:
	- [Ben Herrenschmidt]: Need cachable mapping for paste regions
	  and non-cachable mapping for the MMIO regions. So, just use
	  ioremap() for mapping the MMIO regions; use "winctx" instead
	  of "wc" to avoid collision with "write combine".

Changelog [v3]:
	- Minor reorg/cleanup of map/unmap functions

Changelog [v2]:
	- Get HVWC, UWC and paste addresses from window->vinst (i.e DT)
	  rather than kernel macros.
---
 arch/powerpc/platforms/powernv/vas-window.c | 174 ++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index de21acb..642814a2 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -7,11 +7,185 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#define pr_fmt(fmt) "vas: " fmt
+
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/io.h>
 
 #include "vas.h"
 
+/*
+ * Compute the paste address region for the window @window using the
+ * ->paste_base_addr and ->paste_win_id_shift we got from device tree.
+ */
+static void compute_paste_address(struct vas_window *window, u64 *addr, int *len)
+{
+	int winid;
+	u64 base, shift;
+
+	base = window->vinst->paste_base_addr;
+	shift = window->vinst->paste_win_id_shift;
+	winid = window->winid;
+
+	*addr  = base + (winid << shift);
+	if (len)
+		*len = PAGE_SIZE;
+
+	pr_debug("Txwin #%d: Paste addr 0x%llx\n", winid, *addr);
+}
+
+static inline void get_hvwc_mmio_bar(struct vas_window *window,
+			u64 *start, int *len)
+{
+	u64 pbaddr;
+
+	pbaddr = window->vinst->hvwc_bar_start;
+	*start = pbaddr + window->winid * VAS_HVWC_SIZE;
+	*len = VAS_HVWC_SIZE;
+}
+
+static inline void get_uwc_mmio_bar(struct vas_window *window,
+			u64 *start, int *len)
+{
+	u64 pbaddr;
+
+	pbaddr = window->vinst->uwc_bar_start;
+	*start = pbaddr + window->winid * VAS_UWC_SIZE;
+	*len = VAS_UWC_SIZE;
+}
+
+/*
+ * Map the paste bus address of the given send window into kernel address
+ * space. Unlike MMIO regions (map_mmio_region() below), paste region must
+ * be mapped cache-able and is only applicable to send windows.
+ */
+void *map_paste_region(struct vas_window *txwin)
+{
+	int len;
+	void *map;
+	char *name;
+	u64 start;
+
+	name = kasprintf(GFP_KERNEL, "window-v%d-w%d", txwin->vinst->vas_id,
+				txwin->winid);
+	if (!name)
+		goto free_name;
+
+	txwin->paste_addr_name = name;
+	compute_paste_address(txwin, &start, &len);
+
+	if (!request_mem_region(start, len, name)) {
+		pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
+				__func__, start, len);
+		goto free_name;
+	}
+
+	map = ioremap_cache(start, len);
+	if (!map) {
+		pr_devel("%s(): ioremap_cache(0x%llx, %d) failed\n", __func__,
+				start, len);
+		goto free_name;
+	}
+
+	pr_devel("Mapped paste addr 0x%llx to kaddr 0x%p\n", start, map);
+	return map;
+
+free_name:
+	kfree(name);
+	return ERR_PTR(-ENOMEM);
+}
+
+
+static void *map_mmio_region(char *name, u64 start, int len)
+{
+	void *map;
+
+	if (!request_mem_region(start, len, name)) {
+		pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
+				__func__, start, len);
+		return NULL;
+	}
+
+	map = ioremap(start, len);
+	if (!map) {
+		pr_devel("%s(): ioremap(0x%llx, %d) failed\n", __func__, start,
+				len);
+		return NULL;
+	}
+
+	return map;
+}
+
+static void unmap_region(void *addr, u64 start, int len)
+{
+	iounmap(addr);
+	release_mem_region((phys_addr_t)start, len);
+}
+
+/*
+ * Unmap the paste address region for a window.
+ */
+void unmap_paste_region(struct vas_window *window)
+{
+	int len;
+	u64 busaddr_start;
+
+	if (window->paste_kaddr) {
+		compute_paste_address(window, &busaddr_start, &len);
+		unmap_region(window->paste_kaddr, busaddr_start, len);
+		window->paste_kaddr = NULL;
+		kfree(window->paste_addr_name);
+		window->paste_addr_name = NULL;
+	}
+}
+
+/*
+ * Unmap the MMIO regions for a window.
+ */
+static void unmap_winctx_mmio_bars(struct vas_window *window)
+{
+	int len;
+	u64 busaddr_start;
+
+	if (window->hvwc_map) {
+		get_hvwc_mmio_bar(window, &busaddr_start, &len);
+		unmap_region(window->hvwc_map, busaddr_start, len);
+		window->hvwc_map = NULL;
+	}
+
+	if (window->uwc_map) {
+		get_uwc_mmio_bar(window, &busaddr_start, &len);
+		unmap_region(window->uwc_map, busaddr_start, len);
+		window->uwc_map = NULL;
+	}
+}
+
+/*
+ * Find the Hypervisor Window Context (HVWC) MMIO Base Address Region and the
+ * OS/User Window Context (UWC) MMIO Base Address Region for the given window.
+ * Map these bus addresses and save the mapped kernel addresses in @window.
+ */
+int map_winctx_mmio_bars(struct vas_window *window)
+{
+	int len;
+	u64 start;
+
+	get_hvwc_mmio_bar(window, &start, &len);
+	window->hvwc_map = map_mmio_region("HVWCM_Window", start, len);
+
+	get_uwc_mmio_bar(window, &start, &len);
+	window->uwc_map = map_mmio_region("UWCM_Window", start, len);
+
+	if (!window->hvwc_map || !window->uwc_map) {
+		unmap_winctx_mmio_bars(window);
+		return -1;
+	}
+
+	return 0;
+}
+
 /* stub for now */
 int vas_win_close(struct vas_window *window)
 {
-- 
2.7.4
