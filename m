Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VVy23gXVzF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 05:40:58 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6HJd0uS062466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 15:40:55 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k9p209h0k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 15:40:55 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Tue, 17 Jul 2018 15:40:54 -0400
From: John Allen <jallen@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Cc: John Allen <jallen@linux.ibm.com>
Subject: [PATCH v2 1/2] powerpc/pseries: Avoid blocking rtas polling handling
 multiple PRRN events
Date: Tue, 17 Jul 2018 14:40:47 -0500
In-Reply-To: <20180717194048.3057-1-jallen@linux.ibm.com>
References: <20180717194048.3057-1-jallen@linux.ibm.com>
Message-Id: <20180717194048.3057-2-jallen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a PRRN event is being handled and another PRRN event comes in, the
second event will block rtas polling waiting on the first to complete,
preventing any further rtas events from being handled. This can be
especially problematic in case that PRRN events are continuously being
queued in which case rtas polling gets indefinitely blocked completely.

This patch introduces a mutex that prevents any subsequent PRRN events from
running while there is a prrn event being handled, allowing rtas polling to
continue normally.

Signed-off-by: John Allen <jallen@linux.ibm.com>
---
v2:
  -Unlock prrn_lock when PRRN operations are complete, not after handler is
   scheduled.
  -Remove call to flush_work, the previous broken method of serializing
   PRRN events.
---
 arch/powerpc/kernel/rtasd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 44d66c33d59d..845fc5aec178 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -35,6 +35,8 @@
 
 static DEFINE_SPINLOCK(rtasd_log_lock);
 
+static DEFINE_MUTEX(prrn_lock);
+
 static DECLARE_WAIT_QUEUE_HEAD(rtas_log_wait);
 
 static char *rtas_log_buf;
@@ -284,15 +286,17 @@ static void prrn_work_fn(struct work_struct *work)
 	 */
 	pseries_devicetree_update(-prrn_update_scope);
 	numa_update_cpu_topology(false);
+	mutex_unlock(&prrn_lock);
 }
 
 static DECLARE_WORK(prrn_work, prrn_work_fn);
 
 static void prrn_schedule_update(u32 scope)
 {
-	flush_work(&prrn_work);
-	prrn_update_scope = scope;
-	schedule_work(&prrn_work);
+	if (mutex_trylock(&prrn_lock)) {
+		prrn_update_scope = scope;
+		schedule_work(&prrn_work);
+	}
 }
 
 static void handle_rtas_event(const struct rtas_error_log *log)
-- 
2.17.1
