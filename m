Return-Path: <SRS0=BtxG=OE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BA1C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Nov 2018 21:49:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EC62082E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Nov 2018 21:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EC62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4333bm44LfzDqpM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 08:49:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4333Vh230tzDqmd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 08:44:59 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAPLi54T139657
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 16:44:57 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nymueq6a4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 16:44:57 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Sun, 25 Nov 2018 21:44:55 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 25 Nov 2018 21:44:48 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAPLilUK2949456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 25 Nov 2018 21:44:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01EF5AE053;
 Sun, 25 Nov 2018 21:44:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8AA7AE051;
 Sun, 25 Nov 2018 21:44:43 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.68])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Sun, 25 Nov 2018 21:44:43 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Sun, 25 Nov 2018 23:44:42 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] powerpc: prefer memblock APIs returning virtual address
Date: Sun, 25 Nov 2018 23:44:33 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112521-0012-0000-0000-000002CFFEFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112521-0013-0000-0000-0000210538C5
Message-Id: <1543182277-8819-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-25_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811250133
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There are a several places that allocate memory using memblock APIs that
return a physical address, convert the returned address to the virtual
address and frequently also memset(0) the allocated range.

Update these places to use memblock allocators already returning a virtual
address; use memblock functions that clear the allocated memory instead of
calling memset(0).

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/powerpc/kernel/paca.c             | 14 ++++++--------
 arch/powerpc/kernel/setup_64.c         | 21 ++++++++++-----------
 arch/powerpc/mm/hash_utils_64.c        |  6 +++---
 arch/powerpc/mm/pgtable-book3e.c       |  8 ++------
 arch/powerpc/mm/pgtable-book3s64.c     |  5 +----
 arch/powerpc/mm/pgtable-radix.c        | 24 +++++++++---------------
 arch/powerpc/platforms/pasemi/iommu.c  |  5 +++--
 arch/powerpc/platforms/pseries/setup.c | 11 +++++++----
 arch/powerpc/sysdev/dart_iommu.c       |  5 +++--
 9 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 913bfca..fa884ad 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -27,7 +27,7 @@
 static void *__init alloc_paca_data(unsigned long size, unsigned long align,
 				unsigned long limit, int cpu)
 {
-	unsigned long pa;
+	void *ptr;
 	int nid;
 
 	/*
@@ -42,17 +42,15 @@ static void *__init alloc_paca_data(unsigned long size, unsigned long align,
 		nid = early_cpu_to_node(cpu);
 	}
 
-	pa = memblock_alloc_base_nid(size, align, limit, nid, MEMBLOCK_NONE);
-	if (!pa) {
-		pa = memblock_alloc_base(size, align, limit);
-		if (!pa)
-			panic("cannot allocate paca data");
-	}
+	ptr = memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
+					 limit, nid);
+	if (!ptr)
+		panic("cannot allocate paca data");
 
 	if (cpu == boot_cpuid)
 		memblock_set_bottom_up(false);
 
-	return __va(pa);
+	return ptr;
 }
 
 #ifdef CONFIG_PPC_PSERIES
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 236c115..d11ee7f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -634,19 +634,17 @@ __init u64 ppc64_bolted_size(void)
 
 static void *__init alloc_stack(unsigned long limit, int cpu)
 {
-	unsigned long pa;
+	void *ptr;
 
 	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
 
-	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
-					early_cpu_to_node(cpu), MEMBLOCK_NONE);
-	if (!pa) {
-		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
-		if (!pa)
-			panic("cannot allocate stacks");
-	}
+	ptr = memblock_alloc_try_nid_raw(THREAD_SIZE, THREAD_SIZE,
+					 MEMBLOCK_LOW_LIMIT, limit,
+					 early_cpu_to_node(cpu));
+	if (!ptr)
+		panic("cannot allocate stacks");
 
-	return __va(pa);
+	return ptr;
 }
 
 void __init irqstack_early_init(void)
@@ -933,8 +931,9 @@ static void __ref init_fallback_flush(void)
 	 * hardware prefetch runoff. We don't have a recipe for load patterns to
 	 * reliably avoid the prefetcher.
 	 */
-	l1d_flush_fallback_area = __va(memblock_alloc_base(l1d_size * 2, l1d_size, limit));
-	memset(l1d_flush_fallback_area, 0, l1d_size * 2);
+	l1d_flush_fallback_area = memblock_alloc_try_nid(l1d_size * 2,
+						l1d_size, MEMBLOCK_LOW_LIMIT,
+						limit, NUMA_NO_NODE);
 
 	for_each_possible_cpu(cpu) {
 		struct paca_struct *paca = paca_ptrs[cpu];
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0cc7fbc..bc6be44 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -908,9 +908,9 @@ static void __init htab_initialize(void)
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (debug_pagealloc_enabled()) {
 		linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
-		linear_map_hash_slots = __va(memblock_alloc_base(
-				linear_map_hash_count, 1, ppc64_rma_size));
-		memset(linear_map_hash_slots, 0, linear_map_hash_count);
+		linear_map_hash_slots = memblock_alloc_try_nid(
+				linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
+				ppc64_rma_size,	NUMA_NO_NODE);
 	}
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable-book3e.c
index e0ccf36..53cbc7d 100644
--- a/arch/powerpc/mm/pgtable-book3e.c
+++ b/arch/powerpc/mm/pgtable-book3e.c
@@ -57,12 +57,8 @@ void vmemmap_remove_mapping(unsigned long start,
 
 static __ref void *early_alloc_pgtable(unsigned long size)
 {
-	void *pt;
-
-	pt = __va(memblock_alloc_base(size, size, __pa(MAX_DMA_ADDRESS)));
-	memset(pt, 0, size);
-
-	return pt;
+	return memblock_alloc_try_nid(size, size, MEMBLOCK_LOW_LIMIT,
+				      __pa(MAX_DMA_ADDRESS), NUMA_NO_NODE);
 }
 
 /*
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 9f93c9f..70d5478 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -195,11 +195,8 @@ void __init mmu_partition_table_init(void)
 	unsigned long ptcr;
 
 	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 36), "Partition table size too large.");
-	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
-						MEMBLOCK_ALLOC_ANYWHERE));
-
 	/* Initialize the Partition Table with no entries */
-	memset((void *)partition_tb, 0, patb_size);
+	partition_tb = memblock_alloc(patb_size, patb_size);
 
 	/*
 	 * update partition table control register,
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 9311560..415a1eb0 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -51,24 +51,18 @@ static int native_register_process_table(unsigned long base, unsigned long pg_sz
 static __ref void *early_alloc_pgtable(unsigned long size, int nid,
 			unsigned long region_start, unsigned long region_end)
 {
-	unsigned long pa = 0;
+	phys_addr_t min_addr = MEMBLOCK_LOW_LIMIT;
+	phys_addr_t max_addr = MEMBLOCK_ALLOC_ANYWHERE;
 	void *pt;
 
-	if (region_start || region_end) /* has region hint */
-		pa = memblock_alloc_range(size, size, region_start, region_end,
-						MEMBLOCK_NONE);
-	else if (nid != -1) /* has node hint */
-		pa = memblock_alloc_base_nid(size, size,
-						MEMBLOCK_ALLOC_ANYWHERE,
-						nid, MEMBLOCK_NONE);
+	if (region_start)
+		min_addr = region_start;
+	if (region_end)
+		max_addr = region_end;
 
-	if (!pa)
-		pa = memblock_alloc_base(size, size, MEMBLOCK_ALLOC_ANYWHERE);
-
-	BUG_ON(!pa);
-
-	pt = __va(pa);
-	memset(pt, 0, size);
+	pt = memblock_alloc_try_nid_nopanic(size, size, min_addr, max_addr,
+					    nid);
+	BUG_ON(!pt);
 
 	return pt;
 }
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index f297152..f62930f 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -208,7 +208,9 @@ static int __init iob_init(struct device_node *dn)
 	pr_debug(" -> %s\n", __func__);
 
 	/* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
-	iob_l2_base = (u32 *)__va(memblock_alloc_base(1UL<<21, 1UL<<21, 0x80000000));
+	iob_l2_base = memblock_alloc_try_nid_raw(1UL << 21, 1UL << 21,
+					MEMBLOCK_LOW_LIMIT, 0x80000000,
+					NUMA_NO_NODE);
 
 	pr_info("IOBMAP L2 allocated at: %p\n", iob_l2_base);
 
@@ -269,4 +271,3 @@ void __init iommu_init_early_pasemi(void)
 	pasemi_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pasemi;
 	set_pci_dma_ops(&dma_iommu_ops);
 }
-
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0f553dc..715ed61 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -130,8 +130,10 @@ static void __init fwnmi_init(void)
 	 * It will be used in real mode mce handler, hence it needs to be
 	 * below RMA.
 	 */
-	mce_data_buf = __va(memblock_alloc_base(RTAS_ERROR_LOG_MAX * nr_cpus,
-					RTAS_ERROR_LOG_MAX, ppc64_rma_size));
+	mce_data_buf = memblock_alloc_try_nid_raw(RTAS_ERROR_LOG_MAX * nr_cpus,
+					RTAS_ERROR_LOG_MAX, MEMBLOCK_LOW_LIMIT,
+					ppc64_rma_size, NUMA_NO_NODE);
+
 	for_each_possible_cpu(i) {
 		paca_ptrs[i]->mce_data_buf = mce_data_buf +
 						(RTAS_ERROR_LOG_MAX * i);
@@ -140,8 +142,9 @@ static void __init fwnmi_init(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* Allocate per cpu slb area to save old slb contents during MCE */
 	size = sizeof(struct slb_entry) * mmu_slb_size * nr_cpus;
-	slb_ptr = __va(memblock_alloc_base(size, sizeof(struct slb_entry),
-					   ppc64_rma_size));
+	slb_ptr = memblock_alloc_try_nid_raw(size, sizeof(struct slb_entry),
+					MEMBLOCK_LOW_LIMIT, ppc64_rma_size,
+					NUMA_NO_NODE);
 	for_each_possible_cpu(i)
 		paca_ptrs[i]->mce_faulty_slbs = slb_ptr + (mmu_slb_size * i);
 #endif
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index a5b40d1..ac6d235 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -251,8 +251,9 @@ static void allocate_dart(void)
 	 * 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
 	 * will blow up an entire large page anyway in the kernel mapping.
 	 */
-	dart_tablebase = __va(memblock_alloc_base(1UL<<24,
-						  1UL<<24, 0x80000000L));
+	dart_tablebase = memblock_alloc_try_nid_raw(1UL << 24, 1UL << 24,
+					MEMBLOCK_LOW_LIMIT, 0x80000000L,
+					NUMA_NO_NODE);
 
 	/* There is no point scanning the DART space for leaks*/
 	kmemleak_no_scan((void *)dart_tablebase);
-- 
2.7.4

