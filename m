Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CD011A0170
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 14:33:33 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Thu, 28 May 2015 10:03:30 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3B5D4E0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 10:06:38 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4S4XQND5767634
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 10:03:26 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4S4XQ3T022101
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 10:03:26 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC PATCH] powerpc/pseries: Ratelimit EPOW event warnings
Date: Thu, 28 May 2015 10:03:15 +0530
Message-Id: <1432787595-9946-1-git-send-email-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We print the respective warning after parsing EPOW interrupts,
prompting user to take action depending upon the severity of the
event.

Some times same EPOW event warning, such as below could flood kernel
log, within very short duration. So Limit the message by using
ratelimit variant of pr_err.

May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
May 25 04:04:24 alp kernel: Non critical power or cooling issue cleared
May 25 04:07:18 alp kernel: Non critical power or cooling issue cleared
May 25 04:13:04 alp kernel: Non critical power or cooling issue cleared
May 25 04:22:04 alp kernel: Non critical power or cooling issue cleared
May 25 04:22:26 alp kernel: Non critical power or cooling issue cleared
May 25 04:22:36 alp kernel: Non critical power or cooling issue cleared

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/ras.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 02e4a17..2556bc2 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -145,17 +145,17 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 
 	switch (action_code) {
 	case EPOW_RESET:
-		pr_err("Non critical power or cooling issue cleared");
+		pr_err_ratelimited("Non critical power or cooling issue cleared");
 		break;
 
 	case EPOW_WARN_COOLING:
-		pr_err("Non critical cooling issue reported by firmware");
-		pr_err("Check RTAS error log for details");
+		pr_err_ratelimited("Non critical cooling issue reported by firmware");
+		pr_err_ratelimited("Check RTAS error log for details");
 		break;
 
 	case EPOW_WARN_POWER:
-		pr_err("Non critical power issue reported by firmware");
-		pr_err("Check RTAS error log for details");
+		pr_err_ratelimited("Non critical power issue reported by firmware");
+		pr_err_ratelimited("Check RTAS error log for details");
 		break;
 
 	case EPOW_SYSTEM_SHUTDOWN:
@@ -177,7 +177,7 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 		break;
 
 	default:
-		pr_err("Unknown power/cooling event (action code %d)",
+		pr_err_ratelimited("Unknown power/cooling event (action code %d)",
 			action_code);
 	}
 }
-- 
2.1.2
