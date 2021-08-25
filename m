Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19164C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 13:35:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2E160F92
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 13:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B2E160F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gvn6G708Sz304y
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 23:35:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gvn5n2Kvhz2xYT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Aug 2021 23:34:49 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4Gvn5d6S7Kz9sTj;
 Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xfO4z1aiVt8q; Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4Gvn5d5WY9z9sTW;
 Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A348F8B85B;
 Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id JgIVHkcI2S1c; Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BD9B8B858;
 Wed, 25 Aug 2021 15:34:45 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 29D996BC7B; Wed, 25 Aug 2021 13:34:45 +0000 (UTC)
Message-Id: <c5a07fadea33d640ad10cecf0ac8faaec1c524e0.1629898474.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc: Redefine HMT_xxx macros as empty on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 25 Aug 2021 13:34:45 +0000 (UTC)
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

HMT_xxx macros are macros for adjusting thread priority
(hardware multi-threading) are macros inherited from PPC64
via commit 5f7c690728ac ("[PATCH] powerpc: Merged ppc_asm.h")

Those instructions are pointless on PPC32, but some common
fonctions like arch_cpu_idle() use them.

So make them empty on PPC32 to avoid those instructions.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/processor.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
index e072577bc7c0..8d79f994b4aa 100644
--- a/arch/powerpc/include/asm/vdso/processor.h
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -5,12 +5,21 @@
 #ifndef __ASSEMBLY__
 
 /* Macros for adjusting thread priority (hardware multi-threading) */
+#ifdef CONFIG_PPC64
 #define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
 #define HMT_low()		asm volatile("or 1, 1, 1	# low priority")
 #define HMT_medium_low()	asm volatile("or 6, 6, 6	# medium low priority")
 #define HMT_medium()		asm volatile("or 2, 2, 2	# medium priority")
 #define HMT_medium_high()	asm volatile("or 5, 5, 5	# medium high priority")
 #define HMT_high()		asm volatile("or 3, 3, 3	# high priority")
+#else
+#define HMT_very_low()
+#define HMT_low()
+#define HMT_medium_low()
+#define HMT_medium()
+#define HMT_medium_high()
+#define HMT_high()
+#endif
 
 #ifdef CONFIG_PPC64
 #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
-- 
2.25.0

