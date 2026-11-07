Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD79606A326
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blHW9Stq;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cr0eq5mF;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blHW9Stq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jM6205tFqz2y2K;
	Sat, 07 Nov 2026 17:43:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794010008;
	cv=none; b=e3eGvUHPbd+/90779ETqmkty5kCrvN+4peLGgdMYfn9VSwQUnbt6Xh8BOS+p+vFnGPOV+OGToyxcISIj5PzHSg4RHYi8lM2dZqeilOv7NfP5TVLjPKzQr5b2p4La+cjdOip3tfcqi7x39ZQJ2fzSmmZBJxgAXMZPJ8+yriq2QVOy7vCTd4V5AQ7L5MzeKGx/OjoE3C8JBVeN07mK8EetwjSn9vtf3/bURLr6tp7CKkIJ8GrXR4PKykC7D+Z/+1taEb1XOEkCQR6Jz+GeF3iNkTvGRczAfr8V5tXO3geoCRTS0Zz9CuWeEttRL3s6lVAo0ifHJhQV5LtCltuXtmxcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794010008; c=relaxed/relaxed;
	bh=ZgUlYm807ROoByleEtNqO6HkY1e2yjPbq5r68jDHbbY=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=oSgF8c1tjn5X5pluyqg5ILHqo68XCey35hkR1uwIzuSskLAdFI50bclevSHPnBQ7Ueb5XjJPv6X8sCb8qL6OY6Zhbe+dOIMycWYxfiCFVIuJlqlors9HKsgK5zgu1mxxhWZkSULtkSOjTxDj6dzaV9sbs8EU8spTBNQmOTAwpHUPieGgvUOyw1s5WdvcBOCDhxxG367XKX2mQKeqU9YeCOxQZqsLqtQRdCx/b/Wafv7OSXEjnpzWa8jOOnbpVZs8+iH7gfBwfjTsO5eJv++pZeOSQplaLqtUQgrdJW1hJyEmMTb1JLgpf9eCyAqGgWyUgJQG+cIpFkj70kMvWxH0Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blHW9Stq; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cr0eq5mF; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blHW9Stq; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blHW9Stq;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cr0eq5mF;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blHW9Stq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLxDR0s57z2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 11:06:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZgUlYm807ROoByleEtNqO6HkY1e2yjPbq5r68jDHbbY=;
	b=blHW9Stq16HlAMW+Vr+8IoDMnu52jDSd2rEOgXK9puAM4vY1kvrUpGmPiMIn87/ruDmznp
	hgQ/enWjtHj7lkF7QAUROy9j3ELAcwmrF9FAjQCRWwBaua7VFfoudEaeEWnyj50HkRMUxm
	poCuvRfRON9asuFtdnmNJxF0//2u+xE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZgUlYm807ROoByleEtNqO6HkY1e2yjPbq5r68jDHbbY=;
	b=Cr0eq5mFqzs8UtRs00aTgZ67kbC/kAyVWTmcISvrirhyaHalYDl9vkdgnkLqqIQWzaEdib
	gfvwcNqSBrxSfV8fBV5QYWeEvdREWxJxyyeKzVRGrdiaEsF2UityRylZwjY+xfyYfdmQi/
	GWK4UkRHCbcNzY/ptVP6W89eOVTZMF4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZgUlYm807ROoByleEtNqO6HkY1e2yjPbq5r68jDHbbY=;
	b=blHW9Stq16HlAMW+Vr+8IoDMnu52jDSd2rEOgXK9puAM4vY1kvrUpGmPiMIn87/ruDmznp
	hgQ/enWjtHj7lkF7QAUROy9j3ELAcwmrF9FAjQCRWwBaua7VFfoudEaeEWnyj50HkRMUxm
	poCuvRfRON9asuFtdnmNJxF0//2u+xE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-MI_QVOPoOweMh2o5yv7axA-1; Fri, 06 Nov 2026 19:06:40 -0500
X-MC-Unique: MI_QVOPoOweMh2o5yv7axA-1
X-Mimecast-MFC-AGG-ID: MI_QVOPoOweMh2o5yv7axA_1794009999
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so396411185a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 16:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794009999; x=1794614799;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZgUlYm807ROoByleEtNqO6HkY1e2yjPbq5r68jDHbbY=;
        b=rpRsnSjdBaqBv1hdRwsuSUn6Okecbpyg6JQpikVzJWggi2hiNUVLbpMLy60IHnbAAm
         Jk5quMVcSCP09IvI9lEyrdd0TjHgYIbgYHftwSZCh9jq0ILMrNvQ9NDnI6uKytFCjOQE
         gEbPBO+jZodEdslhJ9wkGk91rzlAfe+M+558yWwSElqOwnWRTn6eI4gWRuRR3yge6pzM
         ZWgNfke98noPqjRSQEP15DyQeLg4+hyu+JY2K49ioRmeDJEt4eguwKD30KHUCK5o4uZM
         ggblZ3mIBJdK4rd33awGCx7nMfZBJ6IwHN1Vp86RVPRFStyuBCKbggmJ7RSqokGKkgqf
         K2Aw==
X-Forwarded-Encrypted: i=1; AKwUvBzHUbAgLDg2/YVBbitMFFg01cgbimevlN/lUFaj0M6iJiTF7FOlhm9LUPUxpc/Ka6FxntZelORjMq3GRJA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/oezEpNn0K75qZOwd9L4nPkwHcOwYIukAQV8O9sUUNGDMcoL6P
	0/RYJ/Y/n2tfMrKBWeCzCbTyG1HMOBbU1Jl4dU9IOGDRbDrBX35ynRuSHc6Xlq0DtGH1Z5Oi3Wt
	NFZmhLJqWDpB6f5jP2F33yeJyw3Jm7MMZ8bCejNjLiutrQmbjn4ajcTkenF6oYyYTaVY=
X-Gm-Gg: AYBFou1WEjn0wi5tKZlDxiFoBsqkO2p8TiB8hjke7b/W7Kwoy+3Iqqlc7X0Pr34RdS7
	FfG6WXjwlg9lG3oIqC1bTRmfwfet39uS7VIHSKKOU1ZgY2Gumoql5iz4vFhdSJzECD3qqI370Fh
	IMg+0meLXYy60z86s3/QHkl1u4mtQUYnqKSEvTBVak5lbs13eCv9YcL1hgaeg24FiLEkM/tZvSi
	bdIofgUHfptUhCvyB9PqkKdPeITnlay2dNB0JhiYJTXKldeCgrHnWaoHPNK67oMEUF1UiaaLdRh
	PazCsVG+Sc2A+5fHZOnDDh1KKIZQKF+SDte6fzR1hqUWX+LTxTmFfQWovjFZ5UEWS2mgIhQyRsj
	a5ZyvB8gOs6h7ybLk67lKaO3MQ9yRzCyTE7nTry0Z76KMa8mccsVeGVvBsvny6+Hdoq6Dd0ENCU
	59HefRhb7kR5aogIDI
X-Received: by 2002:a05:620a:4487:b0:93e:c12c:fbbf with SMTP id af79cd13be357-945f36131dfmr656683985a.76.1794009999321;
        Fri, 06 Nov 2026 16:06:39 -0800 (PST)
X-Received: by 2002:a05:620a:4487:b0:93e:c12c:fbbf with SMTP id af79cd13be357-945f36131dfmr656679385a.76.1794009998935;
        Fri, 06 Nov 2026 16:06:38 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6acc4a7sm31624376d6.44.2026.11.06.16.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:06:38 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/3] dmaengine: convert to subsys_platform_driver() and
 subsys_platform_driver_probe()
Date: Fri, 06 Nov 2026 19:06:07 -0500
Message-Id: <20261106-dmaengine-subsys-v1-0-780eeddbf3ef@redhat.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBCF4auEWRvItDaCVxEXMZnEEYySaYsl5
 O5Gu/zgvb+CUGESOKsKhVYWfuUOPCjwd5cTaQ7dMJjBIppJh6ejnDiTluUmm2gM/oQWRxPxCP3
 2LhT5809errv78kF+/nWgtS91cMYmdAAAAA==
X-Change-ID: 20261105-dmaengine-subsys-1dc716130f14
To: Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <mani@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Zhang Wei <zw@zh-kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 imx@lists.linux.dev, linux-actions@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.17-dev-d96cb
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=oVVsVvvwfxfCApVHL620mY2qW7PKDgCvH3JDOSlJNIU=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLeZdcF1fMUmH+rXipql15WdnT/1AeSXHt/1r/5ue1r9
 M+H33PedJSyMIhxMciKKbIsyTUqiEhdZXvvjiYLzBxWJpAhDFycAjCR/hkM/8zit2odZXRSqNV5
 sVO+W9Z/z9Uvm+4UuU33k+g7uHdzqgojQ8N5ObsWa4OmxOCDrNu7b3qnL/RZuSGFoz3q0Oawy6H
 sjAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l_VKmshfYII7mZ5oMgVTiSB5uQt8F_ZKIU9NAQ1PWfY_1794009999
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reduce boilerplate code in these drivers and convert them over to use
the macros subsys_platform_driver() and subsys_platform_driver_probe().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (3):
      dmaengine: convert to subsys_platform_driver()
      dmaengine: convert to subsys_platform_driver_probe()
      dmaengine: fsldma: convert to subsys_platform_driver()

 drivers/dma/at_xdmac.c          | 12 +-----------
 drivers/dma/bestcomm/bestcomm.c | 18 +-----------------
 drivers/dma/dma-jz4780.c        | 12 +-----------
 drivers/dma/dw/platform.c       | 12 +-----------
 drivers/dma/fsl-edma-main.c     | 12 +-----------
 drivers/dma/fsldma.c            | 14 +-------------
 drivers/dma/imx-dma.c           |  6 +-----
 drivers/dma/mcf-edma-main.c     | 12 +-----------
 drivers/dma/moxart-dma.c        | 12 +-----------
 drivers/dma/owl-dma.c           | 12 +-----------
 drivers/dma/sa11x0-dma.c        | 12 +-----------
 drivers/dma/sf-pdma/sf-pdma.c   | 14 +-------------
 drivers/dma/ste_dma40.c         |  6 +-----
 drivers/dma/ti/omap-dma.c       | 12 +-----------
 14 files changed, 14 insertions(+), 152 deletions(-)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261105-dmaengine-subsys-1dc716130f14

Best regards,
--  
Brian Masney <bmasney@redhat.com>


