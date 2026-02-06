Return-Path: <linuxppc-dev+bounces-16662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24844EB28F7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:55:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6nwc5wQ7z2xqk;
	Fri, 06 Feb 2026 19:55:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770368112;
	cv=none; b=nY+7vqkmGy/o3Z6BxC9b3FIBWXsgfcrC3oCa1cdhZRAQhV53n0SbFAU3nvTL8/fLwEUjwaybneX7CxZP3Okge1raEEQh7Q/vDovyXk9rqNVg2fkEESInixWlEXcI0FTRhjxqT2s+3jO4CWQzx85rS6//Arm0PgKkAn4sz7M6mENbmmUzGemndeOElBMLojLWWN8/5uBgk3zuUk3bqhU0yOBNEDIzBUu6+RJDL41WjslXJZREE63m/L/BwycV/OfZU8+lmferOqABSQtWxx+05S1Wgp+CZOJrXOjOeU+EXPlZs56TwzNz8QsjPYYVEjJdvpHJ4WoLNZgQKx9BjE3Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770368112; c=relaxed/relaxed;
	bh=H4CfwKcayH4xDR1+iMb7IfsfcQiFBuBvxK6Im43iVvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LT4i9WngJ5GL+SRhOjLrV2FDp7TddXRiYxzrSbf7RbtiJrIZDgqLIi5b5vYCsHZUN6Ls5akWn0kWfGma0IWmZ4wNvSQbAeOemZiEAxX3OcFh7y617GwqL/0DqRTr3aUw33eNcmAsbiQZQcLMpzpWR8zhj6Pp1n6KkSfG0offCfIdi5OY5phHbBCMoa2t90TcRBAL4Rz2sA9/9Dyxmj/uMEUCIM4EgACrYVsbSGYkWqJooQltisKTyCoQQh97jlX/huVETErLMGLx1ucT28/7i/UYjSearTyHwT2wND2Kvimn8p2Qv24dFd/+g0GZZWzF3y5bPSTyKFi6aCsTpvqKfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OBH1zV5p; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OBH1zV5p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6nwb0058z2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 19:55:10 +1100 (AEDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-432dee2b55fso295134f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 00:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770368106; x=1770972906; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4CfwKcayH4xDR1+iMb7IfsfcQiFBuBvxK6Im43iVvY=;
        b=OBH1zV5pDK0GMd0TGO18lsCsYLjtiRfdEBPKPr+ZzwEf+DEalB1ZQXczuTxkHdgH/f
         MweSSvul5nydDRsUszPbA2yG0At/qo/w+0opZAsJyIEgSIeDqdU6zHVA2fSM8F+lIexK
         VHSDiJeohaYVJTjwyOhEWE2F4z+nLN4XmWZVwz7uwEUP+0NXkhwOwL2j/gdsuioiHlLh
         SG9paWZ1hnfDbh41AYxqbGw6Irj6KgUwf6IoU412g8LN53FMArsDi6V/gMbTiXx1srcu
         ZMto81tcksmsClXS4NnB6AXdjm6T0C3q9m9RtZljkHyfIL3GK2hg3u96KwKNKLyPJWSj
         pPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770368107; x=1770972907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4CfwKcayH4xDR1+iMb7IfsfcQiFBuBvxK6Im43iVvY=;
        b=ZVhpEpqDsGAZIU2rlbUzxxWn7S+X35L6oy7IkmMeMTWP2U3ZgygswkTTyYWGzFb1yJ
         dZ5l83mbLnq6yHz4ejGb7DT7nstMKpjdYww43eAc4rMHy5kOvum+o3DhO3P99CPuRRKQ
         z8ZgWcWleIC3mklhojeHuIXHp1n1uUPIpbI98cGvNF4cIl3u2nozrL9eFylxT4ypiNQT
         gqq0gnG1OXXItHrxbUhuRRJ8aj4gWQrdCyEtVZAB5Ui7SN5w5juKOKUTv27WZXArvQV9
         WLvzD8iJK+rEzLS8eRtS1w3Jn6lZcsSEA4d4qLj+qP10AtpT4DX6gB6eb9nauZ+X4Vef
         fQEg==
X-Forwarded-Encrypted: i=1; AJvYcCV/qL+qqNuJ49P2dzuWb44mVKw2l/xzMuONG+Tg4D59N5tF0LpRVKK3hysvzeoXckIIlJyxwNtLJECV3BA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0SKAKYAiJRglKwyBzhQUv/XWaBZg94RoYlfhBFoKsjPbvOK49
	oPE+OKf2a/88UgeXpnBwoUZ+gx6Dh+eKwIqN3Sc1OKHpNv3tWikvjpv5
X-Gm-Gg: AZuq6aL2WCJPBC/eQ2SDT9WvzPDE1at0JmlcK+SPw9CCBL7b6c8MxBKPYXcU6Tcf6YJ
	G8IMdFbMRRQCp+BsaQZJ804tRBatKie8r5g362t0VXq6hpXA5ovcVY91fqSyEG9PFNrqkG6WAeH
	8ZnW+2dg+mD+eiVF2I8WeQkGlSvhKbKOmfyNTKK8uYBZu4JDAswPWlKQZRdGt/Lr9PZgIF287hu
	JdqxES2haizYUvZWocGh2vQyXVOZN33oGR64Iwu0+jSwhUl9lS0oZb4gpR7ptHPAa6R8C9hFjBO
	bC5hy7B8Ogu5WEnJE/J4rW0I1C570+MnSg9sK4SCH7BF41uPEPmJikOTRVdbGQTOD3szEQ1TqCE
	aDMFy1j0zeUbS3lR7fgwhSKvDI1mOMmkqAyiGLwCZcBdfQQj7pG82Mr3is+lx9h2BDKL4QVak0/
	pbYfdb2JuTJc0bbKG+vVtEGV43FXl/5oPu428517eggh/65DGkIjaw3Cphc7Sa7QWo248Cba4Ej
	g7LiV3W
X-Received: by 2002:a05:6000:22c4:b0:431:8f8:7f2a with SMTP id ffacd0b85a97d-4362933ec57mr1767057f8f.1.1770368106350;
        Fri, 06 Feb 2026 00:55:06 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-213.paris.inria.fr. [128.93.83.213])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43629744ec6sm4878270f8f.35.2026.02.06.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:55:05 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	stable@vger.kernel.org,
	Zhao Qiang <qiang.zhao@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net,v2] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()
Date: Fri,  6 Feb 2026 09:53:33 +0100
Message-ID: <20260206085334.21195-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The priv->rx_buffer and priv->tx_buffer are alloc'd together as
contiguous buffers in uhdlc_init() but freed as two buffers in
uhdlc_memclean().

Change the cleanup to only call dma_free_coherent() once on the whole
buffer.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - Cleanup priv->tx_buffer and priv->dma_tx_addr
  - Fix buffer name in commit message

 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index f999798a5612..dff84731343c 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -790,18 +790,14 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 
 	if (priv->rx_buffer) {
 		dma_free_coherent(priv->dev,
-				  RX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
+				  (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
 				  priv->rx_buffer, priv->dma_rx_addr);
 		priv->rx_buffer = NULL;
 		priv->dma_rx_addr = 0;
-	}
 
-	if (priv->tx_buffer) {
-		dma_free_coherent(priv->dev,
-				  TX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
-				  priv->tx_buffer, priv->dma_tx_addr);
 		priv->tx_buffer = NULL;
 		priv->dma_tx_addr = 0;
+
 	}
 }
 
-- 
2.43.0


