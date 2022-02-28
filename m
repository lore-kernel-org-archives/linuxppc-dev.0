Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF28C43217
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Feb 2022 10:54:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K6cgs6vrgz3cgL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Feb 2022 21:54:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4K6cbm4b7bz3cgx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Feb 2022 21:50:28 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E3C41063;
 Mon, 28 Feb 2022 02:50:27 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.185])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 73D0F3F73D;
 Mon, 28 Feb 2022 02:50:19 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: [PATCH V3 12/30] mm/mmap: Drop arch_filter_pgprot()
Date: Mon, 28 Feb 2022 16:17:35 +0530
Message-Id: <1646045273-9343-13-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-csky@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 geert@linux-m68k.org, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There are no platforms left which subscribe ARCH_HAS_FILTER_PGPROT. Hence
just drop arch_filter_pgprot() and also the config ARCH_HAS_FILTER_PGPROT.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/Kconfig |  3 ---
 mm/mmap.c  | 10 +---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index fa436478a94c..212fb6e1ddaa 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -744,9 +744,6 @@ config IDLE_PAGE_TRACKING
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
-config ARCH_HAS_FILTER_PGPROT
-	bool
-
 config ARCH_HAS_VM_GET_PAGE_PROT
 	bool
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 78eeac277a80..c8fd8f06bf7c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,14 +102,6 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
-
-#ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
-static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
-{
-	return prot;
-}
-#endif
-
 static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
 {
 	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
@@ -155,7 +147,7 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)
 	pgprot_t ret = __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
 
-	return arch_filter_pgprot(ret);
+	return ret;
 }
 EXPORT_SYMBOL(vm_get_page_prot);
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
-- 
2.25.1

