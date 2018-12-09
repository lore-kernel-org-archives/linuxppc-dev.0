Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814E4C07E85
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 15:15:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F177920672
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 15:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F177920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CVBD0MqWzDqZb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 02:15:00 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CTt75r8ZzDqxb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 02:01:03 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB9ExIAa085633
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Dec 2018 10:01:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p8v5dprp2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 10:01:00 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Sun, 9 Dec 2018 15:00:58 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 9 Dec 2018 15:00:51 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB9F0oPM26476574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 9 Dec 2018 15:00:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10D96AE051;
 Sun,  9 Dec 2018 15:00:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45CAEAE053;
 Sun,  9 Dec 2018 15:00:47 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.213])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Sun,  9 Dec 2018 15:00:47 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Sun, 09 Dec 2018 17:00:46 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 6/6] arm, unicore32: remove early_alloc*() wrappers
Date: Sun,  9 Dec 2018 17:00:24 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544367624-15376-1-git-send-email-rppt@linux.ibm.com>
References: <1544367624-15376-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120915-0012-0000-0000-000002D6AF53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120915-0013-0000-0000-0000210C1EE1
Message-Id: <1544367624-15376-7-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-09_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812090139
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
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
oneliner wrappers for memblock_alloc.

Replace their usage with direct call to memblock_alloc.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/mmu.c       | 11 +++--------
 arch/unicore32/mm/mmu.c | 12 ++++--------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 0a04c9a5..57de0dd 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
-{
-	return memblock_alloc(sz, align);
-}
-
 static void __init *early_alloc(unsigned long sz)
 {
-	return early_alloc_aligned(sz, sz);
+	return memblock_alloc(sz, sz);
 }
 
 static void *__init late_alloc(unsigned long sz)
@@ -998,7 +993,7 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 	if (!nr)
 		return;
 
-	svm = early_alloc_aligned(sizeof(*svm) * nr, __alignof__(*svm));
+	svm = memblock_alloc(sizeof(*svm) * nr, __alignof__(*svm));
 
 	for (md = io_desc; nr; md++, nr--) {
 		create_mapping(md);
@@ -1020,7 +1015,7 @@ void __init vm_reserve_area_early(unsigned long addr, unsigned long size,
 	struct vm_struct *vm;
 	struct static_vm *svm;
 
-	svm = early_alloc_aligned(sizeof(*svm), __alignof__(*svm));
+	svm = memblock_alloc(sizeof(*svm), __alignof__(*svm));
 
 	vm = &svm->vm;
 	vm->addr = (void *)addr;
diff --git a/arch/unicore32/mm/mmu.c b/arch/unicore32/mm/mmu.c
index 50d8c1a..a402192 100644
--- a/arch/unicore32/mm/mmu.c
+++ b/arch/unicore32/mm/mmu.c
@@ -141,16 +141,12 @@ static void __init build_mem_type_table(void)
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc(unsigned long sz)
-{
-	return memblock_alloc(sz, sz);
-}
-
 static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr,
 		unsigned long prot)
 {
 	if (pmd_none(*pmd)) {
-		pte_t *pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
+		pte_t *pte = memblock_alloc(PTRS_PER_PTE * sizeof(pte_t),
+					    PTRS_PER_PTE * sizeof(pte_t));
 		__pmd_populate(pmd, __pa(pte) | prot);
 	}
 	BUG_ON(pmd_bad(*pmd));
@@ -352,7 +348,7 @@ static void __init devicemaps_init(void)
 	/*
 	 * Allocate the vector page early.
 	 */
-	vectors = early_alloc(PAGE_SIZE);
+	vectors = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
@@ -429,7 +425,7 @@ void __init paging_init(void)
 	top_pmd = pmd_off_k(0xffff0000);
 
 	/* allocate the zero page. */
-	zero_page = early_alloc(PAGE_SIZE);
+	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	bootmem_init();
 
-- 
2.7.4

