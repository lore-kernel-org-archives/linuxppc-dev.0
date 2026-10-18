Return-Path: <linuxppc-dev+bounces-29651-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3006CCA490
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:50:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70RC0X7Mz30HB;
	Mon, 19 Oct 2026 00:49:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331383;
	cv=none; b=oBMS18r1IbaVsUEeA5GMkfjZVeqGQo+JD6f7xkKAmZfZcn6T4zE+1Wv7XPZnlpFjHsK1BQmIkIUGIr4NCkD9FIwOXRuFbUn18GYhTCF6BydE2m7puootD2SvMzgUNGhEkulwGjvtEfcNw1pUN2LdWE3Lp8unsLR8vWNtLWa4uL+CTErY2JsU6iwTD+/ep3qt3muROGsywo4O85nvFZui1emnqPZS5zmbQnm2/m8+JjEih8N5fPZf5zXF3vVW45KYN7HICo/22HEgZUBRC2/58KwQkENo2bvj20OgBNI6mtDPimhseUqidabgrx8DP/zF/vtllNQ0+dGQvzm3cAhL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331383; c=relaxed/relaxed;
	bh=QgyOpAgwDJcgNK32/9PGTXHO9coJXI+TEruCjzlJ5Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfuMv1cw8sDtImh2T+TL2EfuTxM+6+ybj8sDlrsQQuabMfQ7Bs6PVD+pr3pEXEhB+7AfDpSuNLfxtpn9JtWd5/9kUwqvNNisChDDRwjScsRJ7K3a8uzlBhXnhSPYy+miuS09dpviLaspg+L/0STrnAZ12Dadx65aXrgZ5xsS3g82+yOc5sUrZZt3jUgkiqX8Vze90TwvfslQbp0+OE3SsQGjvmkL3A5lERPIG7t/rkYgYMyZsMGl8RiVi5YvYzRrnc4gtF1ZYaKRhihb/JW6s68NZw4Y3SHoGPm/LzEOFv9TJBoa8J1DpJ7S1dK+f1EH44qvWy7lCRQAuxDAjAujmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J3pwcfD1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J3pwcfD1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70RB19zbz30Tp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:42 +1100 (AEDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so1463930a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331378; x=1792936178; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgyOpAgwDJcgNK32/9PGTXHO9coJXI+TEruCjzlJ5Mk=;
        b=J3pwcfD1udtRIHSOdN5yBOkhW3atwvRoKRHaMhHkGZS6rCS/yVkTtF9j8Pk8RAbAAf
         2+abYByPTAWbkCDun6k6yxbrwYQsBX7M2TRXxKwdVLgWXgEytO6qAITuDuOwECvJqLK/
         1//JiBVc7SEn1OuRNs4iI94G8TbCLdokqzqrXsDg1FOGKV8j5+rhleEGD3o7QRxkZ6g2
         vKqFAEuuHZX+hzzazDkgvD9kwVW36szsQfFKxhGb9daxxh1IYLFNWiaiZz1kIp0og85J
         esTC6k0x3mR/y2GPSGfSOl4TxBcsYOZW8mD6+kyLaB6GSDNGESpL4svE+J4alX2dKbzJ
         qm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331378; x=1792936178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgyOpAgwDJcgNK32/9PGTXHO9coJXI+TEruCjzlJ5Mk=;
        b=Fk54RTtU7+wcGu4HPRvQ9MIYNK7WtBigUfPb8HEm2619TN2am7Zmdp/kYrYYI+R2Ka
         YcZEihay/nLxUI3uecXE9OZun+EFN7DuKNnoJqrfpvNUm1+g+72AakxE43BnQCEDVUuh
         K758kgMJXc8c00QQtbCyFPwbS7Nit0rouEpTSzsliYRdXNZFGGJ4ER7E1gUC+CZ57aVG
         FF5snq405nN6QV/voF9LIraQxitDSME//1G+65AJIv69lsJsY1cp40ObkhhIgMrwDVKF
         hJeUY8MWoyzxMDB+PK5rLRB94AiY00PzXwCfHvc3BWUHfjcNxVmZR2rF6J8F9CCQGjsP
         JR1g==
X-Forwarded-Encrypted: i=1; AKwUvBydU+Tw4aZrJtiBOGNy5MQ6p4zUNX3EOtWLFEA9p5zIKqftxcGLXEHGrvv22xHb1bZ+HuSRB73ijHY16aA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLdARhVbToQULQl4pepEddy/TkEn6HSZIdszsCTK3vd2utJD/mZ
	fG+5YwGubpCBeDz7mgeanOZ+IsfyBPB4IaCRD0dO+ZUrMWgcuVbxBroX
X-Gm-Gg: AYBFou3E3F8OcWBl1oYxCqkFagx9aAw5Fc/R5u/jlI8Cwmj6xDDYz6iEy+LQEe1Egy9
	MehyFUkmJbX9nS56tao3OpYWjzGtpLhzdSjGxOEza7V1MbIhYTjFNLVElbCjuRLM7jzLx/Y792v
	8Hwf1+Ol7lvM5PrjN3SDL25hA5phPu3JOA5Q6a1QLdck+NIp4AYzUVopNHFMFDLLOAEhTKNBHZO
	SsBpadZQlWvxF5JS5ThGUB0cJsEdkIiD86JoiR7AK4yWGB1cEjAFQGwAMqp2M3wroYg6nZaMfPH
	vPcbANu37U/XhkqGGG+wT8x4DZ7oHEyFfDjxL2nc0JIuH4rZqKq3Gw/oUHtzRAuOiUsqchf81c9
	Oqijw/1crl3L1GmPhjma/6vAUMKWaa2uLC+Z033DcBZHXFS8hPOjijuUVMfbDVs+KTob/HGQ8jL
	WnkHotWyUn5JJTDDlbdqXdEvg+t0mEnNySpnJ+AbreaAWocYQa0o6FQ4xyJ2gHr6UV0EK6hgUiQ
	pWPjaWrTKGjbfOtc9vSuLvxkfwWVPmcqCRugaeT
X-Received: by 2002:a17:907:d86:b0:c29:f5d5:5aa4 with SMTP id a640c23a62f3a-c41a08dbe04mr331615566b.46.1792331378553;
        Sun, 18 Oct 2026 06:49:38 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:37 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v4 05/10] sparc64: validate Fire register properties before initialization
Date: Sun, 18 Oct 2026 15:45:07 +0200
Message-ID: <20261018134738.1016106-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
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
Content-Transfer-Encoding: 8bit

The Fire interrupt translator reads one reg entry, and PCI PBM setup
reads two, without checking that the firmware supplied enough data.

Check the property before allocating the translator or changing PBM
state. Halt early translation on invalid firmware data rather than leave
raw interrupt numbers untranslated. Return an error from PBM setup so
probe can release its allocations.

Fixes: 861fe90656b8 ("[SPARC64]: SUN4U PCI-E controller support.")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/pci_fire.c      | 9 +++++++--
 arch/sparc/kernel/prom_irqtrans.c | 8 +++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index c35a8e3c1eae..db160eeb0ffe 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -416,7 +416,13 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 {
 	const struct linux_prom64_registers *regs;
 	struct device_node *dp = op->dev.of_node;
-	int err;
+	int err, len;
+
+	regs = of_get_property(dp, "reg", &len);
+	if (!regs || len < 2 * sizeof(*regs)) {
+		dev_err(&op->dev, "missing or short reg property\n");
+		return -EINVAL;
+	}
 
 	pbm->numa_node = NUMA_NO_NODE;
 
@@ -429,7 +435,6 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 	pbm->op = op;
 	pbm->name = dp->full_name;
 
-	regs = of_get_property(dp, "reg", NULL);
 	pbm->pbm_regs = regs[0].phys_addr;
 	pbm->controller_regs = regs[1].phys_addr - 0x410000UL;
 
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 5752bfd73ac0..558ed5114664 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -544,13 +544,19 @@ static void __init fire_irq_trans_init(struct device_node *dp)
 {
 	const struct linux_prom64_registers *regs;
 	struct fire_irq_data *irq_data;
+	int len;
+
+	regs = of_get_property(dp, "reg", &len);
+	if (!regs || len < sizeof(*regs)) {
+		prom_printf("%s: missing or short reg property.\n", dp->full_name);
+		prom_halt();
+	}
 
 	dp->irq_trans = prom_early_alloc(sizeof(struct of_irq_controller));
 	dp->irq_trans->irq_build = fire_irq_build;
 
 	irq_data = prom_early_alloc(sizeof(struct fire_irq_data));
 
-	regs = of_get_property(dp, "reg", NULL);
 	dp->irq_trans->data = irq_data;
 
 	irq_data->pbm_regs = regs[0].phys_addr;
-- 
2.43.0


