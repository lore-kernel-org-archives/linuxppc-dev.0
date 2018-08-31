Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421k523BTfzF37s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 12:36:21 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7V2T3bx041170
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 22:36:19 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m6sk9x8wm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 22:36:18 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 30 Aug 2018 22:36:18 -0400
Subject: [PATCH v4 1/2] powerpc/pseries: Remove prrn_work workqueue
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: johnallen3991@gmail.com, desnesn@linux.vnet.ibm.com,
 haren@linux.vnet.ibm.com
Date: Thu, 30 Aug 2018 21:15:13 -0500
In-Reply-To: <153568164555.2146.11463040249853453135.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <153568164555.2146.11463040249853453135.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153568171320.2146.14267934108644287102.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a PRRN event is received we are already running in a worker
thread. Instead of spawning off another worker thread on the prrn_work
workqueue to handle the PRRN event we can just call the PRRN handler
routine directly.

With this update we can also pass the scope variable for the PRRN
event directly to the handler instead of it being a global variable.

Signed-off-by: John Allen <jallen@linux.ibm.com>
Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
v4:
  - Remove prrn_work workqueue as suggested by Michael Ellerman
  - Make the PRRN event scope passed in as opposed to a global, suggested
    by Michael Ellerman
v3:
  -Scrap the mutex as it only replicates existing workqueue behavior.
v2:
  -Unlock prrn_lock when PRRN operations are complete, not after handler is
   scheduled.
  -Remove call to flush_work, the previous broken method of serializing
   PRRN events.
---
 arch/powerpc/kernel/rtasd.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 44d66c33d59d..23b88b923f06 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -274,27 +274,16 @@ void pSeries_log_error(char *buf, unsigned int err_type, int fatal)
 }
 
 #ifdef CONFIG_PPC_PSERIES
-static s32 prrn_update_scope;
-
-static void prrn_work_fn(struct work_struct *work)
+static void handle_prrn_event(s32 scope)
 {
 	/*
 	 * For PRRN, we must pass the negative of the scope value in
 	 * the RTAS event.
 	 */
-	pseries_devicetree_update(-prrn_update_scope);
+	pseries_devicetree_update(-scope);
 	numa_update_cpu_topology(false);
 }
 
-static DECLARE_WORK(prrn_work, prrn_work_fn);
-
-static void prrn_schedule_update(u32 scope)
-{
-	flush_work(&prrn_work);
-	prrn_update_scope = scope;
-	schedule_work(&prrn_work);
-}
-
 static void handle_rtas_event(const struct rtas_error_log *log)
 {
 	if (rtas_error_type(log) != RTAS_TYPE_PRRN || !prrn_is_enabled())
@@ -303,7 +292,7 @@ static void handle_rtas_event(const struct rtas_error_log *log)
 	/* For PRRN Events the extended log length is used to denote
 	 * the scope for calling rtas update-nodes.
 	 */
-	prrn_schedule_update(rtas_error_extended_log_length(log));
+	handle_prrn_event(rtas_error_extended_log_length(log));
 }
 
 #else
