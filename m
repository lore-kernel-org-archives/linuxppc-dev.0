Return-Path: <SRS0=nl2z=UF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA154C04AB5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 11:38:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF7C206E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 11:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="wKNxZuab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF7C206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KNvS1knszDqgB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 21:38:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="wKNxZuab"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45KNly6mwSzDqf9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2019 21:31:42 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 45KNlt4kgyzB09ZS;
 Thu,  6 Jun 2019 13:31:38 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=wKNxZuab; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id LGvoxYt9z0Ek; Thu,  6 Jun 2019 13:31:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 45KNlt3hh9zB09ZF;
 Thu,  6 Jun 2019 13:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1559820698; bh=z1F6PHZmuc1YG8A1ts1rr1gl6K/z7hQn1Ct+jqvfadg=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=wKNxZuabiknkjHFhEpNMEBBYKgYEVsqPmVlWVKH23OOngNkAMOXv/WWpirLrthAf4
 dxdL5Ni2QCUIUjzkBGvQIOWCYaej6e6GYGQIsfxPMh/cgCO8fx3vC6p6WamX+EzeFL
 caskyQmrz3JaWNqIIMh45RuODxBm43ZAfoWnKb4k=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C28508B894;
 Thu,  6 Jun 2019 13:31:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KnPu75gGijjF; Thu,  6 Jun 2019 13:31:39 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9677C8B891;
 Thu,  6 Jun 2019 13:31:39 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 74F2668CFD; Thu,  6 Jun 2019 11:31:39 +0000 (UTC)
Message-Id: <4d6b83bfa9a832229de142551cea779ddc56cf9a.1559819372.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1559819372.git.christophe.leroy@c-s.fr>
References: <cover.1559819372.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 4/5] crypto: talitos - eliminate unneeded 'done' functions
 at build time
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com
Date: Thu,  6 Jun 2019 11:31:39 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When building for SEC1 only, talitos2_done functions are unneeded
and should go away.

For this, use has_ftr_sec1() which will always return true when only
SEC1 support is being built, allowing GCC to drop TALITOS2 functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 4f03baef952b..b2de931de623 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3401,7 +3401,7 @@ static int talitos_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_out;
 
-	if (of_device_is_compatible(np, "fsl,sec1.0")) {
+	if (has_ftr_sec1(priv)) {
 		if (priv->num_channels == 1)
 			tasklet_init(&priv->done_task[0], talitos1_done_ch0,
 				     (unsigned long)dev);
-- 
2.13.3

