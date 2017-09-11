Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xrZkS0gSnzDrYV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 03:32:31 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8BHTIsf040910
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 13:32:29 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cwx4gtvrd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 13:32:29 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 12 Sep 2017 03:32:26 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8BHWI8F28377224
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 03:32:18 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8BHWIqM000897
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 03:32:18 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Fix for core/nest imc call trace on cpuhotplug
Date: Mon, 11 Sep 2017 23:02:14 +0530
Message-Id: <1505151134-26128-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nest/core pmu units are enabled only when it is used. A reference count is
maintained for the events which uses the nest/core pmu units. Currently in
*_imc_counters_release function a WARN() is used for notification of any
underflow of ref count. Replace WARN() with a pr_info since it is an overkill.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 9ccac86..4d523d0 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -409,7 +409,7 @@ static void nest_imc_counters_release(struct perf_event *event)
 			return;
 		}
 	} else if (ref->refc < 0) {
-		WARN(1, "nest-imc: Invalid event reference count\n");
+		pr_info("nest-imc: Invalid event reference count\n");
 		ref->refc = 0;
 	}
 	mutex_unlock(&ref->lock);
@@ -656,7 +656,7 @@ static void core_imc_counters_release(struct perf_event *event)
 			return;
 		}
 	} else if (ref->refc < 0) {
-		WARN(1, "core-imc: Invalid event reference count\n");
+		pr_info("core-imc: Invalid event reference count\n");
 		ref->refc = 0;
 	}
 	mutex_unlock(&ref->lock);
-- 
2.7.4
