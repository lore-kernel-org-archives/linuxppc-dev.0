Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D31A2C00A0
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 15:48:21 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 22 May 2013 11:13:16 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EC1193940023
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:18:14 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4M5m81661669618
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:18:08 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4M5mDKs017760
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 15:48:13 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc,
 perf: BHRB filter configuration should follow the task
Date: Wed, 22 May 2013 11:17:47 +0530
Message-Id: <1369201667-9048-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1369201667-9048-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1369201667-9048-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the task moves around the system, the corresponding cpuhw
per cpu strcuture should be popullated with the BHRB filter
request value so that PMU could be configured appropriately with
that during the next call into power_pmu_enable().

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 426180b..48c68a8 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1122,8 +1122,11 @@ nocheck:
 
 	ret = 0;
  out:
-	if (has_branch_stack(event))
+	if (has_branch_stack(event)) {
 		power_pmu_bhrb_enable(event);
+		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
+					event->attr.branch_sample_type);
+	}
 
 	perf_pmu_enable(event->pmu);
 	local_irq_restore(flags);
-- 
1.7.11.7
