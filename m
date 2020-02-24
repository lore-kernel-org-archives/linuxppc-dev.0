Return-Path: <SRS0=vDV2=4M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6894EC3567B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 05:09:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F38320658
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 05:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F38320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Qqqq0BqxzDqKX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Feb 2020 16:09:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 48Qqj50RX1zDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2020 16:03:52 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 453EAFEC;
 Sun, 23 Feb 2020 21:03:51 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com
 [10.162.16.95])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 175423F534;
 Sun, 23 Feb 2020 21:03:45 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] mm/vma: Replace all remaining open encodings with
 is_vm_hugetlb_page()
Date: Mon, 24 Feb 2020 10:33:12 +0530
Message-Id: <1582520593-30704-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
References: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
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
Cc: kvm-ppc@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Nick Piggin <npiggin@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This replaces all remaining open encodings with is_vm_hugetlb_page().

Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/powerpc/kvm/e500_mmu_host.c | 2 +-
 fs/binfmt_elf.c                  | 3 ++-
 include/asm-generic/tlb.h        | 3 ++-
 kernel/events/core.c             | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 425d13806645..df9989cf7ba3 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -422,7 +422,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 				break;
 			}
 		} else if (vma && hva >= vma->vm_start &&
-			   (vma->vm_flags & VM_HUGETLB)) {
+			   is_vm_hugetlb_page(vma)) {
 			unsigned long psize = vma_kernel_pagesize(vma);
 
 			tsize = (gtlbe->mas1 & MAS1_TSIZE_MASK) >>
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f4713ea76e82..1eb63867e266 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -27,6 +27,7 @@
 #include <linux/highuid.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
+#include <linux/hugetlb.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
 #include <linux/security.h>
@@ -1317,7 +1318,7 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	}
 
 	/* Hugetlb memory check */
-	if (vma->vm_flags & VM_HUGETLB) {
+	if (is_vm_hugetlb_page(vma)) {
 		if ((vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_SHARED))
 			goto whole;
 		if (!(vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_PRIVATE))
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index f391f6b500b4..3f1649a8cf55 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -13,6 +13,7 @@
 
 #include <linux/mmu_notifier.h>
 #include <linux/swap.h>
+#include <linux/hugetlb_inline.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
@@ -398,7 +399,7 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
 	 * We rely on tlb_end_vma() to issue a flush, such that when we reset
 	 * these values the batch is empty.
 	 */
-	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
+	tlb->vma_huge = is_vm_hugetlb_page(vma);
 	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
 }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e453589da97c..ef5be3ed0580 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -28,6 +28,7 @@
 #include <linux/export.h>
 #include <linux/vmalloc.h>
 #include <linux/hardirq.h>
+#include <linux/hugetlb.h>
 #include <linux/rculist.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -7693,7 +7694,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		flags |= MAP_EXECUTABLE;
 	if (vma->vm_flags & VM_LOCKED)
 		flags |= MAP_LOCKED;
-	if (vma->vm_flags & VM_HUGETLB)
+	if (is_vm_hugetlb_page(vma))
 		flags |= MAP_HUGETLB;
 
 	if (file) {
-- 
2.20.1

