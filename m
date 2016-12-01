Return-Path: <mukesh02@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTs0005gdzDvj3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 20:08:31 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB194KA1117684
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 04:08:28 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 272f8ewcdh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2016 04:08:28 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mukesh02@linux.vnet.ibm.com>;
 Thu, 1 Dec 2016 14:38:23 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 39FCD394004E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 14:38:21 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB198KrF31129746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 14:38:20 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB198JW2011349
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2016 14:38:20 +0530
From: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/powernv/opal-dump : Handles opal_dump_info
 properly
Date: Thu,  1 Dec 2016 14:38:08 +0530
Message-Id: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
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
