Return-Path: <linuxppc-dev+bounces-27469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17745C88E5C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 06:51:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl8gr4W60z2yGT;
	Wed, 16 Sep 2026 16:51:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789541512;
	cv=none; b=gVkXJbk6Nmdt1kuK2cb4AnSU07WtqIDexREnILh7jxSvD+kMUs1NYor8KY/ut7hw1wGpmvKcLuPp8+AXS2P3gtQ+adBPUEmCGnBWvJfI8A9Ecjb7mlQZm0FUPgMSmCKP5leS61avdUQxAJTf+MTguWrXCingggK63R9BjOp02DAejZF4Mw3hXqrF3N4B0vsEF0NOoN8XSMZeNl8j4QKCLXNqhONDoTvUThh9m30vMVYlj1B4WaasRvgaZNaVAdxbCVxvEk4ERJ4eCG+3WiCkWB0rx5ZtoKkwXpGN5vmFdmQgBAGWZ8oUCbnHcH7D/m1qUJvyZVGKumx3mUWrUOaLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789541512; c=relaxed/relaxed;
	bh=AN3SOTukBoOl3ckWtu7ycjUkrBPQfO8wZi20AvSxNVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lB1QzqofQcgLI27w0pZvhw+T0JdgJv6QhoZeK4B6pjgaMmuGZmKkzI7giIgCgctHE3RM0/mtLrFvNh1Fn+S9LG0tfVZU2hFZX21UlN34vtx3dCLzaiSpUamdXDRLriX6r3Cc1LuEsSRNZY9q8raiDHKhwii/BssKR+okqfYRkw7NEoyreJLLitHh/vdutFyQ+dSJArdscN7m1Y1HNKu3XGmeBmP+vzunXnlV67JkaFVwfQnVwm6J7kRfcDAEqhNQyNqyTqG6eG+bTcyC0fCJj8k3t4KpHZc3CgCG/mTfMyIFaiDQa6g52qKMdMFUWKIZVE6m8EXIOfwdC4sx1L2jBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UrkBE1ei; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UrkBE1ei;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0e.google.com (mail-pz2-x0e.google.com [IPv6:2607:f8b0:4864:3b::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl8gp691Qz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:51:50 +1000 (AEST)
Received: by mail-pz2-x0e.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so401764a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 23:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789541508; x=1790146308; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AN3SOTukBoOl3ckWtu7ycjUkrBPQfO8wZi20AvSxNVY=;
        b=UrkBE1eihbenX6TlDLj8+ej2AWvB97pC+9dl3MWDm+Fth+FgVfqM8tjEHPVxR8gqbg
         aVpnjS0pP/asaoRD19+R0HF7sMj8fx/eLfwpl9D0VoQ1+H1X8afIrSp+LdVpBFYQNmHk
         qAo4UETgo6BaCNKVLw2MmDUfOVamWSQulCauI0XV+Vu0p3V8VIKT8bE5C/cBDDU2SbT0
         KZDRRWEm609JKtvAiZnWtd5xRKcehVx9cTUiYg2hCTUKWnAT10tXtKBUoBuqvje3RtQ4
         uJTD8umr6jdchUwZe4b5whb8fZTUEpzQc9UcmFnpAt5Cm92I/Eyhvu/vTsZb0u9XMbo4
         J71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541508; x=1790146308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AN3SOTukBoOl3ckWtu7ycjUkrBPQfO8wZi20AvSxNVY=;
        b=Ya2zsLkvljz/U7BGcRny8yiB2qybUhMG/o+3cvAzMOCu1qad9wDt5/aj5Puk0wybn8
         sgniR9uiy7i/3KRQqAGLJ/YinyuHNt8BQuuLx9vR7puLtmFNtnmPu48hyHgkZNYCpc7L
         A4ZKrCRzzpIR5mBkGjEIHKoaRL3hhNY2GL2r4mgAj1VruB0MP168UtYgDFOhKHeHBcFJ
         04z16IISfDyNbO8U/D81Amlkw44NES/hSw5+fOUzA8a6KG9XY5rbVja6JJ8WbNwZpebk
         fGPl7i52CLQQwrUb4EioZsQXxzs4QOk3BayDRpOB99FXUeKYBjjQMPoQMKQrmk4Cder2
         Cifw==
X-Forwarded-Encrypted: i=1; AKwUvBwQYRXl3RqHA0JxOKRrvXdBC/moPjuWRQWqHjr33pUEea1tCdNUWRneGf2lYORa0CkF2bfPcWQi4h6TD0Y=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mtL66fGmt/wG5KfnxHCtIJm1Hf2kiwhMpYzunF1ajJV9hRyge7
	LlMdTvzW4AFACRtZl/VsXubwipk4i9v2RnyANTHBNl+NS/ssNFu/81tG
X-Gm-Gg: AYBFou2O2Z/yuH6NghDLVUu+eAafzoLdrkbfjfz6G1l/GdpqgzVUA7ALPv6bXX0jISt
	g7jPcbv1OIZ6RWFEQBZRjlkAMMhSGTN3Q5EJpGNDQg0cJohlOfV1mTSUJmP6DyYbJTqpta+wnqp
	z+/72u5XctF3mysMV5+8AOekutkMCOjeviSVz/3ZwGK4NCU+6kqijh9Z0HTJ0fJp0UsnAJJY75a
	sIF8hb1WAn1xaRxUoVhCT2DXbjPhdSkkFarWGuggCLWycKXoeei8BxmMDuaaZFwyqR2xT123iAQ
	kklWJsE3O0cB6+rSrspO8Av6H6jBL2WbR2jvCCLfQaaTAOow4TPKOvQlSSdWpaN+a6ZzO48MaFf
	BO0mReitZNinrjB5dHL9/V8+6Bc/0JUjiwLJfVoQP5Jt8y9+Y/F8y9Jzfofk2b+IEAtyEKoSSyr
	PtWstmMwlweF6M+7SHjldWtAl5vPmrcu0YDdCWXFcWOHzTm9SHQBcd1A==
X-Received: by 2002:a17:90b:4cc8:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39e1e330a2dmr3903318a91.10.1789541508193;
        Tue, 15 Sep 2026 23:51:48 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b9068c6sm2903880a91.1.2026.09.15.23.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:51:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wan: fsl_ucc_hdlc: release resources on remove
Date: Wed, 16 Sep 2026 14:51:36 +0800
Message-ID: <20260916065136.2926089-1-lgs201920130244@gmail.com>
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

ucc_hdlc_probe() allocates and registers an HDLC netdev and, when the
TDM interface is enabled, separately allocates struct ucc_tdm. The
probe failure paths release these resources, but the remove path does
not.

As a result, the registered HDLC netdev can outlive its private data
and retain a dangling private pointer. The separately allocated TDM
data is also leaked when a TDM-mode device is removed.

Unregister the HDLC device before releasing the UCC and DMA resources,
free the netdev after the hardware resources have been cleaned up, and
free the TDM data before releasing the private data.

This issue was found by manual code inspection.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb93f5..ffc8b989e33a 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1254,6 +1254,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
+	unregister_hdlc_device(priv->ndev);
 
 	uhdlc_memclean(priv);
 
@@ -1266,6 +1267,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
+	kfree(priv->utdm);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
-- 
2.43.0


