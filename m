Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E136606A899
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iXStl3NI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQHJ64Mbcz2yLY;
	Thu, 12 Nov 2026 21:51:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794480694;
	cv=none; b=SED9TkUzQhmJb1zggU8yhck4knp3u2BpBLZgFU5TAxSYV+MRLF/G3QKzzZsry+TZLM1GpFFm6dpYVLiWtepxsxteLkFMT/w70r/mQbHZLyFR1tFa+260mw0gP35ttgjSPKRGcOh2ECTFPAVU+Ht/4OQ6fDnK0NkA7OYlC4r3It8znamBxMyxoZMEm2DsDUw0LXbeNwNF8coNJOAZrIS5D1ChAla95z9hkFBQq/LigaWlWPg7iew7yTZy+Ka8V5XuSgMDXx5C7a9a4xcJoqLZTdJbocoUe7Dn5ZDz0N9MRtLvV3t/o+EO+SS5QsJ6fHGddGN7vopTWQQ4h9jIYhxoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794480694; c=relaxed/relaxed;
	bh=Ei7oe26oYP1pIuCcwgZ+hnh5XI2lMWOHH8yz8N46X6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWVGVORyLysWVrGdJjiOOpRJNJCicYZKTYTm2kLDibKm4CiyW6/JZ3u35YxVx+KlUpfMkkm+KdUVghc3Xi9rMCMPTlZC7UIXl/9eyBjhJSLB6vXl5rsYniAJ5iKWCJmVikRSKHuItVNLgklKnWAA9y97RAGOoH3WCywXbvY/fUtNbLaAbnHCgFmiUIRs7C2ITA/B5IWj2tzCwya8lQngvtyHb7doJkoscidQCGZZpY7PrQC+EjU1MtOrYt6pp0rBWdVl3yD2HuQW5/c2ehZV/slFFUrFM2+ltaQFuWR9VK9vkv2A25ho2zwp8AznZBKz/PutfsleRnpNW43GYe6+ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iXStl3NI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iXStl3NI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQHJ52JNtz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:51:32 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so6197383eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 02:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480690; x=1795085490; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ei7oe26oYP1pIuCcwgZ+hnh5XI2lMWOHH8yz8N46X6Y=;
        b=iXStl3NIi9LZPrz6v854pNenQfo/FxaKdn8yCcy3+A/7d8WW79OBGTK//2Q4wTThLJ
         HxqXVH30VZzTpDD3qXOFPexvTS88zzFQbYQZP6FGj7a/yQoIIB/qB1/37/TftJibgkl1
         fM40wJHwda8UayrNjMUxuwOrjfEJSCUCYvReWZNZYN5P2lHvdNhFlUfSWozWookcVIcF
         LcCSnaz876rLfGJdzyru3kQGNjQHjIcOGN9sk/6vofy3ewVZA8B25ny8Q2uAPXEV9s63
         0/TxWcCL3egxXGLRrArCOeZ+iwuzG5BVpOtPG/gfHKnrDzGFxtuV4YDl0nHSjaRvcfMl
         IyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480690; x=1795085490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ei7oe26oYP1pIuCcwgZ+hnh5XI2lMWOHH8yz8N46X6Y=;
        b=E9Liszf1+V2G8aCDcLs/qJSrWM2DOtT8xDlGQ9OWy7DjBzy4nBgqq1ONBydJ50Rm60
         JMENbndW28/K3vjBLoawBV8iFg6msnKuZ7mQTrXbU66BcZMoJac33JlB+oYPwbwYpAH/
         SRReEt6CMC+M48QimHYtKgCjIdSopXRyHdkFK1nlhXr20C7fBgGhSbJhmdcVpLsV1MIV
         CoL01W2P7I5rYHvX/KNUY4z/OQW3m7xEiT9yfDmzNnP1RDqFhDHnqnTUS6/rPpfQo7te
         h8Zv0xuEYAP0zL+/wDtf0O6USPDduEj5THnKVFAVNOPHaX3eaums8VQB1SVontvTaBof
         Hpbg==
X-Forwarded-Encrypted: i=1; AL+hErHe1WbD1uKxX0sSdwXtbkFYz71s5Egny/cMEZZCL/RiyAj/bAf8kwCCUnR2vSeuyH56zTGAHvpdwSCjbwg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9mzk4mf2rS89Nja2JQeh3IZCl8LkcBQyMRZcLuk8fuwqxL83Rt
	OKo0SF2b+y1pt16Ua3gvmv9PpKSQ1mTK8Vhl7ZhedHCBa0TvWFZW9cvq
X-Gm-Gg: AYBFou37L88jR18vo5E9GvLIkG5CRA275OSYCJvtsbl8Fn28lOrO0WX7QXUzJwXs1ss
	BmIIfEN2ilNG1jxqmaqjlFHG4p/WNaBvM01AsFNrbT9r8lfGHQP0kYDr7qCxS2v1wVcXVKJLSs2
	xG7pAvQ78sPRgJ7EDkJZsnlmf5jT3KnmJA6a5aDYkDHP8TL8ZddRmTfRJDpt9teoXQgDytXpM5N
	r44zWXmjjHYIi0lIFLYRS0aXMKqbX7DnOlyyqluQjINfKydP5W81Y/VX0HtxjIRM3ZwJkfKuz5V
	rpXbkoovCagLtuwxiIk6ALaQcckePHbGVbKjY9Rue5EsrdfSfmr5kw2EzLU3NWv9H6zYs6bP1ku
	PSOeNgaXjO7BfJ3CGQwxLbpwwLkajTFZPY4b17sSsiBW1B4XoRHDTZzzmapnjzCjl/hEiB0155g
	YyGsQLZSF6GPTZtKUiAYhVN9VBUcggb45wQqsV998GUWyjlYmZwyKagw67tpBQ0UnARjSDCiOnE
	yRAQsdNHj60YkZ+eWWfIpYKzNpfejgaFI1DqIGgmU5tNf9QHqFwusr73eWnGtb0ghvDD5s0/ne8
	KUkJm15vTvrr0ytfKgSGtUp3fm23hvvtuVpO4P0EC1VUs1Ggr1/W03iLjMJEHt4KNVv+d3W0WiG
	ucYzLkiPe3cdQY1rfRuU4ArDSBl3G5zzpGIARe+wcjohJ
X-Received: by 2002:a05:7301:5f01:b0:35e:2c6:d46c with SMTP id 5a478bee46e88-37685b80487mr7982100eec.10.1794480689606;
        Thu, 12 Nov 2026 02:51:29 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm23047232eec.9.2026.11.12.02.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:51:29 -0800 (PST)
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
Subject: [PATCH 0/5] ASoC: fsl_asrc: Fix probe and resource management issues
Date: Thu, 12 Nov 2026 17:51:11 +0700
Message-ID: <20261112105116.32274-1-phucduc.bui@gmail.com>
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

This series improves error handling and resource management in
the fsl_asrc probe function. It fixes deferred clock handling and
runtime PM usage count, ensures the IRQ is requested after device
initialization, and moves runtime PM cleanup to devm.

Compile-tested only.

Best regards,
Phuc

bui duc phuc (5):
  ASoC: fsl_asrc: Improve probe error handling
  ASoC: fsl_asrc: Fix handling of deferred spba clock
  ASoC: fsl_asrc: Fix runtime PM usage count on init failure
  ASoC: fsl_asrc: Request the IRQ after the device is initialized
  ASoC: fsl_asrc: Use devm for runtime PM cleanup

 sound/soc/fsl/fsl_asrc.c | 92 ++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 41 deletions(-)

-- 
2.43.0


