Return-Path: <linuxppc-dev+bounces-23805-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573C6C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:16:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDWx6FWLz2xpn;
	Wed, 08 Jul 2026 20:16:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505773;
	cv=none; b=Ve/FeKp5zQacPKt9S9q5qo6YzyD/YzYKVu4Qvx/AwDFv5ZOFCsv5PJPI6G3MirUR5cJIGJYBaTYe7kVP9kvIwXwYwzqkaUNaUcxUBMgyq7nfWKpEGXJJke7oyn0H/SZgLMrK5J0wby2IJ2ALrhVTcDSPE57nJuQ7lPTO7tu5APoZz7if/0X8p4URR81EWWOq0bfNlNjN5bHYX07FtGw6uaJSuBmKNp0+IgMcmeDzvY6dnQG/8p64p87bWwsx0TTiP/sNaJ+CA880hWMl9qZ5v+CzNpyXvMNch416II0t4B5uLxUjqfd3u65WqxMU2pSGwa4mViGC8LFnIkijjPYSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505773; c=relaxed/relaxed;
	bh=2D54DLwyp1FomyecUqBcQt3voMAAHcAPIOVYtACtMIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JkwUkBpgDZFX/VrfLjjG2/JoUFX8ngA6TfIw7aNnBnNwYLY3/HEbMFv0Gog5YM22WTyUeiY/U75TdTkaSKz3qxoxoKKdPhwKF5H2T0EtZwfs7X59Gtgok1yp+z7AT5YFmnRIyJnwTb9t5+Nn8z5t/J5zk7W6gfBRXjS2dta/y4V1y9E8EjIO0+xcbkZcODGyfNzVv1DkQrYauObldkoBF+AQvjKb0RsqYsHG+92hgbq675UKAZ+pqVwGYj3McCtpnFTsklarCmOczmnUMsZTz43PMw9X3n7T9YH4raHP6rCDr+qQLrLW22vJPMIrFFVdNH550i5HxS8c8clCfYB4PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=C2ttfkG7; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=C2ttfkG7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWx2czlz308H
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:16:13 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0CE371A0EDE;
	Wed,  8 Jul 2026 10:16:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D52A160337;
	Wed,  8 Jul 2026 10:16:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F165811BC3422;
	Wed,  8 Jul 2026 12:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505768; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2D54DLwyp1FomyecUqBcQt3voMAAHcAPIOVYtACtMIY=;
	b=C2ttfkG7CQu+QwlKhKO8Jy8mmOO5slLHoPzfhlHogbTefzYwmRXBzRSo+BrzSAmSqyrWJR
	G/cf+3aotc/5GwBrkT/7NtWu3Lpu0DcFqFrEoafdWidU8LMlwElD72mAnc1IHvpAX3a6pr
	qxmsmfSMCxsgGVcmY3jjR/y62yQczTURLd3Ctr6RlwNWr9k3GKXSaZgvLdESb2m4FopGBI
	ePG7/l2nZSQYgdpIcZ1/bgKWVosgvqpLWdsBk73Ok4wp7UL8K0jAlgKB2AEMQJGbGQqkwl
	R8zQMjs7PfUwYgpj98uBgJjmgDnngitJYzjUscI2aENsneBuchowX4FqiDhwbw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Wed, 08 Jul 2026 12:15:22 +0200
Subject: [PATCH v2 09/10] soc: fsl: qe: Rename irq variable to parent_irq
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-qe-pic-gpios-v2-9-1972044cfbd1@bootlin.com>
References: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
In-Reply-To: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
To: Qiang Zhao <qiang.zhao@nxp.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=1688;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=lg8pO2TtHb3jP6IOv7CUPg4uuEdOUB/AkCb+PKzxxEo=;
 b=8Gi3R+3l/3Km+4n/8HNw4vV2u2JZvzUjJIXrzPPYx5pm9Y0Ay81LIakl3dqT2jK6OvHk3ua8B
 zoC/7XHYaHfDLNoJmyi5xnIIBRuR6IRLZfntTDNkBdkr998zxLmUy4U
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Rename the local variable holding the platform IRQ to parent_irq, which
better describes its role as the upstream/chained interrupt in the
hierarchy.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 4f6b75439f9f..7375f92f528b 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -18,7 +18,7 @@
 
 struct qepic_data {
 	void __iomem *reg;
-	int irq;
+	int parent_irq;
 };
 
 static void qepic_mask(struct irq_data *d)
@@ -117,7 +117,7 @@ static int qepic_domain_init(struct irq_domain *d)
 {
 	struct qepic_data *data = d->host_data;
 
-	irq_set_chained_handler_and_data(data->irq, qepic_cascade, d);
+	irq_set_chained_handler_and_data(data->parent_irq, qepic_cascade, d);
 
 	return 0;
 }
@@ -126,7 +126,7 @@ static void qepic_domain_exit(struct irq_domain *d)
 {
 	struct qepic_data *data = d->host_data;
 
-	irq_set_chained_handler_and_data(data->irq, NULL, NULL);
+	irq_set_chained_handler_and_data(data->parent_irq, NULL, NULL);
 }
 
 static int qepic_probe(struct platform_device *pdev)
@@ -161,9 +161,9 @@ static int qepic_probe(struct platform_device *pdev)
 	if (IS_ERR(data->reg))
 		return PTR_ERR(data->reg);
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
+	data->parent_irq = platform_get_irq(pdev, 0);
+	if (data->parent_irq < 0)
+		return data->parent_irq;
 
 	domain = devm_irq_domain_instantiate(dev, &d_info);
 	if (IS_ERR(domain))

-- 
2.55.0


