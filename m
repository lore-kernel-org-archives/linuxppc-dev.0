Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C4606A333
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+ZOAzPe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQldk2Drcz2xnn;
	Fri, 13 Nov 2026 16:08:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794546506;
	cv=none; b=ma/Q3uD9K2cBa+EE3tlaB5R1wsF6wy92C+ufy8vyXmUJiPW0+gzU2kFHAVms090yGQWhAb6TE/ITgYb3r+EDnJ0751cT46TAqRbjC8QSe8xDyYfSCnyPIcy/UirVKQ+0MeySj8McTQaRQ/fwabWgn079yiQ5o9O3DFXaRdaVWYbExkcaB/jM483SJiTPOeE0olI0WbEtWW02+BQd9t5JZq5E1dhoY6pviRyxPsrwed8/4NVlZKwuUgHOdDhuK+Ka4O04pYcLI3mQ/pl9YzuwcpjrWRxWlAmXU3uJiyyGyYE/yfAdmNKrk9AUi4bysCmrqmcF+7jlW0tXfc10V9fhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794546506; c=relaxed/relaxed;
	bh=o09ualb3KCuGKClH06bXyCu2n7iDMp017ct6YIx2Da0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNukq1J4rVAIT67/TShHA21qNTdZ7FCMdRrhtZTKceTzoewUP1DmBh9U6roBgufo2RpIX1qSsYqcu2SCrB6V3JG/gQVAOnyNljXBYtLJHOmkLlG3UD3TxgQMNRjCnTgVU7+VsbbOukXcy8VYXJACYqrcp7zNmx1QmVLV7a793KzYIqT1jWH1HC/7yNPPJjykhve39Le40wgFFDRGaMajOQ3ED2etZXeVD6oo+4WoWdYtS+OAgdrGr8qGN/FZlMABVhJAsNbEWofCwFX+Nmg4XlCDkS4sAXur48P335o/ypmiUHXuyZ3I9ZCNNI9CbCYu4vRcg2C0Ef8mbfrY8QEmEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+ZOAzPe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+ZOAzPe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQldj4v6cz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 16:08:25 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2ed06b725fdso11906475ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546503; x=1795151303; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o09ualb3KCuGKClH06bXyCu2n7iDMp017ct6YIx2Da0=;
        b=Z+ZOAzPe8LnFco2SH6lPcaa3x9aMCJaQbkg1ScbMYvVmvPEJOUb4veG2A4riNAj6vQ
         7BroTvTZzDPtdgU6daxYtBPLzwqGSZFrdsJp1dVArzXOl4dL/2NZjK/I+fxZ90KFCNmJ
         LwztW3okjpW8A6gNKDGWnSUDr7NyMB4SlM7FHDY5AkP9rVhnLPyIJuz7lzXHoRiXwUP8
         wJv+gnKRDq2n8iISp8IyRV2Mm3GWeFXjXAnrca9D8WShF3CGdK1H8ANVCjcsUy3Zg5+M
         ZxjRE7pAaZmrL9VUbbANiT69fOY6qVBuFOyznyo/QYImVsEiSM+Ee7ZuDjvSov3HEdBn
         xd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546503; x=1795151303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o09ualb3KCuGKClH06bXyCu2n7iDMp017ct6YIx2Da0=;
        b=fyytqPJCSi6pEUdxaH/FLKjeVMHCDrrk028CWqjjeen1lBMXa7iWbLTHbILndr9A86
         a9+eO0ULokTgjYwndoO3LjoxJrw0+3dGH/X3zPGM+f6Wiz7J4uIHSu4nUhRyS+iNKZOp
         sS+097RNjaFtc1OEl7MOvn+beW4Y+z5KCvsatQNtO/2pPTC5P4iZbLRlvRLvaOrzYKQ4
         NP8yDQSTkImczjKWflE9rBDTU22+kcBXqxZcAG6LnyiE9tVo/1XbAdspdhx75q9IiyM0
         iZOOnYa7ZZtmX+V1lZgMfQJ1C1oL4SCGOI5LXexMVoiiFn0Bhp5P/DMihtqVA/7Rna/P
         Mawg==
X-Forwarded-Encrypted: i=1; AL+hErE4IVeiMSGBtvDIXLZ0eZeOqNc3Ym+BjGhOSwQIsv3p0O+/DbNk7XMqRE+8ijk+h0ES1UUjeSkEhto2HVM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+3W+nEhvsXm6VqLvdsy5Yj4ZdqJl5ZZtGG7sfJL570xXst9NAb
	xp0jS9MoO5MPRllZLwjkmBTz9U2HutGLhNPlG/g8rco3KZXbnJMC+auu
X-Gm-Gg: AYBFou048rwe57EZ6mFpanjWK3u+API+7h2hf+iVHBdFpOd05SjG/3QZptTRkx0tb1K
	9fh1tN3Y1q6qUpCNbRpW1LuoC4MOghP2uEnbZQ6dm9BRFoWYNRiIUI2Sgxt9/dMnEwH2IKnHaZW
	G3L1ZO5qcFZDHH0S4y89/E0+naguUBVA8R4RxY8SPfhNUAqosYa6Q+JZV4jmHqUIW4fNA7N8V1s
	EquPFUSibvI8FXj2OZypfmmN/H1qkPjnBjQ4c0pY6IbOCBhx/Zol/Hirh8CryowF+pZbJALorta
	p+8/WDyzr8uOdzODrLGKH3F5Ji7ukcPSybJTa1r00SggICYytaFOPsobzykIN6xoPlJ6mAj5n5g
	sg4sk7hkSelKlFLzAIwPsBI9KZr5z4yd62bktFyj4uH59YACXMXHbWegxa3H5JyupmS86W9xxZE
	XW1ZcFK53+Ooq+wnMz4xbpqMAXckUL3/w3PUK4o+TPSFXKl7fdxcDz6HDVUCeen/KvVL2FW2cIY
	xeyrOfLPGeZlSV1JQaS64kftY6x4dsAqFJJdxVZ9AZ+zyt1w3314dny7J9CYJTDDBygnD9dbTc8
	FsdYOTHWIJAi6jGLhY1u3XhY8vlFLdKPJKJkNJEXGr8GiEL9Xta9c0qkQjIWGMM9gBv/E7yPqPJ
	OEkbY8RVyx+wW5lsQuwxDxdmQq9GgveyNRrOry/Xg9Uq1
X-Received: by 2002:a17:90b:584b:b0:3b1:d40:2c4e with SMTP id 98e67ed59e1d1-3b1b05b69damr839963a91.0.1794546503542;
        Thu, 12 Nov 2026 21:08:23 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm7643420a91.16.2026.11.12.21.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:08:23 -0800 (PST)
From: phucduc.bui@gmail.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 6/6] ASoC: fsl_asrc: Use devm for m2m cleanup
Date: Fri, 13 Nov 2026 12:07:27 +0700
Message-ID: <20261113050727.14053-7-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113050727.14053-1-phucduc.bui@gmail.com>
References: <20261113050727.14053-1-phucduc.bui@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

Register fsl_asrc_m2m_exit() as a devm action and drop
fsl_asrc_remove(), which has nothing else left to do.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 317ce0a5c765..c8db02f16453 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1267,6 +1267,11 @@ static void fsl_asrc_runtime_suspend_action(void *data)
 		fsl_asrc_runtime_suspend(dev);
 }
 
+static void fsl_asrc_m2m_exit_action(void *data)
+{
+	fsl_asrc_m2m_exit(data);
+}
+
 static int fsl_asrc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1479,14 +1484,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return 0;
-}
-
-static void fsl_asrc_remove(struct platform_device *pdev)
-{
-	struct fsl_asrc *asrc = dev_get_drvdata(&pdev->dev);
-
-	fsl_asrc_m2m_exit(asrc);
+	return devm_add_action_or_reset(&pdev->dev, fsl_asrc_m2m_exit_action, asrc);
 }
 
 static int fsl_asrc_runtime_resume(struct device *dev)
@@ -1648,7 +1646,6 @@ MODULE_DEVICE_TABLE(of, fsl_asrc_ids);
 
 static struct platform_driver fsl_asrc_driver = {
 	.probe = fsl_asrc_probe,
-	.remove = fsl_asrc_remove,
 	.driver = {
 		.name = "fsl-asrc",
 		.of_match_table = fsl_asrc_ids,
-- 
2.43.0


