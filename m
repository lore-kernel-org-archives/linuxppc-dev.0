Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34B8C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 08:37:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56C62184A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 08:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56C62184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4495XK0ynczDqND
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 19:37:37 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4495V66BFyzDqMC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 19:35:42 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1S8Y75O078225
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 03:35:37 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qx8w0gebd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 03:35:36 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 28 Feb 2019 08:35:36 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Feb 2019 08:35:33 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1S8ZWVs60686428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Feb 2019 08:35:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 475717805E;
 Thu, 28 Feb 2019 08:35:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D9267805C;
 Thu, 28 Feb 2019 08:35:29 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.233])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 28 Feb 2019 08:35:29 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: akpm@linux-foundation.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Jan Kara <jack@suse.cz>, mpe@ellerman.id.au,
 Ross Zwisler <zwisler@kernel.org>, "Oliver O'Halloran" <oohall@gmail.com>
Subject: [PATCH 1/2] fs/dax: deposit pagetable even when installing zero page
Date: Thu, 28 Feb 2019 14:05:21 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022808-0016-0000-0000-0000098A1A3A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010678; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167493; UDB=6.00609930; IPR=6.00948107; 
 MB=3.00025776; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-28 08:35:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022808-0017-0000-0000-0000424C085D
Message-Id: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-28_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280061
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Architectures like ppc64 use the deposited page table to store hardware
page table slot information. Make sure we deposit a page table when
using zero page at the pmd level for hash.

Without this we hit

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000000000082a74
Oops: Kernel access of bad area, sig: 11 [#1]
....

NIP [c000000000082a74] __hash_page_thp+0x224/0x5b0
LR [c0000000000829a4] __hash_page_thp+0x154/0x5b0
Call Trace:
 hash_page_mm+0x43c/0x740
 do_hash_page+0x2c/0x3c
 copy_from_iter_flushcache+0xa4/0x4a0
 pmem_copy_from_iter+0x2c/0x50 [nd_pmem]
 dax_copy_from_iter+0x40/0x70
 dax_iomap_actor+0x134/0x360
 iomap_apply+0xfc/0x1b0
 dax_iomap_rw+0xac/0x130
 ext4_file_write_iter+0x254/0x460 [ext4]
 __vfs_write+0x120/0x1e0
 vfs_write+0xd8/0x220
 SyS_write+0x6c/0x110
 system_call+0x3c/0x130

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
TODO:
* Add fixes tag 

 fs/dax.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index 6959837cc465..01bfb2ac34f9 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -33,6 +33,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <asm/pgalloc.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -1410,7 +1411,9 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
+	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = mapping->host;
+	pgtable_t pgtable = NULL;
 	struct page *zero_page;
 	spinlock_t *ptl;
 	pmd_t pmd_entry;
@@ -1425,12 +1428,22 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
 			DAX_PMD | DAX_ZERO_PAGE, false);
 
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
 	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
 	if (!pmd_none(*(vmf->pmd))) {
 		spin_unlock(ptl);
 		goto fallback;
 	}
 
+	if (pgtable) {
+		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+		mm_inc_nr_ptes(vma->vm_mm);
+	}
 	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
 	pmd_entry = pmd_mkhuge(pmd_entry);
 	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
@@ -1439,6 +1452,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	return VM_FAULT_NOPAGE;
 
 fallback:
+	if (pgtable)
+		pte_free(vma->vm_mm, pgtable);
 	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_page, *entry);
 	return VM_FAULT_FALLBACK;
 }
-- 
2.20.1

