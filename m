Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF48606A32F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yv8hzOph
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzSK6txDz2y2R;
	Thu, 05 Nov 2026 21:43:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875425;
	cv=none; b=Ro8kAswaWtpqm4sGWkYJZD5v5l0pIyyDcLvjUk6P3meAHPNsZKX0n/cJN5bjwugLHURI/H4efcRu8ys30atxGz6Hx4q2aV1AhBiONplLQtM3B+f6xDCdOX7a/aKFWzae2eWsu9vJnYB6P9eROTnPPhUucFdMc+2tQFBbIYtzcvbR3DFh1luNUXz9ZrY+XQJARk9ZxEH5ttkBPNhU2wIeH4qMwV3akqMV6AP4V/Jxpnwy8Z51AnHwxARgjKYZ7fw3p5ECvzTY/TGq9fzysmMiS91lvWVzzkN1JQm0uhJDjp0lvQOYdq7YMmxScOYnzRhg8ApLg7Lfu1WaOsV+PkFeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875425; c=relaxed/relaxed;
	bh=uXICPYwChrk17gf+gSy2co454kHftdzrJdqzDelhNpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5v41vM+feRpUS8KBoQ25dWcPRpD4lQrt1ezgsga04EzuLqDilwRd49iV8zeFfTn6bbmC2wqGJqw4EZFSNPJe1FX2izsg0XgjUeu0+weSPVQlJZDlWus2ZrtNQVyr3rp/rwj5ltdU5yp0U2atsR+gBXDHXrFwPZot6lPN70czZzfwLfXjfmsJcUDhCo79oCObCkQJX+UfU4rKL7BhI0G8qY6XXFGzotlJ4gEDdO6obKUc8/A6LBzNgvzhuaEsuL8C+MJShh/M+ncHaT1zfn+aOb5S3nzAYlE4xq+RphQd4lGP+vo6ltKJuRMzfLip3SHpxB91+ByIWuHrTdiTMF94A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yv8hzOph; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yv8hzOph;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzSK1wmGz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:43:45 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2908771eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875423; x=1794480223; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXICPYwChrk17gf+gSy2co454kHftdzrJdqzDelhNpI=;
        b=Yv8hzOphosgpsJdl9UVpmHq8g3GBILsMsFcUSKsvpixvPLmizQcgxlLjX1vN+Gfsq1
         dVfXRzMidsZuETCZAR6RQ6pLSwwU0H87yzGM/oJpvg+hgBfcbRlDHQTD10afIrWJcLyb
         NtWePBPw4yH+dbkBgUXaB1lt/bmpZmKGDESn1SQy61H4lylXSDGTdbN4Nz4ucHTf5vWY
         Fa2syoXn94G/I7eYrnB8isyBdb7pyWA+ZmF/kOObbw7s/Y9FvuSGcu396166Fs1uEPAr
         8Cmq9iZrkP9aGaNgSsi4QW/DvZQhOdf1QTuY9T5B8g/apK5W1XvOVjcVMlmeGxcsZFII
         ilSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875423; x=1794480223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXICPYwChrk17gf+gSy2co454kHftdzrJdqzDelhNpI=;
        b=VeftZ6IClKthMSh9g8+d5V3zcNcn2u1j1aH4dzzk8vWbt5w8TMWC4B1S1AhVur+7+P
         bnI2U/Dx7xNMRp8TMpXAmSjHIvZX31z6njwnBUCLyID4Kyyizoi4FmNHBn9EmgDy/4sw
         i3s4x20cye8y5eGl/ZIFxKZG2+nyjqAe6eX/X9YXgGrIUi9JEtI0pmgsXRvXQ1i0PxJK
         e43n/AIb3/Ij9CwjpaqvlyT4U+ZH/fqcYDPNBdFcCX+Wul1goijHjhUB1iJZCjtgCErH
         HsE+zwZoW6qAkD3aLQTfk9oLgbDDmiWHVC0TsW3hSBl3p+GmOP4wsC7GmLk98DZdDDpO
         h8oQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+wBI8hML+7JWemLcPd2oeQOHaEEmaHL9vhZJbRaYIbHn0pnxdgvYPeJtKKomooqeSxiD3JPWWzMm+x10=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8fknxIx2OH8G9Wj7NA1Mg13MuMxeqL5Zt4dgQyAk+vgbWanxyX
	qpVZcBK0aHmaVDi8oeof9/W2SBYDvgCQtIe8Z2+haE+nCpbRsdIBIP7k
X-Gm-Gg: AYBFou0PvoFEMVyWACSI6b3J2HLr0g8uhi+AjM26a9VU3EZIb/7fvmfliGRJV+1iy0z
	D7XgdgDrjyxVlUPsZHloFUNEjeeuHq9E+NFQ6OP72i/Ar6N/i+eHcDJq6PpBhKvjUkcbiMN6m8o
	y+Z88yabtj/kONAW44H+9ZdERRlNtzvhfRRrtv26VCksqdkKPl2gF4N2h1Tm1Ld8ONQDa1zYUkC
	nUJ+sk4+AQ9DJONSpCa6s1KqMLh6/w1aSom7s79bkg/pZi9wfxQEq43IVrozXQdCCP7zXUfjlDo
	D29bZJVi8Y2XpW2/JDTWFxHV0ccmiFMmQ2/YD/ogwpEO8IpBeqHT8Jp9rE3uaDcmy1Tdxt9/83R
	MT8vC+3xSffMhqYizkrZOiTiuSvYLpyRKUBEi5hjr6msmhW7yLe80lw039yB3fgCLcLwy8VD0cv
	qW58mlpPm1h1l3hWIqo1jxyUws0K8B+STCH4SmVmyGS17yfUrFXyxX6QqRBekebMgvT/L/2Jocn
	FvJGkk7IQJ/4XSN9cIA/xlPp8Ncf1Z0SpQokGtbAtaKAq/Y6XbeT3gW+Xtf6yJf4Az98xdTyKGr
	KN4HnturtpPfUdjzb3ZZjD1Z7kDY1Y3DWbf1CuvmgdHh7EhPcsBygKm+JqFQEiusAqI16sLPYTt
	7S4hKGjTHG9Dm953rQhF8xq/erHcbXObx0BayppF2I3E8
X-Received: by 2002:a05:7022:f507:b0:190:d9bb:281f with SMTP id a92af1059eb24-1ac5e3225aamr26533948c88.18.1793875422948;
        Thu, 05 Nov 2026 02:43:42 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:42 -0800 (PST)
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
Subject: [PATCH v2 06/10] ASoC: fsl_sai: Warn if TE/RE does not clear on disable
Date: Thu,  5 Nov 2026 17:42:33 +0700
Message-ID: <20261105104237.38542-7-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105104237.38542-1-phucduc.bui@gmail.com>
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
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

fsl_sai_config_disable() polls TE/RE with an open-coded loop and
continues silently if the bit does not clear within 1ms. Also, if
regmap_read() fails, the loop condition evaluates xcsr uninitialized.

Use regmap_read_poll_timeout_atomic() and warn on timeout.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 8315a0d8893b..f75a1d61d7b7 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -849,7 +849,8 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 {
 	unsigned int ofs = sai->soc_data->reg_offset;
 	bool tx = dir == TX;
-	u32 xcsr, count = 100, mask;
+	u32 xcsr, mask;
+	int ret;
 
 	if (sai->soc_data->mclk_with_tere && sai->mclk_direction_output)
 		mask = FSL_SAI_CSR_TERE;
@@ -860,10 +861,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 			   mask, 0);
 
 	/* TERE will remain set till the end of current frame */
-	do {
-		udelay(10);
-		regmap_read(sai->regmap, FSL_SAI_xCSR(tx, ofs), &xcsr);
-	} while (--count && xcsr & FSL_SAI_CSR_TERE);
+	ret = regmap_read_poll_timeout_atomic(sai->regmap, FSL_SAI_xCSR(tx, ofs),
+					      xcsr, !(xcsr & FSL_SAI_CSR_TERE),
+					      10, 1000);
+	if (ret == -ETIMEDOUT)
+		dev_warn(&sai->pdev->dev, "%cx not disabled at frame end\n",
+			 tx ? 'T' : 'R');
+	else if (ret)
+		dev_err(&sai->pdev->dev, "failed to read %cSCR : %d\n",
+			tx ? 'T' : 'R', ret);
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
 			   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
-- 
2.43.0


