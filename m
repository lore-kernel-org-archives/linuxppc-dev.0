Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB5C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:22:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E108206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E108206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k1dS2mLNzDqDm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:22:20 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1Js3Vw0zDqFB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:07:57 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3G9wuZ3004671
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 06:07:56 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwbr43sru-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 06:07:55 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 16 Apr 2019 11:07:54 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:07:51 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GA7oJo15466560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:07:50 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 875F8AC060;
 Tue, 16 Apr 2019 10:07:50 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00AD2AC05B;
 Tue, 16 Apr 2019 10:07:48 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.209])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 10:07:48 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v3 7/8] powerpc/mm: Consolidate radix and hash address map
 details
Date: Tue, 16 Apr 2019 15:37:21 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
References: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-0064-0000-0000-000003CB9D05
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010937; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189843; UDB=6.00623449; IPR=6.00970634; 
 MB=3.00026465; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-16 10:07:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-0065-0000-0000-00003D158989
Message-Id: <20190416100722.10324-8-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160069
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

We now have

4K page size config

 kernel_region_map_size = 16TB
 kernel vmalloc start   = 0xc000100000000000
 kernel IO start        = 0xc000200000000000
 kernel vmemmap start   = 0xc000300000000000

with 64K page size config:

 kernel_region_map_size = 512TB
 kernel vmalloc start   = 0xc008000000000000
 kernel IO start        = 0xc00a000000000000
 kernel vmemmap start   = 0xc00c000000000000

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 21 -----
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 18 -----
 arch/powerpc/include/asm/book3s/64/hash.h     | 28 ++-----
 arch/powerpc/include/asm/book3s/64/map.h      | 80 +++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 35 +-------
 arch/powerpc/include/asm/book3s/64/radix.h    | 19 -----
 arch/powerpc/mm/hash_utils_64.c               | 11 +--
 arch/powerpc/mm/pgtable-hash64.c              |  2 +-
 arch/powerpc/mm/pgtable-radix.c               | 13 +--
 arch/powerpc/mm/pgtable_64.c                  | 10 ---
 arch/powerpc/mm/ptdump/hashpagetable.c        |  4 -
 arch/powerpc/mm/ptdump/ptdump.c               |  5 --
 arch/powerpc/mm/slb.c                         |  6 +-
 13 files changed, 101 insertions(+), 151 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/map.h

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 64eaf187f891..fa47d8a237b2 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -7,27 +7,6 @@
 #define H_PUD_INDEX_SIZE  9
 #define H_PGD_INDEX_SIZE  9
 
-/*
- * Each context is 512TB. But on 4k we restrict our max TASK size to 64TB
- * Hence also limit max EA bits to 64TB.
- */
-#define MAX_EA_BITS_PER_CONTEXT		46
-
-#define REGION_SHIFT		(MAX_EA_BITS_PER_CONTEXT - 2)
-
-/*
- * Our page table limit us to 64TB. Hence for the kernel mapping,
- * each MAP area is limited to 16 TB.
- * The four map areas are:  linear mapping, vmap, IO and vmemmap
- */
-#define H_KERN_MAP_SIZE		(ASM_CONST(1) << REGION_SHIFT)
-
-/*
- * Define the address range of the kernel non-linear virtual area
- * 16TB
- */
-#define H_KERN_VIRT_START	ASM_CONST(0xc000100000000000)
-
 #ifndef __ASSEMBLY__
 #define H_PTE_TABLE_SIZE	(sizeof(pte_t) << H_PTE_INDEX_SIZE)
 #define H_PMD_TABLE_SIZE	(sizeof(pmd_t) << H_PMD_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 24ca63beba14..1deddf73033c 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -7,24 +7,6 @@
 #define H_PUD_INDEX_SIZE  10
 #define H_PGD_INDEX_SIZE  8
 
-/*
- * Each context is 512TB size. SLB miss for first context/default context
- * is handled in the hotpath.
- */
-#define MAX_EA_BITS_PER_CONTEXT		49
-#define REGION_SHIFT		MAX_EA_BITS_PER_CONTEXT
-
-/*
- * We use one context for each MAP area.
- */
-#define H_KERN_MAP_SIZE		(1UL << MAX_EA_BITS_PER_CONTEXT)
-
-/*
- * Define the address range of the kernel non-linear virtual area
- * 2PB
- */
-#define H_KERN_VIRT_START	ASM_CONST(0xc008000000000000)
-
 /*
  * 64k aligned address free up few of the lower bits of RPN for us
  * We steal that here. For more deatils look at pte_pfn/pfn_pte()
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index cd9be5fb189b..c6850a5a931d 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -45,10 +45,6 @@
 #define H_PUD_CACHE_INDEX	(H_PUD_INDEX_SIZE)
 #endif
 
-/*
- * One context each will be used for vmap, IO and vmemmap
- */
-#define H_KERN_VIRT_SIZE	(H_KERN_MAP_SIZE * 3)
 /*
  * +------------------------------+
  * |                              |
@@ -75,28 +71,16 @@
  * +------------------------------+  Kernel linear (0xc.....)
  */
 
-#define H_VMALLOC_START		H_KERN_VIRT_START
-#define H_VMALLOC_SIZE		H_KERN_MAP_SIZE
-#define H_VMALLOC_END		(H_VMALLOC_START + H_VMALLOC_SIZE)
-
-#define H_KERN_IO_START		H_VMALLOC_END
-#define H_KERN_IO_SIZE		H_KERN_MAP_SIZE
-#define H_KERN_IO_END		(H_KERN_IO_START + H_KERN_IO_SIZE)
-
-#define H_VMEMMAP_START		H_KERN_IO_END
-#define H_VMEMMAP_SIZE		H_KERN_MAP_SIZE
-#define H_VMEMMAP_END		(H_VMEMMAP_START + H_VMEMMAP_SIZE)
-
-#define NON_LINEAR_REGION_ID(ea)	((((unsigned long)ea - H_KERN_VIRT_START) >> REGION_SHIFT) + 2)
+#define NON_LINEAR_REGION_ID(ea)	((((unsigned long)ea - KERN_VIRT_START) >> REGION_SHIFT) + 2)
 
 /*
  * Region IDs
  */
 #define USER_REGION_ID		0
 #define KERNEL_REGION_ID	1
-#define VMALLOC_REGION_ID	NON_LINEAR_REGION_ID(H_VMALLOC_START)
-#define IO_REGION_ID		NON_LINEAR_REGION_ID(H_KERN_IO_START)
-#define VMEMMAP_REGION_ID	NON_LINEAR_REGION_ID(H_VMEMMAP_START)
+#define VMALLOC_REGION_ID	NON_LINEAR_REGION_ID(VMALLOC_START)
+#define IO_REGION_ID		NON_LINEAR_REGION_ID(KERN_IO_START)
+#define VMEMMAP_REGION_ID	NON_LINEAR_REGION_ID(VMEMMAP_BASE)
 
 /*
  * Defines the address of the vmemap area, in its own region on
@@ -123,11 +107,11 @@ static inline int get_region_id(unsigned long ea)
 	if (id == 0)
 		return USER_REGION_ID;
 
-	if (ea < H_KERN_VIRT_START)
+	if (ea < KERN_VIRT_START)
 		return KERNEL_REGION_ID;
 
 	VM_BUG_ON(id != 0xc);
-	BUILD_BUG_ON(NON_LINEAR_REGION_ID(H_VMALLOC_START) != 2);
+	BUILD_BUG_ON(NON_LINEAR_REGION_ID(VMALLOC_START) != 2);
 
 	region_id = NON_LINEAR_REGION_ID(ea);
 	VM_BUG_ON(region_id > VMEMMAP_REGION_ID);
diff --git a/arch/powerpc/include/asm/book3s/64/map.h b/arch/powerpc/include/asm/book3s/64/map.h
new file mode 100644
index 000000000000..5c01f8c18d61
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/map.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_BOOK3S_64_MAP_H_
+#define _ASM_POWERPC_BOOK3S_64_MAP_H_
+
+/*
+ * We use MAX_EA_BITS_PER_CONTEXT (hash specific) here just to make sure we pick
+ * the same value for hash and radix.
+ */
+#ifdef CONFIG_PPC_64K_PAGES
+
+/*
+ * Each context is 512TB size. SLB miss for first context/default context
+ * is handled in the hotpath.
+ */
+#define MAX_EA_BITS_PER_CONTEXT		49
+
+
+#define REGION_SHIFT		MAX_EA_BITS_PER_CONTEXT
+
+/*
+ * Define the address range of the kernel non-linear virtual area
+ * 2PB
+ */
+#define KERN_VIRT_START		ASM_CONST(0xc008000000000000)
+
+#else
+
+/*
+ * Each context is 512TB. But on 4k we restrict our max TASK size to 64TB
+ * Hence also limit max EA bits to 64TB.
+ */
+#define MAX_EA_BITS_PER_CONTEXT		46
+
+/*
+ * Our page table limit us to 64TB. Hence for the kernel mapping,
+ * each MAP area is limited to 16 TB.
+ * The four map areas are:  linear mapping, vmalloc, IO and vmemmap
+ */
+#define REGION_SHIFT		(MAX_EA_BITS_PER_CONTEXT - 2)
+
+/*
+ * Define the address range of the kernel non-linear virtual area
+ * 16TB
+ */
+#define KERN_VIRT_START		ASM_CONST(0xc000100000000000)
+
+#endif
+
+#define KERN_REGION_MAP_SIZE	(ASM_CONST(1) << REGION_SHIFT)
+
+#define VMALLOC_START		KERN_VIRT_START
+#define VMALLOC_SIZE		KERN_REGION_MAP_SIZE
+#define VMALLOC_END		(VMALLOC_START + VMALLOC_SIZE)
+
+#define KERN_IO_START		VMALLOC_END
+#define KERN_IO_SIZE		KERN_REGION_MAP_SIZE
+#define KERN_IO_END		(KERN_IO_START + KERN_IO_SIZE)
+
+#define VMEMMAP_BASE		KERN_IO_END
+#define VMEMMAP_SIZE		KERN_REGION_MAP_SIZE
+#define VMEMMAP_END		(VMEMMAP_BASE + VMEMMAP_SIZE)
+
+/*
+ * IO space itself carved into the PIO region (ISA and PHB IO space) and
+ * the ioremap space
+ *
+ *  ISA_IO_BASE = KERN_IO_START, 64K reserved area
+ *  PHB_IO_BASE = ISA_IO_BASE + 64K to ISA_IO_BASE + 2G, PHB IO spaces
+ * IOREMAP_BASE = ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RANGE
+ */
+#define FULL_IO_SIZE	0x80000000ul
+#define  ISA_IO_BASE	(KERN_IO_START)
+#define  ISA_IO_END	(KERN_IO_START + 0x10000ul)
+#define  PHB_IO_BASE	(ISA_IO_END)
+#define  PHB_IO_END	(KERN_IO_START + FULL_IO_SIZE)
+#define IOREMAP_BASE	(PHB_IO_END)
+#define IOREMAP_END	(KERN_IO_END)
+
+#endif
+
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8c156c5b4cd5..2c3a0b3f642b 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -269,24 +269,12 @@ enum pgtable_index {
 	HTLB_16G_INDEX,
 };
 
-extern unsigned long __vmalloc_start;
-extern unsigned long __vmalloc_end;
-#define VMALLOC_START	__vmalloc_start
-#define VMALLOC_END	__vmalloc_end
-
-extern unsigned long __kernel_virt_start;
-extern unsigned long __kernel_virt_size;
-extern unsigned long __kernel_io_start;
-extern unsigned long __kernel_io_end;
-#define KERN_VIRT_START __kernel_virt_start
-#define KERN_IO_START  __kernel_io_start
-#define KERN_IO_END __kernel_io_end
-
 extern struct page *vmemmap;
 extern unsigned long ioremap_bot;
 extern unsigned long pci_io_base;
 #endif /* __ASSEMBLY__ */
 
+#include <asm/book3s/64/map.h>
 #include <asm/book3s/64/hash.h>
 #include <asm/book3s/64/radix.h>
 
@@ -297,22 +285,6 @@ extern unsigned long pci_io_base;
 #endif
 
 #include <asm/barrier.h>
-/*
- * IO space itself carved into the PIO region (ISA and PHB IO space) and
- * the ioremap space
- *
- *  ISA_IO_BASE = KERN_IO_START, 64K reserved area
- *  PHB_IO_BASE = ISA_IO_BASE + 64K to ISA_IO_BASE + 2G, PHB IO spaces
- * IOREMAP_BASE = ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RANGE
- */
-#define FULL_IO_SIZE	0x80000000ul
-#define  ISA_IO_BASE	(KERN_IO_START)
-#define  ISA_IO_END	(KERN_IO_START + 0x10000ul)
-#define  PHB_IO_BASE	(ISA_IO_END)
-#define  PHB_IO_END	(KERN_IO_START + FULL_IO_SIZE)
-#define IOREMAP_BASE	(PHB_IO_END)
-#define IOREMAP_END	(KERN_IO_END)
-
 /* Advertise special mapping type for AGP */
 #define HAVE_PAGE_AGP
 
@@ -344,8 +316,9 @@ extern unsigned long pci_io_base;
 
 #endif /* __real_pte */
 
-static inline unsigned long pte_update(struct mm_struct *mm, unsigned long addr,
-				       pte_t *ptep, unsigned long clr,
+static inline unsigned long pte_update(struct mm_struct *mm,
+				       unsigned long addr, pte_t *ptep,
+				       unsigned long clr,
 				       unsigned long set, int huge)
 {
 	if (radix_enabled())
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index b43e12457fea..f1bd844a396a 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -91,25 +91,6 @@
  * +------------------------------+  Kernel linear (0xc.....)
  */
 
-#define RADIX_KERN_VIRT_START	ASM_CONST(0xc008000000000000)
-/*
- * We use MAX_EA_BITS_PER_CONTEXT(hash specific) here just to make sure we pick
- * the same value as hash.
- */
-#define RADIX_KERN_MAP_SIZE	(1UL << MAX_EA_BITS_PER_CONTEXT)
-
-#define RADIX_VMALLOC_START	RADIX_KERN_VIRT_START
-#define RADIX_VMALLOC_SIZE	RADIX_KERN_MAP_SIZE
-#define RADIX_VMALLOC_END	(RADIX_VMALLOC_START + RADIX_VMALLOC_SIZE)
-
-#define RADIX_KERN_IO_START	RADIX_VMALLOC_END
-#define RADIX_KERN_IO_SIZE	RADIX_KERN_MAP_SIZE
-#define RADIX_KERN_IO_END	(RADIX_KERN_IO_START + RADIX_KERN_IO_SIZE)
-
-#define RADIX_VMEMMAP_START	RADIX_KERN_IO_END
-#define RADIX_VMEMMAP_SIZE	RADIX_KERN_MAP_SIZE
-#define RADIX_VMEMMAP_END	(RADIX_VMEMMAP_START + RADIX_VMEMMAP_SIZE)
-
 #ifndef __ASSEMBLY__
 #define RADIX_PTE_TABLE_SIZE	(sizeof(pte_t) << RADIX_PTE_INDEX_SIZE)
 #define RADIX_PMD_TABLE_SIZE	(sizeof(pmd_t) << RADIX_PMD_INDEX_SIZE)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index ef0ca3bf555d..8d16f4fa73e6 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -788,7 +788,7 @@ int hash__create_section_mapping(unsigned long start, unsigned long end, int nid
 {
 	int rc;
 
-	if (end >= H_VMALLOC_START) {
+	if (end >= VMALLOC_START) {
 		pr_warn("Outisde the supported range\n");
 		return -1;
 	}
@@ -936,7 +936,7 @@ static void __init htab_initialize(void)
 		DBG("creating mapping for region: %lx..%lx (prot: %lx)\n",
 		    base, size, prot);
 
-		if ((base + size) >= H_VMALLOC_START) {
+		if ((base + size) >= VMALLOC_START) {
 			pr_warn("Outisde the supported range\n");
 			continue;
 		}
@@ -1024,12 +1024,7 @@ void __init hash__early_init_mmu(void)
 	__pud_val_bits = HASH_PUD_VAL_BITS;
 	__pgd_val_bits = HASH_PGD_VAL_BITS;
 
-	__kernel_virt_start = H_KERN_VIRT_START;
-	__vmalloc_start = H_VMALLOC_START;
-	__vmalloc_end = H_VMALLOC_END;
-	__kernel_io_start = H_KERN_IO_START;
-	__kernel_io_end = H_KERN_IO_END;
-	vmemmap = (struct page *)H_VMEMMAP_START;
+	vmemmap = (struct page *)VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
 
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index d934de4e2b3a..1586a66f9032 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -114,7 +114,7 @@ int __meminit hash__vmemmap_create_mapping(unsigned long start,
 {
 	int rc;
 
-	if ((start + page_size) >= H_VMEMMAP_END) {
+	if ((start + page_size) >= VMEMMAP_END) {
 		pr_warn("Outisde the supported range\n");
 		return -1;
 	}
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c9b24bf78819..b14075763924 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -335,7 +335,7 @@ void __init radix_init_pgtable(void)
 		 * need or a node (which we don't have yet).
 		 */
 
-		if ((reg->base + reg->size) >= RADIX_VMALLOC_START) {
+		if ((reg->base + reg->size) >= VMALLOC_START) {
 			pr_warn("Outisde the supported range\n");
 			continue;
 		}
@@ -579,12 +579,7 @@ void __init radix__early_init_mmu(void)
 	__pud_val_bits = RADIX_PUD_VAL_BITS;
 	__pgd_val_bits = RADIX_PGD_VAL_BITS;
 
-	__kernel_virt_start = RADIX_KERN_VIRT_START;
-	__vmalloc_start = RADIX_VMALLOC_START;
-	__vmalloc_end = RADIX_VMALLOC_END;
-	__kernel_io_start = RADIX_KERN_IO_START;
-	__kernel_io_end = RADIX_KERN_IO_END;
-	vmemmap = (struct page *)RADIX_VMEMMAP_START;
+	vmemmap = (struct page *)VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
 
 #ifdef CONFIG_PCI
@@ -872,7 +867,7 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 
 int __meminit radix__create_section_mapping(unsigned long start, unsigned long end, int nid)
 {
-	if (end >= RADIX_VMALLOC_START) {
+	if (end >= VMALLOC_START) {
 		pr_warn("Outisde the supported range\n");
 		return -1;
 	}
@@ -904,7 +899,7 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 	int nid = early_pfn_to_nid(phys >> PAGE_SHIFT);
 	int ret;
 
-	if ((start + page_size) >= RADIX_VMEMMAP_END) {
+	if ((start + page_size) >= VMEMMAP_END) {
 		pr_warn("Outisde the supported range\n");
 		return -1;
 	}
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 72f58c076e26..3b3bea91c44e 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -88,16 +88,6 @@ unsigned long __pud_val_bits;
 EXPORT_SYMBOL(__pud_val_bits);
 unsigned long __pgd_val_bits;
 EXPORT_SYMBOL(__pgd_val_bits);
-unsigned long __kernel_virt_start;
-EXPORT_SYMBOL(__kernel_virt_start);
-unsigned long __vmalloc_start;
-EXPORT_SYMBOL(__vmalloc_start);
-unsigned long __vmalloc_end;
-EXPORT_SYMBOL(__vmalloc_end);
-unsigned long __kernel_io_start;
-EXPORT_SYMBOL(__kernel_io_start);
-unsigned long __kernel_io_end;
-EXPORT_SYMBOL(__kernel_io_end);
 struct page *vmemmap;
 EXPORT_SYMBOL(vmemmap);
 unsigned long __pte_frag_nr;
diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index b9bda0105841..005b86c49190 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -499,11 +499,7 @@ static void populate_markers(void)
 	address_markers[6].start_address = PHB_IO_END;
 	address_markers[7].start_address = IOREMAP_BASE;
 	address_markers[8].start_address = IOREMAP_END;
-#ifdef CONFIG_PPC_BOOK3S_64
-	address_markers[9].start_address =  H_VMEMMAP_START;
-#else
 	address_markers[9].start_address =  VMEMMAP_BASE;
-#endif
 }
 
 static int ptdump_show(struct seq_file *m, void *v)
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 63fc56feea15..a1df08c2c5da 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -303,12 +303,7 @@ static void populate_markers(void)
 	address_markers[i++].start_address = PHB_IO_END;
 	address_markers[i++].start_address = IOREMAP_BASE;
 	address_markers[i++].start_address = IOREMAP_END;
-	/* What is the ifdef about? */
-#ifdef CONFIG_PPC_BOOK3S_64
-	address_markers[i++].start_address =  H_VMEMMAP_START;
-#else
 	address_markers[i++].start_address =  VMEMMAP_BASE;
-#endif
 #else /* !CONFIG_PPC64 */
 	address_markers[i++].start_address = ioremap_bot;
 	address_markers[i++].start_address = IOREMAP_TOP;
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index a0c37f428d60..508573c56411 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -702,21 +702,21 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	} else if (id == VMEMMAP_REGION_ID) {
 
-		if (ea >= H_VMEMMAP_END)
+		if (ea >= VMEMMAP_END)
 			return -EFAULT;
 
 		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmemmap_psize].sllp;
 #endif
 	} else if (id == VMALLOC_REGION_ID) {
 
-		if (ea >= H_VMALLOC_END)
+		if (ea >= VMALLOC_END)
 			return -EFAULT;
 
 		flags = local_paca->vmalloc_sllp;
 
 	} else if (id == IO_REGION_ID) {
 
-		if (ea >= H_KERN_IO_END)
+		if (ea >= KERN_IO_END)
 			return -EFAULT;
 
 		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_io_psize].sllp;
-- 
2.20.1

