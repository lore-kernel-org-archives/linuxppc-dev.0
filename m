Return-Path: <srs0=ey7g=22=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkrYz0qFFzDqcY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:34:47 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vkrYy67FXz8swR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:34:46 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vkrYy2TD2z9s2s
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 14:34:46 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2H3TkTj057833
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 23:34:40 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2980w6qh40-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 23:34:40 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 23:34:39 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org
Subject: [PATCH v3 08/10] VAS: Define vas_win_close() interface
Date: Thu, 16 Mar 2017 20:34:00 -0700
In-Reply-To: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1489721642-5657-9-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define the vas_win_close() interface which should be used to close a
send or receive windows.

While the hardware configurations required to open send and receive windows
differ, the configuration to close a window is the same for both. So we use
a single interface to close the window.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v3]:
	- Fix order of parameters in GET_FIELD().
	- Update references and sequence for closing/quiescing a window.
---
 arch/powerpc/include/asm/vas.h |   7 +++
 drivers/misc/vas/vas-window.c  | 120 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index d49b05b..fc00249 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -83,6 +83,13 @@ extern struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 			struct vas_rx_win_attr *attr);
 
 /*
+ * Close the send or receive window identified by @win. For receive windows
+ * return -EAGAIN if there are active send windows attached to this receive
+ * window.
+ */
+int vas_win_close(struct vas_window *win);
+
+/*
  * Get/Set bit fields
  */
 #define GET_FIELD(m, v)		(((v) & (m)) >> MASK_LSH(m))
diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index 605a2fa..40e4f7d 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -548,6 +548,14 @@ int vas_window_reset(struct vas_instance *vinst, int winid)
 	return 0;
 }
 
+static void put_rx_win(struct vas_window *rxwin)
+{
+	/* Better not be a send window! */
+	WARN_ON_ONCE(rxwin->tx_win);
+
+	atomic_dec(&rxwin->num_txwins);
+}
+
 struct vas_window *get_vinstance_rxwin(struct vas_instance *vinst,
 			enum vas_cop_type cop)
 {
@@ -747,3 +755,115 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 	vas_release_window_id(&vinst->ida, rxwin->winid);
 	return ERR_PTR(rc);
 }
+
+static void poll_window_busy_state(struct vas_window *window)
+{
+	int busy;
+	uint64_t val;
+
+retry:
+	/*
+	 * Poll Window Busy flag
+	 */
+	val = read_hvwc_reg(window, VREG(WIN_STATUS));
+	busy = GET_FIELD(VAS_WIN_BUSY, val);
+	if (busy) {
+		val = 0;
+		schedule_timeout(2000);
+		goto retry;
+	}
+}
+
+static void poll_window_credits_return(struct vas_window *window)
+{
+	int credits;
+	uint64_t val;
+
+retry:
+	/*
+	 * Poll Window Credits
+	 */
+	if (window->tx_win) {
+		val = read_hvwc_reg(window, VREG(TX_WCRED));
+		credits = GET_FIELD(VAS_TX_WCRED, val);
+	} else {
+		val = read_hvwc_reg(window, VREG(LRX_WCRED));
+		credits = GET_FIELD(VAS_LRX_WCRED, val);
+	}
+
+	if (credits != VAS_WCREDS_DEFAULT) {
+		val = 0;
+		schedule_timeout(2000);
+		goto retry;
+	}
+}
+
+static void poll_window_castout(struct vas_window *window)
+{
+	int cached;
+	uint64_t val;
+
+	/* Cast window context out of the cache */
+retry:
+	val = read_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL));
+	cached = GET_FIELD(VAS_WIN_CACHE_STATUS, val);
+	if (cached) {
+		val = 0ULL;
+		val = SET_FIELD(VAS_CASTOUT_REQ, val, 1);
+		val = SET_FIELD(VAS_PUSH_TO_MEM, val, 0);
+		write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), val);
+
+		schedule_timeout(2000);
+		goto retry;
+	}
+}
+
+/*
+ * Close a window.
+ *
+ * See Section 1.12.1 of VAS workbook v1.05 for details on closing window:
+ *	- disable new paste operations (unmap paste address)
+ *	- Poll for the "Window Busy" bit to be cleared
+ *	- Clear the Open/Enable bit for the Window.
+ *	- Poll for return of window Credits (implies FIFO empty for Rx win?)
+ *	- Unpin and cast window context out of cache
+ *
+ * Besides the hardware, kernel has some bookkeeping of course.
+ */
+int vas_win_close(struct vas_window *window)
+{
+	uint64_t val;
+
+	if (!window)
+		return 0;
+
+	if (!window->tx_win && atomic_read(&window->num_txwins) != 0) {
+		pr_devel("VAS: Attempting to close an active Rx window!\n");
+		WARN_ON_ONCE(1);
+		return -EAGAIN;
+	}
+
+	unmap_wc_paste_kaddr(window);
+
+	poll_window_busy_state(window);
+
+	/* Unpin window from cache and close it */
+	val = read_hvwc_reg(window, VREG(WINCTL));
+	val = SET_FIELD(VAS_WINCTL_PIN, val, 0);
+	val = SET_FIELD(VAS_WINCTL_OPEN, val, 0);
+	write_hvwc_reg(window, VREG(WINCTL), val);
+
+	poll_window_credits_return(window);
+
+	poll_window_castout(window);
+
+	/* if send window, drop reference to matching receive window */
+	if (window->tx_win)
+		put_rx_win(window->rxwin);
+
+	vas_release_window_id(&window->vinst->ida, window->winid);
+
+	vas_window_free(window);
+
+	return 0;
+}
-- 
2.7.4
