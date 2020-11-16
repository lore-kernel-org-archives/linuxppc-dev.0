Return-Path: <SRS0=L4jv=EW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B215BC5519F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 15:57:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D69620A8B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 15:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D69620A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZYcS3FFzzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 02:57:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZYWk09c1zDqJW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 02:53:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CZYWV1WF6z9vDFb;
 Mon, 16 Nov 2020 16:53:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id SSJpeJkvd8xF; Mon, 16 Nov 2020 16:53:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CZYWT75MBz9vDFd;
 Mon, 16 Nov 2020 16:53:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DA0B38B7A8;
 Mon, 16 Nov 2020 16:53:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id pv1LfhojYMg9; Mon, 16 Nov 2020 16:53:14 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 384CC8B7A5;
 Mon, 16 Nov 2020 16:53:14 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id BE24066884; Mon, 16 Nov 2020 15:53:13 +0000 (UTC)
Message-Id: <40ae19c2bf013e3815a6ae0d6016963fdb0f51b7.1605541983.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/5] powerpc/mm: sanity_check_fault() should work for all, 
 not only BOOK3S
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 16 Nov 2020 15:53:13 +0000 (UTC)
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

The verification and message introduced by commit 374f3f5979f9
("powerpc/mm/hash: Handle user access of kernel address gracefully")
applies to all platforms, it should not be limited to BOOK3S.

Make the BOOK3S version of sanity_check_fault() the one for all,
and bail out earlier if not BOOK3S.

Fixes: 374f3f5979f9 ("powerpc/mm/hash: Handle user access of kernel address gracefully")
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 0add963a849b..72e1b51beb10 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -303,7 +303,6 @@ static inline void cmo_account_page_fault(void)
 static inline void cmo_account_page_fault(void) { }
 #endif /* CONFIG_PPC_SMLPAR */
 
-#ifdef CONFIG_PPC_BOOK3S
 static void sanity_check_fault(bool is_write, bool is_user,
 			       unsigned long error_code, unsigned long address)
 {
@@ -320,6 +319,9 @@ static void sanity_check_fault(bool is_write, bool is_user,
 		return;
 	}
 
+	if (!IS_ENABLED(CONFIG_PPC_BOOK3S))
+		return;
+
 	/*
 	 * For hash translation mode, we should never get a
 	 * PROTFAULT. Any update to pte to reduce access will result in us
@@ -354,10 +356,6 @@ static void sanity_check_fault(bool is_write, bool is_user,
 
 	WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
 }
-#else
-static void sanity_check_fault(bool is_write, bool is_user,
-			       unsigned long error_code, unsigned long address) { }
-#endif /* CONFIG_PPC_BOOK3S */
 
 /*
  * Define the correct "is_write" bit in error_code based
-- 
2.25.0

