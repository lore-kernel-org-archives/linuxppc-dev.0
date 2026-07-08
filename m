Return-Path: <linuxppc-dev+bounces-23797-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63CFC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:15:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDWc2s6Zz2yft;
	Wed, 08 Jul 2026 20:15:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505756;
	cv=none; b=oopHUJfoXpuzgj/PWODz5h/ZEKpPOfXPVDBSYVckpX09laPz9UmGhoPCRdoZqFluh3bER/tIij5bAluYrZVpsCuNBHztvxExx2o8wL0RfHzYiqLujV5nVPh7JYA522J23KUo5N/WMAjcX95k1yhNqs/ohjvrVa0xCJtEMci1v3LCjQVVyOPue1WmSRCaH2J9xHzfDk02ukWGRA1mK1I7y6RhACq30RMlAang72y57zX3LN1jEcvBfFOo2XafvfTiY0edtCgstDkSK2VKzBPzI+vBNvz0idT7aKe2OnysGGaga5XjL+tYJbu8BEkXqN9/ENFRU8G0id48IEde53ZnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505756; c=relaxed/relaxed;
	bh=EKGSzFWOQ0pgQff5lX37PQfUpTYPDf3zSxLME5aZVNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1ZJ81OGhnvnK7CvLOVflfLLwZSNPtR6ELMVJZTUDtD3hno6YNBmNblYZpChh3LWKxVJnGIvo1YMHrEdlkyhnJUVkgY579op5I+K467euZacsyUMeujm4Xc3kyT//Lp3H0P0inzqoRuh7CMg3F87+kV4F0H4GNRiZjnTio87CGPeIb5TrxfVjxipK7I559o23/0NeAA0USKVHuwdCJ98G4VO8YUYlbwh8U0etBeL8u3P6a+M8/Un9ovPQPUWJKIdxoRnFmFrIzeFkYtJRSh5S1J9Qzp40hR2yEUAqxWRVzQ//K9+ByNcdTapixi+MY7+xG0MXf8JP+VynmgEOKI2Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wOkDlcVl; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wOkDlcVl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWZ0xyxz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:15:52 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 01ECD1A0EDD;
	Wed,  8 Jul 2026 10:15:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB49060337;
	Wed,  8 Jul 2026 10:15:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5568411BC3441;
	Wed,  8 Jul 2026 12:15:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EKGSzFWOQ0pgQff5lX37PQfUpTYPDf3zSxLME5aZVNs=;
	b=wOkDlcVlrzIeZekN+Rr1aY0KnyT0yISevNhGNqeEDo4xeZSk8U5szWWykx26hxSM4zmOO9
	4W+hSEF3MG79p49AxzMrl6Q4IOsx8KUB87fbAZn27W1bb5jC+DMSLUNRrrVZ5NZ7JnxmIf
	oNZZz7ud0Bf6s/LKrLoxYG7uYJrzKkZxcRfkOomRjqdqOv1HtKgSOoLW66iQ3kLgn5pnOm
	SOxqyTZbK9BTaU7s+Q/6s6qpx9G03KRfvCcGxQF260INxNoRZYx/mgg0Bb0Lbfz4QALfN/
	/gccyOGjITQgmFHHct6cyxVhaQS356VRoJT5UAo7VRqbxGm8A1C+P058ZZ9RJg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Wed, 08 Jul 2026 12:15:14 +0200
Subject: [PATCH v2 01/10] soc: fsl: qe: Add chained_irq_{enter,exit}()
 calls in cascade handler
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
Message-Id: <20260708-qe-pic-gpios-v2-1-1972044cfbd1@bootlin.com>
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
 Herve Codina <herve.codina@bootlin.com>, stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=1181;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=uMsD6FEMT4fz2ANAG1m3/bi6O+rr81eHSt9sCqU/PRg=;
 b=Oo/ytMkVc4RMpzD8Ct5wc9ZSu6LfQvEt/QNk4/iQG9C9hhfvqlv4fj7tjnPtYMgGaXhWU/SNi
 yrXEADV6AHADH5rmybjYIbAD8+K0+pPYc3VN/W3HOjEljoeBxbMbBWf
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Wrap the cascade handler body with chained_irq_{enter,exit}() to
properly inform the parent IRQ chip that a chained interrupt is being
serviced.

Fixes: f0bcd784e1b76 ("soc: fsl: qe: Add an interrupt controller for QUICC Engine Ports")
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
Cc: stable@kernel.org
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 33ca1ddafe18..c3768c82a58c 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/platform_device.h>
 
@@ -82,7 +83,13 @@ static int qepic_get_irq(struct irq_desc *desc)
 
 static void qepic_cascade(struct irq_desc *desc)
 {
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
 	generic_handle_irq(qepic_get_irq(desc));
+
+	chained_irq_exit(chip, desc);
 }
 
 static int qepic_host_map(struct irq_domain *h, unsigned int virq, irq_hw_number_t hw)

-- 
2.55.0


