Return-Path: <SRS0=npwJ=RU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C17C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 15:58:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1BB2087F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 15:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1BB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MkWG0hWkzDq7j
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 02:58:34 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MkJQ0w55zDqPK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 02:49:09 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2HFn89C005542
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 11:49:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r9em0rw3q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 11:49:08 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Sun, 17 Mar 2019 15:49:07 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 17 Mar 2019 15:49:05 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2HFn4lq16253044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Mar 2019 15:49:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F8E3B2064;
 Sun, 17 Mar 2019 15:49:04 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A42AEB205F;
 Sun, 17 Mar 2019 15:49:01 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.84.106])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sun, 17 Mar 2019 15:49:01 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH v2 5/5] powerpc/mm/hash: Simplify the region id calculation.
Date: Sun, 17 Mar 2019 21:18:27 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317154827.9188-1-aneesh.kumar@linux.ibm.com>
References: <20190317154827.9188-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031715-2213-0000-0000-000003660E15
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010774; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01175713; UDB=6.00614895; IPR=6.00956389; 
 MB=3.00026018; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-17 15:49:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031715-2214-0000-0000-00005DB484D9
Message-Id: <20190317154827.9188-6-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-17_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903170124
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

This reduces multiple comparisons in get_region_id to a bit shift operation.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  4 ++-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  1 +
 arch/powerpc/include/asm/book3s/64/hash.h     | 31 +++++++++----------
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 0dd62287f56c..64eaf187f891 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -13,12 +13,14 @@
  */
 #define MAX_EA_BITS_PER_CONTEXT		46
 
+#define REGION_SHIFT		(MAX_EA_BITS_PER_CONTEXT - 2)
+
 /*
  * Our page table limit us to 64TB. Hence for the kernel mapping,
  * each MAP area is limited to 16 TB.
  * The four map areas are:  linear mapping, vmap, IO and vmemmap
  */
-#define H_KERN_MAP_SIZE		(ASM_CONST(1) << (MAX_EA_BITS_PER_CONTEXT - 2))
+#define H_KERN_MAP_SIZE		(ASM_CONST(1) << REGION_SHIFT)
 
 /*
  * Define the address range of the kernel non-linear virtual area
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index e392cf17b457..24ca63beba14 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -12,6 +12,7 @@
  * is handled in the hotpath.
  */
 #define MAX_EA_BITS_PER_CONTEXT		49
+#define REGION_SHIFT		MAX_EA_BITS_PER_CONTEXT
 
 /*
  * We use one context for each MAP area.
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 523b9191a1e2..d1f0d7332b84 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -87,26 +87,26 @@
 #define H_VMEMMAP_SIZE		H_KERN_MAP_SIZE
 #define H_VMEMMAP_END		(H_VMEMMAP_START + H_VMEMMAP_SIZE)
 
+#define REGION_ID(ea)	((((unsigned long)ea - H_KERN_VIRT_START) >> REGION_SHIFT) + 2)
+
 /*
  * Region IDs
  */
-#define USER_REGION_ID		1
-#define KERNEL_REGION_ID	2
-#define VMALLOC_REGION_ID	3
-#define IO_REGION_ID		4
-#define VMEMMAP_REGION_ID	5
+#define USER_REGION_ID		0
+#define KERNEL_REGION_ID	1
+#define VMALLOC_REGION_ID	REGION_ID(H_VMALLOC_START)
+#define IO_REGION_ID		REGION_ID(H_KERN_IO_START)
+#define VMEMMAP_REGION_ID	REGION_ID(H_VMEMMAP_START)
 
 /*
  * Defines the address of the vmemap area, in its own region on
  * hash table CPUs.
  */
-
 #ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 #endif /* CONFIG_PPC_MM_SLICES */
 
-
 /* PTEIDX nibble */
 #define _PTEIDX_SECONDARY	0x8
 #define _PTEIDX_GROUP_IX	0x7
@@ -117,22 +117,21 @@
 #ifndef __ASSEMBLY__
 static inline int get_region_id(unsigned long ea)
 {
+	int region_id;
 	int id = (ea >> 60UL);
 
 	if (id == 0)
 		return USER_REGION_ID;
 
-	VM_BUG_ON(id != 0xc);
-	VM_BUG_ON(ea >= H_VMEMMAP_END);
+	if (ea < H_KERN_VIRT_START)
+		return KERNEL_REGION_ID;
 
-	if (ea >= H_VMEMMAP_START)
-		return VMEMMAP_REGION_ID;
-	else if (ea >= H_KERN_IO_START)
-		return IO_REGION_ID;
-	else if (ea >= H_VMALLOC_START)
-		return VMALLOC_REGION_ID;
+	VM_BUG_ON(id != 0xc);
+	BUILD_BUG_ON(REGION_ID(H_VMALLOC_START) != 2);
 
-	return KERNEL_REGION_ID;
+	region_id = REGION_ID(ea);
+	VM_BUG_ON(region_id > VMEMMAP_REGION_ID);
+	return region_id;
 }
 
 #define	hash__pmd_bad(pmd)		(pmd_val(pmd) & H_PMD_BAD_BITS)
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b3f256c042aa..b146448109fd 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -794,7 +794,7 @@ static inline unsigned long get_kernel_context(unsigned long ea)
 		 */
 		ctx =  1 + ((ea & EA_MASK) >> MAX_EA_BITS_PER_CONTEXT);
 	} else
-		ctx = region_id + MAX_KERNEL_CTX_CNT - 2;
+		ctx = region_id + MAX_KERNEL_CTX_CNT - 1;
 	return ctx;
 }
 
-- 
2.20.1

