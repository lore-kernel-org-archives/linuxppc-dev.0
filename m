Return-Path: <SRS0=ASHh=5B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6776C0044D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 15:30:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F7820674
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2020 15:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pXCJ3nPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F7820674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48h0cZ0dGGzDqH2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2020 02:30:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=pXCJ3nPV; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48gwll0Qy2zDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2020 23:36:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48gwlb1cPCz9v02g;
 Mon, 16 Mar 2020 13:36:27 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pXCJ3nPV; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4vTW1xe9IS24; Mon, 16 Mar 2020 13:36:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48gwlb0Ws9z9v02f;
 Mon, 16 Mar 2020 13:36:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1584362187; bh=IQAE5xsf4JKfTQvGnWUT3Dq95zXpNWlpks4QGKGDZUk=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=pXCJ3nPVXiFic4gAs5SGg7NC2PocLDXTkzFT/n1fflMj0yCQoicNNTpXQVXVJYGMm
 I0VCqPtDE+xldEV24rygH9f3mioc60MDQgli1G20nFkHI5xwpH65pJENt0iCNTKAob
 XFJSlzPJ4mcs/UxbDkh8SN0AqMVGvtwzBqvfvZzo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ADDE18B7D0;
 Mon, 16 Mar 2020 13:36:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id nb2XzBIaXayj; Mon, 16 Mar 2020 13:36:31 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 900308B7CB;
 Mon, 16 Mar 2020 13:36:31 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8004965595; Mon, 16 Mar 2020 12:36:31 +0000 (UTC)
Message-Id: <08f37b5315c5d8029c066d0ffecd3439003b18ae.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 45/46] powerpc/32s: Allow mapping with BATs with
 DEBUG_PAGEALLOC
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 16 Mar 2020 12:36:31 +0000 (UTC)
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

DEBUG_PAGEALLOC only manages RW data.

Text and RO data can still be mapped with BATs.

In order to map with BATs, also enforce data alignment. Set
by default to 256M which is a good compromise for keeping
enough BATs for also KASAN and IMMR.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig           | 1 +
 arch/powerpc/mm/book3s32/mmu.c | 6 ++++++
 arch/powerpc/mm/init_32.c      | 5 ++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c086992573d3..44c490e05954 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -793,6 +793,7 @@ config DATA_SHIFT
 	range 17 28 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC) && PPC_BOOK3S_32
 	range 19 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC) && PPC_8xx
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	default 18 if DEBUG_PAGEALLOC && PPC_BOOK3S_32
 	default 23 if STRICT_KERNEL_RWX && PPC_8xx
 	default 23 if DEBUG_PAGEALLOC && PPC_8xx && PIN_TLB_DATA
 	default 19 if DEBUG_PAGEALLOC && PPC_8xx
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index a9b2cbc74797..a6dcc708eee3 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -170,6 +170,12 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 		pr_debug("RAM mapped without BATs\n");
 		return base;
 	}
+	if (debug_pagealloc_enabled()) {
+		if (base >= border)
+			return base;
+		if (top >= border)
+			top = border;
+	}
 
 	if (!strict_kernel_rwx_enabled() || base >= border || top <= border)
 		return __mmu_mapin_ram(base, top);
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 8977a7c2543d..36c39bd37256 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -99,10 +99,9 @@ static void __init MMU_setup(void)
 	if (IS_ENABLED(CONFIG_PPC_8xx))
 		return;
 
-	if (debug_pagealloc_enabled()) {
-		__map_without_bats = 1;
+	if (debug_pagealloc_enabled())
 		__map_without_ltlbs = 1;
-	}
+
 	if (strict_kernel_rwx_enabled())
 		__map_without_ltlbs = 1;
 }
-- 
2.25.0

