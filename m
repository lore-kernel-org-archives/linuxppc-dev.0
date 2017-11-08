Return-Path: <srs0=buqp=cg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWqqf5brqzDrCZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yWqqf2jtJz8v79
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:14 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yWqqd3nHVz9s4q
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2017 13:24:13 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA82Nsha088341
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2017 21:24:11 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e3ptn5sm8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Nov 2017 21:24:11 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Nov 2017 19:24:10 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/18] powerpc/vas: Use helper to unpin/close window
Date: Tue,  7 Nov 2017 18:23:45 -0800
In-Reply-To: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1510107838-15181-6-git-send-email-sukadev@linux.vnet.ibm.com>
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
