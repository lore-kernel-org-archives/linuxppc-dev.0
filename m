Return-Path: <SRS0=5PiN=6Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69553C47255
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 13:07:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DED520714
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 13:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DED520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49LLnw6hZYzDqkL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 23:07:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49LJXR1LYjzDqg9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 21:25:59 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49LJXF4fLFz9ty3n;
 Mon, 11 May 2020 13:25:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qQMdqaCHECX0; Mon, 11 May 2020 13:25:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49LJXF3tTpz9ty3g;
 Mon, 11 May 2020 13:25:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DBEE8B7AE;
 Mon, 11 May 2020 13:25:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GZWaFVxa-fd2; Mon, 11 May 2020 13:25:56 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 04D2D8B7AD;
 Mon, 11 May 2020 13:25:56 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id DD77565A09; Mon, 11 May 2020 11:25:55 +0000 (UTC)
Message-Id: <ec4da311ceded09aa0b053c0e3995a06a6e9f65d.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 29/45] powerpc/8xx: Move PPC_PIN_TLB options into 8xx
 Kconfig
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 11 May 2020 11:25:55 +0000 (UTC)
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

PPC_PIN_TLB options are dedicated to the 8xx, move them into
the 8xx Kconfig.

While we are at it, add some text to explain what it does.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig               | 20 ---------------
 arch/powerpc/platforms/8xx/Kconfig | 41 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8324d98728db..f552726c9de2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1226,26 +1226,6 @@ config TASK_SIZE
 	hex "Size of user task space" if TASK_SIZE_BOOL
 	default "0x80000000" if PPC_8xx
 	default "0xc0000000"
-
-config PIN_TLB
-	bool "Pinned Kernel TLBs (860 ONLY)"
-	depends on ADVANCED_OPTIONS && PPC_8xx && \
-		   !DEBUG_PAGEALLOC && !STRICT_KERNEL_RWX
-
-config PIN_TLB_DATA
-	bool "Pinned TLB for DATA"
-	depends on PIN_TLB
-	default y
-
-config PIN_TLB_IMMR
-	bool "Pinned TLB for IMMR"
-	depends on PIN_TLB || PPC_EARLY_DEBUG_CPM
-	default y
-
-config PIN_TLB_TEXT
-	bool "Pinned TLB for TEXT"
-	depends on PIN_TLB
-	default y
 endmenu
 
 if PPC64
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index b37de62d7e7f..0d036cd868ef 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -162,4 +162,45 @@ config UCODE_PATCH
 	default y
 	depends on !NO_UCODE_PATCH
 
+menu "8xx advanced setup"
+	depends on PPC_8xx
+
+config PIN_TLB
+	bool "Pinned Kernel TLBs"
+	depends on ADVANCED_OPTIONS && !DEBUG_PAGEALLOC && !STRICT_KERNEL_RWX
+	help
+	  On the 8xx, we have 32 instruction TLBs and 32 data TLBs. In each
+	  table 4 TLBs can be pinned.
+
+	  It reduces the amount of usable TLBs to 28 (ie by 12%). That's the
+	  reason why we make it selectable.
+
+	  This option does nothing, it just activate the selection of what
+	  to pin.
+
+config PIN_TLB_DATA
+	bool "Pinned TLB for DATA"
+	depends on PIN_TLB
+	default y
+	help
+	  This pins the first 32 Mbytes of memory with 8M pages.
+
+config PIN_TLB_IMMR
+	bool "Pinned TLB for IMMR"
+	depends on PIN_TLB || PPC_EARLY_DEBUG_CPM
+	default y
+	help
+	  This pins the IMMR area with a 512kbytes page. In case
+	  CONFIG_PIN_TLB_DATA is also selected, it will reduce
+	  CONFIG_PIN_TLB_DATA to 24 Mbytes.
+
+config PIN_TLB_TEXT
+	bool "Pinned TLB for TEXT"
+	depends on PIN_TLB
+	default y
+	help
+	  This pins kernel text with 8M pages.
+
+endmenu
+
 endmenu
-- 
2.25.0

