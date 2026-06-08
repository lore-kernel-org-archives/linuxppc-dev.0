Return-Path: <linuxppc-dev+bounces-22197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3C8CD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:39:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYtSg4ppXz2ytV;
	Mon, 08 Jun 2026 23:39:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780925987;
	cv=none; b=Rc8ncrEBmuYtGJNMyQNUWfGPyhjnHhP4vjjIH9EEyl84omkSukJIEF6c7Pknlhr0qwL2c+kiYPn1jaDrPzPi/I/l8SR0q+qz+0+9vbEO91OlUQpsJ0P8lBNC7BLe4WXc1umZFCjH1LEct7hdtk463g+DKNNZUxPNwjmwxvWUY3OqRXpLD7SsCzIHP9HxDiQXTuuINWkgD4kp80tgCwqaUESReO6CiMVdav39bKami/ZLWpi9SRxEK60J3DLSF/UwRlRRKEuX7lcmRTKFm05KcHJIIHSZ/Prt9fkWo3vJhKI0XpZCQlMnPaFXnx0ho3tXjaSyGC8GxjZE5S26lQyoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780925987; c=relaxed/relaxed;
	bh=cnPr0God56443aVBHA2GEm21wYZNNjULBNiCWm5g3cg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Weo8mTzgsWL8Dg0M84j1NuuXg1V3gTj8QNaub2XnXuhNmGO66MAd+GN/Aqn+iyG5RH0NAuabtwMnzV+9Z5WlGN6AjVdOv9VBmw/1t7gHh8ThplToOPnDTzCcPtkHporHBfLbF1QjNS8ecUNhUzCXF0WwaW4WDckzRnkW5zH+M+yC8ghkI0u+Fhzxe5SkH3P6PzyduZNYvdOqYQQamocSGj5JXtWQuflMl2HwKNpXBaZf0PJAnDdn3klKD+D9PlDANOsxYUV42IGAeuKiQjOZ6qDSa4gEuSBui68yeHgtLa94JIZovGIPoF/aY3uhwdXZk1jB+fvLrnO8DSikOqvoVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fv/E97NO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fv/E97NO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYtSf0mjMz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 23:39:45 +1000 (AEST)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-304c520fe9aso6887866eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780925982; x=1781530782; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnPr0God56443aVBHA2GEm21wYZNNjULBNiCWm5g3cg=;
        b=fv/E97NODC7cbs5+QmB+axeZQPyGUIScY2ott46iUcYVAoD/pBdVwp3Cs7d4D5gC2F
         aDPY4NTf8eN2/YnMi1xeLCXF94OhLEEkL/PjEpZ9gBOYSK5BDG7PNURIL9tBSmBpH7J+
         UrBeUw/nUWm6Ta7R6zI4VNIwOjyMKgYJ3E4RwGRebE7u+GnFErPxndO91j/JVI0Vi7vY
         q8hUys8W67oEibi9Of45Co1iYDMj4GROjlHsTnz21liYzngXRa95ozXtvHoz+HktSUVT
         ttHL9YMIrulOvVLUSuvY57HsIvb6nT61bSdVuR4zvrdujaQk7nFEp8CZ7WayvVCow1tl
         70Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925982; x=1781530782;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnPr0God56443aVBHA2GEm21wYZNNjULBNiCWm5g3cg=;
        b=lLSNxQFtlpQWHQiqLV+tx/VErh3+8NFPSbAYleJIMyN551P/0Wvj4uALGnMqXuUa2O
         ch4B+y9uLIeIq+7+hKqCkTcGQ4ekPFqHkuir4i/YNeNhuwgZic196u+frNIkLQdMuKFc
         PMIStKAMs1xnLQWjpwVN7II4G1Qo5nmZSWXf12xRsA8m3jyup1FSV3lwUobhwMAIGd/x
         Q6XzY8btIDa9eDKcVW2YsFkW4eMhJ0nLoligZSnEBRfiNDY+gSdkADzju9zmicRr6mNG
         arMkRyzLtm0U4KYew287x1fof/2eGyt9MxceZDaZZJuC+a6lkhjqhvaa9b3NIz3OwnVj
         15ww==
X-Forwarded-Encrypted: i=1; AFNElJ8uuSCMeuFTu5iTqvMHJ/kOH3TWlQEIoLIc3ab4BA4nQ2FqKMhk4BdYCFqOMj6uMI8Wh5+YUQe74AXXvDU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwkH592u7Pyd5z4U3J5bjKmkz/UmfqbdwcJr2KIzKI1NwQUHcFI
	YxnaLRpGiZvI7vl5XHS45rIBfrxVDe9GJ2zjia7Xk88dZW33UvwG2RsG
X-Gm-Gg: Acq92OF863kWwm4h/Zu3pBmnksFy8rCIgTYy6LRSdUCCZOni+BQ95dF2IyodwmE/zra
	Hx57TvqQpHL915TedozbP+nv+UdgzV5C7xSvRgVq7J+FMFKmyNMWeYNoZaqKkh+CN5Dy5Xk8bOb
	7LRhhxWbMsjpVi2l/gBkuRGKkq+YfPFWfEEVz047iRhKCCk9jXme+e5gI0b8CBNg61QKTQcE1VU
	itznJHG3ZFqENSaOLr/rPwBPnVTWTY7QPi1e97XTUC+QF61/09NyS3iIuUCcOrHV2Zo7mUv2UhP
	0701AghNAwWC2z2G+T5n1Q6NlX77Pvt2S87OiREeFKEQRoAIoYeejXIzaXq+s65/IELpQzrFCSM
	yU39wsiDHltSrdh0SuAIYjwD1Fgcz9DY4auusd3WeiC8rRw/gLhwWb9GtPDHzoqhBeeWsajmbqU
	nsh4DdQsrVK3R+IIukfInKu99CktfUh1Q+WmM39MgsLg/9wrQeEOTJfde7T/XpGQbBlv69SWgkK
	mHZrzN0K5mJgCPTHlLuIfY=
X-Received: by 2002:a05:7300:134a:b0:2de:cc07:e99 with SMTP id 5a478bee46e88-3077b357e08mr8719405eec.7.1780925982244;
        Mon, 08 Jun 2026 06:39:42 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-23.user3p.v-tal.net.br. [177.4.161.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm23893449eec.5.2026.06.08.06.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:39:41 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Subject: [PATCH 0/3] ASoC: use scoped OF node handling in manual cleanup
 paths
Date: Mon, 08 Jun 2026 10:39:10 -0300
Message-Id: <20260608-asoc-of-node-scoped-cleanup-v1-0-9e3ac518dc2e@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBAF0KuUWTuQphLRq4iLdPKrEUlCxkqh9
 O6Nunybt5KiRihdupUqPlFjTg39oSN5+HQHx9BM1lhnnOnZaxbOE6ccwCq5ILC84NNcOAwjhnC
 2J7gjtaFUTHH57dfb3zqPT8j7W9K27fe7jI5/AAAA
X-Change-ID: 20260601-asoc-of-node-scoped-cleanup-d3be3d927e64
To: Srinivas Kandagatla <srini@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Herve Codina <herve.codina@bootlin.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=C7dxKdcgfrcYjsHEoKJuUHkSmi5vz3fglU2QYjaF3mU=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFlqxwQnzt4WfWDffoev+vtuCZqdWzUp9H6gV9CW54d/7
 FH14zsU2FHKwiDGxSArpsiyOmmR5Z6uB1fr41Z4wMxhZQIZwsDFKQATufyH4b9jiF7l3Ih1zPta
 2D3jXs60qw3Yw7HjVMCsY3eufWo4pa7H8M9g56/tC5oEE5myWILa59V1Oebwxm7e8PT34faaH0u
 MtjAAAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

Some ASoC drivers still manually release child OF nodes
when leaving child-node iteration loops early.

Convert these focused cases to scoped OF node cleanup
so early returns and normal loop exits keep the same node
lifetime handling without explicit of_node_put() calls.

- Patch 1 updates qcom_snd_parse_of() to use
  for_each_available_child_of_node_scoped() for link nodes and
  __free(device_node) for temporary cpu/platform/codec child nodes.
- Patch 2 updates fsl_qmc_audio to use
  for_each_available_child_of_node_scoped() for DAI child-node parsing.
- Patch 3 updates cygnus-ssp to use
  for_each_available_child_of_node_scoped() for SSP child-node parsing.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
Cássio Gabriel (3):
      ASoC: qcom: common: use scoped OF node handling
      ASoC: fsl: fsl_qmc_audio: use scoped child node loop
      ASoC: bcm: cygnus: use scoped child node loop

 sound/soc/bcm/cygnus-ssp.c    | 10 ++++-----
 sound/soc/fsl/fsl_qmc_audio.c |  7 ++-----
 sound/soc/qcom/common.c       | 47 ++++++++++++++-----------------------------
 3 files changed, 21 insertions(+), 43 deletions(-)

---
base-commit: 112b3b39550d94f94eb7e44fd865716835d9aab2

Best regards,
--
Cássio Gabriel <cassiogabrielcontato@gmail.com>


