Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A98C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:55:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5911E206C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5911E206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fpcb1qx3zDqgH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:55:11 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fpNr6H6gzDqbY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:45:00 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0GDehvr127608
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 08:44:58 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q23ejpsy6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 08:44:58 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Wed, 16 Jan 2019 13:44:55 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 13:44:43 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0GDigZr52232384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 13:44:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B34AA405B;
 Wed, 16 Jan 2019 13:44:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F37B0A4054;
 Wed, 16 Jan 2019 13:44:37 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Jan 2019 13:44:37 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Wed, 16 Jan 2019 15:44:37 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 03/21] memblock: replace memblock_alloc_base(ANYWHERE) with
 memblock_phys_alloc
Date: Wed, 16 Jan 2019 15:44:03 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-4275-0000-0000-000002FFFEE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-4276-0000-0000-0000380E2037
Message-Id: <1547646261-32535-4-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=732 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
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

The calls to memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE) and
memblock_phys_alloc(size, align) are equivalent as both try to allocate
'size' bytes with 'align' alignment anywhere in the memory and panic if hte
allocation fails.

The conversion is done using the following semantic patch:

@@
expression size, align;
@@
- memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE)
+ memblock_phys_alloc(size, align)

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/init.c                   | 2 +-
 arch/sh/boards/mach-ap325rxa/setup.c | 2 +-
 arch/sh/boards/mach-ecovec24/setup.c | 4 ++--
 arch/sh/boards/mach-kfr2r09/setup.c  | 2 +-
 arch/sh/boards/mach-migor/setup.c    | 2 +-
 arch/sh/boards/mach-se/7724/setup.c  | 4 ++--
 arch/xtensa/mm/kasan_init.c          | 3 +--
 7 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 478ea8b..b76b90e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -205,7 +205,7 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 
 	BUG_ON(!arm_memblock_steal_permitted);
 
-	phys = memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, align);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 8f234d04..d7ceab6 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -557,7 +557,7 @@ static void __init ap325rxa_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 22b4106..a3901806 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1480,12 +1480,12 @@ static void __init ecovec_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 203d249..55bdf4a 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -631,7 +631,7 @@ static void __init kfr2r09_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index f4ad33c..ba7eee6 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -630,7 +630,7 @@ static void __init migor_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index fdbec22a..4696e10 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -965,12 +965,12 @@ static void __init ms7724se_mv_mem_reserve(void)
 	phys_addr_t phys;
 	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
-	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
+	phys = memblock_phys_alloc(size, PAGE_SIZE);
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index 1734cda..48dbb03 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -52,8 +52,7 @@ static void __init populate(void *start, void *end)
 
 		for (k = 0; k < PTRS_PER_PTE; ++k, ++j) {
 			phys_addr_t phys =
-				memblock_alloc_base(PAGE_SIZE, PAGE_SIZE,
-						    MEMBLOCK_ALLOC_ANYWHERE);
+				memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 
 			set_pte(pte + j, pfn_pte(PHYS_PFN(phys), PAGE_KERNEL));
 		}
-- 
2.7.4

