Return-Path: <SRS0=9oUV=WR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD6C3A59E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 15:24:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABA722CF7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 15:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PfpbmyeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABA722CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DBK46H5lzDqtn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 01:24:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="PfpbmyeO"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DBGb3cHTzDqQY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 01:21:59 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46DBGT3qLvz9v10J;
 Wed, 21 Aug 2019 17:21:53 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=PfpbmyeO; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Yea5GLHY7gcW; Wed, 21 Aug 2019 17:21:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46DBGT2m02z9v10H;
 Wed, 21 Aug 2019 17:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1566400913; bh=I8W+l3URIFEwj3Ss1WM0wfluCLpBRXTInP46mMV22d4=;
 h=From:Subject:To:Cc:Date:From;
 b=PfpbmyeOY7IMD4ZIOr8lWmZb7POGDj+V4KjBacdBHmV5U1bpIdw7UghNP/ClJ8x1L
 hH6aYGyaO5yCq5uwuKQjWAGhn0/GukAbkfBDszDN+nClH2fiPh8g+bI5XKk9LiuZbG
 jDMU7ro+YKk32+GM7Oe7WEXN8TTg+eY+zv0iNhWI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A00128B7F7;
 Wed, 21 Aug 2019 17:21:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gD5cCgbd2cwg; Wed, 21 Aug 2019 17:21:55 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.101])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FDAB8B7EE;
 Wed, 21 Aug 2019 17:21:55 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 70ADB6B708; Wed, 21 Aug 2019 15:21:55 +0000 (UTC)
Message-Id: <4f88d7e6fda53b5f80a71040ab400242f6c8cb93.1566400889.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: tell if a bad page fault on data is read or write.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 21 Aug 2019 15:21:55 +0000 (UTC)
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

DSISR has a bit to tell if the fault is due to a read or a write.

Display it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/fault.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 8432c281de92..b5047f9b5dec 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -645,6 +645,7 @@ NOKPROBE_SYMBOL(do_page_fault);
 void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 {
 	const struct exception_table_entry *entry;
+	int is_write = page_fault_is_write(regs->dsisr);
 
 	/* Are we prepared to handle this fault?  */
 	if ((entry = search_exception_tables(regs->nip)) != NULL) {
@@ -658,9 +659,10 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 	case 0x300:
 	case 0x380:
 	case 0xe00:
-		pr_alert("BUG: %s at 0x%08lx\n",
+		pr_alert("BUG: %s on %s at 0x%08lx\n",
 			 regs->dar < PAGE_SIZE ? "Kernel NULL pointer dereference" :
-			 "Unable to handle kernel data access", regs->dar);
+			 "Unable to handle kernel data access",
+			 is_write ? "write" : "read", regs->dar);
 		break;
 	case 0x400:
 	case 0x480:
-- 
2.13.3

