Return-Path: <linuxppc-dev+bounces-23516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7E3C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:40:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQcR4z0Kz2yfy;
	Sat, 04 Jul 2026 06:40:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783085951;
	cv=none; b=Gdi+NtzgJ9Z1TUzREi18rF7Nyhpwn3NsuU3HLYCR9Wp2ZWExfgwaCPxtSlBT0ykzpz19M3bf6YvSgMyAsdzmYvyj3p1ngD6/En+KVx5YhAa2brxtosCmZHFTdWwF3+eB2jArpW5GXhFFon4oktsZev3qas4Jfmn8PaxcbfdktSY/l0ixnzCd505t9znEpEk2eKh+z1STXlS/bL9l5h6UIYhuGZutM4qireZb1yaMwCf30Ko+LpdGA0yhK+IjOxWRmrTv1uS1joWRW79KFg6CMKEZMz7yzI+XfpCyKU9IthHdCPcZ/ZIUL7AokMIYC0XmwbxEExPZjhC+J67BteYefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783085951; c=relaxed/relaxed;
	bh=PicZCkwsklXN0ONboTGqm4ynP8f37fEnTaMMPeq9K/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OebYTQaOH1KI7RDCvfTuKMlECwQYzcmCCsJJYG+i9p09Dam0/Xu+gph8prXu6jihZSwXTF1GMyHI2FIiwReyAfWEIIwZk5K88uASsvs0oriY6p4naAhINH81kAYpurHLkHUBS16IR4infpOc75Z2CxixHj56Sxuzxhlv07dqZZoMg4PB2gVE6NtFeq/obPI/re7Jh/sRjx7+T0ECu7j4OAwoDnDdyvqemk7bNtTsYzqszaJ6alw0X8DOV0OizbO4TI0hW7R1xOn2mfnzPrU+lyV8vg6CHmJhTlQfY7F5vVMlqlCCj5TNpXD+kfofdXYWIBb8+rhPDPBC5m3192+SYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cLU/0VDl; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cLU/0VDl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsFGR0xqPz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 23:39:11 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E03E91A0E26;
	Fri,  3 Jul 2026 13:30:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B600760300;
	Fri,  3 Jul 2026 13:30:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 507CD104C95A6;
	Fri,  3 Jul 2026 15:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783085441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PicZCkwsklXN0ONboTGqm4ynP8f37fEnTaMMPeq9K/A=;
	b=cLU/0VDlQmsFHLwP9z53WZpW1FIHFoSql5sKKxv1wOwEqpskQjm7bjmc23mfY7vqTU3zZl
	ZYfBnxigCeZO7V0sPkF6/yVqeiA/pSrE3irTBBnFGCI8tOFxQMytKsBt2z9BBJL7Ifc3oJ
	RjWKL+9fCNRvF3lRnqW13uBZKMtGx+J16R9JSzDskJUoy56HXjNuINffWi8jvbsOxbAnFm
	7rgLt/yGuAuTZjJY4y/IVpYAScqo6F0HQAfMyHpUms8ih4OxrdNJ0l0IZVMvXMy+dkqsEL
	r1/LOrPIauOOhEfCDu7v/orZ/V2udBbctPYtian33WQVPqa6BzNoz53+uzH1DA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Fri, 03 Jul 2026 15:30:15 +0200
Subject: [PATCH 07/12] soc: fsl: qe: Handle spurious interrupts
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
Message-Id: <20260703-qe-pic-gpios-v1-7-6c3e706e27dc@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783085423; l=865;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=GK/kK8XvyJnCOp6vz8jBjn9EMBNybdfgy5x95pP3Kus=;
 b=VDBcjajqYHWq3dKjYVCVZd0ZABbny6CisoyUEYgZT1kOEyitshUxNq4S0WMOz6TD8veyDwpI3
 d45jQJ9sQDnAUaiA3GwthcRzuBb4+L9lBtxm0OOz+ITlgpCReL9kh0S
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
index 27b62f4e3afb..c8b73b0aa233 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -77,9 +77,15 @@ static void qepic_cascade(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	event = in_be32(data->reg + CEPIER);
+	if (!event) {
+		handle_bad_irq(desc);
+		goto out;
+	}
+
 	for_each_set_bit(bit, &event, 32)
 		generic_handle_domain_irq(data->host, 32 - bit);
 
+out:
 	chained_irq_exit(chip, desc);
 }
 

-- 
2.55.0


