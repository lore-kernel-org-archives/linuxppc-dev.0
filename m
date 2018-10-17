Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512CECDE30
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 13:07:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CCE214DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 13:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CCE214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZssL5dL2zF3Yy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 00:07:18 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zsmz6khjzDr5V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 00:03:29 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42Zsmq21XKz9ttFX;
 Wed, 17 Oct 2018 15:03:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qX0Jd8w8HOGm; Wed, 17 Oct 2018 15:03:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42Zsmq16XSz9ttBT;
 Wed, 17 Oct 2018 15:03:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 715AD8B7FF;
 Wed, 17 Oct 2018 15:03:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rXdIlUx1zF0d; Wed, 17 Oct 2018 15:03:23 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BD6B8B7F2;
 Wed, 17 Oct 2018 15:03:23 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 216A66F4CD; Wed, 17 Oct 2018 13:03:22 +0000 (UTC)
Message-Id: <19885260cc71182f8c03840204e2553ef42acb67.1539781367.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/book3e: redefine pte_mkprivileged() and pte_mkuser()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 17 Oct 2018 13:03:22 +0000 (UTC)
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

Book3e defines both _PAGE_USER and _PAGE_PRIVILEGED, so the nohash
default pte_mkprivileged() and pte_mkuser() are not usable.

This patch redefines them for book3e.

In theorie, only pte_mkprivileged() needs to be redefined because
_PAGE_USER includes _PAGE_PRIVILEGED, but it is less confusing
to redefine both.

Fixes: a0da4bc166f2 ("powerpc/mm: Allow platforms to redefine some helpers")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/pte-book3e.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
index 58eef8cb569d..fa1451e15b4e 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -109,5 +109,21 @@
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 
+#ifndef __ASSEMBLY__
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_USER) | _PAGE_PRIVILEGED);
+}
+
+#define pte_mkprivileged pte_mkprivileged
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_PRIVILEGED) | _PAGE_USER);
+}
+
+#define pte_mkuser pte_mkuser
+#endif /* __ASSEMBLY__ */
+
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_PTE_BOOK3E_H */
-- 
2.13.3

