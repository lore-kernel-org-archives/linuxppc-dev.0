Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9EEB12C00A7
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 15:48:23 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 22 May 2013 11:12:03 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 63FF5E0053
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:20:47 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4M5m9hk1966366
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:18:09 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4M5mDLP017753
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 15:48:13 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc,
 perf: Ignore separate BHRB privilege state filter request
Date: Wed, 22 May 2013 11:17:46 +0530
Message-Id: <1369201667-9048-2-git-send-email-khandual@linux.vnet.ibm.com>
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

Completely ignore BHRB privilege state filter request as we are
already configuring MMCRA register with privilege state filtering
attribute for the accompanying PMU event. This would help achieve
cleaner user space interaction for BHRB.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index f7d1c4f..8ed323d 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -525,16 +525,17 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
 	u64 pmu_bhrb_filter = 0;
 	u64 br_privilege = branch_sample_type & ONLY_PLM;
 
-	/* BHRB and regular PMU events share the same prvillege state
+	/* BHRB and regular PMU events share the same prvilege state
 	 * filter configuration. BHRB is always recorded along with a
-	 * regular PMU event. So privilege state filter criteria for BHRB
-	 * and the companion PMU events has to be the same. As a default
-	 * "perf record" tool sets all privillege bits ON when no filter
-	 * criteria is provided in the command line. So as along as all
-	 * privillege bits are ON or they are OFF, we are good to go.
+	 * regular PMU event. So privilege state filter criteria for
+	 * the BHRB and the companion PMU events has to be the same.
+	 * Separate BHRB privillege state filter requests would be
+	 * ignored.
 	 */
-	if ((br_privilege != 7) && (br_privilege != 0))
-		return -1;
+
+	if (br_privilege)
+		pr_info("BHRB privilege state filter request %llx ignored\n",
+								br_privilege);
 
 	/* No branch filter requested */
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
-- 
1.7.11.7
