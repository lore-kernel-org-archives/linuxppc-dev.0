Return-Path: <linuxppc-dev+bounces-27192-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55C2C88E63
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Sep 2026 19:48:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjf306n40z2y2Q;
	Mon, 14 Sep 2026 05:48:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789328892;
	cv=none; b=AgrySAFMeZF2Uki9JAwzhaOGI4yQnRmqA65QIfN7GCR9BlHkIdSi/rhpoGroTao8Kwm3MUXQ87qQKX+v3pcRWjsAE3vZpQDbqTiDLYeHP728e4z3pjyabgosEqiz3w4sq2SrXTCBpRWZO2fK4Ds6W5roy9ahAjQIV4TCJn+2JzjtqRYZGiPc1x16HRxWBbASsAXJQnIq0CHmKSgLoeN+bH2nvQa+oOh+iLs7viO33FqVuvKe6S1Wbw4j519gwC6SgH+vc+neGrU1jyO7ouYRcy4zO7iyDIQ+l0JKU35mika6IxbF9mzL1QQLTb+1FJ1AH6BslR3i1QrSymdVhOltCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789328892; c=relaxed/relaxed;
	bh=8sFKNO7az1ksH2fsKhgDozSxLoIS44WxW5mHIfc4ieo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqRKspbxPlBcCy++aftOoe2kBpTyMuqrjPxbfJKlHs/y/f3JQX2MPdBIGVyxIygN5Y8EUmT4sNLI+MhcGW2o+Cx5R+cpzQG0SipWBRZ2ws1wtKd5pWBCnES/CS6ydg1ZEd+GSzJ14DGyPgIAvbxWaKGFVvQs/w5Eg2lqXiARZlikjBko3+bEq7L7HPdpjbhdyCRcJ2TXVH/0wNLNf3qwHYFAUR6zkQob0OZ+/MsVq0pVEs7Nd/O3neI2RzAgWofX7KtSpL+SgZ1nbzya71xX1Kb/XQJaI/J4672a+sF9a4846ew5iSWW6YNWfU4G4NJLJZH0xLBPrHirqwoQoIwRVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aCyev4g0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aCyev4g0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjf2z0xMLz2xWV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 05:48:09 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3954031a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789328886; x=1789933686; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8sFKNO7az1ksH2fsKhgDozSxLoIS44WxW5mHIfc4ieo=;
        b=aCyev4g0lKVrtw+ffThtgowvnoes0eIFJffdU4wxupScn+PauP/Rn2aL4VIyF7nrmp
         yPVYVWOc8rowo0IYRdm2zbHisZfwnOksTDZJvvMpAvQc6/yxMBFovRIqDQDO4khou5Af
         dlj9yqHcIBo57bCU8m7y9tW5ZZafie3ajlvVypVzO1qa4lBj8OmQPfMy9pkSj178lVmh
         JckOvyd6b1eNFfXsliNiM5wS24ymHVMyO8JCQ90S65NTokNKlLn6zwEJLDvtXpszG5qW
         Re8aiKulksKlREggW4EAG/GIxJLwRS+NGP0vMrh/BcIWqjER5nlqXLEtnGf/jUFwWvt1
         ZSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789328886; x=1789933686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8sFKNO7az1ksH2fsKhgDozSxLoIS44WxW5mHIfc4ieo=;
        b=a7aVXXl6MJ9vJTdv1G/lVwgaoywUzgFkF9pjMnOBmB2trxT81jilYayCmozcJobx6m
         lVisxj9GDMIZTG/nFbfNxbPgbEcqe+7bkKs+yxwK2ESLVJvYHdzv5+89QtFwUz+ac+sl
         EjucnafRJZfRhs+9gY/KD1B0Q6i8qdd8Ce/AC48otbXDxHzq/N3zS6/Z50fkuPhKaoE+
         nnbKha7IYqyGrS/+cXJXfVHYyM8rEwohYxkDFj1icxEHYY/AcHp67KJcY7jBo3v1/4rh
         QeejR5Yh1m8hKaR+DCzhGksUhPVYrIr7VBvas7yESzVTAIlvkhMQ8ZuBUkZ6j+Ab7Kif
         B1VQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWNUSNhRPAfNITpGhSRY2Jk+HFFqgwuveRr0gWbgHHgEZY0w2X6hmk9GmTC8TcucfFcybeRZTREztHfgA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mEjA06r6nahQfawu3rShvlMODa6KBqTvCc58g+0EHHM1pSXpVw
	f28b9OL1A8WBXNRQq0pU49ef9eL+Ds4q/02+alYc04uUf6Owf4puq1jp
X-Gm-Gg: AYBFou0FWrC2s+lXhIdXvWXsKgrDnzRHAYSOGKcMtvHVbx3iJAVGSoIwxJZpoMxGahE
	J6W3CmKyAfhWfFj8KTUGDAssXWC03KpfMgG8QiSbVSoxlzeuDNXf5NavodzBM7ff5p/yHE4UFzW
	J2ykKwLLf16Bczy80GVaS2yIuQluZL59iYoIKADXFVVaR3gJB6om9o1g5pWMNzV0jnPXp52jVd0
	WyLAZPn44pFIZ8LoEVTazVYhzadTNFUdKkcnmKjcSfA1Oj4LeHPGtMCXrxJdC2+NydMPHx9BOVm
	CCaYuwaCc/N/x94J8TBR52MKPCOEd8ayUneY9hEzKwKKGLW0v4N+i6MQ6hyocAOi8qWeXnRy0pb
	JGLkXbePJoURlg2HchalnwNn7b6BHC+7RxYCWKQhzwBLfSHsCFI9X33DQVdZkcoBs5MKccdQR8c
	jiIPk2tMwNmowXGlCx27gdus78GkAegrSPZMv57EPsvumojFrjEDITgr50H6lAeciQB3568aldB
	sAh8fWHko5u731eiVlcdoVJnwt7jok/AIgef/MVH9tFi2lTJOStOQodjcPW91HpNIYVyeaMoyHp
	6TdDZplMauzwIFedc6Bobg1cpaFspLGaoPQOeRMESBTuSWmv
X-Received: by 2002:a17:90b:390d:b0:39b:370e:c807 with SMTP id 98e67ed59e1d1-39d9c1fcb7cmr24523582a91.17.1789328886230;
        Sun, 13 Sep 2026 12:48:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39db996bde4sm10689651a91.7.2026.09.13.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:48:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS)
Subject: [PATCHv2] dmaengine: bestcomm: make gen_bd init helpers static
Date: Sun, 13 Sep 2026 12:48:04 -0700
Message-ID: <20260913194804.39939-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
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

bcom_gen_bd_rx_init() and bcom_gen_bd_tx_init() are only called from
the PSC wrapper functions in gen_bd.c, so make them static, drop
their now-unneeded exports, and remove the corresponding header
declarations.

These had use before commit 7d3ee229ea51
("powerpc: Drop MPC5200 LocalPlus bus FIFO driver")

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: mention driver removal that made them unused.
 drivers/dma/bestcomm/gen_bd.c       | 6 ++----
 include/linux/fsl/bestcomm/gen_bd.h | 8 --------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
index 61b5746e1a97..b5093f7445cb 100644
--- a/drivers/dma/bestcomm/gen_bd.c
+++ b/drivers/dma/bestcomm/gen_bd.c
@@ -81,7 +81,7 @@ struct bcom_gen_bd_priv {
 /* Task support code                                                        */
 /* ======================================================================== */
 
-struct bcom_task *
+static struct bcom_task *
 bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
 			int initiator, int ipr, int maxbufsize)
 {
@@ -108,7 +108,6 @@ bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
 
 	return tsk;
 }
-EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_init);
 
 int
 bcom_gen_bd_rx_reset(struct bcom_task *tsk)
@@ -166,7 +165,7 @@ bcom_gen_bd_rx_release(struct bcom_task *tsk)
 EXPORT_SYMBOL_GPL(bcom_gen_bd_rx_release);
 
 
-extern struct bcom_task *
+static struct bcom_task *
 bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
 			int initiator, int ipr)
 {
@@ -192,7 +191,6 @@ bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
 
 	return tsk;
 }
-EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_init);
 
 int
 bcom_gen_bd_tx_reset(struct bcom_task *tsk)
diff --git a/include/linux/fsl/bestcomm/gen_bd.h b/include/linux/fsl/bestcomm/gen_bd.h
index aeb312a1cd00..7253d308d77a 100644
--- a/include/linux/fsl/bestcomm/gen_bd.h
+++ b/include/linux/fsl/bestcomm/gen_bd.h
@@ -16,10 +16,6 @@ struct bcom_gen_bd {
 };
 
 
-extern struct bcom_task *
-bcom_gen_bd_rx_init(int queue_len, phys_addr_t fifo,
-			int initiator, int ipr, int maxbufsize);
-
 extern int
 bcom_gen_bd_rx_reset(struct bcom_task *tsk);
 
@@ -27,10 +23,6 @@ extern void
 bcom_gen_bd_rx_release(struct bcom_task *tsk);
 
 
-extern struct bcom_task *
-bcom_gen_bd_tx_init(int queue_len, phys_addr_t fifo,
-			int initiator, int ipr);
-
 extern int
 bcom_gen_bd_tx_reset(struct bcom_task *tsk);
 
-- 
2.55.0


