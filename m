Return-Path: <srs0=ecaq=47=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYJ583dh1zDqfN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 15:40:28 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wYJ5817Qjz8wV7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 15:40:28 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wYJ572c2Bz9sDB
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 15:40:27 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4P5dLq6082672
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 01:40:23 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2angqmk7ru-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2017 01:40:23 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 25 May 2017 01:40:23 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 08/10] VAS: Define vas_win_close() interface
Date: Wed, 24 May 2017 22:39:48 -0700
In-Reply-To: <1495690790-12172-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1495690790-12172-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1495690790-12172-9-git-send-email-sukadev@linux.vnet.ibm.com>
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
Changelog[v4]:
	- Drop the poll for credits return (we can set the required credit,
	  but cannot really find the available credit at a point in time)
	- Export the symbol

Changelog[v3]:
	- Fix order of parameters in GET_FIELD().
	- Update references and sequence for closing/quiescing a window.
---
 arch/powerpc/include/asm/vas.h              |  7 +++
 arch/powerpc/platforms/powernv/vas-window.c | 97 +++++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 09ea6f7..c923b8f 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -76,4 +76,11 @@ extern void vas_init_rx_win_attr(struct vas_rx_win_attr *rxattr,
 extern struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 			struct vas_rx_win_attr *attr);
 
+/*
+ * Close the send or receive window identified by @win. For receive windows
+ * return -EAGAIN if there are active send windows attached to this receive
+ * window.
+ */
+int vas_win_close(struct vas_window *win);
+
 #endif /* _MISC_VAS_H */
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 2cc9850..caacc28 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -477,7 +477,7 @@ int vas_assign_window_id(struct ida *ida)
 	return winid;
 }
 
-void vas_window_free(struct vas_window *window)
+static void vas_window_free(struct vas_window *window)
 {
 	unmap_winctx_mmio_bars(window);
 	kfree(window->paste_addr_name);
@@ -505,10 +505,12 @@ static struct vas_window *vas_window_alloc(struct vas_instance *vinst, int id)
 	return NULL;
 }
 
-/* stub for now */
-int vas_win_close(struct vas_window *window)
+static void put_rx_win(struct vas_window *rxwin)
 {
-	return -1;
+	/* Better not be a send window! */
+	WARN_ON_ONCE(rxwin->tx_win);
+
+	atomic_dec(&rxwin->num_txwins);
 }
 
 struct vas_window *get_vinstance_rxwin(struct vas_instance *vinst,
@@ -715,3 +717,90 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(vas_rx_win_open);
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
+	unmap_winctx_paste_kaddr(window);
+
+	poll_window_busy_state(window);
+
+	/* Unpin window from cache and close it */
+	val = read_hvwc_reg(window, VREG(WINCTL));
+	val = SET_FIELD(VAS_WINCTL_PIN, val, 0);
+	val = SET_FIELD(VAS_WINCTL_OPEN, val, 0);
+	write_hvwc_reg(window, VREG(WINCTL), val);
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
+EXPORT_SYMBOL_GPL(vas_win_close);
-- 
2.7.4
