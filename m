Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4158C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:37:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BEB218AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nlht15uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BEB218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qxWS26f7zDqSJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:37:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="nlht15uu"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qwwV5rHMzDqYL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:10:34 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qwwQ3K6Sz9tyxB;
 Thu, 31 Jan 2019 11:10:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=nlht15uu; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id FheCnulLkp4v; Thu, 31 Jan 2019 11:10:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qwwQ2HGQz9tyx9;
 Thu, 31 Jan 2019 11:10:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548929430; bh=Wv0JF7XVNnncvSYae7jqrjAVaOTnL2I6Kn3J1WT6QpI=;
 h=From:Subject:To:Cc:Date:From;
 b=nlht15uuFeORSCA24QOR/VGW5U4sDj/yg//X2xZBNWc5oGqQRE5kTveka6FXXDivR
 x9iVjfJFLCdumIC+jPhqMy4Tf2z8stQq7ANDUXxHyDw/g4I29kQttiuaPk8z86rL3h
 WM4+fygz510EMrpHOMN5lwicz0ciklQCht92f/X4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E7768B814;
 Thu, 31 Jan 2019 11:10:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 66rAwejk1GCs; Thu, 31 Jan 2019 11:10:31 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4861B8B78D;
 Thu, 31 Jan 2019 11:10:31 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 3154372E15; Thu, 31 Jan 2019 10:10:31 +0000 (UTC)
Message-Id: <da718ce0da4303de0197b46570680843a188f216.1548851096.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/32: Fix CONFIG_VIRT_CPU_ACCOUNTING_NATIVE for
 40x/booke
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 31 Jan 2019 10:10:31 +0000 (UTC)
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

40x/booke have another path to reach 3f from transfer_to_handler,
make sure it also calls ACCOUNT_CPU_USER_ENTRY() when
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: left inside the user entry path

 arch/powerpc/kernel/entry_32.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0768dfd8a64e..d4c6186aa7e8 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -166,6 +166,13 @@ transfer_to_handler:
 	   internal debug mode bit to do this. */
 	lwz	r12,THREAD_DBCR0(r12)
 	andis.	r12,r12,DBCR0_IDM@h
+#endif
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+	CURRENT_THREAD_INFO(r9, r1)
+	tophys(r9, r9)
+	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
+#endif
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	beq+	3f
 	/* From user and task is ptraced - load up global dbcr0 */
 	li	r12,-1			/* clear all pending debug events */
@@ -185,11 +192,6 @@ transfer_to_handler:
 	addi	r12,r12,-1
 	stw	r12,4(r11)
 #endif
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	CURRENT_THREAD_INFO(r9, r1)
-	tophys(r9, r9)
-	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
-#endif
 
 	b	3f
 
-- 
2.13.3

