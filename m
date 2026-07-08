Return-Path: <linuxppc-dev+bounces-23802-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3B6C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:16:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDWp11wVz2ygX;
	Wed, 08 Jul 2026 20:16:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505766;
	cv=none; b=hQdPZWw780cTHT8XybJKSvAg+qF4fZqnmCVqalfmkIBRWapJUBvJirfTqeXCz2QNyAmJaM08CFJn/VsKdc5APWY3SSDfrwRHaKSOSpKMGscuaNJjuzqKauOX4qPenXmEnHZY0Aq7ZWma9L4pF5DnpDnemu42uPXWdMbH1GaDrvU9r8MIKi6g/VkVoQPhSsQGIs3RprdPy5ATCePQjwhWGRBIaHBwyhvvAJdjSutKkuy/PO7oCGblF/iCcMk57iNX4A0lRuNoBvATRjVQ6Oxqs/pGw6ST0hgx8QXjlDNDCZVqhjUGpw/Db3Bx37Dtj5DJa8zBC7ns6n4X9lJnioXJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505766; c=relaxed/relaxed;
	bh=QVQjk372EQ/aOAJi0x59NYkNGigxMXbij6zxAURUnhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=id5KRDayfcEFw7N1UJU2jtpsJoP17fKdzD9pWl76IorQG65GZIGkDiCiEFfzecmJh0z/Tod82vKXsnb8H0h2lzzN975tWE8MhVzl3PcPuyzuwEw/HGv7Nx38K8oQE6PUCjabO01eyV1P/6cRCDLbv0IxxBCjdBMhi7b4uDOsZPi2OEVVud7a1SPCTyJZ67WMeEmi3LjcrEupuK6ZF1+zTdrX2Hd8DdXtofIAwGGJsdCOi3vivnC6ruSTeKDYkP8nmXtk2+WABNvwtfJLvTTI5IM4WUV+ZbMxqB4wi2Q8WpMjW45XzrbI0ErC+hK1PHZ6J8zVQ7j+Bx+ZhcKP8nKevQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DSEs8fMD; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DSEs8fMD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDWn3VPFz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:16:05 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2A1554E40CF7;
	Wed,  8 Jul 2026 10:16:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C490460337;
	Wed,  8 Jul 2026 10:16:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC20211BC3441;
	Wed,  8 Jul 2026 12:15:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505761; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QVQjk372EQ/aOAJi0x59NYkNGigxMXbij6zxAURUnhQ=;
	b=DSEs8fMDeP/WWEwk61m/T0e2qmm05KRT/+q28FATN+T+VD72LPiZllhnFvh/Hw7THfdTne
	N8qV6xtalmc7fdkli0jgAQJ6vcnr2R2ccsJNEZSmAOksCpBrcoaldsxV+Xn2ta2V24f4HF
	LcULpT+XNrPsc3YNuKuFRG2Bn6Hh5HZ9j7J1kSSjPLUSafW2piDsdhBqbMzx/YGIbEHGEj
	u4Svt65rNegyALp8PfWf/w4poWF+cjBFHtFUpd3u9h9UCO5+S7mkbWoLUAEjIMagxHZ3SS
	KxCnkLXaVNbzkHxXFkNJZYEgre+S1M/642bIGdOuNTWBeczmxr0sbrqapY1UBA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Wed, 08 Jul 2026 12:15:19 +0200
Subject: [PATCH v2 06/10] soc: fsl: qe: Iterate over all pending interrupts
 in cascade handler
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
Message-Id: <20260708-qe-pic-gpios-v2-6-1972044cfbd1@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783505738; l=1700;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=r3vHDvUHA4dsL1TckJnFW5O/nSaMdIgcvEIKqUzCiFU=;
 b=ABpT7RMI/xBzLmktdMmKXMO8zvzIO82law6Twa+KbFNhxcTIjcjZuEkcgCDCJ8oAn/2GgsYMV
 MGbI0UFWhEeDmThOPn8z2KSed9MI3EtbSACz1kkITb0/AbrbQPX6PH5
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
index c8fff45e353c..bc8b68e5d1a9 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2025 Christophe Leroy CS GROUP France (christophe.leroy@csgroup.eu)
  */
 
+#include <linux/bitops.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
@@ -70,25 +71,17 @@ static struct irq_chip qepic = {
 	.irq_set_type = qepic_set_type,
 };
 
-static int qepic_get_irq(struct irq_desc *desc)
-{
-	struct qepic_data *data = irq_desc_get_handler_data(desc);
-	u32 event = ioread32be(data->reg + CEPIER);
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
+	event = ioread32be(data->reg + CEPIER);
+	for_each_set_bit(bit, &event, 32)
+		generic_handle_domain_irq(data->host, 31 - bit);
 
 	chained_irq_exit(chip, desc);
 }

-- 
2.55.0


