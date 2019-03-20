Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895CEC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:32:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D5A2184D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pH6K6byf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D5A2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PR7n6lRRzDqLH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:32:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="pH6K6byf"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZ60r0BzDqJm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:06:54 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQZ14spjz9vC09;
 Wed, 20 Mar 2019 11:06:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pH6K6byf; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id rm1OuaKwZsaW; Wed, 20 Mar 2019 11:06:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ13Qmzz9vByx;
 Wed, 20 Mar 2019 11:06:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076409; bh=t0kkxTub/kcz/F2MguVs5Is4DUYFRq4Gpf8iL+QZExY=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=pH6K6byfU8ShZCb7j0RQ+HxrE7Hz8YEPkTTpPMpLkfuWIOANCPAVKlF4JCCslq22S
 45mphDoLWv1wNzmmD23TJskg8PMcPVUsljJ5GTEi+Eebv8xHBk/qHzEkhzXx177exv
 9FnhoJxyeg+BYF+h3GaxbGvxpitcV7LG12fCJY6g=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DC958B919;
 Wed, 20 Mar 2019 11:06:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qvO1rlrvClrD; Wed, 20 Mar 2019 11:06:50 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 699508B911;
 Wed, 20 Mar 2019 11:06:50 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 489A363AEF; Wed, 20 Mar 2019 10:06:50 +0000 (UTC)
Message-Id: <3dd101cd372c13d0f1b8687f1b9553cc518af7f0.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 14/27] powerpc/mm: no slice for nohash/64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:50 +0000 (UTC)
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

Only nohash/32 and book3s/64 support mm slices.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/64/slice.h | 7 -------
 arch/powerpc/include/asm/slice.h           | 4 +---
 arch/powerpc/platforms/Kconfig.cputype     | 4 ++++
 3 files changed, 5 insertions(+), 10 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/nohash/64/slice.h

diff --git a/arch/powerpc/include/asm/nohash/64/slice.h b/arch/powerpc/include/asm/nohash/64/slice.h
deleted file mode 100644
index 30adfdd4afde..000000000000
--- a/arch/powerpc/include/asm/nohash/64/slice.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_NOHASH_64_SLICE_H
-#define _ASM_POWERPC_NOHASH_64_SLICE_H
-
-#define get_slice_psize(mm, addr)	MMU_PAGE_4K
-
-#endif /* _ASM_POWERPC_NOHASH_64_SLICE_H */
diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index d85c85422fdf..49d950a14e25 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -4,9 +4,7 @@
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/slice.h>
-#elif defined(CONFIG_PPC64)
-#include <asm/nohash/64/slice.h>
-#elif defined(CONFIG_PPC_MMU_NOHASH)
+#elif defined(CONFIG_PPC_MMU_NOHASH_32)
 #include <asm/nohash/32/slice.h>
 #endif
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 842b2c7e156a..51ceeb046867 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -354,6 +354,10 @@ config PPC_MMU_NOHASH
 	def_bool y
 	depends on !PPC_BOOK3S
 
+config PPC_MMU_NOHASH_32
+	def_bool y
+	depends on PPC_MMU_NOHASH && PPC32
+
 config PPC_BOOK3E_MMU
 	def_bool y
 	depends on FSL_BOOKE || PPC_BOOK3E
-- 
2.13.3

