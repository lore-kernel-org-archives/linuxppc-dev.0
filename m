Return-Path: <SRS0=UNki=6E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21158C3815B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 08:22:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D6820BED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 08:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="M262y0AA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D6820BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495KSV1D3PzDqMG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 18:22:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=M262y0AA; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495Jgh17kvzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2020 17:47:12 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 495JgT4PnLz9tyPV;
 Mon, 20 Apr 2020 09:47:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=M262y0AA; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id VBdFqZv-mwsO; Mon, 20 Apr 2020 09:47:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 495JgT3CNPz9tyPS;
 Mon, 20 Apr 2020 09:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1587368821; bh=AJ1N/+HyuH4Cqp5jl/jMd/18yRFzS+fKuSBNXpiE9Ko=;
 h=From:Subject:To:Cc:Date:From;
 b=M262y0AAdU9t16FOH0k/9VlUjpa0fQG99O8NnOY1bGCe5zJJY7Q20Ykc7/7+i0aK4
 pu739PKN0kSzJeZ/PEwJzis1lUDtfRr+uwHI50M3CGDRjwGiL1bor00hb7XeAwLhWG
 QprNwRMx07oZcubeakxaWq3FkUlr4jOyreUmSfLo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 76FF68B77E;
 Mon, 20 Apr 2020 09:47:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iNZ0jAoIIYbL; Mon, 20 Apr 2020 09:47:06 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B5708B77A;
 Mon, 20 Apr 2020 09:47:06 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F254C657B7; Mon, 20 Apr 2020 07:47:05 +0000 (UTC)
Message-Id: <ea599546f2a7771bde551393889e44e6b2632332.1587368807.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32s: Fix build failure with CONFIG_PPC_KUAP_DEBUG
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 20 Apr 2020 07:47:05 +0000 (UTC)
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

gpr2 is not a parametre of kuap_check(), it doesn't exist.

Use gpr instead.

Fixes: a68c31fc01ef ("powerpc/32s: Implement Kernel Userspace Access Protection")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 3c0ba22dc360..db0a1c281587 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -75,7 +75,7 @@
 
 .macro kuap_check	current, gpr
 #ifdef CONFIG_PPC_KUAP_DEBUG
-	lwz	\gpr2, KUAP(thread)
+	lwz	\gpr, KUAP(thread)
 999:	twnei	\gpr, 0
 	EMIT_BUG_ENTRY 999b, __FILE__, __LINE__, (BUGFLAG_WARNING | BUGFLAG_ONCE)
 #endif
-- 
2.25.0

