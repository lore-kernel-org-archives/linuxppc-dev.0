Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9693606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hyW+lDr5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFmw3Y63z30C6;
	Fri, 30 Oct 2026 20:15:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793351712;
	cv=none; b=e3BRdCYZKdZQppOmWWe0zn5lpO44IHGIWpdQSRW+chfwZsy7qALe9sV+Ob0VyfO0HsJeZDQMfNcXuJ/mjlwuB4UFF9tRaUXDooyTyeV29At2pdMfoVvpviSK0tJ87V1nmrUyqG8qW7ssO4SLsucWmurHGcSM8nRFEUagI/4HuGRk7SHMOZcAgDlzjlWtqA8Kv/SrlQ2oz1RvBwV6Fk8jl14NsBrBd/HNK+e3KSG8+4alsD0Jf2P5jkyGXhXhoN9L7iHAiKqcMAD/+C+hMvp6SSAT6usTLyeEKxRdSsJKRdNHvhaZ4eUaPsxMriZXkfa5MGI4RvO3Yz02qSr/Nw+Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793351712; c=relaxed/relaxed;
	bh=HjeoZgaqimaxuDpHFJxW672cms57GDRelnn6QvWm0VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGu9T/BnOXfbASARSEGJS0ov9EQHg4gd2E5jaCa9+roQgIUMNMBtT5gt1xuOTiARELpNikTVBCEq2eWR1i8JrD4l1sbjfWaQZ7uaZ1Y2O8Y58kBiju7TRxsX4uXZecLP37vOwVCmVBQh4kFTy24ombNCv02c2ecrS1fYi7hg9Iq8SR8Q083KOXnhy61e9sm6uZKy3nIMH7NUhZi/B3DaPFMW3qWhnyrXOw1paLzFi1ixQbBhyHmXVOURyOJc9Fk79/S9+yD0ArgaFlzzcVPPvXGUeVqLCFlzYCY8vg5jVbG1Ic2FFFj0sXDQgD5qIrte6UYr5G0eqBG5Dopw38bwpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hyW+lDr5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hyW+lDr5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGFmv3jVMz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:15:11 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2e60f9af6e6so4761315ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351709; x=1793956509; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjeoZgaqimaxuDpHFJxW672cms57GDRelnn6QvWm0VA=;
        b=hyW+lDr5erUIvE98Lw+/y68BTDJWh1tYZrSUeQjvTx3vHqt2F6aOwb1KOnejmn4m+y
         iTNfr7+PkymqvV1ba73NRUhMZGCqcYZEtyea8RfY/8l30Gbp5E1MFrdUQPjDI0nNzOj6
         dOYc7KS57m1YBWn+3gLUty3AwPLoqNL/XUwli6enh+qvQZFNgMgsqKgaxp8sQoR8opkw
         m1ob5f2BTzxVlzd/6zTxWg2O7hJxKDWmTi2048/9siINy5xBXsPvE1yBQ6yDtTdbJvLW
         qrpSRMCxVPGu3Vw481ocivLUIiFLyVRc9gO5yW1bdMA6p2gC8sUfHjvk87gAExIed7be
         mLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351709; x=1793956509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HjeoZgaqimaxuDpHFJxW672cms57GDRelnn6QvWm0VA=;
        b=tsGEKkYxA/BNCNsbA0YmatheGaK1E21Jcb1FY2xZVvaXzRF2gYXDnrsqkmqNl4hunp
         NmxJrO8lSF94ony/fu7GkFEGCCKjk4/HJEGLafMW6TeCiodM4IYyjUyDTJROojXKtAOz
         g00aDe0EtQdZJPD/HXmFxFybH5bmxohd2Ch/YUuUngaj9JvF/FYMhb4D7ufb2tegrQwN
         fAN3HXQ/Dj2sPOWbHUMoj2kZz1yWZwwYnhM3LEco3v7aJ0jkJZM2oaqwLVy6g4RtbM0h
         y6btzh4Zyh9L+7AoVwGaTsbO2sCb/G77M1K2Orx5lTbYs2boIW63sn057tjCoIg9kT9P
         Vtpw==
X-Forwarded-Encrypted: i=1; AKwUvByQ86gzSlkcwhnVKKDcMap1kTQqieYLs2G4a+k5OOpQyYBazzEdbAXMFaN33If12Fv7Q4Zt+ztB1mCGwGM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJppeqcassoy+RXYm8NiVoSV9rP70Dw1hxt6nMkM01cAiNXEB/o
	fU7Nlk5T72jWCAXe9Undq++Z7u+JAPVhIHLKp7/2/I7gAFr4Br7UhsEC
X-Gm-Gg: AYBFou2YNKgHoSvTA44rcF1SI46M9ayl318dTP8SpcygXvuY3cqL4W6v7UgoIb+trYI
	OBKezT3u3fjKotU/guOcZxu2Ckm3ieAtn37/Ems7PhQMADIOWBZt0Fa5ZQM8qLWUgSiPe7tFGl6
	afvAR3nDVmSv4F8z8DppMV3a3TQEyMF7RrCMfwcX2PqWvhcSrTsIhXOapNffTtxXvsU1YPZSKVi
	Mb1YqZRmokSMFAJ+vodCmwGr1WS+9uWZ0sY2N6wUOaQ0skMfnksjvrnSJUr0Psey8kX4LjdZ/BB
	FjRT2hGfZAFLYir4j2GVNKg1v440MplKgNHpN8l6Qd72K1B5m8H8qBhfsDpxYGZWJ4r2jd8rjh9
	8oPt+F+FfvJ8fInJo8pLKUJk2Hk9+g3xfEJdYtwXdfql2wBh1jHCPz/GrGwLZ+yn/rCEIHG96vB
	0/LvRy7QqKPOfYF64LryxF2eJgyK4sFzG9PslQC4Zp3xJCLYOLz4vIalFy+Hb/9zPh81ef6Ske6
	FexFznAyzkLU74lsK+irEk4Jm1lQo0qr7daPHXGba8Td3AoaaCqF+prECwKPjifUok9rRRsOmhM
	GJTvDAwnhWIHwv1zewXoBgQndKn8mcnP8h0m/3iXPq7tdvmGjABvdOGaSU4O7062Sx2ukjQ1GFB
	wih0CcyZRVekJdb5yQLLerzlO8xB/ad7GucT0pjyyJCpv
X-Received: by 2002:a17:903:324c:b0:2e9:5507:b52c with SMTP id d9443c01a7336-2eb364cbff5mr18087185ad.34.1793351709346;
        Fri, 30 Oct 2026 02:15:09 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm4734685ad.6.2026.10.30.02.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:15:08 -0700 (PDT)
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
Subject: [PATCH 5/5] ASoC: fsl_sai: Drop redundant dataline mask AND
Date: Fri, 30 Oct 2026 16:14:04 +0700
Message-ID: <20261030091404.18757-6-phucduc.bui@gmail.com>
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

The rx/tx masks with bits outside soc_dl are already rejected just above,
so masking them with soc_dl again is no-op. Remove it.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index cb07e7d13132..8315a0d8893b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1510,9 +1510,6 @@ static int fsl_sai_read_dlcfg(struct fsl_sai *sai)
 			return -EINVAL;
 		}
 
-		rx = rx & soc_dl;
-		tx = tx & soc_dl;
-
 		cfg[i].type = type;
 		cfg[i].pins[0] = hweight8(rx);
 		cfg[i].mask[0] = rx;
-- 
2.43.0


