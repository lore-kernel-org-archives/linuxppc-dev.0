Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v69ZN5spTzDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 10:26:52 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0MNIjd9128695
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2017 18:26:50 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 284p359jre-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2017 18:26:49 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Jan 2017 09:26:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 224993578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 10:26:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0MNQbVr6947106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 10:26:45 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0MNQCkZ006812
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 10:26:12 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/kernel: Remove nested if statements in
 rtas_initialize()
Date: Mon, 23 Jan 2017 10:25:44 +1100
In-Reply-To: <1485127546-18859-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1485127546-18859-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1485127546-18859-2-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes the unnecessary nested if statements in function
rtas_initialize(), to simplify the code. No functional changes
introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 112cc3b..9ba0f67 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1145,31 +1145,30 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 void __init rtas_initialize(void)
 {
 	unsigned long rtas_region = RTAS_INSTANTIATE_MAX;
+	const __be32 *basep, *entryp, *sizep;
 
 	/* Get RTAS dev node and fill up our "rtas" structure with infos
 	 * about it.
 	 */
 	rtas.dev = of_find_node_by_name(NULL, "rtas");
-	if (rtas.dev) {
-		const __be32 *basep, *entryp, *sizep;
-
-		basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
-		sizep = of_get_property(rtas.dev, "rtas-size", NULL);
-		if (basep != NULL && sizep != NULL) {
-			rtas.base = __be32_to_cpu(*basep);
-			rtas.size = __be32_to_cpu(*sizep);
-			entryp = of_get_property(rtas.dev,
-					"linux,rtas-entry", NULL);
-			if (entryp == NULL) /* Ugh */
-				rtas.entry = rtas.base;
-			else
-				rtas.entry = __be32_to_cpu(*entryp);
-		} else
-			rtas.dev = NULL;
-	}
 	if (!rtas.dev)
 		return;
 
+	basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
+	sizep = of_get_property(rtas.dev, "rtas-size", NULL);
+	if (basep == NULL && sizep == NULL) {
+		rtas.dev = NULL;
+		return;
+	}
+
+	rtas.base = __be32_to_cpu(*basep);
+	rtas.size = __be32_to_cpu(*sizep);
+	entryp = of_get_property(rtas.dev, "linux,rtas-entry", NULL);
+	if (entryp == NULL) /* Ugh */
+		rtas.entry = rtas.base;
+	else
+		rtas.entry = __be32_to_cpu(*entryp);
+
 	/* If RTAS was found, allocate the RMO buffer for it and look for
 	 * the stop-self token if any
 	 */
-- 
2.7.4
