Return-Path: <srs0=cc4y=bg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y89RY3yRkzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y89RX6yCJz8vjD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:40 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y89RW4JpNz9t7F
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2017 13:28:39 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v972ObWV082919
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Oct 2017 22:28:37 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2denvf0k3u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Oct 2017 22:28:37 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 20:28:36 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/18] powerpc/vas: Reduce polling interval for busy state
Date: Fri,  6 Oct 2017 19:28:06 -0700
In-Reply-To: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1507343298-27496-7-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A VAS window is normally in "busy" state for only a short duration.
Reduce the time we wait for the window to go to "not-busy" state to
speed-up vas_win_close() a bit.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 95622a9..1422cdd 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1060,21 +1060,23 @@ int vas_paste_crb(struct vas_window *txwin, int offset, bool re)
 }
 EXPORT_SYMBOL_GPL(vas_paste_crb);
 
+/*
+ * Wait for the window to go to "not-busy" state. It should only take a
+ * short time to queue a CRB, so window should not be busy for too long.
+ * Trying 5ms intervals.
+ */
 static void poll_window_busy_state(struct vas_window *window)
 {
 	int busy;
 	u64 val;
 
 retry:
-	/*
-	 * Poll Window Busy flag
-	 */
 	val = read_hvwc_reg(window, VREG(WIN_STATUS));
 	busy = GET_FIELD(VAS_WIN_BUSY, val);
 	if (busy) {
 		val = 0;
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ);
+		schedule_timeout(msecs_to_jiffies(5));
 		goto retry;
 	}
 }
-- 
2.7.4
