Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F49FC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 16:58:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCEB20827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 16:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCEB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qt0M27C2zF3Fj
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 03:58:27 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qsy96Kk9zF3J6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 03:56:33 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42qsy36b00z9tvqp;
 Wed,  7 Nov 2018 17:56:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Wo8dxnek3jUP; Wed,  7 Nov 2018 17:56:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42qsy35ypCz9tvqG;
 Wed,  7 Nov 2018 17:56:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E578C8B81E;
 Wed,  7 Nov 2018 17:56:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id acCZl8H1qinV; Wed,  7 Nov 2018 17:56:29 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B4898B815;
 Wed,  7 Nov 2018 17:56:29 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 526C66995E; Wed,  7 Nov 2018 16:56:29 +0000 (UTC)
Message-Id: <eae47d2c694537abe3769a18828d5c93f6bcf1ce.1541568127.git.christophe.leroy@c-s.fr>
In-Reply-To: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
References: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 2/6] powerpc: Add framework for Kernel Userspace
 Protection
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 ruscur@russell.cc
Date: Wed,  7 Nov 2018 16:56:29 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds a skeleton for Kernel Userspace Protection
functionnalities like Kernel Userspace Access Protection and
Kernel Userspace Execution Prevention

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h | 2 ++
 arch/powerpc/kernel/setup_64.c | 1 +
 arch/powerpc/mm/init-common.c  | 4 ++++
 arch/powerpc/mm/init_32.c      | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index eb20eb3b8fb0..39c51dcba8f4 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -268,6 +268,8 @@ static inline u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
 }
 #endif /* CONFIG_PPC_MEM_KEYS */
 
+void setup_kup(void);
+
 #endif /* !__ASSEMBLY__ */
 
 /* The kernel use the constants below to index in the page sizes array.
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2a51e4cc8246..4e21b10ff38d 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -372,6 +372,7 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	btext_map();
 #endif /* CONFIG_PPC_EARLY_DEBUG_BOOTX */
+	setup_kup();
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2b656e67f2ea..e469814e8290 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -25,6 +25,10 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
+void setup_kup(void)
+{
+}
+
 static void pgd_ctor(void *addr)
 {
 	memset(addr, 0, PGD_TABLE_SIZE);
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 3e59e5d64b01..4012ee6f0754 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -182,6 +182,8 @@ void __init MMU_init(void)
 	btext_unmap();
 #endif
 
+	setup_kup();
+
 	/* Shortly after that, the entire linear mapping will be available */
 	memblock_set_current_limit(lowmem_end_addr);
 }
-- 
2.13.3

