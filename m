Return-Path: <linuxppc-dev+bounces-29484-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CE6CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:56:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4WRJ3Rzcz2ynZ;
	Wed, 14 Oct 2026 23:56:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791982572;
	cv=none; b=T4dJl9wdwPWEBNGO5LsU2Exd44l2tfg9QkXFpupmufy22OYjmWLeXyscUEgbzuxyIHR7nBk+GnFHuvgHYYCYgZa+vKmB35WEa2EXiS10wE6Kjgq1yi9KaisVemEgPqIR8lZJIUPuB/0rboIOEBk9XXehT9Dq1Emefk74og81bf+9rf3GfuvBQvE9SEFxL/teZulA9EmMcNux8mdNOSQNZPMB5pnOyaf40hsLasOh1+baJY9ksJRNRbagVji5yPvIa+6ZXhhZtPkf/Wy+CEJ9colKekPLqPMQYQrqAeXhoxL7H/0GIlfLvF4+t00kQPU4PwfQmgYJzJaP1knnPgY/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791982572; c=relaxed/relaxed;
	bh=Bx/fbzAbqnMStJvOu8HgXW+2ghzJGQTHCrd7OHKmmSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRXGO6FTm0xQZX6kVbw5LzSDLfW6lZbrjGzAEO+OAFQ8HlXWiueNHcOT1hgrtv19UEHjcVEe1DyCf27g9Cb3G+xYTZfiqoCZgkDRx65/xXEQMUuc8qiqp3YJkRi3+fEt994f4Ip2drST7y73zAWjS1N0J345OOlhSmR2w02/gTQ6qkLbpVOLKPnDyw4OmCb0uQi/f6ZeTkTfo1UWQkDL2FQGP/FZIw+u6fMGCg7VP+d1PhlQRMz7appR8+FQ68J5vG6JufYomWEGCw7sxvOKIjyZZtHKemYwKIAph+8U8YXQbmwRovUKE0gkiWRjV14UXKjCuxgIkkfGqV/QtUETzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=laO4mEzf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=laO4mEzf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4WRG3K66z2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 23:56:09 +1100 (AEDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-487049569b6so2844644f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982566; x=1792587366; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bx/fbzAbqnMStJvOu8HgXW+2ghzJGQTHCrd7OHKmmSY=;
        b=laO4mEzfTCg8JpqBHa3khhkTUkSRcdXC8UEJVPAPDRgPhJ/a485xjWyTHlLZXxNf9l
         ya+9CbPnES5fux+Qn94FzX9SDLd9yorfVJbVDgF94vPu7wPuHJVcP5+Wt6U3iLUNOVl8
         RXlFNssTDmTL+uOdZ+VNJyndu5mfMZw2igJY3H7GneLmF8sWfvEqdltw0yro8TRa7lyy
         ldlrfGCz97T4p55gH9t+KdZ0RWYr7DeC35k9v9CsiDu2zY2EaofaH/GDc0PzZMPz7vii
         owCKfLxgcFQy6BA1JkhxxL1fZtx74MOIa1+nEu0TdWl1XKkM08n0Pz/enJTC3kyVa/tz
         DU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982566; x=1792587366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bx/fbzAbqnMStJvOu8HgXW+2ghzJGQTHCrd7OHKmmSY=;
        b=Zh27UFiF8tLOhtlXsj8s8MT5054/TRsgrUFG+JTEmM85hx1lWxYW+c0mI11/Ruzqnx
         VA64CJSZjAhdfw0G1hNB/IQhUH63fKVvgisKkFLdZTlMpRLtBy7ujUhH59zjUUO6DLB8
         EKlMmCnz3jTf+UCXpZjD6wxaWsXoYh6jXpOQzEgdSJVZCGTXD6MlcpwoQOa0EfxNUfdi
         2X+MkidjM7MXdrQzliA/bNijCyXWjByg84KUYc4RhMAQu7mtnEBjn/CI/59EmkG9/1gu
         0L129oY5Jz7Nnxg+toZWtZXtUGgqlG/m76AHd8A0CZsnKRpxkHG+wcZx+4tZUmiwv8S1
         92SQ==
X-Forwarded-Encrypted: i=1; AKwUvByPGf/xQ3rI1ulYbCFJiHfg7X2mxbpPl69ndN4L14D9GfYVyFYEC0ifZTNVU2f/VbBeid/A4fsu1V04q1U=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLNmn0PurBvRyzmkwdUhPQKhchOZ8ZWsnCptdNqMvMfr51Oxaw1
	puZ0lJNCPG6e6d9TnYXlqoRKA8UpI4E255Z+nyoKN3JlYr/gJZwSxnY2+82UciOBwROIIQ==
X-Gm-Gg: AYBFou2b9MqHbSt+sFNteyvdehnui90y1Tx3e9FB1ko3tzGq7NltpQVJOZvfDAcJMEP
	1GJgBJL3KhfIgc9BiKuJnSUAzEA748k0qWNa1fbkgClFOoreHrfOhdoQBmjih773QuxGLsxsQBY
	XzXTQLJisvegQD7C9FDndjYWynFjOM46nNisv5qxgN5s0b6c+YXGPcgw7kmT5BixsAnzRgFQXOT
	qF3MKTbIfcG4WdE3q6c2Q8Ps8DoikBovvucim1plVBWD4wZbE2vdkwo4prM1fBV64A00BfxbUVS
	BBBdS5zvAnU4TbBTOD7UM9lZwe8f9aK6Zly7BznWpdVq4m0n/8noqUpD9SbSxqxk5CMVASGvCCT
	soil24cCXvODsroykc8lW12JLwMsnEe3mqd8H3P0Sr2raeOWy9Hrc/UKXd06FyReQ1vAAFcGP3f
	FzNEU1N2HB5EL65CYNW7fn+2TocMawWX/u0U4zWdA7j18GxR47WwwMz8R80AkPlxHR9MDfEeUFI
	aOki1SqwodXkXWFDJOO7BHBQcefMu5YOeVMrW2ix8x2cCaX+4PQsXq/PV1mM1U=
X-Received: by 2002:a05:600c:4fc1:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-4a19a9cf1e6mr200322795e9.30.1791982565922;
        Wed, 14 Oct 2026 05:56:05 -0700 (PDT)
Received: from nixos-office (29.pool92-59-2.dynamic.orange.es. [92.59.2.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7003982sm8989089f8f.8.2026.10.14.05.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:56:04 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: maddy@linux.ibm.com
Cc: chleroy@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] powerpc/Kconfig: limit the PPC_85xx DATA_SHIFT range to STRICT_KERNEL_RWX
Date: Wed, 14 Oct 2026 13:55:53 +0100
Message-ID: <20261014125553.2280686-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.55.0
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

On PPC_85xx, enabling DEBUG_PAGEALLOC without STRICT_KERNEL_RWX activates
the DATA_SHIFT range of 20..24, but since the PAGE_SHIFT default is
outside the range (12), kconfig adjusts it to 20, causing 1mb alignment
instead of 4kb. However, the larger alignment is only needed for the
separate kernel permissions provided by STRICT_KERNEL_RWX.

Since PPC_85xx uses page poisoning for DEBUG_PAGEALLOC and does not
support KFENCE, let's restrict this range to STRICT_KERNEL_RWX.

This out-of-range default was found by kconfirm, a static analysis tool
for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Changes since v1:
- add range for STRICT_KERNEL_RWX=n and DEBUG_PAGEALLOC=y

Link to v1:
https://lore.kernel.org/all/20261011113108.539470-1-julianbraha@gmail.com/
---
 arch/powerpc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3b6cd655606..09e6027389b2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -896,7 +896,8 @@ config DATA_SHIFT
 	default 24 if STRICT_KERNEL_RWX && PPC64
 	range 17 28 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_BOOK3S_32
 	range 14 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_8xx
-	range 20 24 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_85xx
+	range 20 24 if STRICT_KERNEL_RWX && PPC_85xx
+	range PAGE_SHIFT 24 if !STRICT_KERNEL_RWX && PPC_85xx
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 18 if (DEBUG_PAGEALLOC || KFENCE) && PPC_BOOK3S_32
 	default 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_8xx && \
-- 
2.55.0


