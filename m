Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CD4E1A01B5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 19:22:47 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 23 Jul 2014 19:22:44 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 075802BB002D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 19:22:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N8xn7h5767656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 18:59:50 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N9MehT011476
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 19:22:40 +1000
Received: from hegdevasant.in.ibm.com (hegdevasant.in.ibm.com [9.124.35.88]
 (may be forged))
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s6N9Mdrq011448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 19:22:40 +1000
Subject: [PATCH 1/2] powerpc/powernv: Change BUG_ON to WARN_ON in elog code
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Wed, 23 Jul 2014 14:52:39 +0530
Message-ID: <20140723092236.4740.33763.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can continue to read the error log (up to MAX size) even if
we get the elog size more than MAX size. Hence change BUG_ON to
WARN_ON.

Also updated error message.

Reported-by: Gopesh Kumar Chaudhary <gopchaud@in.ibm.com>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-elog.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 10268c4..0ad533b 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -249,7 +249,7 @@ static void elog_work_fn(struct work_struct *work)
 
 	rc = opal_get_elog_size(&id, &size, &type);
 	if (rc != OPAL_SUCCESS) {
-		pr_err("ELOG: Opal log read failed\n");
+		pr_err("ELOG: OPAL log info read failed\n");
 		return;
 	}
 
@@ -257,7 +257,7 @@ static void elog_work_fn(struct work_struct *work)
 	log_id = be64_to_cpu(id);
 	elog_type = be64_to_cpu(type);
 
-	BUG_ON(elog_size > OPAL_MAX_ERRLOG_SIZE);
+	WARN_ON(elog_size > OPAL_MAX_ERRLOG_SIZE);
 
 	if (elog_size >= OPAL_MAX_ERRLOG_SIZE)
 		elog_size  =  OPAL_MAX_ERRLOG_SIZE;
