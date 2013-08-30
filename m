Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0409E2C00A3
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Aug 2013 14:25:43 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 30 Aug 2013 09:44:16 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 27A3D394005C
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Aug 2013 09:55:27 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7U4PYN041812016
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Aug 2013 09:55:35 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7U4Pa0u024921
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Aug 2013 09:55:36 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V2 2/6] powerpc,
 perf: Enable conditional branch filter for POWER8
Date: Fri, 30 Aug 2013 09:54:46 +0530
Message-Id: <1377836690-32710-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: eranian@google.com, acme@redhat.com, ellerman@au1.ibm.com,
 sukadev@linux.vnet.ibm.com, michael.neuling@au1.ibm.com
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
