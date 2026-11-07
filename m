Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED6606A326
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr3uu5rl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr3uu5rl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr3uu5rl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jM63X0Xm0z2y2K;
	Sat, 07 Nov 2026 17:44:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794010010;
	cv=none; b=EEaHU0XLorln2RYLcKlHcgTUIkhfD1fcw0Q9OzNnW0noi6Tr3wbH5YFHYpLI7FbBIQYxqLJ1RkAbnMpbZ52npN8teJcqxE/zjU9eaCt8xpvTc/KDaUivG1ajGXhp1k1wHj8kdEUNNWrLDa5j3+RIeE1si6hj+h6di+Z99fcpxmfVhqdKxoPpgy5CynGlGlNHpElWmX47IGLPCloQIJ9i4NuOsqFNkFvchX96SzSQa90ZtED3iGjWIdtDHneM0SZlnrcJW3QGIDDyGJZ3TObCjTtNXwyi41NbazYRT39sA6nJpxOhWjZ+jyNHh1iDMaw3QXT2WsW+BDvSpI1O7kLN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794010010; c=relaxed/relaxed;
	bh=XP2lKTQGAydL4R+xsCm0cY669RVVtn0VvIRtylww03o=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=E7/HbKPUG5E/0doFkRMAupV9XrlxoTDUcil0OiGgx+mgbGQNSHSH48Rguv0jmQmRIOK4Hv63fV7qHeNTqWsUdMxFMiVj/mUK4X+Lv8NzS3Yv7PKf80sfVWmnH3znaQX3PyYGMTuMSi9JPA+773Q4K+M1T2z/Vn18hkFfyBbgb/rI10HdRAAtrEy5wBtx1OYqZ0Qkp9nSfB9Jvo52swpoMsnedU8aV5SI4gYAaPLabGDlPgCt9CFebRKqoYcQnJ4Y3e5NlK4J8XkYafh2DWpj31YvITtCBpK13UFDoz67UGCMMm9iWEDvAlI7wWqob9G0tUmxhu2oUVR7mpzYErTRmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr3uu5rl; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr3uu5rl; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr3uu5rl; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr3uu5rl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr3uu5rl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nr3uu5rl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLxDT4693z2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 11:06:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2lKTQGAydL4R+xsCm0cY669RVVtn0VvIRtylww03o=;
	b=Nr3uu5rlAVDjHH2h7Eo9sdMH6mu3RhgGAn2X16swM8S3O9KlCkcOS447gw37V3aCGRI7kl
	OZ+/9AnSbuGlNykwJ9wRI49G9AQpTCYeiT2OyWcovXCHXOVdxazXtmvgXmWXOgsNo25ay6
	qPwKP/Gq72OP7gra7utmqsL59H5FVHQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2lKTQGAydL4R+xsCm0cY669RVVtn0VvIRtylww03o=;
	b=Nr3uu5rlAVDjHH2h7Eo9sdMH6mu3RhgGAn2X16swM8S3O9KlCkcOS447gw37V3aCGRI7kl
	OZ+/9AnSbuGlNykwJ9wRI49G9AQpTCYeiT2OyWcovXCHXOVdxazXtmvgXmWXOgsNo25ay6
	qPwKP/Gq72OP7gra7utmqsL59H5FVHQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XP2lKTQGAydL4R+xsCm0cY669RVVtn0VvIRtylww03o=;
	b=Nr3uu5rlAVDjHH2h7Eo9sdMH6mu3RhgGAn2X16swM8S3O9KlCkcOS447gw37V3aCGRI7kl
	OZ+/9AnSbuGlNykwJ9wRI49G9AQpTCYeiT2OyWcovXCHXOVdxazXtmvgXmWXOgsNo25ay6
	qPwKP/Gq72OP7gra7utmqsL59H5FVHQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-Zf2OplyxNP60FHM0SIaQtw-1; Fri, 06 Nov 2026 19:06:43 -0500
X-MC-Unique: Zf2OplyxNP60FHM0SIaQtw-1
X-Mimecast-MFC-AGG-ID: Zf2OplyxNP60FHM0SIaQtw_1794010002
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-946038e22f5so67636385a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 16:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794010002; x=1794614802;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XP2lKTQGAydL4R+xsCm0cY669RVVtn0VvIRtylww03o=;
        b=CUuMOCh5R7ZYbvdT/9C3lFxFFJbrqovO3/I/xiRPxfheKXdSQ4hQVknTlWURBWZ2dt
         mLa+PAJ0vvZbnHH25MTLrMsf5O8OHrbiMm8z82WxXoTaKG3+WNy1hE2O4FhO429qdiwt
         kvte9ExBT9PlPKOIvzvyYEMM//jkxqfpb3HxoxHX2Qji3N85c5xcT2+U8sAiMtO6iNTa
         pRz5bee6CChXzdWN9EaQvJpn3bpiIKyW9mOM9z6jTabTK9qAsKUCILzhdtwzJqrASZSq
         9XNAGWYGT3WTC6ARPCZnnJaz1rhvE7pD0mRmNdypLyt8Si4P/jD9u7EM2I+nhIJUb8qw
         Rp9w==
X-Forwarded-Encrypted: i=1; AKwUvBz49EFSj94NsecOaN9q/NYbPOUCg2B3/trJDfJWnwUpz9LxjxaFxF8ITEtpUthTfapEge3l8ynt/w1pQd4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+pmpvCEc6iWriy0fkl1h5WlmYPu9ZBpxgsI1jyge7W7g8+V4Re
	JYuYSPyOwbxkbL7GUahBJFDtEEG9rCozTV4DqnI2lPxMgFRHcwEU1WQRa3YtO/VvcNBweOnzBYw
	qoxzytW3m5f/sebkRb2z5ktTtlC/BQNzztYM+LvXhKNViY+7nom/fNStdjQSN4l1IXCWi7s1zUL
	Q=
X-Gm-Gg: AYBFou0vEfPlF/D3i9VaaXDfqBh6tTye3Ybzv5FOs+4xTeGtZovunSptP9paoj2IDdX
	IyccZrKBnlMEh4yNIACTisO3fWVXMvRiXzXaPsRQzK4CTNZAUj8dRhfwPV5HloUBwx4SJgHIrwP
	gPc2uVe2f0pcm6U3v1uvfiRLd+PyAHxLL6zP0O+DO5Ckv+Tq4zxA6gnvF3NneDRnmlnf6Q5uoxK
	TOfSuly3XhfEoAcoQPVUh/rJvN6Jtu07k8a/1zmVVpUn10kfSkoBEIy9oq4ifZEtMa9Qir4ggMF
	Xf5VMtffYncYJuEI+AWuDJH4C38qAjGUGli5TzW5kEa7TxMccspvqqlyJ/gKH7RnpL5BhTXqI32
	gkNSo2l/k+IP0JDvqiaEWBzNEtJVkb/z/Uj1GCwFSwXeL6mgakfONrc/9ST8+PLFuhnUCh2plO+
	glQ9xaZ6kVomqguj7F
X-Received: by 2002:a05:620a:468f:b0:93e:6325:ae6d with SMTP id af79cd13be357-945f349ce35mr704445685a.40.1794010002571;
        Fri, 06 Nov 2026 16:06:42 -0800 (PST)
X-Received: by 2002:a05:620a:468f:b0:93e:6325:ae6d with SMTP id af79cd13be357-945f349ce35mr704441785a.40.1794010002132;
        Fri, 06 Nov 2026 16:06:42 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6acc4a7sm31624376d6.44.2026.11.06.16.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:06:41 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 06 Nov 2026 19:06:09 -0500
Subject: [PATCH 2/3] dmaengine: convert to subsys_platform_driver_probe()
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
Message-Id: <20261106-dmaengine-subsys-v1-2-780eeddbf3ef@redhat.com>
References: <20261106-dmaengine-subsys-v1-0-780eeddbf3ef@redhat.com>
In-Reply-To: <20261106-dmaengine-subsys-v1-0-780eeddbf3ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=FjTOp1M8Xy8WBCnxDwFzONX6zQMkkI1R2AYzFx+nwrU=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLeZbdoi/pLp60VjjwvcUxslVrirb5DV/utktpvPDq5W
 Wn/wb71HaUsDGJcDLJiiixLco0KIlJX2d67o8kCM4eVCWQIAxenAEykdQkjw6JqyU0+3VVfSzWl
 u41X9l86OG0B89PfCwV8v3te0lN3YmD4K1PKxrDgtUqx6oLWQ+/ii6VYfpw6XSt0c6OA5Me1z50
 zWAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BwvqUntMv0kh11Orn88etm3zExFQP9N0mhCY7xjyHck_1794010002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reduce boilerplate code in these drivers and convert them over to use
the macro subsys_platform_driver_probe().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/dma/imx-dma.c   | 6 +-----
 drivers/dma/ste_dma40.c | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 81c6276436f8..8e0e82df8c5b 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1238,11 +1238,7 @@ static struct platform_driver imxdma_driver = {
 	.remove		= imxdma_remove,
 };
 
-static int __init imxdma_module_init(void)
-{
-	return platform_driver_probe(&imxdma_driver, imxdma_probe);
-}
-subsys_initcall(imxdma_module_init);
+subsys_platform_driver_probe(imxdma_driver, imxdma_probe);
 
 MODULE_AUTHOR("Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>");
 MODULE_DESCRIPTION("i.MX dma driver");
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 2e83503f71d1..4fb54c8f2d23 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3990,8 +3990,4 @@ static struct platform_driver d40_driver = {
 	},
 };
 
-static int __init stedma40_init(void)
-{
-	return platform_driver_probe(&d40_driver, d40_probe);
-}
-subsys_initcall(stedma40_init);
+subsys_platform_driver_probe(d40_driver, d40_probe);

-- 
2.56.0


