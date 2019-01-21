Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9FDC282DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:24:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA7C2084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA7C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jl2J1qBCzDqVd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 19:24:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jkcg0r4gzDqS8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 19:05:22 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0L84IRf080213
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 03:05:21 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q57sc5y1n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 03:05:20 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Mon, 21 Jan 2019 08:05:14 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Jan 2019 08:05:03 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0L852NS62324936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 08:05:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB9DB42052;
 Mon, 21 Jan 2019 08:05:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7CEE4204B;
 Mon, 21 Jan 2019 08:04:57 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.125])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Jan 2019 08:04:57 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Mon, 21 Jan 2019 10:04:57 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 08/21] memblock: drop __memblock_alloc_base()
Date: Mon, 21 Jan 2019 10:03:55 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012108-0016-0000-0000-000002482BD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012108-0017-0000-0000-000032A25B2A
Message-Id: <1548057848-15136-9-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=838 adultscore=0 classifier=spam adjust=0 reason=mlx
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

The __memblock_alloc_base() function tries to allocate a memory up to the
limit specified by its max_addr parameter. Depending on the value of this
parameter, the __memblock_alloc_base() can is replaced with the appropriate
memblock_phys_alloc*() variant.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/sh/kernel/machine_kexec.c |  3 ++-
 arch/x86/kernel/e820.c         |  2 +-
 arch/x86/mm/numa.c             | 12 ++++--------
 drivers/of/of_reserved_mem.c   |  7 ++-----
 include/linux/memblock.h       |  2 --
 mm/memblock.c                  |  9 ++-------
 6 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index b9f9f1a..63d63a3 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -168,7 +168,8 @@ void __init reserve_crashkernel(void)
 	crash_size = PAGE_ALIGN(resource_size(&crashk_res));
 	if (!crashk_res.start) {
 		unsigned long max = memblock_end_of_DRAM() - memory_limit;
-		crashk_res.start = __memblock_alloc_base(crash_size, PAGE_SIZE, max);
+		crashk_res.start = memblock_phys_alloc_range(crash_size,
+							     PAGE_SIZE, 0, max);
 		if (!crashk_res.start) {
 			pr_err("crashkernel allocation failed\n");
 			goto disable;
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 50895c2..9c0eb54 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -778,7 +778,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)
 {
 	u64 addr;
 
-	addr = __memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
+	addr = memblock_phys_alloc(size, align);
 	if (addr) {
 		e820__range_update_kexec(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		pr_info("update e820_table_kexec for e820__memblock_alloc_reserved()\n");
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1308f54..f85ae42 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -195,15 +195,11 @@ static void __init alloc_node_data(int nid)
 	 * Allocate node data.  Try node-local memory and then any node.
 	 * Never allocate in DMA zone.
 	 */
-	nd_pa = memblock_phys_alloc_nid(nd_size, SMP_CACHE_BYTES, nid);
+	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
 	if (!nd_pa) {
-		nd_pa = __memblock_alloc_base(nd_size, SMP_CACHE_BYTES,
-					      MEMBLOCK_ALLOC_ACCESSIBLE);
-		if (!nd_pa) {
-			pr_err("Cannot find %zu bytes in any node (initial node: %d)\n",
-			       nd_size, nid);
-			return;
-		}
+		pr_err("Cannot find %zu bytes in any node (initial node: %d)\n",
+		       nd_size, nid);
+		return;
 	}
 	nd = __va(nd_pa);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0..499f16d 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -31,13 +31,10 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	phys_addr_t *res_base)
 {
 	phys_addr_t base;
-	/*
-	 * We use __memblock_alloc_base() because memblock_alloc_base()
-	 * panic()s on allocation failure.
-	 */
+
 	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
 	align = !align ? SMP_CACHE_BYTES : align;
-	base = __memblock_alloc_base(size, align, end);
+	base = memblock_phys_alloc_range(size, align, 0, end);
 	if (!base)
 		return -ENOMEM;
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 7883c74..768e2b4 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -496,8 +496,6 @@ static inline bool memblock_bottom_up(void)
 
 phys_addr_t memblock_alloc_base(phys_addr_t size, phys_addr_t align,
 				phys_addr_t max_addr);
-phys_addr_t __memblock_alloc_base(phys_addr_t size, phys_addr_t align,
-				  phys_addr_t max_addr);
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
 phys_addr_t memblock_mem_size(unsigned long limit_pfn);
diff --git a/mm/memblock.c b/mm/memblock.c
index 461e40a3..e5ffdcd 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1363,17 +1363,12 @@ phys_addr_t __init memblock_phys_alloc_nid(phys_addr_t size, phys_addr_t align,
 	return ret;
 }
 
-phys_addr_t __init __memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
-{
-	return memblock_alloc_range_nid(size, align, 0, max_addr, NUMA_NO_NODE,
-					MEMBLOCK_NONE);
-}
-
 phys_addr_t __init memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
 {
 	phys_addr_t alloc;
 
-	alloc = __memblock_alloc_base(size, align, max_addr);
+	alloc = memblock_alloc_range_nid(size, align, 0, max_addr, NUMA_NO_NODE,
+					MEMBLOCK_NONE);
 
 	if (alloc == 0)
 		panic("ERROR: Failed to allocate %pa bytes below %pa.\n",
-- 
2.7.4

