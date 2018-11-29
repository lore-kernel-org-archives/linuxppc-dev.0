Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E7CC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:23:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E0D20868
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 19:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E0D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435S953Z6xzDr4M
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 06:23:05 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 435RgH5zYRzDrFF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 06:00:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 435RgD4sPqz9v12C;
 Thu, 29 Nov 2018 20:00:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id AHGpkFLAGPJx; Thu, 29 Nov 2018 20:00:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 435RgD4L9Sz9v11y;
 Thu, 29 Nov 2018 20:00:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 740288B912;
 Thu, 29 Nov 2018 20:00:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dP4yoVakuMrk; Thu, 29 Nov 2018 20:00:39 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F30C8B90F;
 Thu, 29 Nov 2018 20:00:33 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8ADAC69B63; Thu, 29 Nov 2018 19:00:32 +0000 (UTC)
Message-Id: <aa90e128e9822dc0f43f42941f339ae5edca9c63.1543517818.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543517818.git.christophe.leroy@c-s.fr>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 11/13] powerpc/kconfig: define CONFIG_DATA_SHIFT and
 CONFIG_ETEXT_SHIFT
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 29 Nov 2018 19:00:32 +0000 (UTC)
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

CONFIG_STRICT_KERNEL_RWX requires a special alignment
for DATA for some subarches. Today it is just defined
as an #ifdef in vmlinux.lds.S

In order to get more flexibility, this patch moves the
definition of this alignment in Kconfig

On some subarches, CONFIG_STRICT_KERNEL_RWX will
require a special alignment of _etext.

This patch also adds a configuration item for it in Kconfig

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig              | 9 +++++++++
 arch/powerpc/kernel/vmlinux.lds.S | 9 +++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4a81a80d0635..f3e420f3f1d7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -728,6 +728,15 @@ config THREAD_SHIFT
 	  Used to define the stack size. The default is almost always what you
 	  want. Only change this if you know what you are doing.
 
+config ETEXT_SHIFT
+	int
+	default PPC_PAGE_SHIFT
+
+config DATA_SHIFT
+	int
+	default 24 if STRICT_KERNEL_RWX && PPC64
+	default PPC_PAGE_SHIFT
+
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 8 9 if PPC64 && PPC_64K_PAGES
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 1148c3c60c3b..d210dcfe915a 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -12,11 +12,8 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 
-#if defined(CONFIG_STRICT_KERNEL_RWX) && !defined(CONFIG_PPC32)
-#define STRICT_ALIGN_SIZE	(1 << 24)
-#else
-#define STRICT_ALIGN_SIZE	PAGE_SIZE
-#endif
+#define STRICT_ALIGN_SIZE	(1 << CONFIG_DATA_SHIFT)
+#define ETEXT_ALIGN_SIZE	(1 << CONFIG_ETEXT_SHIFT)
 
 ENTRY(_stext)
 
@@ -131,7 +128,7 @@ SECTIONS
 
 	} :kernel
 
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(ETEXT_ALIGN_SIZE);
 	_etext = .;
 	PROVIDE32 (etext = .);
 
-- 
2.13.3

