Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EC7C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:48:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF59920827
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF59920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42s70h2TR9zF37V
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 04:48:04 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42s6gx3yr4zF3bC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 04:33:33 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42s6gm5Mr7z9v0XS;
 Fri,  9 Nov 2018 18:33:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id rj0crbc1WPPR; Fri,  9 Nov 2018 18:33:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42s6gm4tl9z9v0XL;
 Fri,  9 Nov 2018 18:33:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8387C8B899;
 Fri,  9 Nov 2018 18:33:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GxAQMdWs63DK; Fri,  9 Nov 2018 18:33:30 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D46D8B887;
 Fri,  9 Nov 2018 18:33:30 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2CF4A69A2A; Fri,  9 Nov 2018 17:33:30 +0000 (UTC)
Message-Id: <a7c9826fecbafd03fd9ffca6fb24f343f93cab5f.1541784640.git.christophe.leroy@c-s.fr>
In-Reply-To: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
References: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 8/9] powerpc/44x: use patch_sites for TLB handlers patching
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri,  9 Nov 2018 17:33:30 +0000 (UTC)
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

Use patch sites and associated helpers to manage TLB handlers
patching instead of hardcoding.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-44x.h |  3 +++
 arch/powerpc/kernel/head_44x.S     | 11 +++++------
 arch/powerpc/mm/44x_mmu.c          | 14 +++-----------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
index 295b3dbb2698..28aa3b339c5e 100644
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -111,6 +111,9 @@ typedef struct {
 	unsigned long	vdso_base;
 } mm_context_t;
 
+/* patch sites */
+extern s32 patch__tlb_44x_hwater_D, patch__tlb_44x_hwater_I;
+
 #endif /* !__ASSEMBLY__ */
 
 #ifndef CONFIG_PPC_EARLY_DEBUG_44x
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 37e4a7cf0065..bf23c19c92d6 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -40,6 +40,7 @@
 #include <asm/ptrace.h>
 #include <asm/synch.h>
 #include <asm/export.h>
+#include <asm/code-patching-asm.h>
 #include "head_booke.h"
 
 
@@ -382,10 +383,9 @@ interrupt_base:
 	/* Increment, rollover, and store TLB index */
 	addi	r13,r13,1
 
+	patch_site 0f, patch__tlb_44x_hwater_D
 	/* Compare with watermark (instruction gets patched) */
-	.globl tlb_44x_patch_hwater_D
-tlb_44x_patch_hwater_D:
-	cmpwi	0,r13,1			/* reserve entries */
+0:	cmpwi	0,r13,1			/* reserve entries */
 	ble	5f
 	li	r13,0
 5:
@@ -478,10 +478,9 @@ tlb_44x_patch_hwater_D:
 	/* Increment, rollover, and store TLB index */
 	addi	r13,r13,1
 
+	patch_site 0f, patch__tlb_44x_hwater_I
 	/* Compare with watermark (instruction gets patched) */
-	.globl tlb_44x_patch_hwater_I
-tlb_44x_patch_hwater_I:
-	cmpwi	0,r13,1			/* reserve entries */
+0:	cmpwi	0,r13,1			/* reserve entries */
 	ble	5f
 	li	r13,0
 5:
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 12d92518e898..ea2b9af08a48 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -29,6 +29,7 @@
 #include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/cacheflush.h>
+#include <asm/code-patching.h>
 
 #include "mmu_decl.h"
 
@@ -43,22 +44,13 @@ unsigned long tlb_47x_boltmap[1024/8];
 
 static void ppc44x_update_tlb_hwater(void)
 {
-	extern unsigned int tlb_44x_patch_hwater_D[];
-	extern unsigned int tlb_44x_patch_hwater_I[];
-
 	/* The TLB miss handlers hard codes the watermark in a cmpli
 	 * instruction to improve performances rather than loading it
 	 * from the global variable. Thus, we patch the instructions
 	 * in the 2 TLB miss handlers when updating the value
 	 */
-	tlb_44x_patch_hwater_D[0] = (tlb_44x_patch_hwater_D[0] & 0xffff0000) |
-		tlb_44x_hwater;
-	flush_icache_range((unsigned long)&tlb_44x_patch_hwater_D[0],
-			   (unsigned long)&tlb_44x_patch_hwater_D[1]);
-	tlb_44x_patch_hwater_I[0] = (tlb_44x_patch_hwater_I[0] & 0xffff0000) |
-		tlb_44x_hwater;
-	flush_icache_range((unsigned long)&tlb_44x_patch_hwater_I[0],
-			   (unsigned long)&tlb_44x_patch_hwater_I[1]);
+	modify_instruction_site(&patch__tlb_44x_hwater_D, 0xffff, tlb_44x_hwater);
+	modify_instruction_site(&patch__tlb_44x_hwater_I, 0xffff, tlb_44x_hwater);
 }
 
 /*
-- 
2.13.3

