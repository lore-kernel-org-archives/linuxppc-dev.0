Return-Path: <linuxppc-dev+bounces-23803-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDEBC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:16:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDWr30TPz3c2K;
	Wed, 08 Jul 2026 20:16:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505768;
	cv=none; b=Ew3SE5u4fz0JXAMLpp7/jPjpfTW5fMFx6KZqVpbWb937IJcj1jWiyeketyJPnhzmj6CBch0OXuFcRjLn5pxT5jhatjcny3wh1sMpuO4IiFiE5yZjFJrs4XwZRjLqY8L/0niEDNmZ4zHSxhWasQ41x66831vlokMeBMBvmHB2jekGmm4UNEvONFKPzSiMn18R6x7U5o2HHraIW0RpeFGKy84C1871LOMV/i78AaN5WsGEWctyFPbHpTvWBEQ+esEAkvWmt3dyyEgYJ8Tgs8R1WGQ6z3+joqa3GH/b09Zuyilb0ExD7ouMd+CMvGMnPcVxiwn26ke1m4GY8wPWgf8OEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505768; c=relaxed/relaxed;
	bh=JB1mvrB4ocViz/EnCVmYJRgcL16/T9Vo+kOUUbX1PCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ber2BDmzzpnhwvrSKU4gOtIgNKxWBrnzKiPyKrgpOQm0TputAUN9G72m9PTimOBJnqPZ0NpwPzHmq65YUMDukdMW38LUVFVTMUSgETNHf3TIuYnhZ+vvywVJJeSS+b4YUjwP2wJ5j9NGfcPrg2VD7lTkO6HWgcFcC2MyehBBourH5n6h5gmKIvHPIB6+zozeQBUY+vMST3/hiU5fxRKZxFcQP9Oz5YRFg7GxH0rdbSpA6SpXMsVYT1nblp0CXS4WnPNAf3P1ugMQXHI5YtJNyXcBKnDUm6M/pJ1vrrU0zNfkHgfBPRFUy5+uoOjt3WVFobAhhFYzhWHqYZmVH09jjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fCCX0GF3; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fCCX0GF3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWq505Vz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:16:07 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 22B06C8F44A;
	Wed,  8 Jul 2026 10:16:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BDB560337;
	Wed,  8 Jul 2026 10:16:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8D6411BC3444;
	Wed,  8 Jul 2026 12:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505763; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JB1mvrB4ocViz/EnCVmYJRgcL16/T9Vo+kOUUbX1PCg=;
	b=fCCX0GF3r1atAKNjkeDxYhPkvTp4z6JKt4TZjsJOcQJyK5okRAK9IL6DWl6OKHJbPe2xI4
	84tSQxwVQE0Nf5tqjfdNq8qXiLKV5fkX+HHkF7rNDvbW+3hpAcbkL6tJSVa3VlFy9BaSuF
	NubOkb7KDVjiAOsP9OeJ7NzKKDiRj3CGwB3mtf2deObrTZJDUt9P8PAYJmAHZyGzMQJ5TZ
	uWb67cpLj/T0wd7PhSZ7bfr6J4Gk2NNqFLWH91Sb5MrEIEAkx4UtLoS16T/f/7rKe1ST9q
	C047imUXJysQgRdaY+mr0P3UJrKzPTV0BwKZ6k01XWPLPtQNx021H6kY3jR1uA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Wed, 08 Jul 2026 12:15:20 +0200
Subject: [PATCH v2 07/10] soc: fsl: qe: Handle spurious interrupts
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
Message-Id: <20260708-qe-pic-gpios-v2-7-1972044cfbd1@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=868;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=qbFN6lQM89HZuG6ugtMFVH17RNm7kdv+VUWhxlb5SqM=;
 b=CMymsLrV3UXKyTvV60x7YvEhpsjWIJ1kirNC7ZqeOCat6nLAC+rIa0j6VEaoXcz/jdt4F5K5y
 EQElAZoAj3fCtmTw31QAoskFB5cvotXopq6bGUSiCyqrNzHTNUfcKEn
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

When no interrupt bits are set in the event register, call
handle_bad_irq() to account for the spurious interrupt before
exiting the cascade handler.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index bc8b68e5d1a9..29f4334db5a0 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -80,9 +80,15 @@ static void qepic_cascade(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	event = ioread32be(data->reg + CEPIER);
+	if (!event) {
+		handle_bad_irq(desc);
+		goto out;
+	}
+
 	for_each_set_bit(bit, &event, 32)
 		generic_handle_domain_irq(data->host, 31 - bit);
 
+out:
 	chained_irq_exit(chip, desc);
 }
 

-- 
2.55.0


