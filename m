Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5xSz2cKZzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 22:22:11 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v93BJGGl101619
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 07:22:08 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dc8ns3795-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 07:22:07 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 3 Oct 2017 21:22:05 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v93BM2W838404324
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 22:22:02 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v93BM11Y016790
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 22:22:01 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/perf: Cleanup cache_sel bits comment
Date: Tue,  3 Oct 2017 16:51:51 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1507029712-31033-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the raw event code comment in power9-pmu.c with respect to
"cache" bits, since power9 MMCRC does not support these.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-pmu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 24b5b5b7a206..88b0a78eff4d 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -63,16 +63,8 @@
  *	MMCRA[9:11] = thresh_cmp[0:2]
  *	MMCRA[12:18] = thresh_cmp[3:9]
  *
- * if unit == 6 or unit == 7
- *	MMCRC[53:55] = cache_sel[1:3]      (L2EVENT_SEL)
- * else if unit == 8 or unit == 9:
- *	if cache_sel[0] == 0: # L3 bank
- *		MMCRC[47:49] = cache_sel[1:3]  (L3EVENT_SEL0)
- *	else if cache_sel[0] == 1:
- *		MMCRC[50:51] = cache_sel[2:3]  (L3EVENT_SEL1)
- * else if cache_sel[1]: # L1 event
- *	MMCR1[16] = cache_sel[2]
- *	MMCR1[17] = cache_sel[3]
+ * MMCR1[16] = cache_sel[2]
+ * MMCR1[17] = cache_sel[3]
  *
  * if mark:
  *	MMCRA[63]    = 1		(SAMPLE_ENABLE)
-- 
2.7.4
