Return-Path: <srs0=m9cn=as=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvwXs0Kf7zDrp1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xvwXr6r6zz8t3H
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:48 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xvwXr3lKXz9t16
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 14:05:48 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8H44U3k091594
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:46 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d0x9q4rq3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:46 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 16 Sep 2017 22:05:46 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] powerpc/vas: Use helper to unpin/close window
Date: Sat, 16 Sep 2017 21:05:23 -0700
In-Reply-To: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1505621128-23877-6-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use a helper to have the hardware unpin and mark a window closed.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 8ab8a82..95622a9 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1101,6 +1101,20 @@ static void poll_window_castout(struct vas_window *window)
 }
 
 /*
+ * Unpin and close a window so no new requests are accepted and the
+ * hardware can evict this window from cache if necessary.
+ */
+static void unpin_close_window(struct vas_window *window)
+{
+	u64 val;
+
+	val = read_hvwc_reg(window, VREG(WINCTL));
+	val = SET_FIELD(VAS_WINCTL_PIN, val, 0);
+	val = SET_FIELD(VAS_WINCTL_OPEN, val, 0);
+	write_hvwc_reg(window, VREG(WINCTL), val);
+}
+
+/*
  * Close a window.
  *
  * See Section 1.12.1 of VAS workbook v1.05 for details on closing window:
@@ -1114,8 +1128,6 @@ static void poll_window_castout(struct vas_window *window)
  */
 int vas_win_close(struct vas_window *window)
 {
-	u64 val;
-
 	if (!window)
 		return 0;
 
@@ -1131,11 +1143,7 @@ int vas_win_close(struct vas_window *window)
 
 	poll_window_busy_state(window);
 
-	/* Unpin window from cache and close it */
-	val = read_hvwc_reg(window, VREG(WINCTL));
-	val = SET_FIELD(VAS_WINCTL_PIN, val, 0);
-	val = SET_FIELD(VAS_WINCTL_OPEN, val, 0);
-	write_hvwc_reg(window, VREG(WINCTL), val);
+	unpin_close_window(window);
 
 	poll_window_castout(window);
 
-- 
2.7.4
