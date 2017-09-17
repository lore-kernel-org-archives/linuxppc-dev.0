Return-Path: <srs0=m9cn=as=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvwXv74DHzDrp8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xvwXv2kmNz8t3H
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:51 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xvwXt40W4z9t2f
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 14:05:50 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8H44RSp091372
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:49 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d0x9q4rr2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:48 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 16 Sep 2017 22:05:48 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/10] powerpc/vas: Save configured window credits
Date: Sat, 16 Sep 2017 21:05:25 -0700
In-Reply-To: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1505621128-23877-8-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Save the configured max window credits for a window in the vas_window
structure. We will need this when polling for return of window credits.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 6 ++++--
 arch/powerpc/platforms/powernv/vas.h        | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 1422cdd..a59a187 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -674,7 +674,7 @@ static void init_winctx_for_rxwin(struct vas_window *rxwin,
 
 	winctx->rx_fifo = rxattr->rx_fifo;
 	winctx->rx_fifo_size = rxattr->rx_fifo_size;
-	winctx->wcreds_max = rxattr->wcreds_max ?: VAS_WCREDS_DEFAULT;
+	winctx->wcreds_max = rxwin->wcreds_max;
 	winctx->pin_win = rxattr->pin_win;
 
 	winctx->nx_win = rxattr->nx_win;
@@ -844,6 +844,7 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 	rxwin->nx_win = rxattr->nx_win;
 	rxwin->user_win = rxattr->user_win;
 	rxwin->cop = cop;
+	rxwin->wcreds_max = rxattr->wcreds_max ?: VAS_WCREDS_DEFAULT;
 	if (rxattr->user_win)
 		rxwin->pid = task_pid_vnr(current);
 
@@ -893,7 +894,7 @@ static void init_winctx_for_txwin(struct vas_window *txwin,
 	 */
 	memset(winctx, 0, sizeof(struct vas_winctx));
 
-	winctx->wcreds_max = txattr->wcreds_max ?: VAS_WCREDS_DEFAULT;
+	winctx->wcreds_max = txwin->wcreds_max;
 
 	winctx->user_win = txattr->user_win;
 	winctx->nx_win = txwin->rxwin->nx_win;
@@ -978,6 +979,7 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 	txwin->nx_win = txwin->rxwin->nx_win;
 	txwin->pid = attr->pid;
 	txwin->user_win = attr->user_win;
+	txwin->wcreds_max = attr->wcreds_max ?: VAS_WCREDS_DEFAULT;
 
 	init_winctx_for_txwin(txwin, attr, &winctx);
 
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 15d2dfa..ad906f6 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -332,6 +332,7 @@ struct vas_window {
 	void *hvwc_map;		/* HV window context */
 	void *uwc_map;		/* OS/User window context */
 	pid_t pid;		/* Linux process id of owner */
+	int wcreds_max;		/* Window credits */
 
 	/* Fields applicable only to send windows */
 	void *paste_kaddr;
-- 
2.7.4
