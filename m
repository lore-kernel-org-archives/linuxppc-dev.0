Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 27A062C035E
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 17:58:06 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 12:28:00 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 75A8F3940060
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:27:38 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G6vsso44564540
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:27:54 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G6vtwq029034
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 12:27:57 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V3 02/10] powerpc, perf: Enable conditional branch filter for POWER8
Date: Wed, 16 Oct 2013 12:26:49 +0530
Message-Id: <1381906617-11392-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1381906617-11392-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1381906617-11392-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, michaele@au1.ibm.com,
 eranian@google.com
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
index 2ee4a70..6e28587 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -580,11 +580,21 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
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
