Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A94C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:08:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835C92173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835C92173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kjH90nJSzDq6q
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:08:53 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kj4d2Kq9zDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 22:59:44 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HCjEEs064077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rx3j8k3es-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:42 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 17 Apr 2019 13:59:41 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 13:59:39 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HCxc9U11403474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 12:59:38 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ECFCBE054;
 Wed, 17 Apr 2019 12:59:38 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D612BE051;
 Wed, 17 Apr 2019 12:59:36 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.202])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 12:59:36 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v4 3/8] powerpc/mm: Validate address values against different
 region limits
Date: Wed, 17 Apr 2019 18:29:15 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
References: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041712-8235-0000-0000-00000E815855
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010943; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190369; UDB=6.00623770; IPR=6.00971167; 
 MB=3.00026484; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 12:59:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041712-8236-0000-0000-0000452E59D8
Message-Id: <20190417125920.785-4-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170089
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

This adds an explicit check in various functions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c  | 18 +++++++++++++++---
 arch/powerpc/mm/pgtable-hash64.c | 13 ++++++++++---
 arch/powerpc/mm/pgtable-radix.c  | 16 ++++++++++++++++
 arch/powerpc/mm/pgtable_64.c     |  5 +++++
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index c6b39e7694ba..ef0ca3bf555d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -786,9 +786,16 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
 
 int hash__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
-	int rc = htab_bolt_mapping(start, end, __pa(start),
-				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
-				   mmu_kernel_ssize);
+	int rc;
+
+	if (end >= H_VMALLOC_START) {
+		pr_warn("Outisde the supported range\n");
+		return -1;
+	}
+
+	rc = htab_bolt_mapping(start, end, __pa(start),
+			       pgprot_val(PAGE_KERNEL), mmu_linear_psize,
+			       mmu_kernel_ssize);
 
 	if (rc < 0) {
 		int rc2 = htab_remove_mapping(start, end, mmu_linear_psize,
@@ -929,6 +936,11 @@ static void __init htab_initialize(void)
 		DBG("creating mapping for region: %lx..%lx (prot: %lx)\n",
 		    base, size, prot);
 
+		if ((base + size) >= H_VMALLOC_START) {
+			pr_warn("Outisde the supported range\n");
+			continue;
+		}
+
 		BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
 				prot, mmu_linear_psize, mmu_kernel_ssize));
 	}
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index c08d49046a96..d934de4e2b3a 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -112,9 +112,16 @@ int __meminit hash__vmemmap_create_mapping(unsigned long start,
 				       unsigned long page_size,
 				       unsigned long phys)
 {
-	int rc = htab_bolt_mapping(start, start + page_size, phys,
-				   pgprot_val(PAGE_KERNEL),
-				   mmu_vmemmap_psize, mmu_kernel_ssize);
+	int rc;
+
+	if ((start + page_size) >= H_VMEMMAP_END) {
+		pr_warn("Outisde the supported range\n");
+		return -1;
+	}
+
+	rc = htab_bolt_mapping(start, start + page_size, phys,
+			       pgprot_val(PAGE_KERNEL),
+			       mmu_vmemmap_psize, mmu_kernel_ssize);
 	if (rc < 0) {
 		int rc2 = htab_remove_mapping(start, start + page_size,
 					      mmu_vmemmap_psize,
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 94b18996e1b0..263c3ff662c3 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -338,6 +338,12 @@ void __init radix_init_pgtable(void)
 		 * page tables will be allocated within the range. No
 		 * need or a node (which we don't have yet).
 		 */
+
+		if ((reg->base + reg->size) >= RADIX_VMALLOC_START) {
+			pr_warn("Outisde the supported range\n");
+			continue;
+		}
+
 		WARN_ON(create_physical_mapping(reg->base,
 						reg->base + reg->size,
 						-1));
@@ -870,6 +876,11 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 
 int __meminit radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
+	if (end >= RADIX_VMALLOC_START) {
+		pr_warn("Outisde the supported range\n");
+		return -1;
+	}
+
 	return create_physical_mapping(start, end, nid);
 }
 
@@ -897,6 +908,11 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 	int nid = early_pfn_to_nid(phys >> PAGE_SHIFT);
 	int ret;
 
+	if ((start + page_size) >= RADIX_VMEMMAP_END) {
+		pr_warn("Outisde the supported range\n");
+		return -1;
+	}
+
 	ret = __map_kernel_page_nid(start, phys, __pgprot(flags), page_size, nid);
 	BUG_ON(ret);
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 56068cac2a3c..72f58c076e26 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -121,6 +121,11 @@ void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size, pgprot_
 	if (pgprot_val(prot) & H_PAGE_4K_PFN)
 		return NULL;
 
+	if ((ea + size) >= (void *)IOREMAP_END) {
+		pr_warn("Outisde the supported range\n");
+		return NULL;
+	}
+
 	WARN_ON(pa & ~PAGE_MASK);
 	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
 	WARN_ON(size & ~PAGE_MASK);
-- 
2.20.1

