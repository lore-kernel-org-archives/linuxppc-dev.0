Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v84MF70BrzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 12:38:49 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3v84MF1vStz9t1C
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2017 12:38:49 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0Q1cURh023338
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2017 20:38:47 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 287361g9j0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2017 20:38:47 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 18:38:46 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org
Subject: [PATCH v2 08/10] VAS: Define vas_win_close() interface
Date: Wed, 25 Jan 2017 17:38:06 -0800
In-Reply-To: <1485394688-31129-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1485394688-31129-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1485394688-31129-9-git-send-email-sukadev@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/vas.h |  6 +++++
 drivers/misc/vas/vas-window.c  | 52 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index b6362e9..bda851a 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -75,6 +75,12 @@ struct vas_rx_win_attr {
 struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 			struct vas_rx_win_attr *attr);
 
+/*
+ * Close the send or receive window identified by @win. For receive windows
+ * return -EAGAIN if there are active send windows attached to this receive
+ * window.
+ */
+int vas_win_close(struct vas_window *win);
 
 /*
  * Get/Set bit fields
diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index a640d59..4b06780 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -711,3 +711,55 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 	vas_release_window_id(&vinst->ida, rxwin->winid);
 	return ERR_PTR(rc);
 }
+
+int vas_win_close(struct vas_window *window)
+{
+	uint64_t val;
+	int cached;
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
+	/* Unpin window from cache and close it */
+	val = 0ULL;
+	val = SET_FIELD(VAS_WINCTL_PIN, val, 0);
+	val = SET_FIELD(VAS_WINCTL_OPEN, val, 0);
+	write_hvwc_reg(window, VREG(WINCTL), val);
+
+	/*
+	 * See Section 1.11.1 for details on closing window, including
+	 *	- disable new paste operations
+	 *	- block till pending requests are completed
+	 *	- If Rx window, ensure FIFO is empty.
+	 */
+
+	/* Cast window context out of the cache */
+retry:
+	val = read_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL));
+	cached = GET_FIELD(val, VAS_WIN_CACHE_STATUS);
+	if (cached) {
+		val = 0ULL;
+		val = SET_FIELD(VAS_CASTOUT_REQ, val, 1);
+		val = SET_FIELD(VAS_PUSH_TO_MEM, val, 0);
+		write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), val);
+
+		schedule_timeout(2000);
+		goto retry;
+	}
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
