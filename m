Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CCAC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:06:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07B32173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07B32173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kjDq05P8zDqP8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:06:51 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kj4Z4XsczDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 22:59:42 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HCiwYF058935
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:38 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rx3wrj10e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:38 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 17 Apr 2019 13:59:37 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 13:59:35 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HCxYlK55967916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 12:59:34 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3F0BBE04F;
 Wed, 17 Apr 2019 12:59:34 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68CE2BE051;
 Wed, 17 Apr 2019 12:59:32 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.202])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 12:59:32 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v4 2/8] powerpc/mm/hash64: Map all the kernel regions in the
 same 0xc range
Date: Wed, 17 Apr 2019 18:29:14 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
References: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041712-8235-0000-0000-00000E81584F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010943; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190369; UDB=6.00623770; IPR=6.00971167; 
 MB=3.00026484; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 12:59:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041712-8236-0000-0000-0000452E59CA
Message-Id: <20190417125920.785-3-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
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

This patch maps vmalloc, IO and vmemap regions in the 0xc address range
instead of the current 0xd and 0xf range. This brings the mapping closer
to radix translation mode.

With hash 64K page size each of this region is 512TB whereas with 4K config
we are limited by the max page table range of 64TB and hence there regions
are of 16TB size.

The kernel mapping is now:

 On 4K hash

     kernel_region_map_size = 16TB
     kernel vmalloc start   = 0xc000100000000000
     kernel IO start        = 0xc000200000000000
     kernel vmemmap start   = 0xc000300000000000

64K hash, 64K radix and 4k radix:

     kernel_region_map_size = 512TB
     kernel vmalloc start   = 0xc008000000000000
     kernel IO start        = 0xc00a000000000000
     kernel vmemmap start   = 0xc00c000000000000

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 13 +++
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 11 +++
 arch/powerpc/include/asm/book3s/64/hash.h     | 95 ++++++++++++-------
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 31 +++---
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  1 -
 arch/powerpc/include/asm/book3s/64/radix.h    | 41 ++++----
 arch/powerpc/include/asm/page.h               |  3 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c          |  2 +-
 arch/powerpc/mm/copro_fault.c                 | 14 ++-
 arch/powerpc/mm/hash_utils_64.c               | 26 ++---
 arch/powerpc/mm/pgtable-radix.c               |  7 +-
 arch/powerpc/mm/pgtable_64.c                  |  2 -
 arch/powerpc/mm/ptdump/hashpagetable.c        |  2 +-
 arch/powerpc/mm/ptdump/ptdump.c               |  3 +-
 arch/powerpc/mm/slb.c                         | 22 +++--
 arch/powerpc/platforms/cell/spu_base.c        |  4 +-
 drivers/misc/cxl/fault.c                      |  2 +-
 drivers/misc/ocxl/link.c                      |  2 +-
 18 files changed, 172 insertions(+), 109 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index cf5ba5254299..0dd62287f56c 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -13,6 +13,19 @@
  */
 #define MAX_EA_BITS_PER_CONTEXT		46
 
+/*
+ * Our page table limit us to 64TB. Hence for the kernel mapping,
+ * each MAP area is limited to 16 TB.
+ * The four map areas are:  linear mapping, vmap, IO and vmemmap
+ */
+#define H_KERN_MAP_SIZE		(ASM_CONST(1) << (MAX_EA_BITS_PER_CONTEXT - 2))
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
index f82ee8a3b561..e392cf17b457 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -13,6 +13,17 @@
  */
 #define MAX_EA_BITS_PER_CONTEXT		49
 
+/*
+ * We use one context for each MAP area.
+ */
+#define H_KERN_MAP_SIZE		(1UL << MAX_EA_BITS_PER_CONTEXT)
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
index 8cbc4106d449..76741a221910 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -29,6 +29,10 @@
 #define H_PGTABLE_EADDR_SIZE	(H_PTE_INDEX_SIZE + H_PMD_INDEX_SIZE + \
 				 H_PUD_INDEX_SIZE + H_PGD_INDEX_SIZE + PAGE_SHIFT)
 #define H_PGTABLE_RANGE		(ASM_CONST(1) << H_PGTABLE_EADDR_SIZE)
+/*
+ * Top 2 bits are ignored in page table walk.
+ */
+#define EA_MASK			(~(0xcUL << 60))
 
 /*
  * We store the slot details in the second half of page table.
@@ -42,53 +46,56 @@
 #endif
 
 /*
- * Define the address range of the kernel non-linear virtual area. In contrast
- * to the linear mapping, this is managed using the kernel page tables and then
- * inserted into the hash page table to actually take effect, similarly to user
- * mappings.
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
-#define H_KERN_VIRT_START ASM_CONST(0xD000000000000000)
 
-/*
- * Allow virtual mapping of one context size.
- * 512TB for 64K page size
- * 64TB for 4K page size
- */
-#define H_KERN_VIRT_SIZE (1UL << MAX_EA_BITS_PER_CONTEXT)
+#define H_VMALLOC_START		H_KERN_VIRT_START
+#define H_VMALLOC_SIZE		H_KERN_MAP_SIZE
+#define H_VMALLOC_END		(H_VMALLOC_START + H_VMALLOC_SIZE)
 
-/*
- * 8TB IO mapping size
- */
-#define H_KERN_IO_SIZE ASM_CONST(0x80000000000) /* 8T */
-
-/*
- * The vmalloc space starts at the beginning of the kernel non-linear virtual
- * region, and occupies 504T (64K) or 56T (4K)
- */
-#define H_VMALLOC_START H_KERN_VIRT_START
-#define H_VMALLOC_SIZE (H_KERN_VIRT_SIZE - H_KERN_IO_SIZE)
-#define H_VMALLOC_END  (H_VMALLOC_START + H_VMALLOC_SIZE)
+#define H_KERN_IO_START		H_VMALLOC_END
+#define H_KERN_IO_SIZE		H_KERN_MAP_SIZE
+#define H_KERN_IO_END		(H_KERN_IO_START + H_KERN_IO_SIZE)
 
-#define H_KERN_IO_START	H_VMALLOC_END
-#define H_KERN_IO_END	(H_KERN_VIRT_START + H_KERN_VIRT_SIZE)
+#define H_VMEMMAP_START		H_KERN_IO_END
+#define H_VMEMMAP_SIZE		H_KERN_MAP_SIZE
+#define H_VMEMMAP_END		(H_VMEMMAP_START + H_VMEMMAP_SIZE)
 
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
 
 /*
  * Defines the address of the vmemap area, in its own region on
  * hash table CPUs.
  */
-#define H_VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
 
 #ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
@@ -104,6 +111,26 @@
 #define H_PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
 #ifndef __ASSEMBLY__
+static inline int get_region_id(unsigned long ea)
+{
+	int id = (ea >> 60UL);
+
+	if (id == 0)
+		return USER_REGION_ID;
+
+	VM_BUG_ON(id != 0xc);
+	VM_BUG_ON(ea >= H_VMEMMAP_END);
+
+	if (ea >= H_VMEMMAP_START)
+		return VMEMMAP_REGION_ID;
+	else if (ea >= H_KERN_IO_START)
+		return IO_REGION_ID;
+	else if (ea >= H_VMALLOC_START)
+		return VMALLOC_REGION_ID;
+
+	return KERNEL_REGION_ID;
+}
+
 #define	hash__pmd_bad(pmd)		(pmd_val(pmd) & H_PMD_BAD_BITS)
 #define	hash__pud_bad(pud)		(pud_val(pud) & H_PUD_BAD_BITS)
 static inline int hash__pgd_bad(pgd_t pgd)
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index a28a28079edb..b3f256c042aa 100644
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
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 51190a6d1c8a..8c156c5b4cd5 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -279,7 +279,6 @@ extern unsigned long __kernel_virt_size;
 extern unsigned long __kernel_io_start;
 extern unsigned long __kernel_io_end;
 #define KERN_VIRT_START __kernel_virt_start
-#define KERN_VIRT_SIZE  __kernel_virt_size
 #define KERN_IO_START  __kernel_io_start
 #define KERN_IO_END __kernel_io_end
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 6d760a083d62..574eca33f893 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -72,19 +72,17 @@
  * |                              |
  * |                              |
  * |                              |
- * +------------------------------+  Kernel IO map end (0xc010000000000000)
+ * +------------------------------+  Kernel vmemmap end (0xc010000000000000)
  * |                              |
+ * |           512TB		  |
  * |                              |
- * |      1/2 of virtual map      |
+ * +------------------------------+  Kernel IO map end/vmemap start
  * |                              |
+ * |           512TB		  |
  * |                              |
- * +------------------------------+  Kernel IO map start
+ * +------------------------------+  Kernel vmap end/ IO map start
  * |                              |
- * |      1/4 of virtual map      |
- * |                              |
- * +------------------------------+  Kernel vmemap start
- * |                              |
- * |     1/4 of virtual map       |
+ * |           512TB		  |
  * |                              |
  * +------------------------------+  Kernel virt start (0xc008000000000000)
  * |                              |
@@ -93,25 +91,24 @@
  * +------------------------------+  Kernel linear (0xc.....)
  */
 
-#define RADIX_KERN_VIRT_START ASM_CONST(0xc008000000000000)
-#define RADIX_KERN_VIRT_SIZE  ASM_CONST(0x0008000000000000)
-
+#define RADIX_KERN_VIRT_START	ASM_CONST(0xc008000000000000)
 /*
- * The vmalloc space starts at the beginning of that region, and
- * occupies a quarter of it on radix config.
- * (we keep a quarter for the virtual memmap)
+ * 49 =  MAX_EA_BITS_PER_CONTEXT (hash specific). To make sure we pick
+ * the same value as hash.
  */
+#define RADIX_KERN_MAP_SIZE	(1UL << 49)
+
 #define RADIX_VMALLOC_START	RADIX_KERN_VIRT_START
-#define RADIX_VMALLOC_SIZE	(RADIX_KERN_VIRT_SIZE >> 2)
+#define RADIX_VMALLOC_SIZE	RADIX_KERN_MAP_SIZE
 #define RADIX_VMALLOC_END	(RADIX_VMALLOC_START + RADIX_VMALLOC_SIZE)
-/*
- * Defines the address of the vmemap area, in its own region on
- * hash table CPUs.
- */
-#define RADIX_VMEMMAP_BASE		(RADIX_VMALLOC_END)
 
-#define RADIX_KERN_IO_START	(RADIX_KERN_VIRT_START + (RADIX_KERN_VIRT_SIZE >> 1))
-#define RADIX_KERN_IO_END       (RADIX_KERN_VIRT_START + RADIX_KERN_VIRT_SIZE)
+#define RADIX_KERN_IO_START	RADIX_VMALLOC_END
+#define RADIX_KERN_IO_SIZE	RADIX_KERN_MAP_SIZE
+#define RADIX_KERN_IO_END	(RADIX_KERN_IO_START + RADIX_KERN_IO_SIZE)
+
+#define RADIX_VMEMMAP_START	RADIX_KERN_IO_END
+#define RADIX_VMEMMAP_SIZE	RADIX_KERN_MAP_SIZE
+#define RADIX_VMEMMAP_END	(RADIX_VMEMMAP_START + RADIX_VMEMMAP_SIZE)
 
 #ifndef __ASSEMBLY__
 #define RADIX_PTE_TABLE_SIZE	(sizeof(pte_t) << RADIX_PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index ed870468ef6f..918228f2205b 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -139,7 +139,8 @@ static inline bool pfn_valid(unsigned long pfn)
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
index 3b9662a4207e..085509148d95 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -822,7 +822,7 @@ static inline void this_cpu_inc_rm(unsigned int __percpu *addr)
 	raddr = per_cpu_ptr(addr, cpu);
 	l = (unsigned long)raddr;
 
-	if (REGION_ID(l) == VMALLOC_REGION_ID) {
+	if (get_region_id(l) == VMALLOC_REGION_ID) {
 		l = vmalloc_to_phys(raddr);
 		raddr = (unsigned int *)l;
 	}
diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index c8da352e8686..9b0321061bc8 100644
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
@@ -117,10 +117,14 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
 		break;
 	case VMALLOC_REGION_ID:
 		pr_devel("%s: 0x%llx -- VMALLOC_REGION_ID\n", __func__, ea);
-		if (ea < VMALLOC_END)
-			psize = mmu_vmalloc_psize;
-		else
-			psize = mmu_io_psize;
+		psize = mmu_vmalloc_psize;
+		ssize = mmu_kernel_ssize;
+		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
+		vsidkey = SLB_VSID_KERNEL;
+		break;
+	case IO_REGION_ID:
+		pr_devel("%s: 0x%llx -- IO_REGION_ID\n", __func__, ea);
+		psize = mmu_io_psize;
 		ssize = mmu_kernel_ssize;
 		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
 		vsidkey = SLB_VSID_KERNEL;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 394dd969002f..c6b39e7694ba 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1013,12 +1013,11 @@ void __init hash__early_init_mmu(void)
 	__pgd_val_bits = HASH_PGD_VAL_BITS;
 
 	__kernel_virt_start = H_KERN_VIRT_START;
-	__kernel_virt_size = H_KERN_VIRT_SIZE;
 	__vmalloc_start = H_VMALLOC_START;
 	__vmalloc_end = H_VMALLOC_END;
 	__kernel_io_start = H_KERN_IO_START;
 	__kernel_io_end = H_KERN_IO_END;
-	vmemmap = (struct page *)H_VMEMMAP_BASE;
+	vmemmap = (struct page *)H_VMEMMAP_START;
 	ioremap_bot = IOREMAP_BASE;
 
 #ifdef CONFIG_PCI
@@ -1239,7 +1238,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	trace_hash_fault(ea, access, trap);
 
 	/* Get region & vsid */
- 	switch (REGION_ID(ea)) {
+	switch (get_region_id(ea)) {
 	case USER_REGION_ID:
 		user_region = 1;
 		if (! mm) {
@@ -1253,10 +1252,13 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
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
@@ -1422,7 +1424,8 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
 	unsigned long flags = 0;
 	struct mm_struct *mm = current->mm;
 
-	if (REGION_ID(ea) == VMALLOC_REGION_ID)
+	if ((get_region_id(ea) == VMALLOC_REGION_ID) ||
+	    (get_region_id(ea) == IO_REGION_ID))
 		mm = &init_mm;
 
 	if (dsisr & DSISR_NOHPTE)
@@ -1438,8 +1441,9 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 	unsigned long access = _PAGE_PRESENT | _PAGE_READ;
 	unsigned long flags = 0;
 	struct mm_struct *mm = current->mm;
+	unsigned int region_id = get_region_id(ea);
 
-	if (REGION_ID(ea) == VMALLOC_REGION_ID)
+	if ((region_id == VMALLOC_REGION_ID) || (region_id == IO_REGION_ID))
 		mm = &init_mm;
 
 	if (dsisr & DSISR_NOHPTE)
@@ -1456,7 +1460,7 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 	 * 2) user space access kernel space.
 	 */
 	access |= _PAGE_PRIVILEGED;
-	if ((msr & MSR_PR) || (REGION_ID(ea) == USER_REGION_ID))
+	if ((msr & MSR_PR) || (region_id == USER_REGION_ID))
 		access &= ~_PAGE_PRIVILEGED;
 
 	if (trap == 0x400)
@@ -1500,7 +1504,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	int rc, ssize, update_flags = 0;
 	unsigned long access = _PAGE_PRESENT | _PAGE_READ | (is_exec ? _PAGE_EXEC : 0);
 
-	BUG_ON(REGION_ID(ea) != USER_REGION_ID);
+	BUG_ON(get_region_id(ea) != USER_REGION_ID);
 
 	if (!should_hash_preload(mm, ea))
 		return;
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index bca1bf66c56e..94b18996e1b0 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -135,6 +135,10 @@ static int __map_kernel_page(unsigned long ea, unsigned long pa,
 	 */
 	BUILD_BUG_ON(TASK_SIZE_USER64 > RADIX_PGTABLE_RANGE);
 
+#ifdef CONFIG_PPC_64K_PAGES
+	BUILD_BUG_ON(RADIX_KERN_MAP_SIZE != MAX_EA_BITS_PER_CONTEXT);
+#endif
+
 	if (unlikely(!slab_is_available()))
 		return early_map_kernel_page(ea, pa, flags, map_page_size,
 						nid, region_start, region_end);
@@ -574,12 +578,11 @@ void __init radix__early_init_mmu(void)
 	__pgd_val_bits = RADIX_PGD_VAL_BITS;
 
 	__kernel_virt_start = RADIX_KERN_VIRT_START;
-	__kernel_virt_size = RADIX_KERN_VIRT_SIZE;
 	__vmalloc_start = RADIX_VMALLOC_START;
 	__vmalloc_end = RADIX_VMALLOC_END;
 	__kernel_io_start = RADIX_KERN_IO_START;
 	__kernel_io_end = RADIX_KERN_IO_END;
-	vmemmap = (struct page *)RADIX_VMEMMAP_BASE;
+	vmemmap = (struct page *)RADIX_VMEMMAP_START;
 	ioremap_bot = IOREMAP_BASE;
 
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 7cea39bdf05f..56068cac2a3c 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -90,8 +90,6 @@ unsigned long __pgd_val_bits;
 EXPORT_SYMBOL(__pgd_val_bits);
 unsigned long __kernel_virt_start;
 EXPORT_SYMBOL(__kernel_virt_start);
-unsigned long __kernel_virt_size;
-EXPORT_SYMBOL(__kernel_virt_size);
 unsigned long __vmalloc_start;
 EXPORT_SYMBOL(__vmalloc_start);
 unsigned long __vmalloc_end;
diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index b430e4e08af6..b9bda0105841 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -500,7 +500,7 @@ static void populate_markers(void)
 	address_markers[7].start_address = IOREMAP_BASE;
 	address_markers[8].start_address = IOREMAP_END;
 #ifdef CONFIG_PPC_BOOK3S_64
-	address_markers[9].start_address =  H_VMEMMAP_BASE;
+	address_markers[9].start_address =  H_VMEMMAP_START;
 #else
 	address_markers[9].start_address =  VMEMMAP_BASE;
 #endif
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 37138428ab55..63fc56feea15 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -303,8 +303,9 @@ static void populate_markers(void)
 	address_markers[i++].start_address = PHB_IO_END;
 	address_markers[i++].start_address = IOREMAP_BASE;
 	address_markers[i++].start_address = IOREMAP_END;
+	/* What is the ifdef about? */
 #ifdef CONFIG_PPC_BOOK3S_64
-	address_markers[i++].start_address =  H_VMEMMAP_BASE;
+	address_markers[i++].start_address =  H_VMEMMAP_START;
 #else
 	address_markers[i++].start_address =  VMEMMAP_BASE;
 #endif
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 5986df48359b..a0c37f428d60 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -694,7 +694,7 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 	if (id == KERNEL_REGION_ID) {
 
 		/* We only support upto MAX_PHYSMEM_BITS */
-		if ((ea & ~REGION_MASK) > (1UL << MAX_PHYSMEM_BITS))
+		if ((ea & EA_MASK) > (1UL << MAX_PHYSMEM_BITS))
 			return -EFAULT;
 
 		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_linear_psize].sllp;
@@ -702,20 +702,25 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	} else if (id == VMEMMAP_REGION_ID) {
 
-		if ((ea & ~REGION_MASK) >= (1ULL << MAX_EA_BITS_PER_CONTEXT))
+		if (ea >= H_VMEMMAP_END)
 			return -EFAULT;
 
 		flags = SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmemmap_psize].sllp;
 #endif
 	} else if (id == VMALLOC_REGION_ID) {
 
-		if ((ea & ~REGION_MASK) >= (1ULL << MAX_EA_BITS_PER_CONTEXT))
+		if (ea >= H_VMALLOC_END)
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
@@ -725,6 +730,7 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 		ssize = MMU_SEGSIZE_256M;
 
 	context = get_kernel_context(ea);
+
 	return slb_insert_entry(ea, context, flags, ssize, true);
 }
 
@@ -761,7 +767,7 @@ static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
 
 long do_slb_fault(struct pt_regs *regs, unsigned long ea)
 {
-	unsigned long id = REGION_ID(ea);
+	unsigned long id = get_region_id(ea);
 
 	/* IRQs are not reconciled here, so can't check irqs_disabled */
 	VM_WARN_ON(mfmsr() & MSR_EE);
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 7f12c7b78c0f..4770cce1bfe2 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -194,7 +194,7 @@ static int __spu_trap_data_map(struct spu *spu, unsigned long ea, u64 dsisr)
 	 * faults need to be deferred to process context.
 	 */
 	if ((dsisr & MFC_DSISR_PTE_NOT_FOUND) &&
-	    (REGION_ID(ea) != USER_REGION_ID)) {
+	    (get_region_id(ea) != USER_REGION_ID)) {
 
 		spin_unlock(&spu->register_lock);
 		ret = hash_page(ea,
@@ -224,7 +224,7 @@ static void __spu_kernel_slb(void *addr, struct copro_slb *slb)
 	unsigned long ea = (unsigned long)addr;
 	u64 llp;
 
-	if (REGION_ID(ea) == KERNEL_REGION_ID)
+	if (get_region_id(ea) == KERNEL_REGION_ID)
 		llp = mmu_psize_defs[mmu_linear_psize].sllp;
 	else
 		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index dc7b34174f85..a4d17a5a9763 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -168,7 +168,7 @@ int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
 		if (dsisr & CXL_PSL_DSISR_An_S)
 			access |= _PAGE_WRITE;
 
-		if (!mm && (REGION_ID(dar) != USER_REGION_ID))
+		if (!mm && (get_region_id(dar) != USER_REGION_ID))
 			access |= _PAGE_PRIVILEGED;
 
 		if (dsisr & DSISR_NOHPTE)
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index d50b861d7e57..04ec3d74f828 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -163,7 +163,7 @@ static void xsl_fault_handler_bh(struct work_struct *fault_work)
 		if (fault->dsisr & SPA_XSL_S)
 			access |= _PAGE_WRITE;
 
-		if (REGION_ID(fault->dar) != USER_REGION_ID)
+		if (get_region_id(fault->dar) != USER_REGION_ID)
 			access |= _PAGE_PRIVILEGED;
 
 		local_irq_save(flags);
-- 
2.20.1

