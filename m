Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CAEC43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 10:36:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E33E20817
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 10:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E33E20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xs2s3hPmzF3T9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 21:36:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xrnx2gNnzF3jp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 21:25:09 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42xrnp2hy3z9v0hS;
 Sat, 17 Nov 2018 11:25:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id oElvUtjx8A4F; Sat, 17 Nov 2018 11:25:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42xrnp27khz9v0XX;
 Sat, 17 Nov 2018 11:25:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C5818B78A;
 Sat, 17 Nov 2018 11:25:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id JA7lDXKsOgyw; Sat, 17 Nov 2018 11:25:05 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2EB6F8B74B;
 Sat, 17 Nov 2018 11:25:05 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F322A69A6C; Sat, 17 Nov 2018 10:25:04 +0000 (UTC)
Message-Id: <ba5bd02921ca792a47b61457ccf53fe7af767e6d.1542395798.git.christophe.leroy@c-s.fr>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/7] powerpc: change CONFIG_PPC_STD_MMU to CONFIG_PPC_BOOK3S
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 rjw@rjwysocki.net, viresh.kumar@linaro.org
Date: Sat, 17 Nov 2018 10:25:04 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Today we have:

config PPC_BOOK3S
        def_bool y
        depends on PPC_BOOK3S_32 || PPC_BOOK3S_64

config PPC_STD_MMU
        def_bool y
        depends on PPC_BOOK3S

PPC_STD_MMU is therefore redundant with PPC_BOOK3S. Lets remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile | 2 +-
 arch/powerpc/mm/fault.c  | 4 ++--
 arch/powerpc/mm/mem.c    | 4 ++--
 arch/powerpc/xmon/xmon.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 5cc9643d2e0c..1adc3d8a89cc 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
-obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
+obj-$(CONFIG_PPC_BOOK3S)	+= tlb_hash$(BITS).o
 ifdef CONFIG_PPC_BOOK3S_64
 obj-$(CONFIG_PPC_4K_PAGES)	+= hash64_4k.o
 obj-$(CONFIG_PPC_64K_PAGES)	+= hash64_64k.o
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 1697e903bbf2..01b9bcc7fa85 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -341,7 +341,7 @@ static inline void cmo_account_page_fault(void)
 static inline void cmo_account_page_fault(void) { }
 #endif /* CONFIG_PPC_SMLPAR */
 
-#ifdef CONFIG_PPC_STD_MMU
+#ifdef CONFIG_PPC_BOOK3S
 static void sanity_check_fault(bool is_write, unsigned long error_code)
 {
 	/*
@@ -378,7 +378,7 @@ static void sanity_check_fault(bool is_write, unsigned long error_code)
 }
 #else
 static void sanity_check_fault(bool is_write, unsigned long error_code) { }
-#endif /* CONFIG_PPC_STD_MMU */
+#endif /* CONFIG_PPC_BOOK3S */
 
 /*
  * Define the correct "is_write" bit in error_code based
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 0a64fffabee1..065c37d54b49 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -503,7 +503,7 @@ EXPORT_SYMBOL(flush_icache_user_range);
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep)
 {
-#ifdef CONFIG_PPC_STD_MMU
+#ifdef CONFIG_PPC_BOOK3S
 	/*
 	 * We don't need to worry about _PAGE_PRESENT here because we are
 	 * called with either mm->page_table_lock held or ptl lock held
@@ -541,7 +541,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	}
 
 	hash_preload(vma->vm_mm, address, is_exec, trap);
-#endif /* CONFIG_PPC_STD_MMU */
+#endif /* CONFIG_PPC_BOOK3S */
 #if (defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_FSL_BOOK3E)) \
 	&& defined(CONFIG_HUGETLB_PAGE)
 	if (is_vm_hugetlb_page(vma))
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 79fa45df1eee..4e71b854838f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1058,7 +1058,7 @@ cmds(struct pt_regs *excp)
 		case 'P':
 			show_tasks();
 			break;
-#ifdef CONFIG_PPC_STD_MMU
+#ifdef CONFIG_PPC_BOOK3S
 		case 'u':
 			dump_segments();
 			break;
-- 
2.13.3

