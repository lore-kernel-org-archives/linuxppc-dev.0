Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3373DC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 04:15:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70B421734
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 04:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70B421734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Yt6d3xQgzDqVY
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:15:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Yt2y4TFczDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 15:12:42 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id D798DAE8011F;
 Wed,  3 Apr 2019 00:12:39 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v2 2/2] powerpc/mm_iommu: Allow pinning large regions
Date: Wed,  3 Apr 2019 15:12:33 +1100
Message-Id: <20190403041233.57619-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403041233.57619-1-aik@ozlabs.ru>
References: <20190403041233.57619-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When called with vmas_arg==NULL, get_user_pages_longterm() allocates
an array of nr_pages*8 which can easily get greater that the max order,
for example, registering memory for a 256GB guest does this and fails
in __alloc_pages_nodemask().

This adds a loop over chunks of entries to fit the max order limit.

Fixes: 678e174c4c16 ("powerpc/mm/iommu: allow migration of cma allocated pages during mm_iommu_do_alloc", 2019-03-05)
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/mm/mmu_context_iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 9d9be850f8c2..8330f135294f 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -98,6 +98,7 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	struct mm_iommu_table_group_mem_t *mem, *mem2;
 	long i, ret, locked_entries = 0, pinned = 0;
 	unsigned int pageshift;
+	unsigned long entry, chunk;
 
 	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA) {
 		ret = mm_iommu_adjust_locked_vm(mm, entries, true);
@@ -134,11 +135,26 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	}
 
 	down_read(&mm->mmap_sem);
-	ret = get_user_pages_longterm(ua, entries, FOLL_WRITE, mem->hpages, NULL);
+	chunk = (1UL << (PAGE_SHIFT + MAX_ORDER - 1)) /
+			sizeof(struct vm_area_struct *);
+	chunk = min(chunk, entries);
+	for (entry = 0; entry < entries; entry += chunk) {
+		unsigned long n = min(entries - entry, chunk);
+
+		ret = get_user_pages_longterm(ua + (entry << PAGE_SHIFT), n,
+				FOLL_WRITE, mem->hpages + entry, NULL);
+		if (ret == n) {
+			pinned += n;
+			continue;
+		}
+		if (ret > 0)
+			pinned += ret;
+		break;
+	}
 	up_read(&mm->mmap_sem);
-	pinned = ret > 0 ? ret : 0;
-	if (ret != entries) {
-		ret = -EFAULT;
+	if (pinned != entries) {
+		if (!ret)
+			ret = -EFAULT;
 		goto free_exit;
 	}
 
-- 
2.17.1

