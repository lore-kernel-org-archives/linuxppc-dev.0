Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v84M55PLvzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 12:38:41 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3v84M52KTNz9t14
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2017 12:38:41 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0Q1cVK7123120
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2017 20:38:39 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2870k3x6pa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2017 20:38:39 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 18:38:38 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org
Subject: [PATCH v2 04/10] VAS: Define helpers for access MMIO regions
Date: Wed, 25 Jan 2017 17:38:02 -0800
In-Reply-To: <1485394688-31129-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1485394688-31129-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1485394688-31129-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

Changelog [v2]:
	- Get HVWC, UWC and paste addresses from window->vinst (i.e DT)
	  rather than kernel macros.
---
 drivers/misc/vas/vas-window.c | 112 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index 468f3bf..cfbd2f4 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -9,9 +9,121 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/io.h>
 #include <asm/vas.h>
 #include "vas-internal.h"
 
+/*
+ * Compute the paste address region for the window @window using the
+ * ->win_base_addr and ->win_id_shift we got from device tree.
+ */
+void compute_paste_address(struct vas_window *window, uint64_t *addr, int *len)
+{
+	uint64_t base, shift;
+	int winid;
+
+	base = window->vinst->win_base_addr;
+	shift = window->vinst->win_id_shift;
+	winid = window->winid;
+
+	*addr  = base + (winid << shift);
+	*len = PAGE_SIZE;
+
+	pr_debug("Txwin #%d: Paste addr 0x%llx\n", winid, *addr);
+}
+
+static inline void get_hvwc_mmio_bar(struct vas_window *window,
+			uint64_t *start, int *len)
+{
+	uint64_t pbaddr;
+
+	pbaddr = window->vinst->hvwc_bar_start;
+	*start = pbaddr + window->winid * VAS_HVWC_SIZE;
+	*len = VAS_HVWC_SIZE;
+}
+
+static inline void get_uwc_mmio_bar(struct vas_window *window,
+			uint64_t *start, int *len)
+{
+	uint64_t pbaddr;
+
+	pbaddr = window->vinst->uwc_bar_start;
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
+		compute_paste_address(window, &busaddr_start, &len);
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
+	get_uwc_mmio_bar(window, &start, &len);
+	window->uwc_map = map_mmio_region("UWCM_Window", start, len);
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
2.7.4
