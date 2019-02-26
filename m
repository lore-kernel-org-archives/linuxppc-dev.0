Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A214C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 04:43:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D02E217F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 04:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D02E217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447mQz1gqXzDqPT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 15:43:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447mM327XzzDqJN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 15:39:58 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1Q4cf9D099881
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 23:39:57 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qvt521wrp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 23:39:56 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 26 Feb 2019 04:39:56 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 26 Feb 2019 04:39:53 -0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1Q4dqT828049488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Feb 2019 04:39:52 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52E186A047;
 Tue, 26 Feb 2019 04:39:52 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A52446A051;
 Tue, 26 Feb 2019 04:39:49 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.94.202])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 26 Feb 2019 04:39:49 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH v2 2/2] powerpc/mm/hash: Handle mmap_min_addr correctly in
 get_unmapped_area topdown search
Date: Tue, 26 Feb 2019 10:09:35 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226043935.14053-1-aneesh.kumar@linux.ibm.com>
References: <20190226043935.14053-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022604-0004-0000-0000-000014E713B7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010665; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01166464; UDB=6.00609306; IPR=6.00947070; 
 MB=3.00025743; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-26 04:39:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022604-0005-0000-0000-00008AB8C5D8
Message-Id: <20190226043935.14053-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-26_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=773 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260033
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When doing top-down search the low_limit is not PAGE_SIZE but rather
max(PAGE_SIZE, mmap_min_addr). This handle cases in which mmap_min_addr >
PAGE_SIZE.

Fixes: fba2369e6ceb ("mm: use vm_unmapped_area() on powerpc architecture")
Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/slice.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 06898c13901d..aec91dbcdc0b 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -32,6 +32,7 @@
 #include <linux/export.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
+#include <linux/security.h>
 #include <asm/mman.h>
 #include <asm/mmu.h>
 #include <asm/copro.h>
@@ -377,6 +378,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long addr, found, prev;
 	struct vm_unmapped_area_info info;
+	unsigned long min_addr = max(PAGE_SIZE, mmap_min_addr);
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
@@ -393,7 +395,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	if (high_limit > DEFAULT_MAP_WINDOW)
 		addr += mm->context.slb_addr_limit - DEFAULT_MAP_WINDOW;
 
-	while (addr > PAGE_SIZE) {
+	while (addr > min_addr) {
 		info.high_limit = addr;
 		if (!slice_scan_available(addr - 1, available, 0, &addr))
 			continue;
@@ -405,8 +407,8 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 		 * Check if we need to reduce the range, or if we can
 		 * extend it to cover the previous available slice.
 		 */
-		if (addr < PAGE_SIZE)
-			addr = PAGE_SIZE;
+		if (addr < min_addr)
+			addr = min_addr;
 		else if (slice_scan_available(addr - 1, available, 0, &prev)) {
 			addr = prev;
 			goto prev_slice;
@@ -528,7 +530,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		addr = _ALIGN_UP(addr, page_size);
 		slice_dbg(" aligned addr=%lx\n", addr);
 		/* Ignore hint if it's too large or overlaps a VMA */
-		if (addr > high_limit - len ||
+		if (addr > high_limit - len || addr < mmap_min_addr ||
 		    !slice_area_is_free(mm, addr, len))
 			addr = 0;
 	}
-- 
2.20.1

