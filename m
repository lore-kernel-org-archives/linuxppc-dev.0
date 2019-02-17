Return-Path: <SRS0=hR0M=QY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16D8C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 05:19:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DFD218AE
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 05:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DFD218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442Fff1jgpzDqQr
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 16:19:22 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 442FbL2QvvzDqRb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 16:16:30 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1H5E5I1132293
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 00:16:27 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qq0pch2d6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 00:16:27 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Sun, 17 Feb 2019 05:16:26 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 17 Feb 2019 05:16:22 -0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1H5GLCJ17236032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 17 Feb 2019 05:16:21 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBD8E136051;
 Sun, 17 Feb 2019 05:16:21 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65B7813604F;
 Sun, 17 Feb 2019 05:16:18 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.35.167])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sun, 17 Feb 2019 05:16:17 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Subject: [RFC PATCH 2/2] powerpc/mm/hash64: Map all the kernel mapping in the
 same 0xc range
Date: Sun, 17 Feb 2019 10:46:09 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217051609.24140-1-aneesh.kumar@linux.ibm.com>
References: <20190217051609.24140-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021705-0004-0000-0000-000014E3234E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010611; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000280; SDB=6.01162206; UDB=6.00606729; IPR=6.00942773; 
 MB=3.00025620; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-17 05:16:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021705-0005-0000-0000-00008A9FD0DC
Message-Id: <20190217051609.24140-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-17_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902170040
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

This patch maps vmap, IO and vmemap regions in the 0xc address range
instead of the current 0xd and 0xf range. This brings the mapping closer
to radix translation mode.

With hash 64K page size each of this region is 512TB whereas with 4K config
we are limitted by the max page table range of 64TB and hence there regions
are of 16TB size.

NOT-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 17 ++++
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 11 +++
 arch/powerpc/include/asm/book3s/64/hash.h     | 89 ++++++++++++++-----
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 31 ++++---
 arch/powerpc/include/asm/book3s/64/radix.h    | 24 ++---
 arch/powerpc/include/asm/page.h               |  3 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c          |  2 +-
 arch/powerpc/mm/copro_fault.c                 | 14 +--
 arch/powerpc/mm/dump_hashpagetable.c          |  2 +-
 arch/powerpc/mm/dump_linuxpagetables.c        |  2 +-
 arch/powerpc/mm/hash_utils_64.c               | 29 +++---
 arch/powerpc/mm/pgtable-radix.c               |  2 +-
 arch/powerpc/mm/slb.c                         | 22 +++--
 13 files changed, 166 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index cf5ba5254299..6db6e5c5c176 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -13,6 +13,23 @@
  */
 #define MAX_EA_BITS_PER_CONTEXT		46
 
+/*
+ * Our page table limit us to 64TB. Hence for the kernel mapping,
+ * each MAP area is limited to 16 TB.
+ * The four map areas are:
+ * linear mapping
+ * vmap
+ * IO
+ * vmemmap
+ */
+#define EA_KERNEL_MAP_SIZE	(ASM_CONST(1) << (46 - 2))
+
+/*
+ * Define the address range of the kernel non-linear virtual area
+ * 16TB
+ */
+#define H_KERN_VIRT_START	ASM_CONST(0xc000100000000000)
+
 #ifndef __ASSEMBLY__
 #define H_PTE_TABLE_SIZE	(sizeof(pte_t) << H_PTE_INDEX_SIZE)
 #define H_PMD_TABLE_SIZE	(sizeof(pmd_t) << H_PMD_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index f82ee8a3b561..11add16d25d3 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -13,6 +13,17 @@
  */
 #define MAX_EA_BITS_PER_CONTEXT		49
 
+/*
+ * We use one context for each MAP area.
+ */
+#define EA_KERNEL_MAP_SIZE	(1UL << MAX_EA_BITS_PER_CONTEXT)
+
+/*
+ * Define the address range of the kernel non-linear virtual area
+ * 2PB
+ */
+#define H_KERN_VIRT_START	ASM_CONST(0xc008000000000000)
+
 /*
  * 64k aligned address free up few of the lower bits of RPN for us
  * We steal that here. For more deatils look at pte_pfn/pfn_pte()
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 94f9db7a746a..18d5caab7e1d 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -30,6 +30,11 @@
 				 H_PUD_INDEX_SIZE + H_PGD_INDEX_SIZE + PAGE_SHIFT)
 #define H_PGTABLE_RANGE		(ASM_CONST(1) << H_PGTABLE_EADDR_SIZE)
 
+/*
+ * Top 4 bits are ignored in page table walk.
+ */
+#define EA_MASK			(~(0xfUL << 60))
+
 /*
  * We store the slot details in the second half of page table.
  * Increase the pud level table so that hugetlb ptes can be stored
@@ -40,41 +45,63 @@
 #else
 #define H_PUD_CACHE_INDEX	(H_PUD_INDEX_SIZE)
 #endif
+
 /*
- * Define the address range of the kernel non-linear virtual area
+ * 3 context will be used for vmap, IO and vmemmap
  */
-#define H_KERN_VIRT_START ASM_CONST(0xD000000000000000)
-#define H_KERN_VIRT_SIZE  ASM_CONST(0x0000400000000000) /* 64T */
-
+#define H_KERN_VIRT_SIZE	(EA_KERNEL_MAP_SIZE * 3)
 /*
- * The vmalloc space starts at the beginning of that region, and
- * occupies half of it on hash CPUs and a quarter of it on Book3E
- * (we keep a quarter for the virtual memmap)
+ * +------------------------------+
+ * |                              |
+ * |                              |
+ * |                              |
+ * +------------------------------+  Kernel virtual map end (0xc00e000000000000)
+ * |                              |
+ * |                              |
+ * |      512TB/16TB of vmemmap   |
+ * |                              |
+ * |                              |
+ * +------------------------------+  Kernel vmemmap  start
+ * |                              |
+ * |      512TB/16TB of IO map    |
+ * |                              |
+ * +------------------------------+  Kernel IO map start
+ * |                              |
+ * |      512TB/16TB of vmap      |
+ * |                              |
+ * +------------------------------+  Kernel virt start (0xc008000000000000)
+ * |                              |
+ * |                              |
+ * |                              |
+ * +------------------------------+  Kernel linear (0xc.....)
  */
-#define H_VMALLOC_START	H_KERN_VIRT_START
-#define H_VMALLOC_SIZE	ASM_CONST(0x380000000000) /* 56T */
-#define H_VMALLOC_END	(H_VMALLOC_START + H_VMALLOC_SIZE)
 
-#define H_KERN_IO_START	H_VMALLOC_END
-#define H_KERN_IO_END	(H_KERN_VIRT_START + H_KER_VIRT_SIZE)
+#define H_KERN_VMALLOC_START	H_KERN_VIRT_START
+#define H_KERN_VMALLOC_SIZE	EA_KERNEL_MAP_SIZE
+#define H_KERN_VMALLOC_END	(H_KERN_VMALLOC_START + H_KERN_VMALLOC_SIZE)
+
+#define H_KERN_IO_START		H_KERN_VMALLOC_END
+#define H_KERN_IO_SIZE		EA_KERNEL_MAP_SIZE
+#define H_KERN_IO_END		(H_KERN_IO_START + H_KERN_IO_SIZE)
+
+#define H_KERN_VMEMMAP_START	H_KERN_IO_END
+#define H_KERN_VMEMMAP_SIZE	EA_KERNEL_MAP_SIZE
+#define H_KERN_VMEMMAP_END	(H_KERN_VMEMMAP_START + H_KERN_VMEMMAP_SIZE)
 
 /*
  * Region IDs
  */
-#define REGION_SHIFT		60UL
-#define REGION_MASK		(0xfUL << REGION_SHIFT)
-#define REGION_ID(ea)		(((unsigned long)(ea)) >> REGION_SHIFT)
-
-#define VMALLOC_REGION_ID	(REGION_ID(H_VMALLOC_START))
-#define KERNEL_REGION_ID	(REGION_ID(PAGE_OFFSET))
-#define VMEMMAP_REGION_ID	(0xfUL)	/* Server only */
-#define USER_REGION_ID		(0UL)
+#define USER_REGION_ID		1
+#define KERNEL_REGION_ID	2
+#define VMALLOC_REGION_ID	3
+#define IO_REGION_ID		4
+#define VMEMMAP_REGION_ID	5
+#define INVALID_REGION_ID	6
 
 /*
  * Defines the address of the vmemap area, in its own region on
  * hash table CPUs.
  */
-#define H_VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
 
 #ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
@@ -90,6 +117,26 @@
 #define H_PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
 #ifndef __ASSEMBLY__
+static inline int get_region_id(unsigned long ea)
+{
+	int id = (ea >> 60UL);
+
+	if (id == 0)
+		return USER_REGION_ID;
+
+	if (id != 0xc)
+		return INVALID_REGION_ID;
+
+	if (ea >= H_KERN_VMEMMAP_START)
+		return VMEMMAP_REGION_ID;
+	else if (ea >= H_KERN_IO_START)
+		return IO_REGION_ID;
+	else if (ea >= H_KERN_VMALLOC_START)
+		return VMALLOC_REGION_ID;
+
+	return KERNEL_REGION_ID;
+}
+
 #define	hash__pmd_bad(pmd)		(pmd_val(pmd) & H_PMD_BAD_BITS)
 #define	hash__pud_bad(pud)		(pud_val(pud) & H_PUD_BAD_BITS)
 static inline int hash__pgd_bad(pgd_t pgd)
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 12e522807f9f..ddc67bc64ce0 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -588,7 +588,8 @@ extern void slb_set_size(u16 size);
 #endif
 
 #define MAX_VMALLOC_CTX_CNT	1
-#define MAX_MEMMAP_CTX_CNT	1
+#define MAX_IO_CTX_CNT		1
+#define MAX_VMEMMAP_CTX_CNT	1
 
 /*
  * 256MB segment
@@ -601,13 +602,10 @@ extern void slb_set_size(u16 size);
  * would give a protovsid of 0x1fffffffff. That will result in a VSID 0
  * because of the modulo operation in vsid scramble.
  *
- * We add one extra context to MIN_USER_CONTEXT so that we can map kernel
- * context easily. The +1 is to map the unused 0xe region mapping.
  */
 #define MAX_USER_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 2)
 #define MIN_USER_CONTEXT	(MAX_KERNEL_CTX_CNT + MAX_VMALLOC_CTX_CNT + \
-				 MAX_MEMMAP_CTX_CNT + 2)
-
+				 MAX_IO_CTX_CNT + MAX_VMEMMAP_CTX_CNT)
 /*
  * For platforms that support on 65bit VA we limit the context bits
  */
@@ -747,7 +745,7 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 	/*
 	 * Bad address. We return VSID 0 for that
 	 */
-	if ((ea & ~REGION_MASK) >= H_PGTABLE_RANGE)
+	if ((ea & EA_MASK)  >= H_PGTABLE_RANGE)
 		return 0;
 
 	if (!mmu_has_feature(MMU_FTR_68_BIT_VA))
@@ -774,28 +772,29 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
  * 0x00002 -  [ 0xc002000000000000 - 0xc003ffffffffffff]
  * 0x00003 -  [ 0xc004000000000000 - 0xc005ffffffffffff]
  * 0x00004 -  [ 0xc006000000000000 - 0xc007ffffffffffff]
-
- * 0x00005 -  [ 0xd000000000000000 - 0xd001ffffffffffff ]
- * 0x00006 -  Not used - Can map 0xe000000000000000 range.
- * 0x00007 -  [ 0xf000000000000000 - 0xf001ffffffffffff ]
  *
- * So we can compute the context from the region (top nibble) by
- * subtracting 11, or 0xc - 1.
+ * vmap, IO, vmemap
+ *
+ * 0x00005 -  [ 0xc008000000000000 - 0xc009ffffffffffff]
+ * 0x00006 -  [ 0xc00a000000000000 - 0xc00bffffffffffff]
+ * 0x00007 -  [ 0xc00c000000000000 - 0xc00dffffffffffff]
+ *
  */
 static inline unsigned long get_kernel_context(unsigned long ea)
 {
-	unsigned long region_id = REGION_ID(ea);
+	unsigned long region_id = get_region_id(ea);
 	unsigned long ctx;
 	/*
-	 * For linear mapping we do support multiple context
+	 * Depending on Kernel config, kernel region can have one context
+	 * or more.
 	 */
 	if (region_id == KERNEL_REGION_ID) {
 		/*
 		 * We already verified ea to be not beyond the addr limit.
 		 */
-		ctx =  1 + ((ea & ~REGION_MASK) >> MAX_EA_BITS_PER_CONTEXT);
+		ctx =  1 + ((ea & EA_MASK) >> MAX_EA_BITS_PER_CONTEXT);
 	} else
-		ctx = (region_id - 0xc) + MAX_KERNEL_CTX_CNT;
+		ctx = region_id + MAX_KERNEL_CTX_CNT - 2;
 	return ctx;
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 0718c16b4e8d..f1287bb5ce60 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -72,17 +72,17 @@
  * |                              |
  * |                              |
  * |                              |
- * +------------------------------+  Kernel IO map end (0xc010000000000000)
+ * +------------------------------+  Kernel vmemmap end (0xc010000000000000)
  * |                              |
  * |                              |
  * |      1/2 of virtual map      |
  * |                              |
  * |                              |
- * +------------------------------+  Kernel IO map start
+ * +------------------------------+  Kernel IO map end/vmemap start
  * |                              |
  * |      1/4 of virtual map      |
  * |                              |
- * +------------------------------+  Kernel vmemap start
+ * +------------------------------+  Kernel vmap end/ IO map start
  * |                              |
  * |     1/4 of virtual map       |
  * |                              |
@@ -96,22 +96,16 @@
 #define RADIX_KERN_VIRT_START ASM_CONST(0xc008000000000000)
 #define RADIX_KERN_VIRT_SIZE  ASM_CONST(0x0008000000000000)
 
-/*
- * The vmalloc space starts at the beginning of that region, and
- * occupies a quarter of it on radix config.
- * (we keep a quarter for the virtual memmap)
- */
 #define RADIX_VMALLOC_START	RADIX_KERN_VIRT_START
 #define RADIX_VMALLOC_SIZE	(RADIX_KERN_VIRT_SIZE >> 2)
 #define RADIX_VMALLOC_END	(RADIX_VMALLOC_START + RADIX_VMALLOC_SIZE)
-/*
- * Defines the address of the vmemap area, in its own region on
- * hash table CPUs.
- */
-#define RADIX_VMEMMAP_BASE		(RADIX_VMALLOC_END)
 
-#define RADIX_KERN_IO_START	(RADIX_KERN_VIRT_START + (RADIX_KERN_VIRT_SIZE >> 1))
-#define RADIX_KERN_IO_END       (RADIX_KERN_VIRT_START + RADIX_KERN_VIRT_SIZE)
+#define RADIX_KERN_IO_START	RADIX_VMALLOC_END
+#define RADIX_KERN_IO_SIZE	(RADIX_KERN_VIRT_SIZE >> 2)
+#define RADIX_KERN_IO_END	(RADIX_KERN_IO_START + RADIX_KERN_IO_SIZE)
+
+#define RADIX_VMEMMAP_START	(RADIX_VMALLOC_END)
+#define RADIX_VMEMMAP_END	(RADIX_KERN_VIRT_START + RADIX_KERN_VIRT_SIZE)
 
 #ifndef __ASSEMBLY__
 #define RADIX_PTE_TABLE_SIZE	(sizeof(pte_t) << RADIX_PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index aa4497175bd3..bf18b4b335d8 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -148,7 +148,8 @@ static inline bool pfn_valid(unsigned long pfn)
  * return true for some vmalloc addresses, which is incorrect. So explicitly
  * check that the address is in the kernel region.
  */
-#define virt_addr_valid(kaddr) (REGION_ID(kaddr) == KERNEL_REGION_ID && \
+/* may be can drop get_region_id */
+#define virt_addr_valid(kaddr) (get_region_id((unsigned long)kaddr) == KERNEL_REGION_ID && \
 				pfn_valid(virt_to_pfn(kaddr)))
 #else
 #define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index b3f5786b20dc..5ceddb1e3903 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -815,7 +815,7 @@ static inline void this_cpu_inc_rm(unsigned int __percpu *addr)
 	raddr = per_cpu_ptr(addr, cpu);
 	l = (unsigned long)raddr;
 
-	if (REGION_ID(l) == VMALLOC_REGION_ID) {
+	if (get_region_id(l) == VMALLOC_REGION_ID) {
 		l = vmalloc_to_phys(raddr);
 		raddr = (unsigned int *)l;
 	}
diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index c8da352e8686..0da84a03388c 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -105,7 +105,7 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
 	u64 vsid, vsidkey;
 	int psize, ssize;
 
-	switch (REGION_ID(ea)) {
+	switch (get_region_id(ea)) {
 	case USER_REGION_ID:
 		pr_devel("%s: 0x%llx -- USER_REGION_ID\n", __func__, ea);
 		if (mm == NULL)
@@ -117,14 +117,18 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
 		break;
 	case VMALLOC_REGION_ID:
 		pr_devel("%s: 0x%llx -- VMALLOC_REGION_ID\n", __func__, ea);
-		if (ea < VMALLOC_END)
-			psize = mmu_vmalloc_psize;
-		else
-			psize = mmu_io_psize;
+		psize = mmu_vmalloc_psize;
 		ssize = mmu_kernel_ssize;
 		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
 		vsidkey = SLB_VSID_KERNEL;
 		break;
+
+	case IO_REGION_ID:
+		pr_devel("%s: 0x%llx -- IO_REGION_ID\n", __func__, ea);
+		psize = mmu_io_psize;
+		ssize = mmu_kernel_ssize;
+		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
+		vsidkey = SLB_VSID_KERNEL;
 	case KERNEL_REGION_ID:
 		pr_devel("%s: 0x%llx -- KERNEL_REGION_ID\n", __func__, ea);
 		psize = mmu_linear_psize;
diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/dump_hashpagetable.c
index 869294695048..7f1b31dc2887 100644
--- a/arch/powerpc/mm/dump_hashpagetable.c
+++ b/arch/powerpc/mm/dump_hashpagetable.c
@@ -500,7 +500,7 @@ static void populate_markers(void)
 	address_markers[7].start_address = IOREMAP_BASE;
 	address_markers[8].start_address = IOREMAP_END;
 #ifdef CONFIG_PPC_BOOK3S_64
-	address_markers[9].start_address =  H_VMEMMAP_BASE;
+	address_markers[9].start_address =  H_KERN_VMEMMAP_START;
 #else
 	address_markers[9].start_address =  VMEMMAP_BASE;
 #endif
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 6aa41669ac1a..9de42f0b5ac2 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -298,7 +298,7 @@ static void populate_markers(void)
 	address_markers[i++].start_address = IOREMAP_BASE;
 	address_markers[i++].start_address = IOREMAP_END;
 #ifdef CONFIG_PPC_BOOK3S_64
-	address_markers[i++].start_address =  H_VMEMMAP_BASE;
+	address_markers[i++].start_address =  H_KERN_VMEMMAP_START;
 #else
 	address_markers[i++].start_address =  VMEMMAP_BASE;
 #endif
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index bbd87748f3f7..bf31f6479497 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1007,11 +1007,11 @@ void __init hash__early_init_mmu(void)
 
 	__kernel_virt_start = H_KERN_VIRT_START;
 	__kernel_virt_size = H_KERN_VIRT_SIZE;
-	__vmalloc_start = H_VMALLOC_START;
-	__vmalloc_end = H_VMALLOC_END;
+	__vmalloc_start = H_KERN_VMALLOC_START;
+	__vmalloc_end = H_KERN_VMALLOC_END;
 	__kernel_io_start = H_KERN_IO_START;
 	__kernel_io_end = H_KERN_IO_END;
-	vmemmap = (struct page *)H_VMEMMAP_BASE;
+	vmemmap = (struct page *)H_KERN_VMEMMAP_START;
 	ioremap_bot = IOREMAP_BASE;
 
 #ifdef CONFIG_PCI
@@ -1232,7 +1232,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	trace_hash_fault(ea, access, trap);
 
 	/* Get region & vsid */
- 	switch (REGION_ID(ea)) {
+ 	switch (get_region_id(ea)) {
 	case USER_REGION_ID:
 		user_region = 1;
 		if (! mm) {
@@ -1246,10 +1246,13 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		break;
 	case VMALLOC_REGION_ID:
 		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
-		if (ea < VMALLOC_END)
-			psize = mmu_vmalloc_psize;
-		else
-			psize = mmu_io_psize;
+		psize = mmu_vmalloc_psize;
+		ssize = mmu_kernel_ssize;
+		break;
+
+	case IO_REGION_ID:
+		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
+		psize = mmu_io_psize;
 		ssize = mmu_kernel_ssize;
 		break;
 	default:
@@ -1415,7 +1418,8 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
 	unsigned long flags = 0;
 	struct mm_struct *mm = current->mm;
 
-	if (REGION_ID(ea) == VMALLOC_REGION_ID)
+	if ((get_region_id(ea) == VMALLOC_REGION_ID) ||
+	    (get_region_id(ea) == IO_REGION_ID))
 		mm = &init_mm;
 
 	if (dsisr & DSISR_NOHPTE)
@@ -1431,8 +1435,9 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 	unsigned long access = _PAGE_PRESENT | _PAGE_READ;
 	unsigned long flags = 0;
 	struct mm_struct *mm = current->mm;
+	unsigned int region_id = get_region_id(ea);
 
-	if (REGION_ID(ea) == VMALLOC_REGION_ID)
+	if ((region_id == VMALLOC_REGION_ID) || (region_id == IO_REGION_ID))
 		mm = &init_mm;
 
 	if (dsisr & DSISR_NOHPTE)
@@ -1449,7 +1454,7 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 	 * 2) user space access kernel space.
 	 */
 	access |= _PAGE_PRIVILEGED;
-	if ((msr & MSR_PR) || (REGION_ID(ea) == USER_REGION_ID))
+	if ((msr & MSR_PR) || (region_id == USER_REGION_ID))
 		access &= ~_PAGE_PRIVILEGED;
 
 	if (trap == 0x400)
@@ -1493,7 +1498,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	int rc, ssize, update_flags = 0;
 	unsigned long access = _PAGE_PRESENT | _PAGE_READ | (is_exec ? _PAGE_EXEC : 0);
 
-	BUG_ON(REGION_ID(ea) != USER_REGION_ID);
+	BUG_ON(get_region_id(ea) != USER_REGION_ID);
 
 	if (!should_hash_preload(mm, ea))
 		return;
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c288abfc09e1..805250c5d181 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -583,7 +583,7 @@ void __init radix__early_init_mmu(void)
 	__vmalloc_end = RADIX_VMALLOC_END;
 	__kernel_io_start = RADIX_KERN_IO_START;
 	__kernel_io_end = RADIX_KERN_IO_END;
-	vmemmap = (struct page *)RADIX_VMEMMAP_BASE;
+	vmemmap = (struct page *)RADIX_VMEMMAP_START;
 	ioremap_bot = IOREMAP_BASE;
 
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index bc3914d54e26..a200cfffed2a 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -689,7 +689,7 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 	if (id == KERNEL_REGION_ID) {
 
 		/* We only support upto MAX_PHYSMEM_BITS */
-		if ((ea & ~REGION_MASK) > (1UL << MAX_PHYSMEM_BITS))
+		if ((ea & EA_MASK) > (1UL << MAX_PHYSMEM_BITS))
 			return -EFAULT;
 
 		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_linear_psize].sllp;
@@ -697,20 +697,25 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	} else if (id == VMEMMAP_REGION_ID) {
 
-		if ((ea & ~REGION_MASK) >= (1ULL << MAX_EA_BITS_PER_CONTEXT))
+		if (ea >= H_KERN_VMEMMAP_END)
 			return -EFAULT;
 
 		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmemmap_psize].sllp;
 #endif
 	} else if (id == VMALLOC_REGION_ID) {
 
-		if ((ea & ~REGION_MASK) >= (1ULL << MAX_EA_BITS_PER_CONTEXT))
+		if (ea >= H_KERN_VMALLOC_END)
 			return -EFAULT;
 
-		if (ea < H_VMALLOC_END)
-			flags = local_paca->vmalloc_sllp;
-		else
-			flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_io_psize].sllp;
+		flags = local_paca->vmalloc_sllp;
+
+	} else if (id == IO_REGION_ID) {
+
+		if (ea >= H_KERN_IO_END)
+			return -EFAULT;
+
+		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_io_psize].sllp;
+
 	} else {
 		return -EFAULT;
 	}
@@ -720,6 +725,7 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 		ssize = MMU_SEGSIZE_256M;
 
 	context = get_kernel_context(ea);
+
 	return slb_insert_entry(ea, context, flags, ssize, true);
 }
 
@@ -756,7 +762,7 @@ static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
 
 long do_slb_fault(struct pt_regs *regs, unsigned long ea)
 {
-	unsigned long id = REGION_ID(ea);
+	unsigned long id = get_region_id(ea);
 
 	/* IRQs are not reconciled here, so can't check irqs_disabled */
 	VM_WARN_ON(mfmsr() & MSR_EE);
-- 
2.20.1

