Return-Path: <linuxppc-dev+bounces-23801-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40799C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:16:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDWl0s7wz3brM;
	Wed, 08 Jul 2026 20:16:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505763;
	cv=none; b=Jo7nbGVeomDbcK/Pbp0rlP+xZz9lZf/81ridLor3ANDrHvVHlP+YuNU0ZgIyrliFhpixK8ALJrkBXy4jiaDskSX/gDmr0a4vDamkLGDnbY3CfoG4hRT1V3roTYerlzTJBQHMFmHYhJMPFDU01RqPq4U+hkBzT1QJ0c2QQZ1eVodnV5WhBwj4Lm/FBuxKOkKFMq6nZE59DYgMQSX7QiuB5XS2ItgtNc36iJSFWMGAXfisQAXkudU2Hkin9JLi6uIALiv2uIjJmhuVLj9s6tRjYDhb5sI52Y52rrMIphvotBJLuphWfIiFOyvcQnn8pESPKDKxtWQSuUOGTnqBq8UDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505763; c=relaxed/relaxed;
	bh=ef6n7iAZaYmW5RfDmOVxwgE3Bkk2FUJ5t2gDf9cNlS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKo0Qw5hz2T4FA9azgOoFtTKX5H/mcGKUTZbSeWpi2eRdh2uXLvKtA12t34dkFr7ndVu3Ig7K0GzJiG2tEJBzyp2qeMfGNkgVuxnPLlmNjtMW6V0wm5lzItEI+BTz24wGem2t2e0dIYoW1ZdBxkKShP+q2GW1enbOeF5dgdaoRVDdw6gZc2aBmr4UaEu3n9s/nGp1ZzU4MGc3gSzcEQnGLgFljl3CjqSA8cOD4uu+uKtnzoc/7HQFs41QG9frW4QAkVql4boMc6dd/HAW45h6fUm2EJznmWuHimnT8MapSGPtmI74fRocsdv1CnzROcgLGK1mjin6EfZGxI4DXppbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uc7p0jaN; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uc7p0jaN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWk3Xqgz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:16:02 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1FAB64E40CF6;
	Wed,  8 Jul 2026 10:16:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8DC260337;
	Wed,  8 Jul 2026 10:15:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C98A011BC3422;
	Wed,  8 Jul 2026 12:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505758; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ef6n7iAZaYmW5RfDmOVxwgE3Bkk2FUJ5t2gDf9cNlS8=;
	b=uc7p0jaN1tBDRfMkZFYORtAT4IttYYgrTg7xpUsZZKoYIXaziU2iGmMFvnSQPOLkPHjUyw
	298u50wwdKRaWJrYPzoIJk5/kahNc20YmaNESxACtEu0UIgfohrC0xFFiLOcoWqtzzebBN
	ojsgDYGYZRe2fu5BsqdYA5mPrR7VhdD3t24OwAMGWKYIQ1ua7uhCKlNWe7A426DTAiaRcu
	Nw5xBJUR8ZVwJEQ0NcMeO36UndP6GnClRYJB757H570zlrGbopVz6hRSClnAR3ye0tqBZd
	RHuy0PAy8zUdeIExr256zYiyarOFaJkipSXcuGv6eBcU2eKUdH36KmYxnt5wCQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Wed, 08 Jul 2026 12:15:18 +0200
Subject: [PATCH v2 05/10] soc: fsl: qe: Use generic_handle_domain_irq()
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
Message-Id: <20260708-qe-pic-gpios-v2-5-1972044cfbd1@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=1188;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=xbFRoxhXaEBH4Z6kI+nDJgr3V2xJJCGk5mX9z2OeP7M=;
 b=KOg49Ld9mc1j9DuvOxFnlANkXiq6UTbCePbNYkfANdBAfH1b1YhRpaqE+ndIEl0Nek+gHkpO/
 zsqnFBfn0nMB7RU6OQ9QQw/kDGp22n0VVork7kea44xzld2Nta9Vwsc
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Replace the irq_find_mapping() + generic_handle_irq() pattern with
generic_handle_domain_irq(), which handles the IRQ domain lookup
internally. This is less error-prone and more idiomatic.

Remove the now-unused irq_find_mapping() call from qepic_get_irq().

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index c3768c82a58c..c8fff45e353c 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -78,16 +78,17 @@ static int qepic_get_irq(struct irq_desc *desc)
 	if (!event)
 		return -1;
 
-	return irq_find_mapping(data->host, 32 - ffs(event));
+	return 32 - ffs(event);
 }
 
 static void qepic_cascade(struct irq_desc *desc)
 {
+	struct qepic_data *data = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	chained_irq_enter(chip, desc);
 
-	generic_handle_irq(qepic_get_irq(desc));
+	generic_handle_domain_irq(data->host, qepic_get_irq(desc));
 
 	chained_irq_exit(chip, desc);
 }

-- 
2.55.0


