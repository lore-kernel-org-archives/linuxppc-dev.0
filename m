Return-Path: <srs0=m9cn=as=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvwY06vJxzDrnq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:56 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xvwY05dllz8vmk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:56 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xvwXz6vnFz9t5P
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 14:05:55 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8H44ZOq014081
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:51 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d0vwg4ktq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:51 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 16 Sep 2017 22:05:51 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/10] powerpc/vas: poll for return of window credits
Date: Sat, 16 Sep 2017 21:05:26 -0700
In-Reply-To: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1505621128-23877-9-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Normally, the NX driver waits for the CRBs to be processed before closing
the window. But it is better to ensure that the credits are returned before
the window gets reassigned later.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 45 +++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index a59a187..8e14ce1 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1063,6 +1063,49 @@ int vas_paste_crb(struct vas_window *txwin, int offset, bool re)
 EXPORT_SYMBOL_GPL(vas_paste_crb);
 
 /*
+ * If credit checking is enabled for this window, poll for the return
+ * of window credits (i.e for NX engines to process any outstanding CRBs).
+ * Since NX-842 waits for the CRBs to be processed before closing the
+ * window, we should not have to wait for too long.
+ *
+ * TODO: We retry in 10ms intervals now. We could/should probably peek at
+ * 	the VAS_LRFIFO_PUSH_OFFSET register to get an estimate of pending
+ * 	CRBs on the FIFO and compute the delay dynamically on each retry.
+ * 	But that is not really needed until we support NX-GZIP access from
+ * 	user space. (NX-842 driver waits for CSB and Fast thread-wakeup
+ * 	doesn't use credit checking).
+ */
+static void poll_window_credits(struct vas_window *window)
+{
+	u64 val;
+	int creds, mode;
+
+	val = read_hvwc_reg(window, VREG(WINCTL));
+	if (window->tx_win)
+		mode = GET_FIELD(VAS_WINCTL_TX_WCRED_MODE, val);
+	else
+		mode = GET_FIELD(VAS_WINCTL_RX_WCRED_MODE, val);
+
+	if (!mode)
+		return;
+retry:
+	if (window->tx_win) {
+		val = read_hvwc_reg(window, VREG(TX_WCRED));
+		creds = GET_FIELD(VAS_TX_WCRED, val);
+	} else {
+		val = read_hvwc_reg(window, VREG(LRX_WCRED));
+		creds = GET_FIELD(VAS_LRX_WCRED, val);
+	}
+
+	if (creds < window->wcreds_max) {
+		val = 0;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(msecs_to_jiffies(10));
+		goto retry;
+	}
+}
+
+/*
  * Wait for the window to go to "not-busy" state. It should only take a
  * short time to queue a CRB, so window should not be busy for too long.
  * Trying 5ms intervals.
@@ -1149,6 +1192,8 @@ int vas_win_close(struct vas_window *window)
 
 	unpin_close_window(window);
 
+	poll_window_credits(window);
+
 	poll_window_castout(window);
 
 	/* if send window, drop reference to matching receive window */
-- 
2.7.4
