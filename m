Return-Path: <linuxppc-dev+bounces-24954-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF51CC53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 22:33:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8qxL6PHzz2xmV;
	Wed, 29 Jul 2026 08:33:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785258961;
	cv=none; b=FbS83iof4SU97jQTx02U3nwfbtvZlenHdQSKKXk3QHonzpJNQb7JRCrezk/ULk+cBrnyta4BNDDdXPtPSMbZnBu12cwZRxJfndslLbMF26zV5hejGH+s7XiffxbFtqAZbOIY+HKaHF0UjPPucLEr1cYg/AX4SgcJJDkOzkiwx/yOb1IbtuagmIG7P212DE8dhAK/vRztaTSpsPSfE14diUqb6mZRXjV08T3gT7NadE14ak+cOFUrHAUVsIGRovf/1Z6JkM0eDDu9F2bEEjpcZ/Ym7TaUZPj/oVAVMH6LX8XBGdYtsx7Hkj5873sg2GKii0iIPUrvrHQGaX0J6Qq70A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785258961; c=relaxed/relaxed;
	bh=8vqxAh8CqqJc99YaNfeG8WErYj9oZt2HH/TEPC3CmhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXHqi/9SlLaHixuFqTYGr5OMYgQ+J1jcZCx1raMCag0ktFk/3zYolSHsUm6U5MJfbKaKooRiBkOuLJIR4nWRLdxY2lCXXcALXEzxxqbaKuo/eL431U5BOknYYMGA3wTVbZx/LPGyNUOXeA/zR878uV82SzZbDwSJ5LZWYvgGVV5cu3jSj4eTDbdA+h7Q5NQOvlZyRkhMpC/3MM7ZFMiJ2s4Ef7toIUis6bvKxl34P7Pc6s1u0h2lSf6//M+DaZvwF+28IS9M2tV+pDzxL5DIyZFepzJLcInKc7NUPprocPgxNO9ooaKNn3vEBFIC5zqb0dO+RzLjZCkV/6IJUiao1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJakqO8j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WJakqO8j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8hv33s0Pz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 03:15:58 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cace91f112so1971025ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258955; x=1785863755; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vqxAh8CqqJc99YaNfeG8WErYj9oZt2HH/TEPC3CmhQ=;
        b=WJakqO8jXtsQww69JTexZkBt7yWAMwsAAZ0EhSzaGTX69yWsOjKsmwHmgxEcdYGc2A
         /V3dVfzb42JCgG3ND2YvATbdv+KYQu/V4H6kahd3dj8+qCcoqW7sS+y8odhdziJ0O+3e
         qG5pCDu/wjAjpeRFwd3AR6KFAp3QdI0yPRHB1Ejhfe4d729w9ZH31qlni6fp4Cmk5/h4
         JFPSyzhOwu8SYXFVrWIAFwdaB8yAwh6OVyHAe/M3wqsZDcH/kFbeZdraI8iG4Roy6s4e
         nKAiMc9PUGlXGMJTJeZPh0P9JZiQjStIHbJZjtiapa+ZGbZ2eddxu8bIqKtTwto1EHRA
         eEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258955; x=1785863755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vqxAh8CqqJc99YaNfeG8WErYj9oZt2HH/TEPC3CmhQ=;
        b=DyQQWI0HRY7JbaHvSZ6JsbPeUJi6x90217VYgodRTvxl7bQ+oDACp1c0GLTETpnKJD
         gHrorsG6muY699QxiatGg1iHaclbN7GIf3cZ7lEIytPZ3Adf+kcD23jSjsFPB2q7rWUa
         BAzn/cAeUh/fASQyOXZNnVWgPgNzea3vEw7YKuR2QnvGfdCNqtVlru3cr5hStf7eY0I7
         eFWv9GEEOuRSYdM0dq9pOp8YT0tZ5Ig3sorAkQ95NLK+t0YaxGsxdfuft6G8CvWHWfE6
         h9o66MQEk8D0xDjh+AQioEZ0VVeL0yYkV0ioIQ1TlbTzrsKRlyl+6MMAKCZRWXvkWbBt
         fZuQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8x7iIewRz3KYBsLJ9LfD4SR7WUXzJsJ1OBn/9oDlQFLRpoyPVOijy3i3cg3xJ/hp2gT4J5yTwOuhAaIQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwK3Bl4ED0i4JHRG4PSLImZYpMdSFm7cBxgmOGKi8W5ZvpV/N1j
	+fYGSbqLM8YU1BkYEdXjuDSMWcWsZu/dEIw/+vefuHgGLDaRuqCmN2A=
X-Gm-Gg: AR+sD10xa2cCn0Fy08DpEZEiFzkXvjLkuqUu7uFbmCi4fEA6cpNRCms9p6qGIB0OSh4
	kMNXd3spjrlMJhHRu4QaDFGoupJnnj36pfThPYosE2FUsSqzpj52JdNcLTEZkcAe5Tfz7Qe4Au0
	samju0YXiB1EEgSJiEXHXw39PI8ndX+gBFMdBd0vdvp+Bj5UnijxgnyHpkjrfATxSIMacB1pup/
	MxmfxC8QylR5lVWW/YxxEqI9hOWSvdoGilHs/RU6rZ2jQtWWeCCP6oQ3M+EO/+CR+1pR3XFM2lL
	M5j2f1ER1zqWAn4EPxpRs0QNn8ctON9EYp+PlILsxX/8wxuv0h3kuSEF5wyVEXnXRrN8jyFabEy
	PkkesPt2pvK+MCKcPWLMTn7J5lT2ZBJJFLGCeI8mgpCVWGIxN7Rgl6YNiCpkD0JmOwHA0zzibPe
	0wj1f+tv6IG+6USFHEAf3GWc8E2jSc7/LuBC75aSD0tP3aLUGqi7hAsDB0RP1rx5z4E0+12mGpO
	1oPAZRGNu2OyC2DxJYDlLPHuVS+MVuGlGavZZs8
X-Received: by 2002:a17:902:c40d:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d015c2ab6fmr39514985ad.14.1785258955014;
        Tue, 28 Jul 2026 10:15:55 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a466a9sm3235ad.22.2026.07.28.10.15.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 10:15:54 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Wed, 29 Jul 2026 02:15:45 +0900
Message-ID: <20260728171545.49247-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucc_hdlc_probe() registers an HDLC netdev whose private pointer refers to
the separately allocated ucc_hdlc_private object. The remove path frees
that private object without unregistering or freeing the netdev, leaving
a registered device with a dangling private pointer.

Unregister the HDLC device before releasing hardware resources. This
closes an active interface through ndo_stop, which disables NAPI, stops
the UCC, and frees its IRQ. Then free the netdev before releasing its
private object.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb9..4c843c94c 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1255,6 +1255,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
+	unregister_hdlc_device(priv->ndev);
+
 	uhdlc_memclean(priv);
 
 	if (priv->utdm && priv->utdm->si_regs) {
@@ -1266,6 +1268,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
-- 
2.47.1

