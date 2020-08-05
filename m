Return-Path: <SRS0=7j3x=BP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE793C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 15:29:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDFDA2333F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 15:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFDA2333F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BMFt34RVYzDqfD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 01:29:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BMFqY36DBzDqch
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2020 01:27:34 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BMFqN1M0jz9vD3y;
 Wed,  5 Aug 2020 17:27:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id FrQjfHC17EgI; Wed,  5 Aug 2020 17:27:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BMFqN0Yv4z9vD3n;
 Wed,  5 Aug 2020 17:27:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BC418B7ED;
 Wed,  5 Aug 2020 17:27:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1ILtOrr_uo5w; Wed,  5 Aug 2020 17:27:30 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F2CCD8B7EC;
 Wed,  5 Aug 2020 17:27:29 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C654A65BC2; Wed,  5 Aug 2020 15:27:29 +0000 (UTC)
Message-Id: <6eddca2d5611fd57312a88eae31278c87a8fc99d.1596641224.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/kasan: Fix KASAN_SHADOW_START on BOOK3S_32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed,  5 Aug 2020 15:27:29 +0000 (UTC)
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

On BOOK3S_32, when we have modules and strict kernel RWX, modules
are not in vmalloc space but in a dedicated segment that is
below PAGE_OFFSET.

So KASAN_SHADOW_START must take it into account.

MODULES_VADDR can't be used because it is not defined yet
in kasan.h

Fixes: 6ca055322da8 ("powerpc/32s: Use dedicated segment for modules with STRICT_KERNEL_RWX")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kasan.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index d635b96c7ea6..7355ed05e65e 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -15,11 +15,18 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/page.h>
+#include <linux/sizes.h>
 
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
+#if defined(CONFIG_PPC_BOOK3S_32) && defined(CONFIG_MODULES) && defined(CONFIG_STRICT_KERNEL_RWX)
+#define KASAN_KERN_START	ALIGN_DOWN(PAGE_OFFSET - SZ_256M, SZ_256M)
+#else
+#define KASAN_KERN_START	PAGE_OFFSET
+#endif
+
 #define KASAN_SHADOW_START	(KASAN_SHADOW_OFFSET + \
-				 (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
+				 (KASAN_KERN_START >> KASAN_SHADOW_SCALE_SHIFT))
 
 #define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
 
-- 
2.25.0

