Return-Path: <linuxppc-dev+bounces-27565-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DF0C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 12:11:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlvkc3rLLz2y7Y;
	Thu, 17 Sep 2026 22:11:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789647112;
	cv=none; b=T0BaLURhpMVmOSL7XHehzmD4J42IpnrFpOyQP20Xukl2MThV1JKunVlbEvrT20gj9lPTbmPJ59zAU8cJKJKGfIgI3Q3xpesRrdJ2t6bY0ojKBQt4QMh/2GoQDvxtW1bzsOIi2fK4DEw09hzxQQ39oTVE0WsLDZ3jHzCm1xru8lXRfHHgTy76wz+zmGdD49yaLs1HjcA70AumNX+1Opx7mEs6GKz/u5H0w8Rhj7t0ehx5rwR2nFwOK4vG9kpfTerqwohQ9J7kV5JL4o5E8nkwF0WqyATa/1+OnYHU+YFhDmw9hrf+vsNJOJU3lwl3ByuZbA3Ik2e/szI0NuPwO1q6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789647112; c=relaxed/relaxed;
	bh=3s7WaKRRlkRIaU7v5QcdZYP2vnYlxGT/Y2lUD7nlyq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVjmtKadqnh+nFX8UjjcHPDERWGHmnWLiRwv/OzJ/rMXuNtvsM/J8qV1wc9IcwD4TP1e85yJgxJm3CQPoiD0plxhIXr/D2G4x+YRhmShk8vXOsTzNNeYKHH0JfyI/U4IfzFykG6LjoSjhVEo1rIxzR45xMrqa8UW5EKMs5cRr3BsSiWmOmTpOP1N/4+32iJ9vXlT2GYxZRmQxwwwjCT9usKJeaFNlvQsZfo3+p5xvXmVLXrdhd47WHvr7Y5u47ZD1UHxq3K50Pb4XglufKtmFrfNeYefnllAum5brQHDy8rAkvuSI8HtSakVNRzEpQLANK6ulQxBooIFYO6BMjtKLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Us0mT7CI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Us0mT7CI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlvkZ5Sdlz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 22:11:49 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-39d654f02baso603255a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 05:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789647107; x=1790251907; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3s7WaKRRlkRIaU7v5QcdZYP2vnYlxGT/Y2lUD7nlyq4=;
        b=Us0mT7CI+kgkmbna94zZ8zkgmUXsFQOSVc3el0LwpN7oD1YPdl1sDPEMFKWrohodlz
         oaBf2ebWyWqd1srNFqAHWfTKh7JM9BC7L/AKCJvc/ha9JRTiTSWDhCjex8oUVyqu/he/
         ZaR8KxVcD4RB6UFWKleWhQ9yaXiMxA13CHvD4AKkJVjheorKHEHe5AnAaceDe7vPu0Jg
         Jv1B2gv5m9W/a5Jx70Hq2FUxrtTj09IWcvQ0YXvrHuD/IrviFK8q26Mi60A/Z6ftbba9
         LCefsyvchrHimtHFKgrNGDzzySTks3GeZsBKI7JPKBc3QEb04Q02ImpuCY61EDvIiBvy
         dqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647107; x=1790251907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3s7WaKRRlkRIaU7v5QcdZYP2vnYlxGT/Y2lUD7nlyq4=;
        b=gckv6ef4kmf7gSUiereKJJ0LXUWyTa0KKsLuMl95wHWTAXN80IoEsd5XW9bnKg8h0L
         g4ZJcF0hh7PKXb+rh0RylfrfIZDSXlFFgqSwKzAGCPhC+ZZF08HOaJg3PVh6nMRWB8Y0
         H7h9cz9SRNv6uJMCet4Fj7U3mh4HKK6WgSJfYzqqK8jsLqJsFOh/9odPAxyu1+uXeC/t
         zoDGWYvAcUssVnJx4hwhPZqlqlolE1GsWckM3nlExoOhBJy/vXZYB/8VJN5QAfAWLNoq
         2w7k6kHTIdCMu7LdMUZlps9CX+L0m/oIIihHjCjTgU+uPm8tUVZPvIJAWk3yPrjqYDIf
         pTYg==
X-Gm-Message-State: AFuF++lHyh4OTH/Wgd2kDSfV3vbJz8hVlxmfVO39ban2OMonMb8uzxvE
	qmhsetr1SxW67wShSfmeB2JXBAgazFitnsjTfcPV+ey9kDUp3AfoiXQe
X-Gm-Gg: AYBFou017WzfIoiVQMqPp1wovc1MrewwpRbi+7uOmjctE8LfJO9Lg1Gy2nOhDcD93HN
	oUDTe1S4UD7yQlTazFEXPY+8Ny4FImNZ0ea/BW+1L3FK4OFVpBGEHzrF9tzQ9/55dwQSjNCVHCd
	/viuxYZcn7R7W55yVbchi2vD7ghB3m9N8EwAa+2Un+y52d5DfrQ3BGxKMalUQaLxebsPKg0KPrA
	TxEGYyRjOhg6lfqCDb9fInBSsW2iZ9qVTN2sVotC4KsSA2WMvoydGPAcHOK7XnmjIX8ICnvYoZn
	PH2LXaNfELNv08biuYhsg8qwr5BWnTcXOrgccWm5jSUXY1Y9AnEceY63cYE+PQJWUoDKtHUOT47
	qWdKBbWpUTsuNs/Khfgd96xkmYD1MGJL5FOGX258Qe/0gGpNEZEQMkGilWhy3uratkCMV0pFRYc
	CvnioxzU0gDA0EBOfLAEFNcQgD3e3FsjA0KVFp8MKLLChILhojcdGhKif69JfGVbvvUNxVKov64
	/m+9rs5NqrBGov3NLH5nG+CASJjVbx2w4RlAyj7ZdO/FENhwpx+uYVtxIKYf8hz4zay/V8jA4F1
	PUXZKLtR9ll6xU0=
X-Received: by 2002:a17:90b:1f84:b0:39d:f064:3a76 with SMTP id 98e67ed59e1d1-39e1e45e49amr14658875a91.15.1789647106769;
        Thu, 17 Sep 2026 05:11:46 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3987cdeesm1219657a91.1.2026.09.17.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:11:46 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] ASoC: fsl_asrc_m2m: fix pm_runtime usage counter leak on error
Date: Thu, 17 Sep 2026 19:11:36 +0700
Message-ID: <20260917121136.32527-1-phucduc.bui@gmail.com>
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

From: bui duc phuc <phucduc.bui@gmail.com>

pm_runtime_get_sync() leaves the runtime PM usage counter incremented even
when it fails, but the error path in fsl_asrc_m2m_comp_open() does not
call pm_runtime_put_noidle() to balance it, leaking a reference each
time resume fails.

Use pm_runtime_resume_and_get() instead, which automatically drops the
usage counter on failure, fixing the leak.

Fixes: 24a01710f627 ("ASoC: fsl_asrc_m2m: Add memory to memory function")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_asrc_m2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
index 4bc40f328f58..8bd2a144dbf9 100644
--- a/sound/soc/fsl/fsl_asrc_m2m.c
+++ b/sound/soc/fsl/fsl_asrc_m2m.c
@@ -320,7 +320,7 @@ static int fsl_asrc_m2m_comp_open(struct snd_compr_stream *stream)
 	if (ret)
 		goto error_alloc_out_buf;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to power up asrc\n");
 		goto err_pm_runtime;
-- 
2.43.0


