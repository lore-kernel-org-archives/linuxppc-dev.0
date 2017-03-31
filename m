Return-Path: <srs0=lfg8=3i=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvV6J1RxGzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:16 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vvV6H6hgtz8w3D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:15 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vvV6G6RM2z9s4s
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 16:14:14 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2V5DpAD024002
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:12 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29h4ekxgt1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:12 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 23:14:12 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 05/11] VAS: Define helpers for access MMIO regions
Date: Thu, 30 Mar 2017 22:13:38 -0700
In-Reply-To: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1490937224-29149-6-git-send-email-sukadev@linux.vnet.ibm.com>
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
Changelog [v3]:
	- Minor reorg/cleanup of map/unmap functions

Changelog [v2]:
	- Get HVWC, UWC and paste addresses from window->vinst (i.e DT)
	  rather than kernel macros.
---
 arch/powerpc/platforms/powernv/vas-window.c | 126 ++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 6156fbe..ec084d2 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -9,9 +9,135 @@
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/io.h>
 
 #include "vas.h"
 
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
+static void unmap_wc_paste_kaddr(struct vas_window *window)
+{
+	int len;
+	uint64_t busaddr_start;
+
+	if (window->paste_kaddr) {
+		iounmap(window->paste_kaddr);
+		compute_paste_address(window, &busaddr_start, &len);
+		release_mem_region((phys_addr_t)busaddr_start, len);
+		window->paste_kaddr = NULL;
+	}
+
+}
+
+static void unmap_wc_mmio_bars(struct vas_window *window)
+{
+	int len;
+	uint64_t busaddr_start;
+
+	unmap_wc_paste_kaddr(window);
+
+	if (window->hvwc_map) {
+		iounmap(window->hvwc_map);
+		get_hvwc_mmio_bar(window, &busaddr_start, &len);
+		release_mem_region((phys_addr_t)busaddr_start, len);
+		window->hvwc_map = NULL;
+	}
+
+	if (window->uwc_map) {
+		iounmap(window->uwc_map);
+		get_uwc_mmio_bar(window, &busaddr_start, &len);
+		release_mem_region((phys_addr_t)busaddr_start, len);
+		window->uwc_map = NULL;
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
+	window->paste_kaddr = window->hvwc_map = window->uwc_map = NULL;
+
+	get_hvwc_mmio_bar(window, &start, &len);
+	window->hvwc_map = map_mmio_region("HVWCM_Window", start, len);
+
+	get_uwc_mmio_bar(window, &start, &len);
+	window->uwc_map = map_mmio_region("UWCM_Window", start, len);
+
+	if (!window->hvwc_map || !window->uwc_map) {
+		unmap_wc_mmio_bars(window);
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
