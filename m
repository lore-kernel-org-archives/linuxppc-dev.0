Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B581C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:29:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05202077B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VxhFAYYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05202077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4454Kc5C3GzDqSY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 06:29:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="VxhFAYYL"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4453sv16kPzDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:08:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4453sr1Htxz9v9DH;
 Thu, 21 Feb 2019 20:08:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=VxhFAYYL; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id hqxJ4phjcETZ; Thu, 21 Feb 2019 20:08:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4453sr038yz9v9DG;
 Thu, 21 Feb 2019 20:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550776128; bh=02ljiBkmcqq7HcRxan5DntP8oMfjS88LVnUYOxruHkQ=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=VxhFAYYLSmGaGQFcOpAYoWY/29Q0q+2/me9UNpzKdEfakVHh6882R3TWGPpSOHLdA
 xDXw/umTYysAumVokx8C9hrUWfpzf0XYgR9eZCPDdDn3hpvqNNL6tS5kFb0/5/Jbo3
 LBOLZBy3ESUEjQbnQKpHUWRiP2pLbXXb8tt0Q16M=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 079F48B86A;
 Thu, 21 Feb 2019 20:08:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 851xaWu4prLf; Thu, 21 Feb 2019 20:08:47 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CFA618B852;
 Thu, 21 Feb 2019 20:08:47 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A3A626EF61; Thu, 21 Feb 2019 19:08:47 +0000 (UTC)
Message-Id: <ba19b60d4f1ecdd56e33363dc611473338226f5e.1550775950.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550775950.git.christophe.leroy@c-s.fr>
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 11/16] powerpc/kconfig: define CONFIG_DATA_SHIFT and
 CONFIG_ETEXT_SHIFT
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 21 Feb 2019 19:08:47 +0000 (UTC)
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
index 417e52a27f63..edef40a2b446 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -725,6 +725,15 @@ config THREAD_SHIFT
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
index c3efb972c8c1..060a1acd7c6d 100644
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

