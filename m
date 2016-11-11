Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmTP0JT8zDvjf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:37 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmTN2NTLz9tl4
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:36 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGwpvf088985
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:34 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nhv78xac-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:34 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:33 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 11/11] VAS: Define/use interface to setup irq handling.
Date: Fri, 11 Nov 2016 09:02:56 -0800
In-Reply-To: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1478883776-11121-12-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When VAS hardware encounters an address translation error it will
post the failing CRB to a fault window and issue an interrupt to
the kernel.

Use OPAL/XIVE to register a IRQ trigger port for each send window
and setup IRQ handling in the kernel for this IRQ. (The existing
init_winctx_regs() call configures the trigger port in the VAS
registers.

When the VAS hardware generates an interrupt, the kernel interrupt
handler wakes up the fault thread (from previous patch) to process
the fault CRB. As mentioned in that patch, this interrupt handling
is needed when we support user space access to VAS/NX. But including
this patch of routing VAS interrupt to kernel handler for review.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |  3 +-
 arch/powerpc/include/asm/opal.h                |  2 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |  2 +
 drivers/misc/vas/vas-window.c                  | 81 ++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index eabe07e..192d430 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -168,7 +168,8 @@
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
 #define OPAL_VAS_READ_FIR			128
-#define OPAL_LAST				128
+#define OPAL_VAS_GET_TRIGGER_PORT		129
+#define OPAL_LAST				129
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index b20ec10..30042f9 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -229,6 +229,8 @@ int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			     uint32_t pe_num, uint32_t tce_size,
 			     uint64_t dma_addr, uint32_t npages);
 int64_t opal_vas_read_fir(uint32_t chip_id, int32_t idx, __be64 *fir);
+int64_t opal_vas_get_trigger_port(uint32_t chip_id, int32_t idx, __be32 *girq,
+				 __be64 *port);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index acb6396..9b88e22 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -309,3 +309,5 @@ OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
 OPAL_CALL(opal_vas_read_fir,			OPAL_VAS_READ_FIR);
+OPAL_CALL(opal_vas_get_trigger_port,		OPAL_VAS_GET_TRIGGER_PORT);
+
diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index f6610de..ba10922 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -10,7 +10,11 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <asm/opal.h>
+#include <asm/opal-api.h>
 #include <asm/vas.h>
 #include "vas-internal.h"
 #include "copy-paste.h"
@@ -603,6 +607,72 @@ int vas_window_reset(struct vas_instance *vinst, int winid)
 	return 0;
 }
 
+static irqreturn_t vas_irq_handler(int virq, void *data)
+{
+	struct vas_window *win = data;
+
+	pr_devel("VAS: virq %d, window %d\n", virq, win->winid);
+	vas_wakeup_fault_win_thread();
+
+	return IRQ_HANDLED;
+}
+
+static int setup_irq_mapping(struct vas_window *win)
+{
+	int rc;
+	int winid;
+	uint32_t virq;
+	int32_t girq;
+	uint64_t port;
+	char devname[64];
+
+	winid = win->winid;
+	snprintf(devname, sizeof(devname), "vas-window-%d", winid);
+
+	girq = 0;
+	port = 0ULL;
+	rc = opal_vas_get_trigger_port(win->vinst->chip, winid, &girq, &port);
+
+	pr_devel("VAS: %swin #%d: IRQ trigger %d, port 0x%llx, rc %d\n",
+			win->txwin ? "Tx" : "Rx", winid, girq, port, rc);
+	if (rc)
+		return -EINVAL;
+
+	virq = irq_create_mapping(NULL, girq);
+	if (!virq) {
+		pr_devel("VAS: %swin #%d: Unable to map global irq %d\n",
+				win->txwin ? "Tx" : "Rx", winid, girq);
+		return -EINVAL;
+	}
+
+	rc = request_irq(virq, vas_irq_handler, 0, devname, win);
+	if (rc) {
+		pr_devel("VAS: %swin #%d: request_irq() returns %d\n",
+				win->txwin ? "Tx" : "Rx", winid, rc);
+		return rc;
+	}
+
+	win->hwirq = girq;
+	win->irq_port = port;
+
+	return 0;
+}
+
+static void free_irq_mapping(struct vas_window *win)
+{
+	unsigned int irq;
+
+	irq = irq_find_mapping(NULL, win->hwirq);
+	if (!irq) {
+		pr_devel("VAS: Receieved unknown hwirq %d\n", win->hwirq);
+		WARN_ON_ONCE(true);
+		return;
+	}
+
+	free_irq(irq, win);
+}
+
+
 static void put_rx_win(struct vas_window *rxwin)
 {
 	/* Better not be a send window! */
@@ -897,6 +967,15 @@ struct vas_window *vas_tx_win_open(int node, int chip, enum vas_cop_type cop,
 	txwin->rxwin = rxwin;
 	txwin->nx_win = txwin->rxwin->nx_win;
 
+	if (setup_irq_mapping(txwin)) {
+		/*
+		 * TODO: IRQ mapping is essential for user space send windows.
+		 *	 We only support in-kernel initially, so ignore errors
+		 *	 in setting up IRQ mappings for now.
+		 */
+		WARN_ON_ONCE(1);
+	}
+
 	init_winctx_for_txwin(txwin, attr, &winctx);
 
 	init_winctx_regs(txwin, &winctx);
@@ -1014,6 +1093,8 @@ retry:
 	if (window->txwin)
 		put_rx_win(window->rxwin);
 
+	free_irq_mapping(window);
+
 	vas_release_window_id(&window->vinst->ida, window->winid);
 
 	vas_window_free(window);
-- 
1.8.3.1
