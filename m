Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE027C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 17:10:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D7120811
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 17:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D7120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xPr02hsLzF3q5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 04:10:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xPnM65HPzF3ng
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 04:08:07 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42xPnG2Khwz9vF72;
 Fri, 16 Nov 2018 18:08:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id TxI24c6A5i8M; Fri, 16 Nov 2018 18:08:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42xPnG1sMdz9vF6m;
 Fri, 16 Nov 2018 18:08:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F2B58B91D;
 Fri, 16 Nov 2018 18:08:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id yxikudVm--Oq; Fri, 16 Nov 2018 18:08:04 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 06A708B8C0;
 Fri, 16 Nov 2018 18:08:04 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id EE7E469A5D; Fri, 16 Nov 2018 17:08:03 +0000 (UTC)
Message-Id: <e30942451ce1893d839c4b6f9dcab1e230d2cbfb.1542388044.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: Eliminate not possible mmu features at compile
 time
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 16 Nov 2018 17:08:03 +0000 (UTC)
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

Depending on the CONFIG selected, many of the MMU features are
not possible. Lets only get the possible ones in MMU_FTRS_POSSIBLE.

This allows gcc to get rid at compile time of code related to
not possible features.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index eb20eb3b8fb0..b13d8e571dd9 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -131,16 +131,37 @@ DECLARE_PER_CPU(int, next_tlbcam_idx);
 #endif
 
 enum {
-	MMU_FTRS_POSSIBLE = MMU_FTR_HPTE_TABLE | MMU_FTR_TYPE_8xx |
-		MMU_FTR_TYPE_40x | MMU_FTR_TYPE_44x | MMU_FTR_TYPE_FSL_E |
-		MMU_FTR_TYPE_47x | MMU_FTR_USE_HIGH_BATS | MMU_FTR_BIG_PHYS |
-		MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_USE_TLBILX |
-		MMU_FTR_LOCK_BCAST_INVAL | MMU_FTR_NEED_DTLB_SW_LRU |
+	MMU_FTRS_POSSIBLE =
+#ifdef CONFIG_PPC_BOOK3S
+		MMU_FTR_HPTE_TABLE |
+#endif
+#ifdef CONFIG_PPC_8xx
+		MMU_FTR_TYPE_8xx |
+#endif
+#ifdef CONFIG_40x
+		MMU_FTR_TYPE_40x |
+#endif
+#ifdef CONFIG_44x
+		MMU_FTR_TYPE_44x |
+#endif
+#if defined(CONFIG_E200) || defined(CONFIG_E500)
+		MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS | MMU_FTR_USE_TLBILX |
+#endif
+#ifdef CONFIG_PPC_47x
+		MMU_FTR_TYPE_47x | MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL |
+#endif
+#ifdef CONFIG_PPC_BOOK3S_32
+		MMU_FTR_USE_HIGH_BATS | MMU_FTR_NEED_DTLB_SW_LRU |
+#endif
+#ifdef CONFIG_PPC_BOOK3E_64
 		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
 		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
 		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
 		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
 		MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA |
+#endif
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_TYPE_RADIX |
 #endif
-- 
2.13.3

