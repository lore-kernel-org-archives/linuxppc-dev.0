Return-Path: <linuxppc-dev+bounces-20995-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE698CD4851
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 23:25:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHNbh2KPDz2y8F;
	Sat, 16 May 2026 09:25:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778887536;
	cv=none; b=O8p4xm9J2UVxYZ2hpwMVG6f/EX1RFqGPUhtmXzJij7MrdgO7qLb9q1FetXXkNOBTxphXuxEbQXJg16VwNIHxYX9Y5U2W/3LrUO5R5WEgw7Mi2ESPJmutV0skl58rG5uRuuCUA3LY/lgoTzroJ0x0CCXi/0YukdzCskd4ymF7ZYSsZVjBz8Pfs9EItUIbheeOi8C3+/NpEYggvkDuscn5Bxt6Ns6S15oItHyqU93LTfsRkrJhi4StbnwbCfaCgAo8b0m4f3d4lmNH4lOmpBq85wrboazAwsHUEvMl25XdDDW7d5QopHRNIqdKO9lchtps69T4T0utzdaeeVmELzBRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778887536; c=relaxed/relaxed;
	bh=JPip9GXJ2ZgqYI5/dbZPeYxHICUGQ67m9hMm/MHmTGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzSI01T8ljbGf+H1CWfi+fyHQ+fDoSZRTmGmqQir0VIuAmQRvfP6Gxg1KCFtC4A3+sW43AARYbYDn5XD4qyrmL98eP8h1hfK7DyyclQzkaJJHCEuKEaL264h0vX1d3DpuVsHbvnRajA+/8VP6Q0rR/dZCvNpKrj5fOavvy1H97DCbUWIiwsR4N/8EZO4/eU2FhcBa3a2J1rW3xJ4RXYXVKZfblomX+rv9gFZUE8x1nD+GKP0pX1ZTJjgE1ss0ELaVd96aJMWGp2mlLvgHCwtdnNKiNSQFjRwyDFaC7UpMBYyDJmNfLyjqcrQvvpQ64Fcjkm6t9P4JXvSVeDP6rluTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pNWmrUNO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pNWmrUNO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHNbg3wqDz2xGX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 09:25:34 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso119219a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 16:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778887532; x=1779492332; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPip9GXJ2ZgqYI5/dbZPeYxHICUGQ67m9hMm/MHmTGg=;
        b=pNWmrUNOaGBiBThYf0Rx7b4+sZfr6VH5BsCvETAa4uyXEKHEFTlw+X8lVeE9SqpvBp
         aM3EqBrJfrWuQBcFaHz4d7OdECEtfYH86YG5Sosxkkpmgsh4qnjowUtrcBBS69gv7q9i
         8EcWIreezkjIGjDU8BhPNFONWkMD9SA5bJI8M1QwwkrN3kMf+tIR5Fo8wpT+OslBz5wu
         UY07Rk8SYiusqAsUhbxnDFJQUX+qKBBg2lesp57pvmY/2CTsIVURgnXcT/VXblQsOp7h
         wlf3ZGyX6myMs5aHwv3FAIWRCrWkPCDHPo75KvvM7ygpIId0MlDhgryP3EM2QrghCpNw
         mkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887532; x=1779492332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPip9GXJ2ZgqYI5/dbZPeYxHICUGQ67m9hMm/MHmTGg=;
        b=XYt4i0y4dXzHHp6jjvFSVsWt1s5sSR0fNO74616bZl3Fq2wNQJ7pD5s8p1iZHA9tdn
         tVpCuD7fS6Pm3EHDvjCWj2FIzq1RbH3RcHGi259E60GAUQRwCOb8OBJYoipcvAa6o8SD
         VwLf48o0rMPq+DSpp+cXAVyxkdpVa8UP0duHNNAHp9vBYXGl3VMSEEs9IQvkHq7nwJhl
         fzb5yYv5r1BlLy5W0S2B7eOvFwGo/HpAoda2w6EdMlGWc85QrwTvggdXoZyZ4oOvDTeX
         vQHAQIGfatNE4fGfm9ngS8YADreFSD3jU9NQE7md7iltR/NwrwAIntPutQywoXjVbgEy
         pUaw==
X-Gm-Message-State: AOJu0Yx8D5HA7CCZnMOpIxoL5lIOqHmQnO9ks235u2jGqdTePOSV1mxD
	gad99Xra247DCwuk2GtX9/pKRKGjXMnvSvD4z0ZYyShyU+PZ12BMw3LOnjuyqA==
X-Gm-Gg: Acq92OEjDP+s6kpLdyqDVQ7ZjjItaNgasGaW6Ues3ZKnCVgI6uhraq321tDxWjd+eKL
	JU7Rm51XODytCOeTux8AlVZRm6h3Qa7RYf8UgKb+ejNof7KNypEkJcs0tBNeMTXecaJUi29DrPm
	kPCylTV7EgEqi73bwmndlBarEKV1n2xDuT9yWS5IFkNr+h4SPlO/mr2A+HNUUQZZFt5rfPjQv1V
	ePhDzp2YwSSRpUAlI5p7tT70HxgCYPioNoj6mY8XMTiqbYiJmTyzZSQnSa6n6zkfkFHWPqwJigx
	6lGoXFQHs9tl1ktGkdCPk+x2tqcR+BNJRmULxVyEGlm/v87q/pOB4wrMPQl/ahpGwUOjohKPW6R
	BPZrHB4ons02r+LePaPgsv7XMzwDxCVOVNM5FmOBBlW9A4psE7SD75d4eFcEJW+t96yx6IPjDLy
	iOTstpvNEhR2iOAlw4OiTqEuuREFG1RvnGR43n+kM1K4765rJmzjQkpUxXi4262vOdDcPc72eUb
	QFQqo1Ml2L4hAjZ9pimDjDhw7Kg0yCRyotJ7pXfBgtFL57trpiZQer2
X-Received: by 2002:a05:6a21:3298:b0:39b:f026:6f8e with SMTP id adf61e73a8af0-3b22ebeab3fmr7209559637.34.1778887532369;
        Fri, 15 May 2026 16:25:32 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb0ff0edsm6806225a12.20.2026.05.15.16.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:25:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/44x: Use platform resource helper for GPIO MMIO
Date: Fri, 15 May 2026 16:25:14 -0700
Message-ID: <20260515232514.1155590-1-rosenp@gmail.com>
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
Content-Transfer-Encoding: 8bit

Map the PPC4xx GPIO register block through the platform device
resource instead of reparsing the firmware node directly.

The GPIO node now probes as a platform device, so use the
platform helper to keep resource handling aligned with the converted
driver model and to report mapping failures with the platform device
context.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/platforms/44x/gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/44x/gpio.c b/arch/powerpc/platforms/44x/gpio.c
index 2bc5cc260894..4d5176aa6895 100644
--- a/arch/powerpc/platforms/44x/gpio.c
+++ b/arch/powerpc/platforms/44x/gpio.c
@@ -182,7 +182,7 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
 	if (!gc->label)
 		return -ENOMEM;
 
-	chip->regs = devm_of_iomap(dev, np, 0, NULL);
+	chip->regs = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
-- 
2.54.0


