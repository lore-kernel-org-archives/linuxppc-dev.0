Return-Path: <srs0=m9cn=as=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvwXp6FLTzDrnY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:46 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xvwXp5dDWz8v8G
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:46 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xvwXp0vkGz9t2f
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 14:05:45 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8H44QaQ097604
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:44 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d0wk9bae6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:43 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 16 Sep 2017 22:05:43 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/10] powerpc/vas: Drop poll_window_cast_out().
Date: Sat, 16 Sep 2017 21:05:22 -0700
In-Reply-To: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1505621128-23877-5-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Polling for window cast out is listed in the spec, but turns out that
it is not strictly necessary and slows down window close. Making it a
stub for now.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 34 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 67ffc5d..8ab8a82 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1079,25 +1079,25 @@ static void poll_window_busy_state(struct vas_window *window)
 	}
 }
 
+/*
+ * Have the hardware cast a window out of cache and wait for it to
+ * be completed.
+ *
+ * NOTE: It can take a relatively long time to cast the window context
+ *	out of the cache. It is not strictly necessary to cast out if:
+ *
+ *	- we clear the "Pin Window" bit (so hardware is free to evict)
+ *
+ *	- we re-initialize the window context when it is reassigned.
+ *
+ *	We do the former in vas_win_close() and latter in vas_win_open().
+ *	So, ignoring the cast-out for now. We can add it as needed. If
+ *	casting out becomes necessary we should consider offloading the
+ *	job to a worker thread, so the window close can proceed quickly.
+ */
 static void poll_window_castout(struct vas_window *window)
 {
-	int cached;
-	u64 val;
-
-	/* Cast window context out of the cache */
-retry:
-	val = read_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL));
-	cached = GET_FIELD(VAS_WIN_CACHE_STATUS, val);
-	if (cached) {
-		val = 0ULL;
-		val = SET_FIELD(VAS_CASTOUT_REQ, val, 1);
-		val = SET_FIELD(VAS_PUSH_TO_MEM, val, 0);
-		write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), val);
-
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ);
-		goto retry;
-	}
+	/* stub for now */
 }
 
 /*
-- 
2.7.4
