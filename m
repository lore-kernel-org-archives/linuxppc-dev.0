Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rggSk5tT1zDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 12:33:26 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u612SXmJ075361
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:33:24 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwnpbf6t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:33:24 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 1 Jul 2016 12:33:19 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 190DC3578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 12:33:17 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u612XHBu21495928
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 12:33:17 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u612XG6f018777
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 12:33:16 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] powerpc/fadump: Fix compile error due to missing semicolon
Date: Fri,  1 Jul 2016 12:31:48 +1000
In-Reply-To: <1467025661-1410-1-git-send-email-colin.king@canonical.com>
References: <1467025661-1410-1-git-send-email-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1467340308-720-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The commit "powerpc/fadump: trivial fix of spelling mistake, clean up
message" removed a semicolon causing the following compile failure:

arch/powerpc/kernel/fadump.c: In function ‘fadump_invalidate_dump’:
arch/powerpc/kernel/fadump.c:1014:2: error: expected ‘;’ before ‘}’ token
  }
  ^

Reported-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index f066486..b3a6633 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1010,7 +1010,7 @@ static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
 
 	if (rc) {
 		pr_err("Failed to invalidate firmware-assisted dump registration. Unexpected error (%d).\n", rc);
-		return rc
+		return rc;
 	}
 	fw_dump.dump_active = 0;
 	fdm_active = NULL;
-- 
2.8.1
