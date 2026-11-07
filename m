Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C0606A326
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gdm3ijz8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gdm3ijz8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gdm3ijz8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jM63g1dLxz2y2K;
	Sat, 07 Nov 2026 17:44:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794010073;
	cv=none; b=Rqbs2lK0uplwuvT1XyoU5SR3p10urnlJo6EOUMsgdpsmPc/WuN/11Tg0FieG7YyHliMVHLfaEGpzgwxXDPbre+XEasQu1X2iY4grENAAytRkIF497OQkeHmsW5DZv7f/P4TXG33GHrf5ne+0Jp+ArCKp4sTFl+xQ9YjjljQ2SuSAxCLxIXJo6T0cKHnPFezvHRuEGDAsOILV0gGfWs8KG6D/wLnAj299ts6OTtH8rrjmV21sArFpANSgBAfMwzDQonRzlj8VMd2laOGvhj2IUqcK99nHLxnDOjcxyJKgTdep9mCFkLzBdRh19s87G5EQtlPT4tcK9Q+1MTDNzu3lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794010073; c=relaxed/relaxed;
	bh=UdtdyDCTn3IifZCbbp9UgSX4Df7wJU84qONeUfr3t8U=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=lliCQpqIPvnnq27ssX9zf32C6ER9YlMgKjaRWn7SRU4GqJGeYJ14hfbPUx+8ybNI5+FtHwtTBrQDnqb0x8QasFvsEfwM/MWenOxFTPeB/9B3mAAsXyjlWkHuzxazG5iF6F7dwFdzdK2I6NYKTxiT66B0eR9oHMvTUBX0L/cPbLM6UHrmz8PC73ZHpGlpmjlqebGJ7BBlVHb1klx6Pv8jgsZXVTdN2zlqnmblWxOcLt0HyGe7p57hYDLSXQObJKc8seAFTxCH4CAKKTmLm3qUVgr3JHB4u96gqPUjejMpGWUH6kuTePX7OWaKpTFiovMJoDfmOs7HjV5lZbBv/9pz4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gdm3ijz8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gdm3ijz8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gdm3ijz8; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gdm3ijz8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gdm3ijz8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gdm3ijz8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Sat, 07 Nov 2026 11:07:52 AEDT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLxFh0cz2z2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 11:07:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdtdyDCTn3IifZCbbp9UgSX4Df7wJU84qONeUfr3t8U=;
	b=Gdm3ijz8U6rbJfq685hRTKrm1wdwCWQAlw4ieUEeiXCfNPdPAp/N4uUQPCrVJ8qBqr8r2d
	khlALKZTXwevBWuTqg9/VLBN53EgeEfDXLM4FkGJxk75m7Ce/R6EMefWDEhX0To0cKytit
	IajKlpJSUzSdxgwljO9ZRAkLgG0KoGY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdtdyDCTn3IifZCbbp9UgSX4Df7wJU84qONeUfr3t8U=;
	b=Gdm3ijz8U6rbJfq685hRTKrm1wdwCWQAlw4ieUEeiXCfNPdPAp/N4uUQPCrVJ8qBqr8r2d
	khlALKZTXwevBWuTqg9/VLBN53EgeEfDXLM4FkGJxk75m7Ce/R6EMefWDEhX0To0cKytit
	IajKlpJSUzSdxgwljO9ZRAkLgG0KoGY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794010068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdtdyDCTn3IifZCbbp9UgSX4Df7wJU84qONeUfr3t8U=;
	b=Gdm3ijz8U6rbJfq685hRTKrm1wdwCWQAlw4ieUEeiXCfNPdPAp/N4uUQPCrVJ8qBqr8r2d
	khlALKZTXwevBWuTqg9/VLBN53EgeEfDXLM4FkGJxk75m7Ce/R6EMefWDEhX0To0cKytit
	IajKlpJSUzSdxgwljO9ZRAkLgG0KoGY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-L2ST6RhYP-ebAoXitHrBBA-1; Fri, 06 Nov 2026 19:06:42 -0500
X-MC-Unique: L2ST6RhYP-ebAoXitHrBBA-1
X-Mimecast-MFC-AGG-ID: L2ST6RhYP-ebAoXitHrBBA_1794010002
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91ea053ef90so22708236d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 16:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794010001; x=1794614801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdtdyDCTn3IifZCbbp9UgSX4Df7wJU84qONeUfr3t8U=;
        b=SpEEoSKD+ybMQxZFWcKh3d1r9lDQRYqfboFPUMASmdrir4WaJf1e7+vNrXSoVH4Jvh
         k+08IqoYb3+u0NLuhiT2pOl9yRUpFh4uKKFfJWVGPRPONdHzg0c5xeWA3lhOR9nt6aWz
         MVb3d2RooaddNN7jtN2ADKoTv8vG++9KbxCL8yg9EztuIIjeHoy4iA9AVpQBiuGR0cOZ
         S9XVBKfggBKsN0QMHA+vixDlmfK1mYLfZuxpKzj8gVlZQrPPYblNceWGtMKCn3IzuXb2
         Zg2Iug/LkW20MUUTuMzPu8HgDUfQ1WGVVQrlA82zl0y9xAk4LcvjXw8pswdivQf4ehAe
         KxAg==
X-Forwarded-Encrypted: i=1; AL+hErEUqKtF2O35x4XEqcULC+VOCEswjPnSWr64qTPkxNxNraUxzAphJynD3Z0EqSUo/MAPP5L0HwotjSaZ9/Q=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8TE+QfChHrtCCXbv+7Cy4YNtA2JAlE2okzWQN+qwZ7/BdWjJHG
	tK0vGRiuqgc36LdtPp+LzQlcDOQdfvBAHqyu6JArCz91iLdyFulHVa6T65XV0+qtWYbqGZU/ohL
	M7MFbI7KKKXr16bTGVRDe0Zyw+xDN7OvG+EwlBXrxZPun542fwZ75DnzYUO6GsWZ1bCU=
X-Gm-Gg: AYBFou1ttquYcw5vqUmWKjQxoGgpUkbj9oQDAoUAT4eYso6dgXwxqexdMa4e+dYcSU3
	bjO+seS1CCg/nbByjkwYnhUaw+YGL+Cag5mtTwUZP3PCyti3mPcNOtEKSgBSNR8muxZywgNBVRn
	lgz3a7lqzy/RSiPg0T3SvtnZUhJ4j9vBcjmGxgWlAgMA3hvQrsLlabTBXHe6tZMvhHhGfDuuRvF
	WMFyqWX+Tcb6dtNEJmbxVVBJdqE5V9PJtlcJNsuinEfEugdajUZPKqMiO80Yxhu9gseml73pYuc
	wQU3RH8N+ONd4hAdkxrsD/RO/LoiglS0HbIl8a+NYsDSNpX2Py1hu/YvSU/bsIAexm9jZ4zCvjV
	lcBeyXi3PxC63OwUdsPwv7m8M+GDUZiWvqfUs/1OaqVQBxxipR/jYWSdZbgUNkxGfO4erWJNqtG
	4ia+oB0SVatTiZl9/X
X-Received: by 2002:a05:6214:460e:b0:91e:7bef:a4b4 with SMTP id 6a1803df08f44-91ea927f443mr60124096d6.2.1794010001255;
        Fri, 06 Nov 2026 16:06:41 -0800 (PST)
X-Received: by 2002:a05:6214:460e:b0:91e:7bef:a4b4 with SMTP id 6a1803df08f44-91ea927f443mr60123486d6.2.1794010000556;
        Fri, 06 Nov 2026 16:06:40 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6acc4a7sm31624376d6.44.2026.11.06.16.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:06:39 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 06 Nov 2026 19:06:08 -0500
Subject: [PATCH 1/3] dmaengine: convert to subsys_platform_driver()
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
Message-Id: <20261106-dmaengine-subsys-v1-1-780eeddbf3ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8793; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=7C9fqKNgBFi22vFkQ7N44YlNIVFY4LFfjkA6CgiIeoo=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLeZTfvfKz943LobmVhe7b8mWVbi7s0N16MnLjy6OrJu
 nMrz9dc7ChlYRDjYpAVU2RZkmtUEJG6yvbeHU0WmDmsTCBDGLg4BWAiIZYMf3h6irao8mR5rN9e
 nCO3qDN2/abUyA6TmvOSek6z107tdmVk2HVn4sn8uxFz/s7Ilqp7F3bZzq7Zj/+OyvPF04Um7DS
 OYAMA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s5Cu-xmC16lzKMQfLujrI1PODfknD6JR170gq1iGmh8_1794010002
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
the macro subsys_platform_driver().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/dma/at_xdmac.c          | 12 +-----------
 drivers/dma/bestcomm/bestcomm.c | 18 +-----------------
 drivers/dma/dma-jz4780.c        | 12 +-----------
 drivers/dma/dw/platform.c       | 12 +-----------
 drivers/dma/fsl-edma-main.c     | 12 +-----------
 drivers/dma/mcf-edma-main.c     | 12 +-----------
 drivers/dma/moxart-dma.c        | 12 +-----------
 drivers/dma/owl-dma.c           | 12 +-----------
 drivers/dma/sa11x0-dma.c        | 12 +-----------
 drivers/dma/sf-pdma/sf-pdma.c   | 14 +-------------
 drivers/dma/ti/omap-dma.c       | 12 +-----------
 11 files changed, 11 insertions(+), 129 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index d40a8b40dddc..8b19d46ac812 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2488,17 +2488,7 @@ static struct platform_driver at_xdmac_driver = {
 	}
 };
 
-static int __init at_xdmac_init(void)
-{
-	return platform_driver_register(&at_xdmac_driver);
-}
-subsys_initcall(at_xdmac_init);
-
-static void __exit at_xdmac_exit(void)
-{
-	platform_driver_unregister(&at_xdmac_driver);
-}
-module_exit(at_xdmac_exit);
+subsys_platform_driver(at_xdmac_driver);
 
 MODULE_DESCRIPTION("Atmel Extended DMA Controller driver");
 MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index 241a91936fe8..1dadcc259382 100644
--- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -474,23 +474,7 @@ static struct platform_driver mpc52xx_bcom_of_platform_driver = {
 /* Module                                                                   */
 /* ======================================================================== */
 
-static int __init
-mpc52xx_bcom_init(void)
-{
-	return platform_driver_register(&mpc52xx_bcom_of_platform_driver);
-}
-
-static void __exit
-mpc52xx_bcom_exit(void)
-{
-	platform_driver_unregister(&mpc52xx_bcom_of_platform_driver);
-}
-
-/* If we're not a module, we must make sure everything is setup before  */
-/* anyone tries to use us ... that's why we use subsys_initcall instead */
-/* of module_init. */
-subsys_initcall(mpc52xx_bcom_init);
-module_exit(mpc52xx_bcom_exit);
+subsys_platform_driver(mpc52xx_bcom_of_platform_driver);
 
 MODULE_DESCRIPTION("Freescale MPC52xx BestComm DMA");
 MODULE_AUTHOR("Sylvain Munaut <tnt@246tNt.com>");
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index ac2094e65ecf..32a40c17e0cd 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1129,17 +1129,7 @@ static struct platform_driver jz4780_dma_driver = {
 	},
 };
 
-static int __init jz4780_dma_init(void)
-{
-	return platform_driver_register(&jz4780_dma_driver);
-}
-subsys_initcall(jz4780_dma_init);
-
-static void __exit jz4780_dma_exit(void)
-{
-	platform_driver_unregister(&jz4780_dma_driver);
-}
-module_exit(jz4780_dma_exit);
+subsys_platform_driver(jz4780_dma_driver);
 
 MODULE_AUTHOR("Alex Smith <alex@alex-smith.me.uk>");
 MODULE_DESCRIPTION("Ingenic JZ4780 DMA controller driver");
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 5c1c97eb28a4..7576ad255343 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -195,17 +195,7 @@ static struct platform_driver dw_driver = {
 	},
 };
 
-static int __init dw_init(void)
-{
-	return platform_driver_register(&dw_driver);
-}
-subsys_initcall(dw_init);
-
-static void __exit dw_exit(void)
-{
-	platform_driver_unregister(&dw_driver);
-}
-module_exit(dw_exit);
+subsys_platform_driver(dw_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare DMA Controller platform driver");
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 630285c85482..c731104c3306 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -978,17 +978,7 @@ static struct platform_driver fsl_edma_driver = {
 	.remove		= fsl_edma_remove,
 };
 
-static int __init fsl_edma_init(void)
-{
-	return platform_driver_register(&fsl_edma_driver);
-}
-subsys_initcall(fsl_edma_init);
-
-static void __exit fsl_edma_exit(void)
-{
-	platform_driver_unregister(&fsl_edma_driver);
-}
-module_exit(fsl_edma_exit);
+subsys_platform_driver(fsl_edma_driver);
 
 MODULE_DESCRIPTION("Freescale eDMA engine driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 9e1c6400c77b..fb6c06d4a8d1 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -282,17 +282,7 @@ bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL(mcf_edma_filter_fn);
 
-static int __init mcf_edma_init(void)
-{
-	return platform_driver_register(&mcf_edma_driver);
-}
-subsys_initcall(mcf_edma_init);
-
-static void __exit mcf_edma_exit(void)
-{
-	platform_driver_unregister(&mcf_edma_driver);
-}
-module_exit(mcf_edma_exit);
+subsys_platform_driver(mcf_edma_driver);
 
 MODULE_ALIAS("platform:mcf-edma");
 MODULE_DESCRIPTION("Freescale eDMA engine driver, ColdFire family");
diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 28be93eed4cc..d33733afce9d 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -646,17 +646,7 @@ static struct platform_driver moxart_driver = {
 	},
 };
 
-static int moxart_init(void)
-{
-	return platform_driver_register(&moxart_driver);
-}
-subsys_initcall(moxart_init);
-
-static void __exit moxart_exit(void)
-{
-	platform_driver_unregister(&moxart_driver);
-}
-module_exit(moxart_exit);
+subsys_platform_driver(moxart_driver);
 
 MODULE_AUTHOR("Jonas Jensen <jonas.jensen@gmail.com>");
 MODULE_DESCRIPTION("MOXART DMA engine driver");
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 9dc88d804a2e..c13c449ad05b 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1254,17 +1254,7 @@ static struct platform_driver owl_dma_driver = {
 	},
 };
 
-static int owl_dma_init(void)
-{
-	return platform_driver_register(&owl_dma_driver);
-}
-subsys_initcall(owl_dma_init);
-
-static void __exit owl_dma_exit(void)
-{
-	platform_driver_unregister(&owl_dma_driver);
-}
-module_exit(owl_dma_exit);
+subsys_platform_driver(owl_dma_driver);
 
 MODULE_AUTHOR("David Liu <liuwei@actions-semi.com>");
 MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index a6fa431530e3..70b191519053 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -1080,17 +1080,7 @@ static struct platform_driver sa11x0_dma_driver = {
 	.remove		= sa11x0_dma_remove,
 };
 
-static int __init sa11x0_dma_init(void)
-{
-	return platform_driver_register(&sa11x0_dma_driver);
-}
-subsys_initcall(sa11x0_dma_init);
-
-static void __exit sa11x0_dma_exit(void)
-{
-	platform_driver_unregister(&sa11x0_dma_driver);
-}
-module_exit(sa11x0_dma_exit);
+subsys_platform_driver(sa11x0_dma_driver);
 
 MODULE_AUTHOR("Russell King");
 MODULE_DESCRIPTION("SA-11x0 DMA driver");
diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6f79cc28703e..d62563f6c7f0 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -639,19 +639,7 @@ static struct platform_driver sf_pdma_driver = {
 	},
 };
 
-static int __init sf_pdma_init(void)
-{
-	return platform_driver_register(&sf_pdma_driver);
-}
-
-static void __exit sf_pdma_exit(void)
-{
-	platform_driver_unregister(&sf_pdma_driver);
-}
-
-/* do early init */
-subsys_initcall(sf_pdma_init);
-module_exit(sf_pdma_exit);
+subsys_platform_driver(sf_pdma_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("SiFive Platform DMA driver");
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 55ece7fd0d99..da1f4eec9eb2 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1941,17 +1941,7 @@ static bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
 	return false;
 }
 
-static int omap_dma_init(void)
-{
-	return platform_driver_register(&omap_dma_driver);
-}
-subsys_initcall(omap_dma_init);
-
-static void __exit omap_dma_exit(void)
-{
-	platform_driver_unregister(&omap_dma_driver);
-}
-module_exit(omap_dma_exit);
+subsys_platform_driver(omap_dma_driver);
 
 MODULE_AUTHOR("Russell King");
 MODULE_DESCRIPTION("Texas Instruments sDMA DMAengine support");

-- 
2.56.0


