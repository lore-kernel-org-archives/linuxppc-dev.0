Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067C5C282DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:22:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A7F2084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A7F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jl041dfvzDqVP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 19:22:12 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jkcW5MTdzDqTK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 19:05:15 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0L83oSc162225
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 03:05:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q59whgvtr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 03:05:12 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Mon, 21 Jan 2019 08:05:09 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Jan 2019 08:04:58 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0L84vVC10158356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 08:04:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F014152052;
 Mon, 21 Jan 2019 08:04:56 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.125])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1A24552067;
 Mon, 21 Jan 2019 08:04:52 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Mon, 21 Jan 2019 10:04:51 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 07/21] memblock: memblock_phys_alloc(): don't panic
Date: Mon, 21 Jan 2019 10:03:54 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012108-0012-0000-0000-000002EAB8F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012108-0013-0000-0000-00002121DE96
Message-Id: <1548057848-15136-8-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
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

Make the memblock_phys_alloc() function an inline wrapper for
memblock_phys_alloc_range() and update the memblock_phys_alloc() callers to
check the returned value and panic in case of error.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/init.c                   | 4 ++++
 arch/arm64/mm/mmu.c                  | 2 ++
 arch/powerpc/sysdev/dart_iommu.c     | 3 +++
 arch/s390/kernel/crash_dump.c        | 3 +++
 arch/s390/kernel/setup.c             | 3 +++
 arch/sh/boards/mach-ap325rxa/setup.c | 3 +++
 arch/sh/boards/mach-ecovec24/setup.c | 6 ++++++
 arch/sh/boards/mach-kfr2r09/setup.c  | 3 +++
 arch/sh/boards/mach-migor/setup.c    | 3 +++
 arch/sh/boards/mach-se/7724/setup.c  | 6 ++++++
 arch/xtensa/mm/kasan_init.c          | 3 +++
 include/linux/memblock.h             | 7 ++++++-
 mm/memblock.c                        | 5 -----
 13 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index b76b90e..15dddfe 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -206,6 +206,10 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 	BUG_ON(!arm_memblock_steal_permitted);
 
 	phys = memblock_phys_alloc(size, align);
+	if (!phys)
+		panic("Failed to steal %pa bytes at %pS\n",
+		      &size, (void *)_RET_IP_);
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b6f5aa5..a74e4be 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -104,6 +104,8 @@ static phys_addr_t __init early_pgtable_alloc(void)
 	void *ptr;
 
 	phys = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate page table page\n");
 
 	/*
 	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 25bc25f..b82c9ff 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -265,6 +265,9 @@ static void allocate_dart(void)
 	 * prefetching into invalid pages and corrupting data
 	 */
 	tmp = memblock_phys_alloc(DART_PAGE_SIZE, DART_PAGE_SIZE);
+	if (!tmp)
+		panic("DART: table allocation failed\n");
+
 	dart_emptyval = DARTMAP_VALID | ((tmp >> DART_PAGE_SHIFT) &
 					 DARTMAP_RPNMASK);
 
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 97eae38..f96a585 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -61,6 +61,9 @@ struct save_area * __init save_area_alloc(bool is_boot_cpu)
 	struct save_area *sa;
 
 	sa = (void *) memblock_phys_alloc(sizeof(*sa), 8);
+	if (!sa)
+		panic("Failed to allocate save area\n");
+
 	if (is_boot_cpu)
 		list_add(&sa->list, &dump_save_areas);
 	else
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 72dd23e..da48397 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -968,6 +968,9 @@ static void __init setup_randomness(void)
 
 	vmms = (struct sysinfo_3_2_2 *) memblock_phys_alloc(PAGE_SIZE,
 							    PAGE_SIZE);
+	if (!vmms)
+		panic("Failed to allocate memory for sysinfo structure\n");
+
 	if (stsi(vmms, 3, 2, 2) == 0 && vmms->count)
 		add_device_randomness(&vmms->vm, sizeof(vmms->vm[0]) * vmms->count);
 	memblock_free((unsigned long) vmms, PAGE_SIZE);
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index d7ceab6..08a0cc9 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -558,6 +558,9 @@ static void __init ap325rxa_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index a3901806..fd264a6 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1481,11 +1481,17 @@ static void __init ecovec_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU0 memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU1 memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 55bdf4a..ebe90d06 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -632,6 +632,9 @@ static void __init kfr2r09_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index ba7eee6..1adff09 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -631,6 +631,9 @@ static void __init migor_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 4696e10..201631a 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -966,11 +966,17 @@ static void __init ms7724se_mv_mem_reserve(void)
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU0 memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
 	phys = memblock_phys_alloc(size, PAGE_SIZE);
+	if (!phys)
+		panic("Failed to allocate CEU1 memory\n");
+
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index 48dbb03..4852848 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -54,6 +54,9 @@ static void __init populate(void *start, void *end)
 			phys_addr_t phys =
 				memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 
+			if (!phys)
+				panic("Failed to allocate page table page\n");
+
 			set_pte(pte + j, pfn_pte(PHYS_PFN(phys), PAGE_KERNEL));
 		}
 	}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 66dfdb3..7883c74 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -374,7 +374,12 @@ phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
 phys_addr_t memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align, int nid);
 phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
 
-phys_addr_t memblock_phys_alloc(phys_addr_t size, phys_addr_t align);
+static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
+					      phys_addr_t align)
+{
+	return memblock_phys_alloc_range(size, align, 0,
+					 MEMBLOCK_ALLOC_ACCESSIBLE);
+}
 
 void *memblock_alloc_try_nid_raw(phys_addr_t size, phys_addr_t align,
 				 phys_addr_t min_addr, phys_addr_t max_addr,
diff --git a/mm/memblock.c b/mm/memblock.c
index 8aabb1b..461e40a3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1382,11 +1382,6 @@ phys_addr_t __init memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys
 	return alloc;
 }
 
-phys_addr_t __init memblock_phys_alloc(phys_addr_t size, phys_addr_t align)
-{
-	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
-}
-
 phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
 {
 	phys_addr_t res = memblock_phys_alloc_nid(size, align, nid);
-- 
2.7.4

