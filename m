Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkPtf56cgzDqc9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:32:42 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GANioB078126
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:31 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297cf6pvcp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:30 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 06:32:29 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 02/11] powerpc/mm/slice: when computing slice mask limit
 lowe slice max addr correctly
Date: Thu, 16 Mar 2017 16:02:00 +0530
In-Reply-To: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1489660329-22501-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For low slice max addr should be less that 4G

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slice.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 2b27458902ee..bf150557dba8 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -83,11 +83,10 @@ static struct slice_mask slice_range_to_mask(unsigned long start,
 	struct slice_mask ret = { 0, 0 };
 
 	if (start < SLICE_LOW_TOP) {
-		unsigned long mend = min(end, SLICE_LOW_TOP);
-		unsigned long mstart = min(start, SLICE_LOW_TOP);
+		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
 
 		ret.low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
-			- (1u << GET_LOW_SLICE_INDEX(mstart));
+			- (1u << GET_LOW_SLICE_INDEX(start));
 	}
 
 	if ((start + len) > SLICE_LOW_TOP)
-- 
2.7.4
