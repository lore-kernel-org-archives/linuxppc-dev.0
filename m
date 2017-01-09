Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txwz12h3WzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 00:31:09 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v09DUP4Z035026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 08:31:07 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27v5nbxfc3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 08:31:06 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 9 Jan 2017 19:01:02 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 320A4E0060
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 19:02:01 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v09DV0h919333122
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 19:01:00 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v09DV0fP028646
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 19:01:00 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/perf: fix PM_BR_CMPL event code for power9
Date: Mon,  9 Jan 2017 19:00:15 +0530
In-Reply-To: <1483968615-15850-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483968615-15850-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1483968615-15850-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use 0x10012 event code for PM_BR_CMPL event in
power9 event list instead of current 0x40060.

Fixes:34922527a2bcb ('powerpc/perf: Add power9 event list macros for generic and cache events')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-events-list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index c529d9e3e245..b58b1339d79f 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -16,7 +16,7 @@ EVENT(PM_CYC,					0x0001e)
 EVENT(PM_ICT_NOSLOT_CYC,			0x100f8)
 EVENT(PM_CMPLU_STALL,				0x1e054)
 EVENT(PM_INST_CMPL,				0x00002)
-EVENT(PM_BR_CMPL,				0x40060)
+EVENT(PM_BR_CMPL,				0x10012)
 EVENT(PM_BR_MPRED_CMPL,				0x400f6)
 
 /* All L1 D cache load references counted at finish, gated by reject */
-- 
2.7.4
