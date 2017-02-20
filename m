Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRkpX500zzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:23:16 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1KDJCHN098106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:23:13 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28qvbychcj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:23:13 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 23:23:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6DB802CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:23:09 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1KDN1Eq47382726
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:23:09 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1KDMb93000716
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:22:37 +1100
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
To: stewart@linux.vnet.ibm.com, jk@ozlabs.org, hegdevasant@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Subject: [PATCH V2 1/2] powerpc/powernv/opal-dump : Handles opal_dump_info
 properly
Date: Mon, 20 Feb 2017 18:52:10 +0530
Message-Id: <1487596931-26975-1-git-send-email-mukesh02@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Moves the return value check of 'opal_dump_info' to a proper place which
was previously unnecessarily filling all the dump info even on failure.

Signed-off-by: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
---
 arch/powerpc/platforms/powernv/opal-dump.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 4c82782..ae32212 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -225,13 +225,16 @@ static int64_t dump_read_info(uint32_t *dump_id, uint32_t *dump_size, uint32_t *
 	if (rc == OPAL_PARAMETER)
 		rc = opal_dump_info(&id, &size);
 
+	if (rc) {
+		pr_warn("%s: Failed to get dump info (%d)\n",
+			__func__, rc);
+		return rc;
+	}
+
 	*dump_id = be32_to_cpu(id);
 	*dump_size = be32_to_cpu(size);
 	*dump_type = be32_to_cpu(type);
 
-	if (rc)
-		pr_warn("%s: Failed to get dump info (%d)\n",
-			__func__, rc);
 	return rc;
 }
 
-- 
2.7.4
