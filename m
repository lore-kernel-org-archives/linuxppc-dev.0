Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF524606A8BF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stHbhf2K
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQldT2QT4z3bgK;
	Fri, 13 Nov 2026 16:08:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794546493;
	cv=none; b=nAcW8XAr7MucYUhW74sZThM70UhSCh8js2OfwoYMvBEzOgXJWAf+V8j86SEMIvcoz7ByXNnzhKCltlJrR85Yf9dd62uR3OrFZw7UJcJtthn8QDJOHV+D+RA/6YLDsxm6OMcHhDU9aMf4ZXadi238YURE+vEEUXOOLt9HZjKEFuMBo5ilic3oC5aOwEyGlZ3KLsuygBuYCi57Pr0qTdLi4xim0LeDYpP0TLpdhT0qV3joVr6Lsk/iwMflIizKGLPFco3/8aCCK+uMjihPwO5XhU5hl6qQqWwoq9KNEYgXs9Br2AphYx2dkj07qyuMQi46vL+h/7IbrqGivQ4z8KjOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794546493; c=relaxed/relaxed;
	bh=ADGcsJLWHH299RpecEFnjkTKrpHnNUktG/Mb17Rashk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUobie1Sqzvu0CXSEBV5l6+BUwzcupqWel2TfNh6Slzt4pdUh+F7i5o5Pw6ffTDRy7SrKHgHzdRsT3StuT6qSZG01H2FPh6vo5Kbc6Td7mX8EEeNp+PG3ihCF0LuLz/wjqEmq1uJqaza0eTl1g7KGOkmuRNL2jFMiO14LfLNfLB5wQkxTbJrzWVKJUyEn7lgxhKCo8KiPgZReMwCkanzXVD2wDJx4X/vy2Yz6UGceG6NTSrUaQp2SMm/g+nHch5geFowRTNofbHz6lnEmpC95B7gCv9BGHzgHZ+mGzNXPlkiH3LhTbQpfDED3NzZ/ltnaQqzH+RbO+wYsZkUlCK9ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stHbhf2K; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stHbhf2K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQldS505Kz3bfZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 16:08:12 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3b15e46698aso484650a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546490; x=1795151290; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ADGcsJLWHH299RpecEFnjkTKrpHnNUktG/Mb17Rashk=;
        b=stHbhf2K1T8QoVFwsHvRR47yOfZ3W7cN4BWfPzyil25zB6L9j5jomYegIHKH75XCW/
         OP6w+ALyLydRndb8gyvQTPlytq7SFEhXPafrC8AKfOGGH6rlA208eHTzshHTNKSVzbY6
         Oc6r/t3ZI3sNrjthv2YThNwSfpAOD9VWvfshESagPlSCm0PX3A0R/1YkansF6QFwyUpQ
         8S/HLNPoQ4YaH7nNH2M/mUvBXyEG7I1ELcSa2S2yz1UlZgqcuiCFVE0o/YS9qDJ6+v5R
         JKLwzEQ1kb/lwHclBMWz9uqXSTay+oY90hY4cg4lyGsRc2AI13Ute70V+XvSbmgwqINh
         raoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546490; x=1795151290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ADGcsJLWHH299RpecEFnjkTKrpHnNUktG/Mb17Rashk=;
        b=rcOhygC9RC/3pS4wprrG4p8qpj2ZMK9zPPvGus87r88KfGFB4RXq4m3H0qNDMDkVLU
         rrdgSkcqE4IPslrgPwDh08XDP59UXb1mRm14gstJMBJgFPttaHtwjHiFg6RXQKbStvw7
         hnk9PQX6wzk9mrRcgYsezk1Fnftp299BCwEffH5L97UuhtfXmjhlUVCsFskQyqn12UuE
         c4+gxpm2L1S1F4KHREW8UgKaOrnXA6GFwrmn5ybPrNBpRx1eBHA4XF8cgWt3uVVMdv2q
         P1EIi3SU3LhohH2BnRl4PT5PgiIFK66SfliFbnrX0PNmbVCkQgKtZV1PT+C8TjvizEFq
         RXCQ==
X-Forwarded-Encrypted: i=1; AL+hErEnd/7fwMs6JvGTLFLwQOBv8Gvn0uUsO+si6VNddUU4H9Nwv0AVt92DSaAaB07Xg6QO1Fw6i4TGjx2D7pY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9B/lYbaJvDlaCtcP7lpUW2iNVgtMQspkknF4w2ODrDd92oe+uZ
	lMoel49dLRTyn51OCA5niVBKnVKdmhpZXJymV6wNWBw0qnK9kXk4WeV0
X-Gm-Gg: AYBFou0fZIL7ynH/fIt2PUnP8dwaHt/t0rnaNr9R1EDUcYe8/Cl7OSgO7n4SdDJhIzR
	5oR5G4pHEkyiKjxMwsgZUKPidPng9ayOLEmijqJFspuk32ZD2O/+YDOKT7u8fURx4Zj+gguFbW3
	WTuZpe2s4+oMYhHAZ+h3n+jbuW+o5b3vEKtIvXM3rHyGnOiGrcrAsXE3KJmafLFtsmDoNlmMwi0
	DE/zEI6+tJBtKLaGklZvHnv74Yq4MuV7Eg3vUOMb/ORighNruOxj78ujqs3uLl0ikGPDXpKy23H
	huIhWjrMJjRWKe7NxNjsKji0e2B4w14kDAPdkWJNhB1DVoOtSAWyREO1H9GiR1VJ2Z8drJkainn
	irzC+GlVk6RTKPQPG4RYKNPkPlb004HT7L6ClVxrS08iXkVCR1tdf/KiApB1dMbaToxJPNM7hwj
	cvE5IKxAxxAEiL9DL4C638JEOx3PiP9O9MIqydE5ATq5iSJFh+8z6vcut0msqizjDXu7NOZibIq
	DPQxDX7QIYZTRgBcogsbg8laPo4eD5Gf4h28Dnipceg0FSTnGMKMiCC7SXdairTLVdprg7HYo66
	xTsjxduhF7qgf2m0ygxeKtRoEP1VTAQTZbtY6j7BFApL8o7nOR1Gec/chDheB6lZAWHV6y0Kf4T
	8ROPYHnr3Ti7s8VgPwIai4+ueIku+Upkgjp5HY3959mNa
X-Received: by 2002:a17:90b:5585:b0:3b0:ae41:2711 with SMTP id 98e67ed59e1d1-3b1b0a12f15mr1032070a91.24.1794546490576;
        Thu, 12 Nov 2026 21:08:10 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm7643420a91.16.2026.11.12.21.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:08:10 -0800 (PST)
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
Subject: [PATCH v2 3/6] ASoC: fsl_asrc: Fix runtime PM usage count on init failure
Date: Fri, 13 Nov 2026 12:07:24 +0700
Message-ID: <20261113050727.14053-4-phucduc.bui@gmail.com>
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

Balance the runtime PM usage count when fsl_asrc_init() fails
after pm_runtime_resume_and_get() succeeds.

Fixes: cab04ab5900f ("ASoC: fsl_asrc: Don't use devm_regmap_init_mmio_clk")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Change in v2:
 - Update the commit based on Sashiko's review.

 sound/soc/fsl/fsl_asrc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index c91ffb5e0c5e..f7ac60724c6c 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1432,6 +1432,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	ret = fsl_asrc_init(asrc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init asrc %d\n", ret);
+		pm_runtime_put_noidle(&pdev->dev);
 		goto err_pm_get_sync;
 	}
 
-- 
2.43.0


