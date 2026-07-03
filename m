Return-Path: <linuxppc-dev+bounces-23518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609BCC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:40:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQcg2SrLz2ygg;
	Sat, 04 Jul 2026 06:40:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783086414;
	cv=none; b=NEPQlhElujN88Bs2TuTOw6Vsa3lnvZDCR7eA90jzbpLMyVaElrTIFPn0EYAxoZs9fH7TnhQltM/cZ284BUpSHAHrbYCAKfD9nRrF1sMpp3ztKA6HY9I/D0AiFArPlZ+SDYrTskNSrKIg6Z07xBbrKnn3YoU+jF1I26RRzfnRldk8pisMn0wZ/JYgP6N2euy6fw3YNQu7TS7sswMaodwxlEnR5upao09ZNsOAM6hHchYrio34if/MBRzdmIQkmnB4ZerMapbvlJyfBz9bs5GKF/FXOqE12HPKqlYWhWccAyEbh4gIqMCyY1WDqKZIijtDPPBxpH1LwgYS8z8HIWJCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783086414; c=relaxed/relaxed;
	bh=XVGgD3fb+eKy4BrLSrfxqR3z72o1xfjS9b0bDJoQno0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3WzAjaRfIuoCRAqaDm5z361fBcsH+LNaiLYHuuuPseiH3Evx6YUHdyPtxaSmhZ/BQyoNG+OuFo+laFBwH0eWflNHcYXq4TG51jw/JE55IuWn0dDU95AQRVjzQZjIpSZBtmBKJhvclxrjDlfU9bUs7etn4F2N6jy9SL4OhaskStH561Krv8/bnLStRfFHLF1Yh0EkWZmNUy6e1HTr+U4PnUswCLDGKhRmBBzLoUXE0owPthlECQv+dMkpBMNAOs+zZJpXbtR5/AclHPMCS2ozVuJPX1Ma3RjGrD0thKVri18Q161dj1C+ZLdUG+rQ6Lhh9/Ed5N3cuBJx1gva2dWlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SXF3aul5; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=SXF3aul5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsFRK3c1Yz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:46:51 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0CD50C49F5C;
	Fri,  3 Jul 2026 13:31:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3DD5560300;
	Fri,  3 Jul 2026 13:30:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDC72104C95AA;
	Fri,  3 Jul 2026 15:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783085447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XVGgD3fb+eKy4BrLSrfxqR3z72o1xfjS9b0bDJoQno0=;
	b=SXF3aul57hCaFh0VwEkkDSj/4nrSy/i+RyZiUelCBbEO0WRhxrx+wugPe+O262Q2RWPryr
	01Eiw2vI4D/H3JB+8zNIL8FqyLZBEpO4/3liT+fx6v7WXY3gMAbltcVDycJRIPQTdr9XYH
	XFWLhhvSZ4fS/9qRWpaeMc+CNki8if6Ye5TOHvpe2uHyU91dLmlfIBslkemMLn9mCgeY7+
	65kQO32lqKDNuVFd3MmtqUeLMn8ybqiC0BL3poSdGzag7F8TcFFQxEeVJZOyRvUmr2jcjp
	si/yh8hhQrTg0pIwce3HfF6eSOHmv4Frt6TZPw3ppPswb92XhaNILGjHOc1x/g==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Fri, 03 Jul 2026 15:30:18 +0200
Subject: [PATCH 10/12] soc: fsl: qe: Rename host member to domain in struct
 qepic_data
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
Message-Id: <20260703-qe-pic-gpios-v1-10-6c3e706e27dc@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783085423; l=1508;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=Q1LU98vM9HHOAM5h2e8fS0MJIEHJs/m4IozHvGGHGHk=;
 b=3ByUpPIH3v8ySIFn0+aNMFaKPQFIWVsopDzpFPZIneWR1GFcygDi4tPD47xYf/IimB0uOiwhP
 8Xx53Iyu7rDBu4rrgnyFLfvF61fEsYOCObL3lJRFukRrLA7p86s6HlX
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Rename the host field to domain to match the common kernel naming
convention for irq_domain pointers.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 718703dab024..1bf2af087b78 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -18,8 +18,8 @@
 
 struct qepic_data {
 	void __iomem *reg;
-	struct irq_domain *host;
 	int parent_irq;
+	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
 };
 
@@ -85,7 +85,7 @@ static void qepic_cascade(struct irq_desc *desc)
 	}
 
 	for_each_set_bit(bit, &event, 32)
-		generic_handle_domain_irq(data->host, 32 - bit);
+		generic_handle_domain_irq(data->domain, 32 - bit);
 
 out:
 	chained_irq_exit(chip, desc);
@@ -158,11 +158,11 @@ static int qepic_probe(struct platform_device *pdev)
 	if (data->parent_irq < 0)
 		return data->parent_irq;
 
-	data->host = devm_irq_domain_instantiate(dev, &d_info);
-	if (IS_ERR(data->host))
-		return PTR_ERR(data->host);
+	data->domain = devm_irq_domain_instantiate(dev, &d_info);
+	if (IS_ERR(data->domain))
+		return PTR_ERR(data->domain);
 
-	data->gc = irq_get_domain_generic_chip(data->host, 0);
+	data->gc = irq_get_domain_generic_chip(data->domain, 0);
 	if (!data->gc)
 		return -ENODEV;
 	data->gc->reg_base = data->reg;

-- 
2.55.0


