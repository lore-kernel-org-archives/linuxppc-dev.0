Return-Path: <linuxppc-dev+bounces-25088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1ACEC54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 10:09:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9lLZ4Ztqz2yYd;
	Thu, 30 Jul 2026 20:09:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785406198;
	cv=none; b=ObG8E1TMVMMxxBrCj6NY0VB9/DHfZGBFw1QoW8beJ9tzc55StEfu0SPrJ1Q+/KDt45hMDzkA/AxFoRqPjlT6yKGgZpI1u5XfkiD5GZAXH6vecm6zfeqYnrFu7jsZRTz8vu4rvvOhVc6mql302Gy/G9BsrPrfNbWNkmpRmEumBKpKwKlcqLPkZQx5o70bMaJCMywoLakS55WHqBEBza22kz1zeGAItwIzXMf/F1sk9uF6dyNY3CsztUp832l88aQmXKAzV+hjGDkzbMV/R6WtifLwYKx3b7IYC5vG1kBeRW2kZBhWQcgimg4WRW7H4vBGVkwodLjwtyNASzre1lyRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785406198; c=relaxed/relaxed;
	bh=hHXOv04DuMhM+9hs8qoLTNRU6S66RipG6LbigyuoqQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abg1Gskj775bp5ZuTpwiCN6VZXFTk2gLTIFQuZxN3KqZvby2IAESlrGK2OKaWMlW3PAg+FoWW9KKqS6pBqCZGP18QziMh46zU6ibPmpi9Y/yilAgj0ukGyDyolDxOna3DhfCW4tJoJim4ZNoVe93nED8sHU2FSDrujnwaCgyuOCOlRbW+4tjjIA8VhN/bxTDcstDsE6IIqG7ul8Xusp1AdAdZHmqHeYMsdfecpnxuVbCD8ihqN1IHcsudOMzD7E0tt20AIdUYXu+dUWinCKdwgxdLcY5+iWErXqiAwzC4opI5VkDA0fFVQEDdOR7uBp335JsDawZ/SD3mYOKUVhG8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVA+POSH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVA+POSH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9lLZ0Bbqz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 20:09:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 24DDE40E15;
	Thu, 30 Jul 2026 10:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E1D1F000E9;
	Thu, 30 Jul 2026 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785406196;
	bh=hHXOv04DuMhM+9hs8qoLTNRU6S66RipG6LbigyuoqQI=;
	h=From:To:Cc:Subject:Date;
	b=mVA+POSHxQAZLN+oAZWAVt9cmwnWFvtoz1E1rRBi6l/LsKDcpaSIM13dY1xwRPS6f
	 wjuBRIviuLuhLECvrSOXsYVOAT226CczOgVnCBzYY55/oD75ugofZ226zNKdPAgjCq
	 g+EaPGsXzlrCsMxHAfvEIwPC3hBpxECMuPuDIFKyKbbBO0dsXk79yKGAuZKuVtQUr9
	 Ks/ydUVHrCTvUvLU2jRxRqpyWIejaUfyuVlGbjlXLX9/kF4JctAUd3CrFBCPFUOZyA
	 2rhyWdTfqqB6tbcW6GmkFTnZMkdk8hxE4A7aK2DvBt+CnqnOeggU2A29UEtGviLlXh
	 8QbsryWpEFFhQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: RAGUENES Jean Noel <jean-noel.raguenes2@cs-soprasteria.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH] soc: fsl: qe: implement get_direction()
Date: Thu, 30 Jul 2026 12:09:40 +0200
Message-ID: <30b3f278a10b46252783458c81dc438df176f86c.1785405882.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=chleroy@kernel.org; h=from:subject:message-id; bh=t4jN5WDxBUnYILBi/TUtcunD2+40jxQnux/VuTVXIiY=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRlK706cLh8n9izg9viW/Os8+8qGp2/ev/Rc4VTLE3rH MNOhiTN7ihlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATadRjZNh0aoo5z6fjy6/s 5ioK69db+M44VkaeP/Jx2797pzc9zbJjZOh9a2O+cPnF21qaahNOzHq062mPctv1RT5OPH+zDxy 6OpkJAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

The lack of get_direction() callback in this driver causes GPIOLIB to
emit a warning. Implement it.

Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of gpio_chip::get_direction()")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/soc/fsl/qe/gpio.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 66828f2a3577..6d8f4d549fe2 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -135,6 +135,30 @@ static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
+static int qe_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct qe_gpio_chip *qe_gc = gpiochip_get_data(gc);
+	struct qe_pio_regs __iomem *regs = qe_gc->regs;
+	unsigned long flags;
+	u32 val, mask;
+
+	spin_lock_irqsave(&qe_gc->lock, flags);
+
+	if (gpio < QE_PIO_PINS / 2)
+		val = ioread32be(&regs->cpdir1);
+	else
+		val = ioread32be(&regs->cpdir2);
+
+	spin_unlock_irqrestore(&qe_gc->lock, flags);
+
+	mask = (u32)QE_PIO_DIR_OUT << (QE_PIO_PINS - 2 - (gpio % (QE_PIO_PINS / 2)) * 2);
+
+	if (val & mask)
+		return GPIO_LINE_DIRECTION_OUT;
+	else
+		return GPIO_LINE_DIRECTION_IN;
+}
+
 struct qe_pin {
 	/*
 	 * The qe_gpio_chip name is unfortunate, we should change that to
@@ -308,6 +332,7 @@ static int qe_gpio_probe(struct platform_device *ofdev)
 	gc->ngpio = QE_PIO_PINS;
 	gc->direction_input = qe_gpio_dir_in;
 	gc->direction_output = qe_gpio_dir_out;
+	gc->get_direction = qe_gpio_get_direction;
 	gc->get = qe_gpio_get;
 	gc->set = qe_gpio_set;
 	gc->set_multiple = qe_gpio_set_multiple;
-- 
2.54.0


