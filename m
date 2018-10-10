Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7566EC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:51:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30F9206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWD2Ki4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30F9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VJWv3TfTzF34W
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 13:51:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AWD2Ki4k";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AWD2Ki4k"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VJPK1DL6zF33c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 13:45:41 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id w14-v6so1762950plp.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 19:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NXzyMY46pVOKH2xdNQWrvSfSQrlZcfeJEdRJL5v1K68=;
 b=AWD2Ki4kr8DuPUParSaLo4QtTF61WYW5ivfMwPXbp8X3XhtH6W1kIBbm6A4BIOEz7Q
 n/TxhHjlJ3BLwK0PIxofR95w1MSL76Xc07/9gNBc5KSrh/qzyRleuZwdWFHQpB+EcluG
 QvR1Lh04dI/9Pw8qrQvvRrXa9QPNnbTAuRuC1N32clwnDovb65HcR1iPNcD29ZxruQfq
 oXG9GXqvGVndhM22zbUnqISL0+2Lufl/Jozl8uNLPazCFO8PrJdwwxgTGJQfypXv7+CV
 UeeEm87Qw8m5MtvWR/JUNdZ3ytkhGZ4uZZNfC4YPGCPBPWb25qK1klvTATY4cVxFGOUx
 /S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=NXzyMY46pVOKH2xdNQWrvSfSQrlZcfeJEdRJL5v1K68=;
 b=NHbrn3qfFaiPJAtZVAVRnxig7cXp8E8/deR/oQMqiv1hCuZyzTcOQTHrooLUY2VTnw
 N/PWxnV1a6EUhOvUbC8So7U83wJ5dMkW+lYeJ6WLpC+dyMRRoAgwEohOzuvLvIZpGLzi
 ib/bQnpiU2famumhnUvQAy7vxruVASLu97zymgfEIhN6AoLgOUs2NXOwoKZpN3SHmvFv
 0qexPGR8GwDBtTZ9129mB+aagxntVIuUb24QIR8vwNC5ep9aix6uixjfcWlVD7VHdFsi
 rIEsrBe0nNNdGS/xfJP43g26HB2+ZbDnECxec04byC3BweiTnaNhdGOdCXzOtSQOzvsm
 W/+w==
X-Gm-Message-State: ABuFfohlUh0tc5IT+tGvXvGLnmPOOfc3zyQwjlVfJdWXYmg50uPLsXQ+
 eKKSIJ8whonYO7fJC9rButFrCWN3
X-Google-Smtp-Source: ACcGV60RtazFarMp7pbWAE5VXHn70aIISd5ty5+Rnx2yZhBf+BJw2e2ppmTBIFBWLOtOT8TsTY8u5w==
X-Received: by 2002:a17:902:8d82:: with SMTP id
 v2-v6mr32014154plo.9.1539139539036; 
 Tue, 09 Oct 2018 19:45:39 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id o2-v6sm26867640pgi.62.2018.10.09.19.45.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 19:45:38 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 10 Oct 2018 13:15:32 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/boot: Disable vector instructions
Date: Wed, 10 Oct 2018 13:15:22 +1030
Message-Id: <20181010024523.4921-2-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010024523.4921-1-joel@jms.id.au>
References: <20181010024523.4921-1-joel@jms.id.au>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This will avoid auto-vectorisation when building with higher
optimisation levels.

We don't know if the machine can support VSX and even if it's present
it's probably not going to be enabled at this point in boot.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/boot/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0fb96c26136f..739ef8d43b91 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -32,8 +32,8 @@ else
 endif
 
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-		 -fno-strict-aliasing -Os -msoft-float -pipe \
-		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
+		 -fno-strict-aliasing -Os -msoft-float -mno-altivec -mno-vsx \
+		 -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 -D$(compress-y)
 
 ifdef CONFIG_PPC64_BOOT_WRAPPER
-- 
2.17.1

