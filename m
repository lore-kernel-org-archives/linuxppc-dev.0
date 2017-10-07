Return-Path: <srs0=cc4y=bg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y89Rx1NKVzDqpw
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:29:01 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y89Rx0HyFz8t08
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:29:01 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y89Rw2q6Cz9t7H
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2017 13:29:00 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v972OX3S039482
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Oct 2017 22:28:58 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2deehw0pf2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Oct 2017 22:28:58 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 20:28:57 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 18/18] powerpc/vas: Add support for user receive window
Date: Fri,  6 Oct 2017 19:28:18 -0700
In-Reply-To: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1507343298-27496-19-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for user space receive window (for the Fast thread-wakeup
coprocessor type)

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 59 +++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 1d08b64..99642ec 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -16,7 +16,8 @@
 #include <linux/log2.h>
 #include <linux/rcupdate.h>
 #include <linux/cred.h>
-
+#include <asm/switch_to.h>
+#include <asm/ppc-opcode.h>
 #include "vas.h"
 #include "copy-paste.h"
 
@@ -602,6 +603,32 @@ static void put_rx_win(struct vas_window *rxwin)
 }
 
 /*
+ * Find the user space receive window given the @pswid.
+ *      - We must have a valid vasid and it must belong to this instance.
+ *        (so both send and receive windows are on the same VAS instance)
+ *      - The window must refer to an OPEN, FTW, RECEIVE window.
+ *
+ * NOTE: We access ->windows[] table and assume that vinst->mutex is held.
+ */
+static struct vas_window *get_user_rxwin(struct vas_instance *vinst, u32 pswid)
+{
+	int vasid, winid;
+	struct vas_window *rxwin;
+
+	decode_pswid(pswid, &vasid, &winid);
+
+	if (vinst->vas_id != vasid)
+		return ERR_PTR(-EINVAL);
+
+	rxwin = vinst->windows[winid];
+
+	if (!rxwin || rxwin->tx_win || rxwin->cop != VAS_COP_TYPE_FTW)
+		return ERR_PTR(-EINVAL);
+
+	return rxwin;
+}
+
+/*
  * Get the VAS receive window associated with NX engine identified
  * by @cop and if applicable, @pswid.
  *
@@ -614,10 +641,10 @@ static struct vas_window *get_vinst_rxwin(struct vas_instance *vinst,
 
 	mutex_lock(&vinst->mutex);
 
-	if (cop == VAS_COP_TYPE_842 || cop == VAS_COP_TYPE_842_HIPRI)
-		rxwin = vinst->rxwin[cop] ?: ERR_PTR(-EINVAL);
+	if (cop == VAS_COP_TYPE_FTW)
+		rxwin = get_user_rxwin(vinst, pswid);
 	else
-		rxwin = ERR_PTR(-EINVAL);
+		rxwin = vinst->rxwin[cop] ?: ERR_PTR(-EINVAL);
 
 	if (!IS_ERR(rxwin))
 		atomic_inc(&rxwin->num_txwins);
@@ -941,10 +968,9 @@ static void init_winctx_for_txwin(struct vas_window *txwin,
 	winctx->tx_word_mode = txattr->tx_win_ord_mode;
 	winctx->rsvd_txbuf_count = txattr->rsvd_txbuf_count;
 
-	if (winctx->nx_win) {
+	winctx->intr_disable = true;
+	if (winctx->nx_win)
 		winctx->data_stamp = true;
-		winctx->intr_disable = true;
-	}
 
 	winctx->lpid = txattr->lpid;
 	winctx->pidr = txattr->pidr;
@@ -989,6 +1015,14 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 	if (!tx_win_args_valid(cop, attr))
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * If caller did not specify a vasid but specified the PSWID of a
+	 * receive window (applicable only to FTW windows), use the vasid
+	 * from that receive window.
+	 */
+	if (vasid == -1 && attr->pswid)
+		decode_pswid(attr->pswid, &vasid, NULL);
+
 	vinst = find_vas_instance(vasid);
 	if (!vinst) {
 		pr_devel("vasid %d not found!\n", vasid);
@@ -1037,6 +1071,17 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 
 	set_vinst_win(vinst, txwin);
 
+	set_thread_used_vas();
+
+	/*
+	 * Even a process that has no foreign real address mapping can use
+	 * an unpaired COPY instruction (to no real effect). Issue CP_ABORT
+	 * to clear any pending COPY and prevent a covert channel.
+	 *
+	 * __switch_to() will issue CP_ABORT on future context switches.
+	 */
+	asm volatile(PPC_CP_ABORT);
+
 	return txwin;
 
 free_window:
-- 
2.7.4
