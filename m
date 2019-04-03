Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44472C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 06:07:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9972084B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 06:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9972084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ywb272nYzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 17:07:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YwY61P3kzDqQy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 17:05:30 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x335xo6K098590
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Apr 2019 02:05:27 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rmn9m4g8h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2019 02:05:27 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 3 Apr 2019 07:05:26 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 3 Apr 2019 07:05:23 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3365MCu16646286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Apr 2019 06:05:22 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A93F78066;
 Wed,  3 Apr 2019 06:05:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C419678060;
 Wed,  3 Apr 2019 06:05:19 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.57.68])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  3 Apr 2019 06:05:19 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Fix build error with FLATMEM book3s64 config
Date: Wed,  3 Apr 2019 11:35:14 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040306-0012-0000-0000-00001721BCE8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010865; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183593; UDB=6.00619665; IPR=6.00964344; 
 MB=3.00026271; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-03 06:05:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040306-0013-0000-0000-000056BBB823
Message-Id: <20190403060514.26119-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-03_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=690 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030040
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
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The current value of MAX_PHYSMEM_BITS cannot work with 32 bit configs.
We used to have MAX_PHYSMEM_BITS not defined without SPARSEMEM and 32
bit configs never expected a value to be set for MAX_PHYSMEM_BITS.

Dependent code such as zsmalloc derived the right values based on other
fields. Instead of finding a value that works with different configs,
use new values only for book3s_64. For 64 bit booke, use the definition
of MAX_PHYSMEM_BITS as per commit a7df61a0e2b6 ("[PATCH] ppc64: Increase sparsemem defaults")
That change was done in 2005 and hopefully will work with book3e 64.

Fixes: 8bc086899816 ("powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM configurations")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 15 +++++++++++++++
 arch/powerpc/include/asm/mmu.h           | 15 ---------------
 arch/powerpc/include/asm/nohash/64/mmu.h |  2 ++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 1ceee000c18d..a809bdd77322 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -35,6 +35,21 @@ typedef pte_t *pgtable_t;
 
 #endif /* __ASSEMBLY__ */
 
+/*
+ * If we store section details in page->flags we can't increase the MAX_PHYSMEM_BITS
+ * if we increase SECTIONS_WIDTH we will not store node details in page->flags and
+ * page_to_nid does a page->section->node lookup
+ * Hence only increase for VMEMMAP. Further depending on SPARSEMEM_EXTREME reduce
+ * memory requirements with large number of sections.
+ * 51 bits is the max physical real address on POWER9
+ */
+#if defined(CONFIG_SPARSEMEM_VMEMMAP) && defined(CONFIG_SPARSEMEM_EXTREME) &&  \
+	defined(CONFIG_PPC_64K_PAGES)
+#define MAX_PHYSMEM_BITS 51
+#else
+#define MAX_PHYSMEM_BITS 46
+#endif
+
 /* 64-bit classic hash table MMU */
 #include <asm/book3s/64/mmu-hash.h>
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 598cdcdd1355..78d53c4396ac 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -341,21 +341,6 @@ static inline bool strict_kernel_rwx_enabled(void)
  */
 #define MMU_PAGE_COUNT	16
 
-/*
- * If we store section details in page->flags we can't increase the MAX_PHYSMEM_BITS
- * if we increase SECTIONS_WIDTH we will not store node details in page->flags and
- * page_to_nid does a page->section->node lookup
- * Hence only increase for VMEMMAP. Further depending on SPARSEMEM_EXTREME reduce
- * memory requirements with large number of sections.
- * 51 bits is the max physical real address on POWER9
- */
-#if defined(CONFIG_SPARSEMEM_VMEMMAP) && defined(CONFIG_SPARSEMEM_EXTREME) &&	\
-	defined (CONFIG_PPC_64K_PAGES)
-#define MAX_PHYSMEM_BITS        51
-#elif defined(CONFIG_SPARSEMEM)
-#define MAX_PHYSMEM_BITS        46
-#endif
-
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/mmu.h>
 #else /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
index e6585480dfc4..81cf30c370e5 100644
--- a/arch/powerpc/include/asm/nohash/64/mmu.h
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
 #define _ASM_POWERPC_NOHASH_64_MMU_H_
 
+#define MAX_PHYSMEM_BITS        44
+
 /* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
 #include <asm/nohash/mmu-book3e.h>
 
-- 
2.20.1

