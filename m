Return-Path: <linuxppc-dev+bounces-23508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2707DC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:39:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQbQ0NMjz2xC3;
	Sat, 04 Jul 2026 06:39:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783085776;
	cv=none; b=JAhLJyvVFR+yOTo2UwsHcNNNkbYEvTxju+65Icd4206xK661f24P/PRC6bvrxmG4aREhXCfWP+FOJ6H8czrCwE7WVtIrWax1Zhc8WCEP8gz3lWDMC0zfT6wnPTR6P3Te7vD1j+hwRw2zba9a2V7pcc1kBPCEoeNVT/T2hLomxaFYiWITv4Br2C++p7TO5Y5sktmZgCMfr7chT0uCGtYAyHoyDdVUsU1DIa/+g7ukVkQprZVDO0uJUPJmeOgzbk6kxyz/uM3P+yyfuJr58OoyOpfpmAKFWIT1CNoijC2tO7a2+UQHWGA1PpGFx1BulXh8k4pZbFIHY9R2/Q5rAl6s+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783085776; c=relaxed/relaxed;
	bh=1oefoDKc99jkDXFZ2F7f0RgFb3hTkk3t4ZLcXBYIg34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QER/9NVq6o+DUnd5yjC5UupN1qiENHwvW6CsvFJI15JAhkKUBt9dF5o9JlXViEHZnLEbav4BeEObXmqEDifzQjMs1DOTs47N+UC1k0dGcyMVPlOIr1bYDIzB8nVFeMO1ZJSVEjpl10fX2BPfZYrgluTbFzfz8nBobSOX3RUx6iANTyy2aHJ/JOjv1wHnhReCNb1/A/x4X0bsWckr0/nlHEjNzknbj+28+PvcqkjCqLKM9T8AMOqX+sYDNku7zqzFHN2qEbWqMDPoP+wJlkrhhQhPbYJg2+1YWJRfc6UBvgv4XgCj6zHaIjDNXvoLCeX1JVPic/ew7nayxpHU6z29SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=G8KQcMnf; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=G8KQcMnf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 338 seconds by postgrey-1.37 at boromir; Fri, 03 Jul 2026 23:36:14 AEST
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsFC24Mtyz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:36:13 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2BDEA4E40C6D;
	Fri,  3 Jul 2026 13:30:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0134160300;
	Fri,  3 Jul 2026 13:30:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4CC6104C956C;
	Fri,  3 Jul 2026 15:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783085439; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1oefoDKc99jkDXFZ2F7f0RgFb3hTkk3t4ZLcXBYIg34=;
	b=G8KQcMnfA97uJv1/eCDL6gH5IJ+vm4EPXOagsotJwMTR8oFIuKQVSqeAQabajojEBOfO7b
	EG6Ai4UrKdvo/lWnemKKYKr2lDtsJqp9vuCs5MmQolpxyXe6VD18Q/7ieOSK/x3tHSCjOK
	fIWjh7AQkkrXrWHgGcycvuKv9NpJCgCqSyk08REr4s+G7rREldOvO2X8Pe89oRxXhDMYvj
	wFPm6CwPrZLq88t0zeS6huzkV3f/U8Ct9V29MC/htJcd9I2Y8EV5ngyNPmjG5vphXt5QhB
	0ydHTI5lm6L0upADw+4GjQmD5mE93pXSzfyi+IDS1Gcd5tci6mXX+3Hz5pfZeg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Fri, 03 Jul 2026 15:30:14 +0200
Subject: [PATCH 06/12] soc: fsl: qe: Iterate over all pending interrupts in
 cascade handler
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
Message-Id: <20260703-qe-pic-gpios-v1-6-6c3e706e27dc@bootlin.com>
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
In-Reply-To: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783085423; l=1694;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=d9GunKd8m7L9v6kr11X2z55lp5pdUtS6kYCuy9Mzz3U=;
 b=nGB9C+Ncr3tcfR6k3rWU9qZiyRkLg+NUYBUuOA/C44U+SvIww5Y7/csAreOLgStzScc0eoVL5
 Rl1ffD4IbTMA+i9IIjd417wirii40xmTivqc9LO03NpXTjZM++mNBRk
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Instead of only servicing a single interrupt, the chained handler can
handle all IRQs that have their bit set in the event register.
This avoid multiple parent IRQ handler being serviced if more than one
interrupt are pending on the QE PIC.

Remove unused code.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 3bca116fd2f5..27b62f4e3afb 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2025 Christophe Leroy CS GROUP France (christophe.leroy@csgroup.eu)
  */
 
+#include <linux/bitops.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
@@ -67,25 +68,17 @@ static struct irq_chip qepic = {
 	.irq_set_type = qepic_set_type,
 };
 
-static int qepic_get_irq(struct irq_desc *desc)
-{
-	struct qepic_data *data = irq_desc_get_handler_data(desc);
-	u32 event = in_be32(data->reg + CEPIER);
-
-	if (!event)
-		return -1;
-
-	return 32 - ffs(event);
-}
-
 static void qepic_cascade(struct irq_desc *desc)
 {
 	struct qepic_data *data = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long event, bit;
 
 	chained_irq_enter(chip, desc);
 
-	generic_handle_domain_irq(data->host, qepic_get_irq(desc));
+	event = in_be32(data->reg + CEPIER);
+	for_each_set_bit(bit, &event, 32)
+		generic_handle_domain_irq(data->host, 32 - bit);
 
 	chained_irq_exit(chip, desc);
 }

-- 
2.55.0


