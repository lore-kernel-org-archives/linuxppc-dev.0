Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7AE2B2C02CF
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 15:25:51 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 10 Jun 2013 15:17:17 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C6CAF2BB0050
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 15:25:43 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5A5BCLJ63439042
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 15:11:12 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5A5Pgdh031361
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 15:25:43 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V3 2/2] powerpc,
 perf: BHRB filter configuration should follow the task
Date: Mon, 10 Jun 2013 10:55:10 +0530
Message-Id: <1370841910-28695-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1370841910-28695-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1370841910-28695-1-git-send-email-khandual@linux.vnet.ibm.com>
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
