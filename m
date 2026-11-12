Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72143606A8A2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z141eJor
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQHJS3h4lz308H;
	Thu, 12 Nov 2026 21:51:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794480712;
	cv=none; b=GVV68gbN12/mDbFdaJzgZPbUrfK3EvLiBsxVV6a5sEN/48iMJscL1Wd7zcDHCAEGmEJu3tzM9iIdHjg4JIrSM9xxqkrCGd6icncYd8PoRrPt09NnHRF1iDncp8EemjhC7KVs12grTrnpYXnkyWmJ7hWowR5C4PRKLi/6UqsfRRHw9CvxQ9naHe92gaa5sE7Vp4vqG2FdgmNEcbCZgY2axvr31eGaIEv/yVGFg4CEtCYGyvC43k7QV21/Lr1nfftvNZttomdSb61wnPqFgN899vDdxRgP9MJsdRdIZD2g0jcbDPxZWYQ0vB7bt5HhQgOypyEQ+A4PuoR6yctD0n4Wew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794480712; c=relaxed/relaxed;
	bh=y2Z4k53MZ5CuMtRn2UaTr841R9J/LmSKA80BVWLhtkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+EnDaRw63sQ5qwXyKWhjPiHktVGhQFAYpIan8coiGhEDU/eBxgsd7tVUjBAeTJZOpDT21IqLRdJdTZZ9Sq8lgdtXL+S82wOfF1Gcl4Ksok1YDhLufFahatrePn1pwZbzgEdyZMB5GgHc3noZxwOdolpZ4PlO6AwLQBU9g8BugBcwv+yLsKEoQWCXCd9yQQhnwZchmKTFclOxU24m7/oMPgPg5xIV8HkbJPyt0g+SFbOs/1f4OXcbPn1cUWY4XAAg3bBJeOd935ipixHrgBgDcmKhHyzJG9HZzC96V7d0SeyOVPWqU7bjbg3zuxW1NcAzWLnBnAfJ8PchjIwL/zptQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z141eJor; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z141eJor;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQHJR6YTwz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:51:51 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1a2af4c8d00so4373139c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 02:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480709; x=1795085509; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2Z4k53MZ5CuMtRn2UaTr841R9J/LmSKA80BVWLhtkM=;
        b=Z141eJor6mTjNxUu3N1j7q0FNgZrXLcavyNt+DerzUOPJSHWDhENTT1bo1u7yR2WDO
         lMm45jpmA13yWR08mXVD3a9LcRcBpvWq8M4e7AwFq+zoe/84iETTqRiwU74GGUurZ8wW
         r9WzrO83sxE8KBmZ5eZzTI1QWvuBuHT+gCTtHp8PkhofS+HxVUgFXxcZ6rblTDUA5t3B
         5Yw/ReDLwg3LbRwNyGZgUpCfc1Mzu+Cf4bhLU+vHyHOsLEMUXL7AdWS0ykNbkeZqV0xM
         SD/kp0xMOOmoHT9/BdLdJyXqjggb+0jSgRwhB6pSSpkRoNKQewrdPiUQZ8XJtLQW7NVu
         AgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480709; x=1795085509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2Z4k53MZ5CuMtRn2UaTr841R9J/LmSKA80BVWLhtkM=;
        b=JhEv5OciungW8rv24FLeq7N4U2/Yak2P2eXsV/CbnzZxSaLhsF5sY9qYQBgbi7Nbh6
         jELT6Pm60vYyd8VLhzgy3rG4YLwhMVEss6GvnXxLShrF49HPOFv1W8wfuHoja16NaXyH
         Pgz+c7TqIkPcN4RxdxFIoCEehMGXR9nKtlh4SLA9teCy97rwKt9fD0arfkTctkr6PV9c
         tgZhLe7Tq7fZsZ5oXZl9XIX6NTW1VXbbzNlTuxPBeLxqb/7sWb3eO6gSm3vXK575UBi1
         YTBphBqWfCZSo4Ajy6BNAsEQ4DQXmN4+kLkHJJTfZAtVSom1bJ9G1cmrKRUxz8ASmtT6
         2H1Q==
X-Forwarded-Encrypted: i=1; AL+hErHxvVpT9WPL0EDqEahOTLClZdG9FcaQ3AIUy+ZSrowt6NN37tPT+wwlVk7I8hQUDMPMYu7QEZ1uKyVeOao=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/7aXxgBnr6ERShBaoyfiafm6PHTxQfUzPeyLAABK2UUbJJjkfJ
	xSnAClstoUsXoMfFJaVOPmzkdeDF+iS3zpv5UZsNa7sfH5T7g1gLA8M9
X-Gm-Gg: AYBFou2tHqGOMmPjEKiKX88PIMJ1C0Q46yS6ioz5vITU1EybOQBZTx3PNUXHLFMquqO
	+p2UenDUJFE0EAFer5ASSNKQAjg86AjTvND5mNK5Bquo1Zfhb4vp0MPwCRf/2pD5+1FSk1Hj5E2
	GwRnR5lXM01FjvSloLJfZL2RCsSwHAG/6UeenP4293cVZN4VqDIwmuk1UXhA+NS9Ma4EhdDm+4W
	7HMnyFl6LLHb3aFkWdaU/ggZLVKGIB3adn5cLFQTDj46ghGf2k0A+L9jdHJZpjvBhXeNsUPz+H5
	qzQ/RIHz6763xtXAVZPNQGTD8n/vGKY9E3qrH4DHFPIabKz4Fm7H1sBho5WkgxA0CG2nJfExI+e
	b0/AgyFlQqmyf0+/VrHKXxui1bDVI/PyXwgZQMyb8HwXH4vb5aJq9b8lokTtEVt4s0Oozpr3w86
	ZPIrKHa8qFTDI8GiSUXdEyJwyfNuz5h8vPpjbxh8mrMORRML4nxydOJp+csbf8EifrhuokeIiKj
	FuLzjow21CYwDDksgm0MIh6V4WVH7k8TfujzydYMbeqJwNI1YqCFbDhEjWJySjLHtSiK7mFfzsV
	2h8f0t0b/VgaEwf7ax8LCnANNr6y27e7c+hivKMCIen2r8JE92lLh3lfNCw6+myWH+9D4y1YGKY
	/gWUpjcYTi6egOwx3V7jW0hzxI7Cb7NUcBJKBV7KWVHZQ
X-Received: by 2002:a05:7301:2121:b0:358:eccb:af7c with SMTP id 5a478bee46e88-37686467c11mr5852796eec.33.1794480709185;
        Thu, 12 Nov 2026 02:51:49 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm23047232eec.9.2026.11.12.02.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:51:48 -0800 (PST)
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
Subject: [PATCH 4/5] ASoC: fsl_asrc: Request the IRQ after the device is initialized
Date: Thu, 12 Nov 2026 17:51:15 +0700
Message-ID: <20261112105116.32274-5-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112105116.32274-1-phucduc.bui@gmail.com>
References: <20261112105116.32274-1-phucduc.bui@gmail.com>
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

Request the IRQ after fsl_asrc_init(), while the device is still
runtime active, so that the interrupt handler cannot run before
the device is initialized.

If requesting the IRQ fails, balance the runtime PM usage count
before proceeding with cleanup.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index f7ac60724c6c..c97f814d7358 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1299,11 +1299,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
-			       dev_name(&pdev->dev), asrc);
-	if (ret)
-		return ret;
-
 	asrc->mem_clk = devm_clk_get(&pdev->dev, "mem");
 	if (IS_ERR(asrc->mem_clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(asrc->mem_clk),
@@ -1436,6 +1431,14 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 	}
 
+	/* Request the IRQ only once the device is initialized */
+	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
+			       dev_name(&pdev->dev), asrc);
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		goto err_pm_get_sync;
+	}
+
 	ret = pm_runtime_put_sync(&pdev->dev);
 	if (ret < 0 && ret != -ENOSYS)
 		goto err_pm_get_sync;
-- 
2.43.0


