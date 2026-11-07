Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C6606A326
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S4r+Adu3;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BU2YqtgH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S4r+Adu3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jM63p64jjz2y71;
	Sat, 07 Nov 2026 17:44:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794010085;
	cv=none; b=QHcDXZMZSfZdB1LIjmx7wxeF9I2wV+Z+Jmh0z8lf55XUyCK5HHYNEXlp9D1c9THV8UuAw3H+u+wLQHXQ3BK3EoSjLhrjB64JEPtzthUUpkzMFov9eVeHhZQp49YpbfpV9PITRc23d+9zuDz5zxX1NSeDka2Ywn3GqkbOpoaNjQX5hc8/LVlOYR6yiw4Bmw2skADD0jTXBRbObiVxsJ4qN7NrBnzbj8iE21A2RnLrncIJ2TYGfMUE6Mytki/9FhU/tRjkWUlMyk7qz+NXCUQCnyb6ggioUaH/bHaO1gtrWYyv6Op7SEQiBNXFn26Ug1LlxGw5CIIVmIjcY1RZbcJdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794010085; c=relaxed/relaxed;
	bh=b1jw8/k9HF1Z0QFcfzQluiREZXrKVRI5j5BkQVxckCU=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=ALV2TfilGac+DMv8+PV4HYD6R8TM2rBjA8HlTAWkpnHSNi7IQWz4xdim9i0OuQDIqepDSxqJfa8hRUDd8e+jPbyzspN4Z7LJSNFsw+5lU3IscbXSJm1lGoyhLKDl6YG2L1iqR4W3UWwFjd3c7ryDhAlEU3qRipDif8FEB17lst+wTXfAfQUqEOC9wo9VA3uFsgZwBUqIMiPeixu32wKoCwdcJYWkEps6SF0wyrVAVWPEH0WFg2mMz7rm+48YY8yjk4FqYcF7Upky5rHqpm2O0L/Th2lPm3Yju568Kx438KCvYU51Esm1bPXH9I+2Z4VZR1pv1H3hakWsrXfYyzvDNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S4r+Adu3; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BU2YqtgH; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S4r+Adu3; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S4r+Adu3;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BU2YqtgH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S4r+Adu3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLxFw6mnLz2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 11:08:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1jw8/k9HF1Z0QFcfzQluiREZXrKVRI5j5BkQVxckCU=;
	b=S4r+Adu3VJZwqUxOsZ0sg+LFhuvIHg2J8IRJ21jfbIBLMqhdpGXuHUbvaduIVITETreMMy
	F8yVpEieDoAyQPe4LeavKVPmRNHEYBhdV8H75ZEoVwzrsH79FshMj/jD4PaU+jlxqS0DLJ
	rjatmaFh63/dbFBgkxaNiiTHCi7KFIM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1jw8/k9HF1Z0QFcfzQluiREZXrKVRI5j5BkQVxckCU=;
	b=BU2YqtgHSE7J2z9hv9UTAZ5oOxIYSLlnTfn5oztw425XSKRjjhLoN3UIucZSgI2LUdswv6
	KpEeM6a23TWp+omkrXZphDdzlXZHstpYSvmDj8dUxDwxuAOfrobTj0dr4GqLGV0G5JD0uC
	OW33cbGcUzTGREBYMCXz4AmsTkfQzX4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1jw8/k9HF1Z0QFcfzQluiREZXrKVRI5j5BkQVxckCU=;
	b=S4r+Adu3VJZwqUxOsZ0sg+LFhuvIHg2J8IRJ21jfbIBLMqhdpGXuHUbvaduIVITETreMMy
	F8yVpEieDoAyQPe4LeavKVPmRNHEYBhdV8H75ZEoVwzrsH79FshMj/jD4PaU+jlxqS0DLJ
	rjatmaFh63/dbFBgkxaNiiTHCi7KFIM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-vGXUyimhNzifbhZOQUkQtA-1; Fri, 06 Nov 2026 19:06:48 -0500
X-MC-Unique: vGXUyimhNzifbhZOQUkQtA-1
X-Mimecast-MFC-AGG-ID: vGXUyimhNzifbhZOQUkQtA_1794010007
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-544019b1831so23294111cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 16:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794010007; x=1794614807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1jw8/k9HF1Z0QFcfzQluiREZXrKVRI5j5BkQVxckCU=;
        b=jSbCr8Gene5aGGrR0vvc40ofOsy9azNxlQGZuSpxxzyjsM+3bIIMoxn8u076Nlmdb7
         x4N2HXg23LdZ5moyzJQl+3YC/THe4P6K/fjuMVBE1JdBXyLqYepIWZObGfv4VjZ+Y0cA
         dBjRMoENEsgHuuKhMEmZh9Tk29Zmpl5MdxvMeSSdHVsD1EJ2lJ1uQE1mFiqp7YFXmg/V
         4T4td5CrU3LAdwA+oR7MbxBinye+y6Oqe5i1m1CGfO6Zn6gSJHHemeMXC2kbleRdYTES
         yGaFSJrtSANwArMURBSA8byYG1KrHhFhhmz/EozvixhBGv9LxVeYpKvr1sDp5GMCZrIg
         TbYw==
X-Forwarded-Encrypted: i=1; AKwUvBxFgmycO3QLV6j4iB+N+T+uq+EGB9P+be1T7kHkCN8O4Ib1jMQkA6LsDz560fFI5VtAiudYsK87fuSYUGY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+nIVMtjfsO/GJtnxU6svSw16kCO4PRf92DSyDv7iRBdsXHYcfW
	bnsz/U9TtPMbKIqVOmukfFdMEyAiJ7wa54ciupviMM1dG+mB6qDxN/G80h1ScQq/bcZG6eTkdp0
	eVpBDZaTv9U+LeFGV5BODPn0W1aLlLKinw2f6/fgUwvUalGBKJmd2n8OK434BUfHwdbQ=
X-Gm-Gg: AYBFou1JQ/jxRt/ArosR7vF5ipFs0ZSeT6duorPkvqEiIW3g5LZ3IOwhvjHXlGaIDzR
	t5iiL5Bdf1xUl2iEFifQv97fzuwVfls6vYY/tQiKoEb49SfdW1TD0EJKfX5ITl+X/GBd3Hol3k4
	tY+W8Nune2nP8gHUdaZT5kGwEdlKteHGd2D3fi2XFrkXcW3lnHKP0EDsgItg+eQGgkd5J/GRkiK
	K/Bw7fVXzhtGlLKuDMHmV1rgf0PMeT/umVxbJV7LpFhSqzWiB2JlxOQNBbl0RAA3+wkg9OuAe46
	5brPhZewbLCd/2vVngbXWUGaOTQSM1ULGjxG2XZQbNJS7Nrfn60RAPVOvojKdRMjydKpkdRbQAH
	ey1xG2sYDc9x2ZRU3DTSgbXqHKy0cW5QIfz31RoZDoiam78/O54bq3payZ+9atiiBCurqNJ4UoG
	RWtxC4oKSw6fTEwjhu
X-Received: by 2002:a05:622a:114b:b0:537:f05d:881a with SMTP id d75a77b69052e-54e132997ddmr61751721cf.12.1794010007256;
        Fri, 06 Nov 2026 16:06:47 -0800 (PST)
X-Received: by 2002:a05:622a:114b:b0:537:f05d:881a with SMTP id d75a77b69052e-54e132997ddmr61751141cf.12.1794010006668;
        Fri, 06 Nov 2026 16:06:46 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6acc4a7sm31624376d6.44.2026.11.06.16.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:06:42 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 06 Nov 2026 19:06:10 -0500
Subject: [PATCH 3/3] dmaengine: fsldma: convert to subsys_platform_driver()
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
Message-Id: <20261106-dmaengine-subsys-v1-3-780eeddbf3ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=hy3g6mWddGYLX6Myo7kSoYtQp+hY5Hbo/vUsysOb4zQ=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLeZbeeNxabtVqgmXFuKMOEE2yy/Scinn4R5Zj7TWhOt
 atoruLqjlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACbiOouR4cR1jkNqh68wrEm/
 stlDUKbx8PxggVfG0h+OhJx8eL8//yQjw16uPZumb/y3PVJc7N7WsJVuGVcamc2sSnpsTuX05Pi
 UMQAA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vHuOIuL9_gv5PkaJVIofOsqrPXrgkqEfC5KUIJ-oxGA_1794010007
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

Reduce boilerplate code in this driver and convert it over to use
the macro subsys_platform_driver().

Note that this driver previously displayed a log message during init
time, and this change drops that message.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/dma/fsldma.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 99a878ed1444..fd3dca7616a8 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1431,19 +1431,7 @@ static struct platform_driver fsldma_of_driver = {
 /* Module Init / Exit                                                         */
 /*----------------------------------------------------------------------------*/
 
-static __init int fsldma_init(void)
-{
-	pr_info("Freescale Elo series DMA driver\n");
-	return platform_driver_register(&fsldma_of_driver);
-}
-
-static void __exit fsldma_exit(void)
-{
-	platform_driver_unregister(&fsldma_of_driver);
-}
-
-subsys_initcall(fsldma_init);
-module_exit(fsldma_exit);
+subsys_platform_driver(fsldma_of_driver);
 
 MODULE_DESCRIPTION("Freescale Elo series DMA driver");
 MODULE_LICENSE("GPL");

-- 
2.56.0


