Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C0B52C00A6
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 16:23:12 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 22 May 2013 11:48:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B40D4125805F
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:55:06 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4M6N0g68847698
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:53:01 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4M6N6DJ011756
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 06:23:08 GMT
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] powerpc, perf: Enable conditional branch filter for POWER8
Date: Wed, 22 May 2013 11:52:38 +0530
Message-Id: <1369203761-12649-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, peterz@infradead.org,
 eranian@google.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enables conditional branch filter support for POWER8
utilizing MMCRA register based filter and also invalidates
a BHRB branch filter combination involving conditional
branches.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 8ed323d..e60b38f 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -548,11 +548,21 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
 		return -1;
 
+	/* Invalid branch filter combination - HW does not support */
+	if ((branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) &&
+			(branch_sample_type & PERF_SAMPLE_BRANCH_COND))
+		return -1;
+
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
 		pmu_bhrb_filter |= POWER8_MMCRA_IFM1;
 		return pmu_bhrb_filter;
 	}
 
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
+		pmu_bhrb_filter |= POWER8_MMCRA_IFM3;
+		return pmu_bhrb_filter;
+	}
+
 	/* Every thing else is unsupported */
 	return -1;
 }
-- 
1.7.11.7
