Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429B606A337
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XpF7cYr6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNzZN70Zgz2yCr;
	Tue, 10 Nov 2026 18:59:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794297564;
	cv=none; b=GjwVMnyahaqDoMnZRFJmKSjMvZhxQ8ToWQU33HjQfkLmD42Q0NDoUNp5bMC4DvTywI/ZntFdcTcRJ5LuUEZoD0LpVs+FxNFMef7jKHptjd3wZFud+57baLeyUR39InYue8Hk1ij6QislYYmcXqnbcX/iMuxGEhqMWjc+RRHd1fKHP9fmXNsKOhXmivYyFMJ4efkbaO7tWdTosAaynNEn54S3B+cBef7cdxyRHTegVNq5ZkXv8ZKukSlLS1GGrCR+5v6vt+68yGIO/Crq9HdtlCSrgUU3NFZbvkXV8COUaQ6HQfOCeLjMAOBrKEWllebECdDjTQwidKbteARR5OzW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794297564; c=relaxed/relaxed;
	bh=A3AZfHlonGfOYkB2NhiE9hp9NLJUEbt7yri4wujwdi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqj41kvOQ/dHRh9lUFQ2xJ1nxkDohsFu2QX3ZksSTRheaiI72lIN6nJMY+/C05UZvQiT5nCfu9IWCBd217Qpgcy7tNLRa0Lj2j6JNSlN8t8XIJ88kyx7zepen+KPCMsDlHiJceNWoorUaiPOABuqWQfMNYzBT9Sl2QixnmTulLEi74vmSKbth02BIARB5o/JL9NWw9ysQVVZEIfss9W5YkyTIhxARKCVOiYudOUdAKUsqu3zChulDfu/XFz/Ke7520A+VEzIAHnVZcJX8W1d6XbL/n87xHn0E5rAyYSSYyKwe4vosMiZ0msKXEsrmGetsvQv1Yg5ZUlJ/UkZvW81Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XpF7cYr6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XpF7cYr6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNzZN2l4Kz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 18:59:24 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-36a315ed211so2001660eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 23:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794297562; x=1794902362; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3AZfHlonGfOYkB2NhiE9hp9NLJUEbt7yri4wujwdi0=;
        b=XpF7cYr6+7371432H/X5Xx7R6Ems8KreZuSp7wgHOYehJD5xEf53ptXMI0Ry22ck/R
         sNTZ5zaz9dWfm+wRZM9sHYjblKv356U7qzikuQkt0Ob2yUcRkfZV6SnONA2iXR+4D21C
         KRG2RGfiQpg4sLn3bO8Gj5ldVfXKU4EO5WYsN3eiDWvGiz6DVPJGbaPmKloBxGO+tXgo
         MDTLJdncf2VPr2NtIAfM128AWMcVuXoI+vQ4JaBWGk1ZVwFf5SuSWaX5aB9QY+EsGZOT
         Jwf1R9u622DjmIe2hobchZgW6t3OoAuwPmQQDoaYYY1BHywus98lvOkcdT44nob0QqE7
         b3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794297562; x=1794902362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A3AZfHlonGfOYkB2NhiE9hp9NLJUEbt7yri4wujwdi0=;
        b=vB44++fHWGEjvb98gZ9JQRlMTL22nkNzM32WCbgkHIqy8+md2zGxHOho4+vs0b/Ucg
         SS1wKQGrxXaq8JXBuBOvtZdqtFmateN4G4Ro4ZeTWZ9tlQ0nsGQhdPSo2vtXqktNEGyM
         VKEKyJouwByYWZGqsb8MBno+oz0So1V0ciuP8BZW2AOtsJrPKCtPz5YNGdfjv/hzxg7S
         kWdtpXNh8ecMJeMcSwPYsTz4UE1cDn1Mk/+Rm5GrD8ZVKyKXTsJ8vPG9jvKEfzOMX54+
         TSb9YXoBDFagbGRS2hccNsMHuLlroCoz++0zl5Q88DseKyWvdfdxzhZ3xfzI9amWqn3m
         Iw6Q==
X-Forwarded-Encrypted: i=1; AL+hErFqrM1+bJQWhGUDlEkG5/ORVMH54ejl/LYqe+O1MOqX17rfueTmrii3aXyz08lOPkRTQRhGzn2NuOfU894=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8pKk04BVYlD86KuNowzWdhdB4/hRogsbqPvbftJQFz50yb0fYO
	3JIUAqL0Hg+5mxbwTXSMBLMsEcj2Czb0o6glEwYTg84RcVIlKcRnRkEj
X-Gm-Gg: AYBFou11ozLxKhkXU5MC2ckEdtuc25RvLgWsbiUpV2zKRA8FNDlR2gfOEbRMbtzpDbf
	OfqPFc2Ta70sbwX6Bj7mQ6rjTt88E5nHJI0bfl6WqlsTvnn2ksSDOY0KH2O2vLBJ61TkooPRmsp
	HX0yim6G3WwC9xeVypsF98SFcz0/p/25urlobjFxcvo5sBYLOB4d5Rr1QfAC/a8zi3rCH/pkxhO
	zsinUx4ojX++TvcHq+fzeDb9ji9SnsQpUviVDcsxWszxjWt6Yhg5NQq1ZloQSyG6ZbLiARxa7mq
	FLuW78cCiClubyyPyK7TeBQhTxrJfDQXVfYz9Q6VcMi8ORyDUzF4d0cZmjesLj+CeYd7J/e4jL4
	2WP8OM8/YSqk0EjLNkeI0fB0HwDlt6izZA2ERu4U9kVMzhLGp8ZANDByP2qW8MdNLkZZssJrrWz
	ADoGSs7oZBrEoeSq12qA1GTPpBmgtRUUd1eLYv/Xv/4FCOQOv9RWeEdAJUxIDgOrgpeQm/f9vgx
	bfUtS27tydPVUKkZeJPnejwITZspniGKxd5jv3c9F/DNqQOl63RWTf8WsQzSG/opKGKYYlkY9ss
	dZU6Zs6wM3FW/lRmwELPf7ovuoMwLK1JnOvlGfHzipPl7FOTMhEjk1+ryQqrjkCCbRmvApppLrA
	XYc9+1MGTiHal9Vn6zP6HgBowjodJbdNjGqGsUs995qLj
X-Received: by 2002:a05:7300:e9d9:20b0:36a:2f6c:490e with SMTP id 5a478bee46e88-37508f421a2mr2946764eec.6.1794297562223;
        Mon, 09 Nov 2026 23:59:22 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm4498321eec.3.2026.11.09.23.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:59:21 -0800 (PST)
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
Subject: [PATCH 2/2] ASoC: fsl_sai: Report dataline configuration read errors
Date: Tue, 10 Nov 2026 14:58:41 +0700
Message-ID: <20261110075841.12104-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110075841.12104-1-phucduc.bui@gmail.com>
References: <20261110075841.12104-1-phucduc.bui@gmail.com>
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

fsl_sai_read_dlcfg() returns errors from of_property_read_u32_index()
without reporting them.

Add a dev_err() call in fsl_sai_probe() to report failures returned
by fsl_sai_read_dlcfg().

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 59c9b8c28133..16197f9ac2d8 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1621,8 +1621,10 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	/* read dataline mask for rx and tx*/
 	ret = fsl_sai_read_dlcfg(sai);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(dev, "failed to read dlcfg %d\n", ret);
 		return ret;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.43.0


