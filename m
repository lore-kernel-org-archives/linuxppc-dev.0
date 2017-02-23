Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTWMw5r1mzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 21:54:52 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1NAs9DV114251
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 05:54:49 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28swwx15xe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 05:54:49 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 23 Feb 2017 16:24:46 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 67BF0E0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 16:26:24 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1NArekZ17235980
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 16:23:41 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1NAsiLw027803
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 16:24:44 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/xics: Adjust interrupt receive priority for offline
 cpus
Date: Thu, 23 Feb 2017 16:24:43 +0530
Message-Id: <20170223105443.22029-1-svaidy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Offline CPUs need to receive IPIs through XIVE when they are
in stop state and wakeup from that state.

Reduce interrupt receive priority in order to receive XIVE
wakeup interrupts when in offline state.

LOWEST_PRIORITY would allow all interrupts to be delivered
as wakeup events.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 arch/powerpc/sysdev/xics/xics-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 69d858e..c674a9d 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -199,7 +199,7 @@ void xics_migrate_irqs_away(void)
 	xics_set_cpu_giq(xics_default_distrib_server, 0);
 
 	/* Allow IPIs again... */
-	icp_ops->set_priority(DEFAULT_PRIORITY);
+	icp_ops->set_priority(LOWEST_PRIORITY);
 
 	for_each_irq_desc(virq, desc) {
 		struct irq_chip *chip;
-- 
2.9.3
