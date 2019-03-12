Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA9C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:32:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AB42077B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="fQXoenqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AB42077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JqV83zwqzDqJC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:32:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="fQXoenqm"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jq7R29vtzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:16:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Jq7M26gczB09Zt;
 Tue, 12 Mar 2019 23:16:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=fQXoenqm; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EGUj0-8sqf2W; Tue, 12 Mar 2019 23:16:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Jq7M0xDPzB09ZG;
 Tue, 12 Mar 2019 23:16:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552428975; bh=mIGQaprlAVCVWpPiH4xPJkXAyE92iR9cx2tnTNWnRqU=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=fQXoenqm0P/pOBebO8hAN+jBJviFvKS7NXJNClJzbO3yPlr+BfXpE8olkWTXIqIWQ
 JN4rPm6po/CtsDbWm5giWD1Hx5PvyEod2zciYPIVeO/nz0+M9vTpVKFX7HC4z29YHC
 e+lOdfyIVMx63wfeVNhLjHiwFYAKkEecDGoICk24=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 571DD8B8B1;
 Tue, 12 Mar 2019 23:16:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id aG88fi4S6WiR; Tue, 12 Mar 2019 23:16:15 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A8BC8B8A7;
 Tue, 12 Mar 2019 23:16:15 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D9B0D6FA15; Tue, 12 Mar 2019 22:16:14 +0000 (UTC)
Message-Id: <9ddd549404655be32ea511fc055f50bc168bb30d.1552428161.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552428161.git.christophe.leroy@c-s.fr>
References: <cover.1552428161.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v10 09/18] powerpc/32: prepare shadow area for KASAN
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Tue, 12 Mar 2019 22:16:14 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch prepares a shadow area for KASAN.

The shadow area will be at the top of the kernel virtual
memory space above the fixmap area and will occupy one
eighth of the total kernel virtual memory space.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig.debug        |  5 +++++
 arch/powerpc/include/asm/fixmap.h |  5 +++++
 arch/powerpc/include/asm/kasan.h  | 16 ++++++++++++++++
 arch/powerpc/mm/mem.c             |  4 ++++
 arch/powerpc/mm/ptdump/ptdump.c   |  8 ++++++++
 5 files changed, 38 insertions(+)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 4e00cb0a5464..61febbbdd02b 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -366,3 +366,8 @@ config PPC_FAST_ENDIAN_SWITCH
         depends on DEBUG_KERNEL && PPC_BOOK3S_64
         help
 	  If you're unsure what this is, say N.
+
+config KASAN_SHADOW_OFFSET
+	hex
+	depends on KASAN
+	default 0xe0000000
diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index b9fbed84ddca..0cfc365d814b 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -22,7 +22,12 @@
 #include <asm/kmap_types.h>
 #endif
 
+#ifdef CONFIG_KASAN
+#include <asm/kasan.h>
+#define FIXADDR_TOP	(KASAN_SHADOW_START - PAGE_SIZE)
+#else
 #define FIXADDR_TOP	((unsigned long)(-PAGE_SIZE))
+#endif
 
 /*
  * Here we define all the compile-time 'special' virtual
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index 2c179a39d4ba..05274dea3109 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -12,4 +12,20 @@
 #define EXPORT_SYMBOL_KASAN(fn)
 #endif
 
+#ifndef __ASSEMBLY__
+
+#include <asm/page.h>
+
+#define KASAN_SHADOW_SCALE_SHIFT	3
+
+#define KASAN_SHADOW_START	(KASAN_SHADOW_OFFSET + \
+				 (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
+
+#define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
+
+#define KASAN_SHADOW_END	0UL
+
+#define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
+
+#endif /* __ASSEMBLY */
 #endif
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f6787f90e158..4e7fa4eb2dd3 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -309,6 +309,10 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 #ifdef CONFIG_PPC32
 	pr_info("Kernel virtual memory layout:\n");
+#ifdef CONFIG_KASAN
+	pr_info("  * 0x%08lx..0x%08lx  : kasan shadow mem\n",
+		KASAN_SHADOW_START, KASAN_SHADOW_END);
+#endif
 	pr_info("  * 0x%08lx..0x%08lx  : fixmap\n", FIXADDR_START, FIXADDR_TOP);
 #ifdef CONFIG_HIGHMEM
 	pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 37138428ab55..812ed680024f 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -101,6 +101,10 @@ static struct addr_marker address_markers[] = {
 	{ 0,	"Fixmap start" },
 	{ 0,	"Fixmap end" },
 #endif
+#ifdef CONFIG_KASAN
+	{ 0,	"kasan shadow mem start" },
+	{ 0,	"kasan shadow mem end" },
+#endif
 	{ -1,	NULL },
 };
 
@@ -322,6 +326,10 @@ static void populate_markers(void)
 #endif
 	address_markers[i++].start_address = FIXADDR_START;
 	address_markers[i++].start_address = FIXADDR_TOP;
+#ifdef CONFIG_KASAN
+	address_markers[i++].start_address = KASAN_SHADOW_START;
+	address_markers[i++].start_address = KASAN_SHADOW_END;
+#endif
 #endif /* CONFIG_PPC64 */
 }
 
-- 
2.13.3

