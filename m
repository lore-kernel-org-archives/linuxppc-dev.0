Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcxXx00jkzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 04:58:56 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7NIwqFg090290
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 14:58:54 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chej235sx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 14:58:54 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 04:58:49 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7NIwkvW39256318
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 04:58:46 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7NIwk3V017280
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 04:58:46 +1000
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc/powernv/idle: Round up latency and residency values
Date: Thu, 24 Aug 2017 00:28:41 +0530
Message-Id: <20170823185841.25286-1-svaidy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerNV platforms, firmware provides exit latency and
target residency for each of the idle states in nano
seconds.  Cpuidle framework expects the values in micro
seconds.  Round up to nearest micro seconds to avoid errors
in cases where the values are defined as fractional micro
seconds.

Default idle state of 'snooze' has exit latency of zero.  If
other states have fractional micro second exit latency, they
would get rounded down to zero micro second and make cpuidle
framework choose deeper idle state when snooze loop is the
right choice.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 42896a67aeae..5f3922392059 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -383,9 +383,9 @@ static int powernv_add_idle_states(void)
 		 * Firmware passes residency and latency values in ns.
 		 * cpuidle expects it in us.
 		 */
-		exit_latency = latency_ns[i] / 1000;
+		exit_latency = DIV_ROUND_UP(latency_ns[i], 1000);
 		if (!rc)
-			target_residency = residency_ns[i] / 1000;
+			target_residency = DIV_ROUND_UP(residency_ns[i], 1000);
 		else
 			target_residency = 0;
 
-- 
2.13.5
