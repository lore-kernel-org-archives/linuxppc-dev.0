Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31793606A330
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7HeheYb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzRg64TLz2xSV;
	Thu, 05 Nov 2026 21:43:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875391;
	cv=none; b=BNXRnzCFX6qYIwJjFARdu4gACP5uELgNsjZhFvKtTy+qKRSKe7kIm0PSHyVjsW8e7Kodtbp9RzukStw/dCXcUc/NIoGjcloXqajW2bdUVuPeWETa93siTOSGaxqC70RbW/YyxpDSTHQLuTEJ6fyg0NPtFt03y8gzz/oAAG1ZyUBwW2oOVQLmE9qZ/24BXTMDANOTH3WCg4lhfnSbZSFyjb/iBGIku4/efskCPxbi73HgsNRB0ixeWDXuSSNsYn48DptQEKHYvNkjuZ+nTlnpe7jrG20R/1M1BHmcW/xe4E0EwJ3Q5XXRfnwprQiYnoTRWC11n3dPIBQLYlypqnN1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875391; c=relaxed/relaxed;
	bh=WU0mTIuYpv0rehcbLRaasNOk5Yx7WkJzHYLOVNfF1wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJjNUxpCz8hlmnFj/B6tF4qlHd61h2Pse13arIF6SWs02mV3EKpx/yvDG24D0AbFjgKZtN0N6ygGgP6t7MJ9z2e2/FuhIz2KqAlWvafKhwRQnQYVMGstG6D5OcczRd6HltYYQmPe1BzFXrBMGRaIcHDVdUU0BHBImxGdY/1MKqLTeqm1a3+e0lNYM2FkyJIhSHlJxYOs89+82x0rZchIhHHMRbL4fgG2nHU5pnIZU20DRo16HRLC2N2HKxFBLKQqPS3HMJ3yfL182fIO6z2TgVY4S/NxcB6d7XfNJB3lof9ydBKG+kJj8ufS1Yn7yWo/FgoyLjw3ySGaY9PAvjizVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7HeheYb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7HeheYb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com [IPv6:2607:f8b0:4864:20::1230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzRf0R3tz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:43:09 +1100 (AEDT)
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-15ea896ddc8so2909944c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875386; x=1794480186; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WU0mTIuYpv0rehcbLRaasNOk5Yx7WkJzHYLOVNfF1wY=;
        b=O7HeheYbBHBGd9kYEfPyK0sjfD4/4u+V8BlUlK6yeCQJ2ETmvDn8ExKMqdq26XFwE/
         DuK2TkHcCx9rF/XWKan1yvyGcoQQ4d3xS4QCYnfRFlwAYpK/wzyn35tAgp6IWUOoP+Vb
         W5a/XWN7Y5DwGt+D4nKnM1p6cGk4M2sdi9rAWSMjnFcZ7W9NlvX8++7Xk6MLBOmLR4Ul
         fBIqeuly50UujsLH3O+bVlh4JuXDNGp9cgujcDRB4OZ0zdBdTYpKY6OuQs0eO06fp7U2
         K00ilcNk66PTInkIbRsxdcpbtHeclui/AgZ/WfCGIezq/LJXMIP3F1kfj31ezfCm52cx
         E1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875386; x=1794480186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WU0mTIuYpv0rehcbLRaasNOk5Yx7WkJzHYLOVNfF1wY=;
        b=FwO5V2BFOfxk7KkdxhbiXIn6hqVGj5ohGm4yAJVFNEa7DSZH/ZSt6TqSrKUzu0ni0H
         pzOcCOMX+38vCEz4omL8I3P8b/TEQip4GLPhuiYdOG4z7zqv3Kko9FnbeASL5KHyAgoH
         4PwlOlnM5RnVIutWm1jnX+q0fLEEZgM5tyhn2VR4JjsdwhxK8zDdaZ+pNQRfLvuN/ukO
         l9KpKrVqr3b+UjugA58ZidIXaM45oaAVxJCUvHIQo/Ry2O9qZZmZTGFQMEQx0L7aK+kY
         uXtVaOZSXlgz8qhg21mABRpyBczvTqEwweV6Kehdj1Nqq6HaEwOF78twTkXuY60iGfji
         V0Ag==
X-Forwarded-Encrypted: i=1; AKwUvBz6HhcugAkbzJN0wvgIRbzZkErObkVU7Ac7BVpXmPxPnWVcbtw7SbgMM1CriHASwRfBsISkwLfTExGkBiU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+mtxrp+pOCZfKMfJYakP3kXaWwoPrh4RZuhEUI5L5ech0F2/cz
	hK4ebEhU7sphPIUsgmNdmPCpBuOg3dMPo4USEJYRW+wfY4g0zRj2czPr
X-Gm-Gg: AYBFou1+FgLPWBXgNZOkGRCe3nlBDOqAL5szZj9WbWN7qfI4ncZmYqq6GPfwnDha8N6
	T2/AgevF45/1LD+aOA20Sffg0R6/8uOmwe0p5Om+T3bHG1QTMdTYBZTeQ0k5gZWK6swrlGp/LFT
	Ec658zxuUp1YdqozmgEHwwcHZAfZ0r+ZgtpYdqGx1cv+Tg+c3UNPMbYihRqxEKCrynC27GNdE9l
	tNq6ND5ixqoLLJYDN65A2qrJEsgmUviSRQmK198f68G+z2ZGGOAoTo+Kq8kmoiJc5MLRPpfeYoW
	jupfLoATqoBm0i+Nzu3ufjObzYzh27A3hoF3Y1F1HynNdgq1Yf2wrxtuZFY2zX+jtMhk2HbHGS/
	H20hrz1270k6aB9S/wzb6pOZc7cQuxoEYeSfPn2pvt2ASp0uHpEhaV9Bz3/ZAr6hAl6Nq0fdJBb
	1KLjZmGTN/WqSxT4KctSyUr7zNAL0zt6Fh7SyhQhBHqyRAlhD7mFVh6hJORafXr7fC4SWV6iFja
	zbtC7hSKoKSpxuN4UvyT+gjbeMl8oGKu+I8HAsOoLddO0Mpgv0m3bKBbfhjXAdRkSq9tnqF2nGM
	lUtOq/YukX4Rjfh/kmflRImwxkmk5LnSlYmJABn4Hb1YY2kT40kqS/XLLe6UpaZOm66UFMy7VSU
	8rRAB3kODIlK4wCBgg7GLHGBvw9aB3TrPFy7cTsLng11x
X-Received: by 2002:a05:7022:7f0b:b0:1a7:2ce7:ad10 with SMTP id a92af1059eb24-1ac5d69f67emr26766196c88.44.1793875385784;
        Thu, 05 Nov 2026 02:43:05 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:05 -0800 (PST)
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
Subject: [PATCH v2 00/10] ASoC: fsl_sai: Address several issues in the driver
Date: Thu,  5 Nov 2026 17:42:27 +0700
Message-ID: <20261105104237.38542-1-phucduc.bui@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

I've continued reviewing the FSL SAI driver and referred to the
i.MX RT1180 Reference Manual when looking into its register
configurations and behavior:

https://www.nxp.com/docs/en/reference-manual/IMXRT1180RM.pdf

Link v1: 
https://lore.kernel.org/all/20261030091404.18757-1-phucduc.bui@gmail.com/
Change in v2:
 - Add five patches covering disable handling, documentation, 
   ISR error handling, BCLK ratio validation, 
   and preventing incorrect CHMOD writes to the other direction's xCR4.

Compile-tested only.

Best regards,
Phuc

bui duc phuc (10):
  ASoC: fsl_sai: Fix PM QoS cleanup on resume failure
  ASoC: fsl_sai: Use optional clock getter for MCLKs
  ASoC: fsl_sai: Remove redundant error messages
  ASoC: fsl_sai: Propagate device tree property read errors
  ASoC: fsl_sai: Drop redundant dataline mask AND
  ASoC: fsl_sai: Warn if TE/RE does not clear on disable
  ASoC: fsl_sai: Clarify fsl_sai_dir_is_synced() documentation
  ASoC: fsl_sai: Check regmap_read() return value in ISR
  ASoC: fsl_sai: Reject bclk ratio smaller than slot width
  ASoC: fsl_sai: Don't write CHMOD to the other direction's xCR4

 sound/soc/fsl/fsl_sai.c | 89 +++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

-- 
2.43.0


