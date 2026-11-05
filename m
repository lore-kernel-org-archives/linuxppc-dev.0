Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8F606EEAD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFlUqI/I
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzSm55kdz2ySC;
	Thu, 05 Nov 2026 21:44:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875448;
	cv=none; b=WUyOwLWIhZcNc+4hm2zBO8fd+Gtvv7cwlxKzWH7UPgPUrzKcTts+QHcybCAUv1uYN66AQskx96ge2lIDRE69c24EwriRf5I+EpNmF0XleKq4my3o6C6i7gS7o0abtV3JmG1xUc4ZGT/OSzePh3Et5tGmMitCMRznSuJtIXAOxfkoVb2K4QG9UQPJ35sZ0pv/hrqBcM6Y5hVm+eLaFBQ6/iiWLakjfbrHX4LB1Pl6BrwHs7RsH+YExNuxs0djN/xRKYa/urcW5bxhf+GL3ekaRI7H0D1f3DWQ+hA18h1u2rxyb6kFjd9DIFtHF/7aX2PLcHEnHdbquayPKOiiqbYWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875448; c=relaxed/relaxed;
	bh=plnEW8+Hp4dXa8Lp3EAtMLPmG1hUTIPGT+05VPB/oMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHncFWFuOfNY0QoB3dmlTaPsq6MaMP55e5ZqXaFsFVf31SKm0LAGBiblXyCQujSY7Rts8wYers3wY4gQ0T/RdZYa/kriuE6T+ggvtKCMeSohBpEEqbZErJQMHGevl2GTlXPCbJheqqdpCSbXyeaW7RyVJj3Mv2ulAn9NbYpW9D9RtAlnOQrrhfiVkhCnzAz/2YMURhD9y7M6ZwhbraniBE9KBphvIunmKYM5WJl40HB8aeqAYe0wRDe+F+7QTopqJ/XhcFSL1G334ap4KdLLmMYmBZTo3+n/Q9Uf3Br8WD79DSFqQ38EP67xyZAY4zR+XQHkxa7hBKTmCfIzfb/aHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFlUqI/I; dkim-atps=neutral; spf=pass (client-ip=74.125.82.175; helo=mail-dy1-f175.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFlUqI/I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.175; helo=mail-dy1-f175.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzSm10Ygz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:44:08 +1100 (AEDT)
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a1947498bso4824988eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875445; x=1794480245; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=plnEW8+Hp4dXa8Lp3EAtMLPmG1hUTIPGT+05VPB/oMQ=;
        b=sFlUqI/In+4cLHivRpGs5C6Z5R4hjQcdY5kFPxVuS9/xw60+xnzjagEuSW1ze4uqAf
         ZEclUk+yrXl0UYOsXK+Jqn5Ymgyh0+uYzOaM1J+NIqJkwZ55iEALUEI7pfC7FNQA7prs
         hFIHoMyqs0ZNmYP+AM5dyHkCGHz2Is3Vrv6vIMkJaBLw8lIYa8fomxRLTq8b3QGJ1lUF
         xTIoa4PEjL5yA+xndFJzunIOlFtVuoaE4hndJh1fePnv9+hTUNr7X4hb/l5PmtFP77Ki
         axwDyEYM1zTZH4cQgtB82LglsuwjIbaFEVuwfWsICvKbZlWA4FoXM15n0SfZW8SI3xVG
         +AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875445; x=1794480245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=plnEW8+Hp4dXa8Lp3EAtMLPmG1hUTIPGT+05VPB/oMQ=;
        b=txzRTHdOvOo9y/AsL4GPgThOBKIynjTexSDBYj9VObom+JNZbVeDO2Q4wawxh2xYM/
         UXLZ+0ptQfAE6LAei5b4zTbMyVPVmQcfLOZXN24+p01nMzTeQcX29acGl+tob72XhNuw
         5yn7T4cgBroOqehCs+hTcUoRMeC4H3zjqpExoBi/ROvC/3MxyYH97zB9n3OevuTYQk3G
         LHQwIZ7RKHIIlMd9K/yUTkHHn6fTlFDlevRBqA9XchyMvjwcaal59NjMbnZOE342WUJX
         b06TPyLqnnM4yD8mUQRZ0buGVBCIcZqNMz+YWabnEI+1aUGRv2c3K00aYURuvbgSw6OD
         U7ow==
X-Forwarded-Encrypted: i=1; AKwUvBzTIYqLhca7SVAA0nZI2uBuoXOX+dtMdl3VnDroPxyFMC9xWF5P73uEeYjpFUuELBERsFMYQD2hqbbKyy4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+8db/LfkOtmS6U6ZP9f9Nuopnu+ajp3zeQnqQGuWux4AruJ4Ee
	Sa2yWrXiRBF8CeJvGM19YtoSxaQlKE8EoJJPDdn3M8eYChMjn1D2DdT6
X-Gm-Gg: AYBFou0002NV52SLntf6zuzuczPQxIDqmEDdpcb0dDTOcBw2jIAUTyjYX48xZx7+9dA
	t6PsljF46PhziTO1Gm4Z2C+zSR1BFCGqbF5mCUzbEbYtQtxDedld5tRbWlKjQ+2X86s5Gkvrgmd
	HyxnHwGs9cnVAUOYWcWt60o7JyZqn/m6mKdZS31WG6jOlQxvEnZlOJjVNRQUxndn5u+mAfjd116
	Gm9X2lBN5Wp6D70RofA4NLn/CzqG18yVBqNv4WEf7ozogU33iBpnH40fyhkt59Ft3cdK1/1cxg1
	d09N7g2J9tRWJ2BHfzR90Cal6Mvez7EPMrXQ1AXxXxImpQdbOUhxgtZPiHbncSKBEunPOIZRc0P
	NA/L2LG1DIs/A8YxJlNWuLSWB7QX070LRXJl+lH4xdRCySaUDH+YKUJXd8ewvH5J0O87pLYeDl8
	v/Pfx20hu1eXPS7IZ2SnaqywGynssHlmaioQ9oKCsEvwQ9dR60GDlgJWU+CHx6b4oNsBICBDkuY
	uJHvsg3tZvL2+o9Al34hhkgFVFDu7+ln4cOREj3BnX6Pzo4/f3KlIySh2pRszhrGe4H9ZSy7tEy
	q7jIf+xiqjy9MAoxZevr7ZqjPb/qQtz3bDmgwMaSROCbsinurbKATWvK6J4nTFkAxRUwJ7Bb+yW
	SHu94XNPsGCXhSE5tl/FEdQtQ7a6ik0mfoqhYbgF76ZK/
X-Received: by 2002:a05:7022:3a05:b0:1b2:4da6:bccf with SMTP id a92af1059eb24-1b24da6bf79mr4455241c88.31.1793875444532;
        Thu, 05 Nov 2026 02:44:04 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:44:04 -0800 (PST)
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
Subject: [PATCH v2 10/10] ASoC: fsl_sai: Don't write CHMOD to the other direction's xCR4
Date: Thu,  5 Nov 2026 17:42:37 +0700
Message-ID: <20261105104237.38542-11-phucduc.bui@gmail.com>
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

When the current direction is synced to the other one, hw_params()
also writes the frame configuration to the other direction's xCR4.
The mask includes CHMOD, whose value is set by the current direction
(Tx only) but written to the other one, so it is wrong:
- TCR4[CHMOD] is cleared, while Tx needs it set (output mode).
- RCR4 bit 5 is set, while it is reserved and must be written as 0.

CHMOD is not part of the frame configuration, so drop it from the mask.

Fixes: f4c4b1bb2f5a ("ASoC: fsl_sai: Set SAI Channel Mode to Output Mode")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index c61703ddb6f8..430e896d064e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -720,8 +720,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 	if (fsl_sai_dir_is_synced(sai, adir)) {
 		regmap_update_bits(sai->regmap, FSL_SAI_xCR4(!tx, ofs),
-				   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK |
-				   FSL_SAI_CR4_CHMOD_MASK,
+				   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
 				   val_cr4);
 		regmap_update_bits(sai->regmap, FSL_SAI_xCR5(!tx, ofs),
 				   FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
-- 
2.43.0


