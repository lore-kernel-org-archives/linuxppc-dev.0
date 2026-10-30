Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED2606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imzH5tEf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFmq397cz30Vy;
	Fri, 30 Oct 2026 20:15:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793351707;
	cv=none; b=DgPXYKDy0whKroBJPYy0ayze49ptiTE4zAzFBvwz7qDJceXQygjWi6CP48z5HepXT+g+HondLpuAAQOrOsjo5IrX2nU6U33bt15Zh6g4BDEQo/5BdHSbVYNr7pcKl+ALZlxOFT4JUTi3kuZI6yuvIXnY9bxH+yrjjvoN9u0j/LZsCbMX0WrsWI9fq2BWKTbP6a7P+PL3javLLzOOyB6E2VDW+v7+zeSqiciAfWR2veAVBVM8tR99m+ejED4albJS3C0lvBKfmae/PMMJ4VCFABIjm2LibRtx8XniEawngNBs6tWPjZz7yjF1qxQ7hGAZ5nbZnG2yXfrOaRCEH4bFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793351707; c=relaxed/relaxed;
	bh=zEuTfCcCze6o8lz+tPI92UoFysg4iqRaW2ZEcUe6QAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZa9AB98qkryiTFTThf1h03zMgNktqVma8KUnTCHTA17/5KFPOeuEFKCYodIAu+Qrs5ayfQPtr85m9tqXFxa3YK5xybTDwqwoOUrsALpVKmYusESbhdEKuJdi1OPa+k9lXJo6SFjd6RCS8N+XTHb9fRIelGx6v7tAcnkC2i08DULmzVGf/gAiM8F0MNBXEsz+odaV6tgTwDuwEeUQu445aTpAJrDp8p9IQetTmirlaUyU9llWoED38dIQAq2pgkcsMios9yWQxzfyKa4iCdlnjy2ZhxxCCpPUxA6C01x+/2FP1ljhM8FZOycQC8B0/yYZZqI1oZr3zER7IwbZd7A+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imzH5tEf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imzH5tEf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGFmp1M6kz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:15:06 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2e8fe8e343fso3166865ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351704; x=1793956504; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zEuTfCcCze6o8lz+tPI92UoFysg4iqRaW2ZEcUe6QAU=;
        b=imzH5tEfJPazjobRk/KjTk742ysvPJXVLUOO/8ajt99L5DpKiNA3TxgTFcefDDSF77
         dk5gWijDRIXk+CGPZM6aZcuMpaGyHzmulN6RZug3QdzuJvBUJPVuxWiTCze/Bgg2fx20
         8k/1toaO0MzAGef5uSWKis5nDV5fc/qfMgotmtsuTorOr7DtOa5v6fa2+8Wglqsu+NG2
         FO4iHUKlBDzz0jRCuqQaGFmUwGKsc+9fSiHCAmjExNctL1agtsnVAT2JsbcqTjKVihMZ
         vhXmfMrKWS98RBuUaJ6eEjuRd4QvaKx8gQaOLMu/+QCAr5AUwtYrygOJ7bKhGGfpzLk3
         5dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351704; x=1793956504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zEuTfCcCze6o8lz+tPI92UoFysg4iqRaW2ZEcUe6QAU=;
        b=hnTF5IQzNG3KvxrRullN1tksItVmAr9u6XdXaHFZznrvHHFOhYywoegsnEMq/DPRQ+
         Ww21Q6kL8hICDFBoC26rCPtgyuZXEq2ngX2QxeLK3+9UYUwy3tYaHBLOd024w2hMHk7y
         UlewcVQVw+EGGTs37GYpRyvKfMw4P8MArEOrcRtUBIiIwQWZGTFGCfJ8DPsZ3nESmk5E
         Qu1eFGPQ8TakVa715+dIxQvzcIQHvZ0LLIvEEQYxL4kUmpIDSAJWUCFOCM4wviTllMAw
         lJVnF5v/04v6QHhq1JO6tUIYObcCArnMHnsIyqZSC7pdLwO67E1t8v0iF2QpJZ1cTITq
         KWRg==
X-Forwarded-Encrypted: i=1; AKwUvByZG4JXKokhCCnfzwELZyykSCf2QW2xReepz3boAlj2O27Rle/JcLGOrxugQsJnH6YJEs3PebQmFDpYK8c=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLsnGdUQe0jPp/k7hBt8Y25ocYs66ZGGrnV/ttWVBJ95GMNzKGh
	5dgyzw86D1+u2a5wq9B8zEc54Fpz28FF2ColsFNPb/CsfZx7ymTIRQ9P
X-Gm-Gg: AYBFou3GlcH6b7BJBNA+XRiAZ6cQ1+FGxQ69Y/6UO1jwiz5yAiGQjnKiXM9dvzYtqEu
	KTdNcwQ1ewwBcBy//wcJfrD8/9U018ZWFghQMUW+Wdl11Wtpn1+lFrXtMpZf9xi5D0NRzxlos/b
	To3apowAceMLdjwYDHi7rrfE13ks9V0uED6BgICN1j4L3yGO5DaF5XkMaYspsDfRlAI4hFd4DcC
	jp9wL3UlalNHUiDf4V3M40pFyBDn+Pjx4D6Xm3S7d1BJxMYU9zGoujbPmcpAxg5FHrm5S2CDi8K
	MrlhH6tv4YwCgBx+PbQ1P50qCegn38qDnaqZgyIMkPaJEOunA0ZpnSCrQ/Wd/kcohXmfzZP1+iy
	9/QQ07JIfOQLd2dTbg944Jzz0z/jrCasiQGvQUzWvLlMNFpgMpiMIPdRKePrK0tYaApP6QKUGtK
	ziJ5FwmUPLNhKMOpMwfwhQr9b6LfXc787uUqkJhqn0/JuBLe0qHba152wkm9qOsc6eI6NDw6kzE
	pmot4/gVX8CpL4jJCAurEBGiOAhV8J4oYdJ1UqW06663ukiMbFgtETTfK33kd455JqJ7fx0vbJc
	M5NtJdALe8YhYW56LbcqcXTga3my7vXqGHsz4KI0ziWXib1XVECy4KEbW8vzOyXIEgMo3J0INP7
	/8m8QorAo2HgPDG1Sm9clUfnX6zcxij0+wQEwoc+4v0vwm+/8XQNS5sk4OVdcNYOZKQ==
X-Received: by 2002:a17:902:ec8d:b0:2e2:ffcb:87a9 with SMTP id d9443c01a7336-2eb3642fe66mr17350985ad.24.1793351703935;
        Fri, 30 Oct 2026 02:15:03 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm4734685ad.6.2026.10.30.02.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:15:03 -0700 (PDT)
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
Subject: [PATCH 4/5] ASoC: fsl_sai: Propagate device tree property read errors
Date: Fri, 30 Oct 2026 16:14:03 +0700
Message-ID: <20261030091404.18757-5-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030091404.18757-1-phucduc.bui@gmail.com>
References: <20261030091404.18757-1-phucduc.bui@gmail.com>
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

Return the original error codes from of_property_read_u32_index()
instead of replacing them with -EINVAL.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5532fab80be0..cb07e7d13132 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1495,15 +1495,15 @@ static int fsl_sai_read_dlcfg(struct fsl_sai *sai)
 		 */
 		ret = of_property_read_u32_index(np, propname, index++, &type);
 		if (ret)
-			return -EINVAL;
+			return ret;
 
 		ret = of_property_read_u32_index(np, propname, index++, &rx);
 		if (ret)
-			return -EINVAL;
+			return ret;
 
 		ret = of_property_read_u32_index(np, propname, index++, &tx);
 		if (ret)
-			return -EINVAL;
+			return ret;
 
 		if ((rx & ~soc_dl) || (tx & ~soc_dl)) {
 			dev_err(dev, "dataline cfg[%d] setting error, mask is 0x%x\n", i, soc_dl);
-- 
2.43.0


