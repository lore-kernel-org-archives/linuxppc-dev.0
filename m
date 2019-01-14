Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7C5C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:40:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDE7206DD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDE7206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dF4Y3HFMzDqQd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:40:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dF2l0PyNzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 11:38:54 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 5E93AAE80001;
 Sun, 13 Jan 2019 19:38:51 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] KVM: PPC: Fix compile when CONFIG_PPC_RADIX_MMU is not
 defined
Date: Mon, 14 Jan 2019 11:38:49 +1100
Message-Id: <20190114003849.130240-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds some stubs for hash only configs.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 .../include/asm/book3s/64/tlbflush-radix.h    | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index 671316f..05147cec 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -13,8 +13,32 @@ static inline int mmu_get_ap(int psize)
 
 #ifdef CONFIG_PPC_RADIX_MMU
 extern void radix__tlbiel_all(unsigned int action);
+extern void radix__flush_tlb_lpid_page(unsigned int lpid,
+					unsigned long addr,
+					unsigned long page_size);
+extern void radix__flush_pwc_lpid(unsigned int lpid);
+extern void radix__flush_tlb_lpid(unsigned int lpid);
+extern void radix__local_flush_tlb_lpid_guest(unsigned int lpid);
 #else
 static inline void radix__tlbiel_all(unsigned int action) { WARN_ON(1); };
+static inline void radix__flush_tlb_lpid_page(unsigned int lpid,
+					unsigned long addr,
+					unsigned long page_size)
+{
+	WARN_ON(1);
+}
+static inline void radix__flush_pwc_lpid(unsigned int lpid)
+{
+	WARN_ON(1);
+}
+static inline void radix__flush_tlb_lpid(unsigned int lpid)
+{
+	WARN_ON(1);
+}
+static inline void radix__local_flush_tlb_lpid_guest(unsigned int lpid)
+{
+	WARN_ON(1);
+}
 #endif
 
 extern void radix__flush_hugetlb_tlb_range(struct vm_area_struct *vma,
@@ -49,12 +73,6 @@ extern void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr);
 extern void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr);
 extern void radix__flush_tlb_all(void);
 
-extern void radix__flush_tlb_lpid_page(unsigned int lpid,
-					unsigned long addr,
-					unsigned long page_size);
-extern void radix__flush_pwc_lpid(unsigned int lpid);
-extern void radix__flush_tlb_lpid(unsigned int lpid);
 extern void radix__local_flush_tlb_lpid(unsigned int lpid);
-extern void radix__local_flush_tlb_lpid_guest(unsigned int lpid);
 
 #endif
-- 
2.17.1

