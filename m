Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFB60A3816
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBaG+Wji
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNzZJ1qp1z2yqs;
	Tue, 10 Nov 2026 18:59:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794297560;
	cv=none; b=ls+AQJXbWpsDYg1STMMDVpqkkv0vG9+UsODAjT0ZHHyVyPP/r5b0OLQdwyCFDoO9CAurzwlERZmYkZLKeqeqLdw8Il0swSI8jd80YFsTV3wxZQYLTypZOA4Wbq15Z1T+tmTs4kYKOIKjjTqz1bmpa4QS3rGGi4IMpIiOqGqHYTRO7nqKfWYnLj/VrReTojpkbOmVzZFJ8txa/gifuNg9mybVndGs4B7EBjyOtbXeMv05q+glEgZV7mXGP6R9vnmtTVaLScbSLM3eAHuzqEtREbg//wouqOH4bygdfmm6doJ2KigCm+V2pvhW85ggOZL42b465+j6vTAY7lhrrevl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794297560; c=relaxed/relaxed;
	bh=Y6PKiZVhgPoQCx9LcIllCoQr4zQzHDju681FGCOxyQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4eDJa1yoBXecFJUG3lSbCNLoThibGVG0C2TNvioIECjuFRYpujnEMakIDFFbJ07LOUmbJ85PkWpgnfWlgztTC5UWOD/OwufJXm+xUrvjqffEV2nXO/d9sNmfrK1xdxEnoOH2/whwXI8LicRXwHAm2pXNkjWVee7G9c1ZRqcTY2ZuPUH9Slvi7znQg+dJi8q8LsBo+98a3XLlFro0Apyr2kNNRtD3o8kIhKVFJ82OiDPRv6ZRGuwpQ617y5YU4ZUn7aMKzd6VriyuhuH6+HrYyi+KfdSOrPjwljpnxUviJuMjsO2HUxwQAuU/oiVVg+W1kF7ZgYYEZHI5TMGHxaQjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBaG+Wji; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BBaG+Wji;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNzZH28m9z2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 18:59:19 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-36f8cdd30beso2305021eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 23:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794297557; x=1794902357; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y6PKiZVhgPoQCx9LcIllCoQr4zQzHDju681FGCOxyQE=;
        b=BBaG+WjimbbCjNstfiS7c+2cQl2iJ8N3kgnGt8ZmCP5YVN+7OM0z2FsiBzq+yRISYq
         lW/Q9GV2f4FfavUjLQC8dd7ycFr5aV6szTWlB7Eo9fgpdFWy2mOo3/XShAJu3AxPfoB4
         EDMcnpR2hWh3NTCuQYhGnOaV8JFVTzdJ4a62n95Q5s6l083blZbKbXgTqtdOp+CdtwOR
         dRAJrgtKPVNi2b4eOindtlXvJFu0KOSFISdlmduJLf6MQuFFDnMmdNjbXrrw7rvLk7uQ
         HtGI+LFFtICQXg39nAcHvdgO2piQyreVi6Kf39mPIarwuwcwnixWupvZC+6nqIertv3E
         Cdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794297557; x=1794902357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y6PKiZVhgPoQCx9LcIllCoQr4zQzHDju681FGCOxyQE=;
        b=xVHvrn6Bjdg+62Y4H6SdX0dvWHDpS7FoBSSW4N6BCwUNzOfmGipCBY0Wx5SUr4knmS
         rjQmI5MLgJOpCNe2l3zecBBmjq8+8HSa42xR5DNuBmgds+n5EZ4muLNXfuxrsHnq/0KJ
         NG76l78jqR+e0oO8df14xnM/gvy5xAW6bUqRgQNm2rCwM/7ot1EciSVyg4NdwqAUxvZ/
         wo9ZgArttEQJJi9wBWGcJrcqF0vidS88rcO5Lt4GZ4tiMBk8zD8zxslw+vKyLDACfPv6
         WdYMqAKdixz+sP7I48GuQ/rVzRulNJw8urK28X2Glz2mNt/GKe0IklhSRhGIej5Zehmz
         C7QQ==
X-Forwarded-Encrypted: i=1; AL+hErHGqS4XyMxpAcrq+mhCkPFEKInYqsMX8G7CuUY3aA/kIM6BINBWKrxt27AHO8OZqGIy7l662XrQau4zeA4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8/48pHZqZmwNl8gbms8LW1xyg7xhbwx9vV3j7pSnMhCy1NGYId
	fQpnS1VffenArEsoGXhfgzv0mSxaUmIKgC1FLeq+Ya3p+g7dYqns5UnC
X-Gm-Gg: AYBFou3zOqDKPvLel1K6Q6Lp76IIVZ3npfUXghKEiO9GTGfqVNa8qdeAm/iPAuu7kqf
	cnMFFLp/b02kzIREZZ1wLeds64RAILr0w/ZwQ6PcSkPDCH2I857Z4bGjz99QZuUN8JLLjUZQDw1
	RCYYNWorjmUYbjeu/paibSIHXXBKOzfVRQHNxoJwKJr6krZYz+ZiVNT9B99YI+bLTBwyIXfFicp
	bokRFKuEWlvtsVxeL1mAz2ZPMxxBp0GjPtPIGqX3rgStr6mi8nLmzYgTQ0RnsvfVCqnxSJ8sGWf
	UuJTEnZnhaT6hj1mT29YKaAqbqkzTDD8NzDXq5d96LUF5PA07T0Q/e12xIOyd756OyuTfVgv/oe
	jTjzU+9rkX1Z34bgmV+yrVT8ep3XJzmdRhXDmJkytRVB/uPH4S9F57oIWcvVjMG0gK7dv0455J+
	EVijr2iOw44CYV98uv+RWczSmNVw3AeDdhD4zdAJE2KoeSQRpFJICuwTxfIX2MslVjOP1tWa+V1
	n2BDymqYJBFJhte6hQYG2FOm+woAxzk18ggXtcTNcJ93kFz/JzHI4C9O/LAqis9+ilL/0QsBR7+
	nKAVMfjIyuH5lXV2R1vLOvomPBOesTxaxYmeKMYyxjV6Og1/c00ox12fN89vqoZxiZCx2XLuSK+
	JR3PCDxOPsOBNJG/nQfhhVoY9LIn6aqR6dHYnGF7USNY1
X-Received: by 2002:a05:7300:80cb:b0:36a:1d6a:596b with SMTP id 5a478bee46e88-3751f56137emr3803806eec.29.1794297556929;
        Mon, 09 Nov 2026 23:59:16 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm4498321eec.3.2026.11.09.23.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:59:16 -0800 (PST)
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
Subject: [PATCH 1/2] ASoC: fsl_sai: Make fsl_sai_reset_hw() return void
Date: Tue, 10 Nov 2026 14:58:40 +0700
Message-ID: <20261110075841.12104-2-phucduc.bui@gmail.com>
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

fsl_sai_reset_hw() has a single caller, which does not need to
handle its return value. The function already reports register
write failures through dev_err().

Change the return type to void and continue clearing RCSR even
if clearing TCSR fails.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 430e896d064e..59c9b8c28133 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1410,7 +1410,7 @@ static int fsl_sai_check_version(struct device *dev)
 	return 0;
 }
 
-static int fsl_sai_reset_hw(struct device *dev)
+static void fsl_sai_reset_hw(struct device *dev)
 {
 	struct fsl_sai *sai = dev_get_drvdata(dev);
 	unsigned char ofs = sai->soc_data->reg_offset;
@@ -1421,18 +1421,12 @@ static int fsl_sai_reset_hw(struct device *dev)
 	 * Bootloader may leave SAI running causing interrupt storm.
 	 */
 	ret = regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), 0);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "Failed to clear TCSR: %d\n", ret);
-		return ret;
-	}
 
 	ret = regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), 0);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "Failed to clear RCSR: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
 }
 
 /*
-- 
2.43.0


