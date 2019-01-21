Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7812FC282DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:34:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4B02084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4B02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jlGL6TJYzDqWH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 19:34:34 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jkdJ0hqrzDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 19:05:55 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0L83ouc028421
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 03:05:54 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q59wfrwue-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 03:05:53 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Mon, 21 Jan 2019 08:05:50 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Jan 2019 08:05:39 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0L85caw29032612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 08:05:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4571C4203F;
 Mon, 21 Jan 2019 08:05:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55F6142047;
 Mon, 21 Jan 2019 08:05:33 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.125])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Jan 2019 08:05:33 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Mon, 21 Jan 2019 10:05:32 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 14/21] ia64: add checks for the return value of
 memblock_alloc*()
Date: Mon, 21 Jan 2019 10:04:01 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012108-0028-0000-0000-0000033BE18C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012108-0029-0000-0000-000023F915A0
Message-Id: <1548057848-15136-15-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210066
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, Petr Mladek <pmladek@suse.com>,
 linux-xtensa@linux-xtensa.org, linux-alpha@vger.kernel.org,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 openrisc@lists.librecores.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add panic() calls if memblock_alloc*() returns NULL.

Most of the changes are simply addition of

	if(!ptr)
		panic();

statements after the calls to memblock_alloc*() variants.

Exceptions are create_mem_map_page_table() and ia64_log_init() that were
slightly refactored to accommodate the change.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/kernel/mca.c          | 20 ++++++++++++++------
 arch/ia64/mm/contig.c           |  8 ++++++--
 arch/ia64/mm/discontig.c        |  4 ++++
 arch/ia64/mm/init.c             | 38 ++++++++++++++++++++++++++++++--------
 arch/ia64/mm/tlb.c              |  6 ++++++
 arch/ia64/sn/kernel/io_common.c |  3 +++
 arch/ia64/sn/kernel/setup.c     | 12 +++++++++++-
 7 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 370bc34..5cabb3f 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -359,11 +359,6 @@ typedef struct ia64_state_log_s
 
 static ia64_state_log_t ia64_state_log[IA64_MAX_LOG_TYPES];
 
-#define IA64_LOG_ALLOCATE(it, size) \
-	{ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)] = \
-		(ia64_err_rec_t *)memblock_alloc(size, SMP_CACHE_BYTES); \
-	ia64_state_log[it].isl_log[IA64_LOG_NEXT_INDEX(it)] = \
-		(ia64_err_rec_t *)memblock_alloc(size, SMP_CACHE_BYTES);}
 #define IA64_LOG_LOCK_INIT(it) spin_lock_init(&ia64_state_log[it].isl_lock)
 #define IA64_LOG_LOCK(it)      spin_lock_irqsave(&ia64_state_log[it].isl_lock, s)
 #define IA64_LOG_UNLOCK(it)    spin_unlock_irqrestore(&ia64_state_log[it].isl_lock,s)
@@ -378,6 +373,19 @@ static ia64_state_log_t ia64_state_log[IA64_MAX_LOG_TYPES];
 #define IA64_LOG_CURR_BUFFER(it)   (void *)((ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)]))
 #define IA64_LOG_COUNT(it)         ia64_state_log[it].isl_count
 
+static inline void ia64_log_allocate(int it, u64 size)
+{
+	ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)] =
+		(ia64_err_rec_t *)memblock_alloc(size, SMP_CACHE_BYTES);
+	if (!ia64_state_log[it].isl_log[IA64_LOG_CURR_INDEX(it)])
+		panic("%s: Failed to allocate %llu bytes\n", __func__, size);
+
+	ia64_state_log[it].isl_log[IA64_LOG_NEXT_INDEX(it)] =
+		(ia64_err_rec_t *)memblock_alloc(size, SMP_CACHE_BYTES);
+	if (!ia64_state_log[it].isl_log[IA64_LOG_NEXT_INDEX(it)])
+		panic("%s: Failed to allocate %llu bytes\n", __func__, size);
+}
+
 /*
  * ia64_log_init
  *	Reset the OS ia64 log buffer
@@ -399,7 +407,7 @@ ia64_log_init(int sal_info_type)
 		return;
 
 	// set up OS data structures to hold error info
-	IA64_LOG_ALLOCATE(sal_info_type, max_size);
+	ia64_log_allocate(sal_info_type, max_size);
 }
 
 /*
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 6e44723..d29fb6b 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -84,9 +84,13 @@ void *per_cpu_init(void)
 static inline void
 alloc_per_cpu_data(void)
 {
-	cpu_data = memblock_alloc_from(PERCPU_PAGE_SIZE * num_possible_cpus(),
-				       PERCPU_PAGE_SIZE,
+	size_t size = PERCPU_PAGE_SIZE * num_possible_cpus();
+
+	cpu_data = memblock_alloc_from(size, PERCPU_PAGE_SIZE,
 				       __pa(MAX_DMA_ADDRESS));
+	if (!cpu_data)
+		panic("%s: Failed to allocate %lu bytes align=%lx from=%lx\n",
+		      __func__, size, PERCPU_PAGE_SIZE, __pa(MAX_DMA_ADDRESS));
 }
 
 /**
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index f9c3675..05490dd 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -454,6 +454,10 @@ static void __init *memory_less_node_alloc(int nid, unsigned long pernodesize)
 				     __pa(MAX_DMA_ADDRESS),
 				     MEMBLOCK_ALLOC_ACCESSIBLE,
 				     bestnode);
+	if (!ptr)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
+		      __func__, pernodesize, PERCPU_PAGE_SIZE, bestnode,
+		      __pa(MAX_DMA_ADDRESS));
 
 	return ptr;
 }
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 29d8415..e49200e 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -444,23 +444,45 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
 
 	for (address = start_page; address < end_page; address += PAGE_SIZE) {
 		pgd = pgd_offset_k(address);
-		if (pgd_none(*pgd))
-			pgd_populate(&init_mm, pgd, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
+		if (pgd_none(*pgd)) {
+			pud = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
+			if (!pud)
+				goto err_alloc;
+			pgd_populate(&init_mm, pgd, pud);
+		}
 		pud = pud_offset(pgd, address);
 
-		if (pud_none(*pud))
-			pud_populate(&init_mm, pud, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
+		if (pud_none(*pud)) {
+			pmd = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
+			if (!pmd)
+				goto err_alloc;
+			pud_populate(&init_mm, pud, pmd);
+		}
 		pmd = pmd_offset(pud, address);
 
-		if (pmd_none(*pmd))
-			pmd_populate_kernel(&init_mm, pmd, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
+		if (pmd_none(*pmd)) {
+			pte = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
+			if (!pte)
+				goto err_alloc;
+			pmd_populate_kernel(&init_mm, pmd, pte);
+		}
 		pte = pte_offset_kernel(pmd, address);
 
-		if (pte_none(*pte))
-			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node)) >> PAGE_SHIFT,
+		if (pte_none(*pte)) {
+			void *page = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE,
+							 node);
+			if (!page)
+				goto err_alloc;
+			set_pte(pte, pfn_pte(__pa(page) >> PAGE_SHIFT,
 					     PAGE_KERNEL));
+		}
 	}
 	return 0;
+
+err_alloc:
+	panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d\n",
+	      __func__, PAGE_SIZE, PAGE_SIZE, node);
+	return -ENOMEM;
 }
 
 struct memmap_init_callback_data {
diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index 9340bcb..5fc89aa 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -61,8 +61,14 @@ mmu_context_init (void)
 {
 	ia64_ctx.bitmap = memblock_alloc((ia64_ctx.max_ctx + 1) >> 3,
 					 SMP_CACHE_BYTES);
+	if (!ia64_ctx.bitmap)
+		panic("%s: Failed to allocate %u bytes\n", __func__,
+		      (ia64_ctx.max_ctx + 1) >> 3);
 	ia64_ctx.flushmap = memblock_alloc((ia64_ctx.max_ctx + 1) >> 3,
 					   SMP_CACHE_BYTES);
+	if (!ia64_ctx.flushmap)
+		panic("%s: Failed to allocate %u bytes\n", __func__,
+		      (ia64_ctx.max_ctx + 1) >> 3);
 }
 
 /*
diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index 8df13d0..d468473 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -394,6 +394,9 @@ void __init hubdev_init_node(nodepda_t * npda, cnodeid_t node)
 	hubdev_info = (struct hubdev_info *)memblock_alloc_node(size,
 								SMP_CACHE_BYTES,
 								node);
+	if (!hubdev_info)
+		panic("%s: Failed to allocate %d bytes align=0x%x nid=%d\n",
+		      __func__, size, SMP_CACHE_BYTES, node);
 
 	npda->pdinfo = (void *)hubdev_info;
 }
diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index a6d40a2..e6a5049 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -513,6 +513,10 @@ static void __init sn_init_pdas(char **cmdline_p)
 		nodepdaindr[cnode] =
 		    memblock_alloc_node(sizeof(nodepda_t), SMP_CACHE_BYTES,
 					cnode);
+		if (!nodepdaindr[cnode])
+			panic("%s: Failed to allocate %lu bytes align=0x%x nid=%d\n",
+			      __func__, sizeof(nodepda_t), SMP_CACHE_BYTES,
+			      cnode);
 		memset(nodepdaindr[cnode]->phys_cpuid, -1,
 		    sizeof(nodepdaindr[cnode]->phys_cpuid));
 		spin_lock_init(&nodepdaindr[cnode]->ptc_lock);
@@ -521,9 +525,15 @@ static void __init sn_init_pdas(char **cmdline_p)
 	/*
 	 * Allocate & initialize nodepda for TIOs.  For now, put them on node 0.
 	 */
-	for (cnode = num_online_nodes(); cnode < num_cnodes; cnode++)
+	for (cnode = num_online_nodes(); cnode < num_cnodes; cnode++) {
 		nodepdaindr[cnode] =
 		    memblock_alloc_node(sizeof(nodepda_t), SMP_CACHE_BYTES, 0);
+		if (!nodepdaindr[cnode])
+			panic("%s: Failed to allocate %lu bytes align=0x%x nid=%d\n",
+			      __func__, sizeof(nodepda_t), SMP_CACHE_BYTES,
+			      cnode);
+	}
+
 
 	/*
 	 * Now copy the array of nodepda pointers to each nodepda.
-- 
2.7.4

