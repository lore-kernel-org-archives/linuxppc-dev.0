Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE9B71A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 15:18:22 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 10:48:20 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 78FE7E004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 10:51:33 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t525IEPD40304744
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:48:15 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t525IERB001093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 10:48:14 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/pseries: Ratelimit EPOW event warnings
Date: Tue,  2 Jun 2015 10:48:11 +0530
Message-Id: <1433222291-26461-1-git-send-email-kamalesh@linux.vnet.ibm.com>
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
log, over a period of time. So Limit the warnings by using ratelimit
variant of pr_err. Also, merge adjacent pr_err/pr_emerg into single
one to reduce the number of lines printed per warning.

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
v2 Changes:
 - Merged multiple adjacent pr_err/pr_emerg into single line to reduce multi-line
   warnings, based on Michael's comments.

 arch/powerpc/platforms/pseries/ras.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 02e4a17..3620935 100644
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
+		pr_err_ratelimited("Non critical cooling issue reported by firmware,"
+				   " Check RTAS error log for details");
 		break;
 
 	case EPOW_WARN_POWER:
-		pr_err("Non critical power issue reported by firmware");
-		pr_err("Check RTAS error log for details");
+		pr_err_ratelimited("Non critical power issue reported by firmware,"
+				   " Check RTAS error log for details");
 		break;
 
 	case EPOW_SYSTEM_SHUTDOWN:
@@ -169,15 +169,14 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
 
 	case EPOW_MAIN_ENCLOSURE:
 	case EPOW_POWER_OFF:
-		pr_emerg("Critical power/cooling issue reported by firmware");
-		pr_emerg("Check RTAS error log for details");
-		pr_emerg("Immediate power off");
+		pr_emerg("Critical power/cooling issue reported by firmware,"
+			 " Check RTAS error log for details. Immediate power off");
 		emergency_sync();
 		kernel_power_off();
 		break;
 
 	default:
-		pr_err("Unknown power/cooling event (action code %d)",
+		pr_err_ratelimited("Unknown power/cooling event (action code %d)",
 			action_code);
 	}
 }
-- 
2.1.2
