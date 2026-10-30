Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53272606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRXGOD3J
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFmK6KtJz2yPR;
	Fri, 30 Oct 2026 20:14:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793351681;
	cv=none; b=LdjSDiZmT72jG9DkHJ40aKc5/GqAEFaqRLupO0Zoyr6micrRuFDC8ybcJ9Bf1tFf3gd6fm/3fKsYfDWevbUcQo3zuDIXKQQRXy3b8e/Kh6JtLIfi9PI6g3WNLfb4wO/+RAuJWx1wSd/Xce20WRBJvIS81jMlFI4QBvoOvldQ3nTdRh1V6PLpuPbB1Qp9n3NCjzp0bXJTTPoEjZNvk87qPkquFYTahCHV7eDbSAmm1IQmMFL+6C1wmrWq6B7o6opCsr20qxUkkkxOCPHB4vPHfgehJj9J6Sg2oLrx+pGW5ntMWh0SFB4Ai+iyDaS7vpMELH/pyadjbMUWgfee+Klp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793351681; c=relaxed/relaxed;
	bh=01Uj7NkgzYwGaJezFr94PPu1LmMCL2796EWK+iXo/l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0QkIZNc4rmIhlblmeFymZkgjXxdOvzk3R8xuDMhaIaoo0jx6iIFn8NMQzkXDuKz/vPGhdObYabzJplrFSEeBc37QOUHjGYrzSC2BsRjOUieClA8scLNvHa6AYJfD4uJt01IJoGogLmzEY7TVCrei+0mllCLizsQvZWKsgdKJdOBE44eWNK6HX5pAr9ijhPNBdpw+R71xbh/7uVNhJmVF4SOgrAvRawv9UXlkcFbx15FI+H7ATB10rm5W2Uf4uY2bF7ZTzZXREouxUd7Np+onIImNz63Cn8IJtzDtoLqi8rDIzlIPO6Lpuhdp7npbB1UxnSd6WcOp0TtzHCEWx3d0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRXGOD3J; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRXGOD3J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGFmJ4MYZz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:14:40 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2ea138a3497so2930775ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351678; x=1793956478; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=01Uj7NkgzYwGaJezFr94PPu1LmMCL2796EWK+iXo/l0=;
        b=vRXGOD3JZbkEt78KFPDyoiDfN0AM9/8g4xKguMrzs3jKjh57stSKXc6AemkOzWjPfc
         oYRlT5+6jNfMMPOUAAq/GxWtbloNbpXhFiJWbvo/QIpMhdkTEgDKg3ehVANH+RR8lOhd
         V28OF5aX5fB81czcIgsJVQCzexlcnCpDwxuBgPxOteNWQO7p/FbMjv213zVUet3U/mrT
         OqGbXGmr6RQzO/xetMra3mHUfQS6zLRuuKHVO0Tmvk249Z/XurgaTlLImQbM66uUTBLJ
         35qWzH091J0aj6rYbWhIq1ZglhbWxJyOJbHAGBBhrBRlwV1F6rr5SIj7M18xdN/n4ITG
         8kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351678; x=1793956478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=01Uj7NkgzYwGaJezFr94PPu1LmMCL2796EWK+iXo/l0=;
        b=v/GbM4FGESVIqwyNoQnWd7btUa5qzOzRTe9CLFGBttDrLDOijT0UXXmHsT5AYmgK/w
         de8HDiZgaDMnH7UgK+9BAmPVposQCVeVZv08LIFWeq2Hwuzm/WoI+IWci2VhDuY1aP0b
         hRmyITqu3GD0cgt8suNN4iFgkRmr5Ym4UA4nY/V//wBV/RYugTtDrfrs5tk68pqTyO0z
         tUJ9j7OAZkRC+V37tJlkxBZ3ab/Q+E74VvAHZTFvJVSCGWgIV3Ny4G8zci4kPVEmT7l7
         o5MShQR4hSfROzSlQTHzZiMfILjZDkeRSGOFAI3j1NbyWDhV78MZdct3OGYegi6wACil
         gKUg==
X-Forwarded-Encrypted: i=1; AKwUvByHkl43Q57FVEBFXT3Uz6YUXwjMu+aKO4UDHjm1X7Iqt57D0JV39mdhihTbCKC+ZSQ05L2yQKSGJhZIFZE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKbINfPm8jPnoIEZ8EMrh8J5xbqrRaCXhiTYM+54xKwWFA2HJFT
	R/RoaHOEaHd93gQLjtzeip8QAZUGy4b+eAfjuHpnmz3Tdhmt+v4u2e+z
X-Gm-Gg: AYBFou2Vp0YSCcuTixx/HpGJyGko7pbMwAyzFajvkvyhmUkqmHhkAeY06/7NG/oiN6u
	oo/MUZPf/b/sF3NOklmMOMiJFcLY1q/zBZ1DCMqBC136RIsEe8n9Bea1T2L4HZzf0rA/ECO7bYh
	6yQXWJsFOMROWILlU8w1hRiHWXhNWCXmc8YBPDBzeBkC2Cirbj4a99A8EbOqVp9H+j6qs6QwwpZ
	wUPo+lgL2Rw6/JQC0pnlULqVv/Ffzpz8ZvSCWOA0WGbq6Je4EY43SNADLwpaMD+ELknMP9VXykP
	VnPwISzDp2gfxhGqSF1qqyS7KmhsOJ6XuYqvy+1qyvssAu2N9RNyCbfjI88tgW8872onoZG6AgV
	uH8zjw/nHoF5LqjPjJK7lKluYt+gcs4N904WIWV79dlTaj8pE4vYj0FC49ueRvuMMUpCQXnzPcz
	b1GYYs9OtgNs+aTILlcbwmxLh/dWWaFogv1CSBPXUGmt99qoOQ4fkXEMPb0kHT7U3XWDTJipMhW
	vWSTI18exL9bGRgF2zYWP5ECTHWZDcIK6t6Ak8XmPmodIpF1/XQhgpBDldJuRePtjwwT5HXddFR
	FtdRP41/B/8+hrxj+fTkvcZkoKlsjhGavIBP35/om1GZeg4vQuMEjokYygHG/OP5HeYz2uSOvpu
	1ldoIlNc7wGQu9XGKdVSyGKMOfd3GoF8y2zP0/rtRRyRt
X-Received: by 2002:a17:902:e881:b0:2e9:4d43:d58a with SMTP id d9443c01a7336-2eb36402699mr18501005ad.1.1793351677709;
        Fri, 30 Oct 2026 02:14:37 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm4734685ad.6.2026.10.30.02.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:14:37 -0700 (PDT)
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
Subject: [PATCH 0/5] ASoC: fsl_sai: Address several issues in the driver
Date: Fri, 30 Oct 2026 16:13:59 +0700
Message-ID: <20261030091404.18757-1-phucduc.bui@gmail.com>
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

I've been reviewing the FSL SAI driver and found a few issues
related to error handling and clock management.

This series addresses those issues with several small fixes
and cleanups.

There may be more to look at, but I wanted to send these
changes first.

Compile-tested only.

Best regards,
Phuc

bui duc phuc (5):
  ASoC: fsl_sai: Fix PM QoS cleanup on resume failure
  ASoC: fsl_sai: Use optional clock getter for MCLKs
  ASoC: fsl_sai: Remove redundant error messages
  ASoC: fsl_sai: Propagate device tree property read errors
  ASoC: fsl_sai: Drop redundant dataline mask AND

 sound/soc/fsl/fsl_sai.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

-- 
2.43.0


