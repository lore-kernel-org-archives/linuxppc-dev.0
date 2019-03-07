Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30460C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 14:52:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7B12081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 14:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7B12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FYWm17lTzDqHH
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 01:52:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=lvivier@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FYTr1FktzDqDP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 01:50:56 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDA1A81DFC;
 Thu,  7 Mar 2019 14:50:53 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-24.brq.redhat.com [10.40.204.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C5A0165E7;
 Thu,  7 Mar 2019 14:50:50 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mm: move warning from resize_hpt_for_hotplug()
Date: Thu,  7 Mar 2019 15:50:50 +0100
Message-Id: <20190307145050.17886-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 07 Mar 2019 14:50:53 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

resize_hpt_for_hotplug() reports a warning when it cannot
resize the hash page table ("Unable to resize hash page
table to target order") but in some cases it's not a problem
and can make user thinks something has not worked properly.

This patch moves the warning to arch_remove_memory() to
only report the problem when it is needed.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/include/asm/sparsemem.h  |  4 ++--
 arch/powerpc/mm/hash_utils_64.c       | 17 ++++++-----------
 arch/powerpc/mm/mem.c                 |  3 ++-
 arch/powerpc/platforms/pseries/lpar.c |  1 -
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 68da49320592..3192d454a733 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -17,9 +17,9 @@ extern int create_section_mapping(unsigned long start, unsigned long end, int ni
 extern int remove_section_mapping(unsigned long start, unsigned long end);
 
 #ifdef CONFIG_PPC_BOOK3S_64
-extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
+extern int resize_hpt_for_hotplug(unsigned long new_mem_size);
 #else
-static inline void resize_hpt_for_hotplug(unsigned long new_mem_size) { }
+static inline int resize_hpt_for_hotplug(unsigned long new_mem_size) { return 0; }
 #endif
 
 #ifdef CONFIG_NUMA
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0cc7fbc3bd1c..40bb2a8326bb 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -755,12 +755,12 @@ static unsigned long __init htab_get_table_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-void resize_hpt_for_hotplug(unsigned long new_mem_size)
+int resize_hpt_for_hotplug(unsigned long new_mem_size)
 {
 	unsigned target_hpt_shift;
 
 	if (!mmu_hash_ops.resize_hpt)
-		return;
+		return 0;
 
 	target_hpt_shift = htab_shift_for_mem_size(new_mem_size);
 
@@ -773,15 +773,10 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
 	 * current shift
 	 */
 	if ((target_hpt_shift > ppc64_pft_size)
-	    || (target_hpt_shift < (ppc64_pft_size - 1))) {
-		int rc;
-
-		rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
-		if (rc && (rc != -ENODEV))
-			printk(KERN_WARNING
-			       "Unable to resize hash page table to target order %d: %d\n",
-			       target_hpt_shift, rc);
-	}
+	    || (target_hpt_shift < (ppc64_pft_size - 1)))
+		return mmu_hash_ops.resize_hpt(target_hpt_shift);
+
+	return 0;
 }
 
 int hash__create_section_mapping(unsigned long start, unsigned long end, int nid)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 33cc6f676fa6..0d40d970cf4a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -169,7 +169,8 @@ int __meminit arch_remove_memory(int nid, u64 start, u64 size,
 	 */
 	vm_unmap_aliases();
 
-	resize_hpt_for_hotplug(memblock_phys_mem_size());
+	if (resize_hpt_for_hotplug(memblock_phys_mem_size()) == -ENOSPC)
+		pr_warn("Hash collision while resizing HPT\n");
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index f2a9f0adc2d3..b407034a80ba 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -918,7 +918,6 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 	if (rc != 0) {
 		switch (state.commit_rc) {
 		case H_PTEG_FULL:
-			pr_warn("Hash collision while resizing HPT\n");
 			return -ENOSPC;
 
 		default:
-- 
2.20.1

