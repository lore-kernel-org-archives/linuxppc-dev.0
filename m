Return-Path: <SRS0=+bYb=OD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4914C433FE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Sep 2021 11:37:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444F760FA0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Sep 2021 11:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 444F760FA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7Pbq4Y5yz301j
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Sep 2021 21:37:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7PbP2Lfbz2xl7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2021 21:37:18 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4H7PbF1rCGz9s4C;
 Mon, 13 Sep 2021 13:37:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tneXrTBhke6s; Mon, 13 Sep 2021 13:37:13 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by pegase1.c-s.fr (Postfix) with ESMTPS id 4H7PbF017kz9s42;
 Mon, 13 Sep 2021 13:37:12 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18DBbCq5143479
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Sep 2021 13:37:12 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18DBbBvG143476;
 Mon, 13 Sep 2021 13:37:11 +0200
Date: Mon, 17 Sep 2001 00:00:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@c-s.fr using -f
Message-Id: <1718f38859d5366f82d5bef531f255cedf537b5d.1631532888.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 1/6] powerpc/signal64: Access function descriptor with user
 access block
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, ebiederm@xmission.com,
 hch@infradead.org
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

Access the function descriptor of the handler within a
user access block.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Flatten the change to avoid nested gotos.
---
 arch/powerpc/kernel/signal_64.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 1831bba0582e..7b1cd50bc4fb 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -936,8 +936,13 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		func_descr_t __user *funct_desc_ptr =
 			(func_descr_t __user *) ksig->ka.sa.sa_handler;
 
-		err |= get_user(regs->ctr, &funct_desc_ptr->entry);
-		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
+		if (!user_read_access_begin(funct_desc_ptr, sizeof(func_descr_t)))
+			goto badfunc;
+
+		unsafe_get_user(regs->ctr, &funct_desc_ptr->entry, badfunc_block);
+		unsafe_get_user(regs->gpr[2], &funct_desc_ptr->toc, badfunc_block);
+
+		user_read_access_end();
 	}
 
 	/* enter the signal handler in native-endian mode */
@@ -962,5 +967,12 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 badframe:
 	signal_fault(current, regs, "handle_rt_signal64", frame);
 
+	return 1;
+
+badfunc_block:
+	user_read_access_end();
+badfunc:
+	signal_fault(current, regs, __func__, (void __user *)ksig->ka.sa.sa_handler);
+
 	return 1;
 }
-- 
2.31.1

