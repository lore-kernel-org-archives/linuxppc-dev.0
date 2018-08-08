Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lwKq6qtKzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 01:29:35 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w78FOEgE073983
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2018 11:29:33 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kr19k5wym-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 11:29:32 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Wed, 8 Aug 2018 09:29:32 -0600
From: John Allen <jallen@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: nfont@linux.vnet.ibm.com, desnesn@linux.vnet.ibm.com,
 John Allen <jallen@linux.ibm.com>
Subject: [PATCH v3 1/2] powerpc/pseries: Avoid blocking rtas polling handling
 multiple PRRN events
Date: Wed,  8 Aug 2018 10:29:25 -0500
In-Reply-To: <20180808152926.28842-1-jallen@linux.ibm.com>
References: <20180808152926.28842-1-jallen@linux.ibm.com>
Message-Id: <20180808152926.28842-2-jallen@linux.ibm.com>
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

This patch removes the blocking call to flush_work and allows the
default workqueue behavior to handle duplicate events.

Signed-off-by: John Allen <jallen@linux.ibm.com>
---
v3:
  -Scrap the mutex as it only replicates existing workqueue behavior.
v2:
  -Unlock prrn_lock when PRRN operations are complete, not after handler is
   scheduled.
  -Remove call to flush_work, the previous broken method of serializing
   PRRN events.
---
 arch/powerpc/kernel/rtasd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 44d66c33d59d..2017934e5985 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -290,7 +290,6 @@ static DECLARE_WORK(prrn_work, prrn_work_fn);
 
 static void prrn_schedule_update(u32 scope)
 {
-	flush_work(&prrn_work);
 	prrn_update_scope = scope;
 	schedule_work(&prrn_work);
 }
-- 
2.17.1
