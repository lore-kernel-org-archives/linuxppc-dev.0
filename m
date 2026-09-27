Return-Path: <linuxppc-dev+bounces-28344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688A3C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 20:43:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htGcB5yDpz2yMn;
	Mon, 28 Sep 2026 06:43:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790541802;
	cv=none; b=EwLlzesxD+JRS2iy0z0UriWzNQceVnhDZFEpBOJaOCIx+xNpByH1O8gKMMadMqPoxvrtlU4c7JfMRhBRA5+pXewx3SmjoL9rDfhh26D1iFjxAw5hRCzeyegiRaNJ2jXwkqgRz0VLcmGRqZb1yDu1nI3HSkFBq4NDb7b2KMIIMFygLrML8pAwVa+d/5CAsbxZyBatxGUnaN6q0nSuYOlqtk7nG+rje21u1Kz8Y9h5+nNojSoAKT2BAiWessy1D6DKk4Vxo1ucXaBGq0h2NS8HPn22xSMCq4ONA3IgXKmrBkkUX3XeQScKyblVoMfeNQQl+wiep3YSd9VWZbL5uullXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790541802; c=relaxed/relaxed;
	bh=YfUIOw0LZDaV+qpARbEy58798D+e2vA00v6oms+VU5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxN0lhdWuBYm2bZ/mO9yzH01WJ1pTW1GBySh0csezOIX7H8U0DjFvgc8TYPSF1RNPePt2fU5sQHL/aEXDYx8NF95TF/pY8NjNdkWlvQfNhKm5tq+waPnzC6S12upPu/fidYXI0D3e9/IRNi5ldGf9Dxe8nt6cY1VgF3VGkNV8diTi6Bqg3wUBfPmNlnX7U0kmD2nnp4KcSTzWVsLHGzlSIuoZ8G2vIUY77f9kkZ3NAILAsHfZ6o+foqeHH6LVsDw87D22iCuSQGqwvd9n8g+w34ocVwIO91pRLFyTFHzmMKb+kZgsOnYyZie1qDiT9jHVvZdy3e2QTScHIXfsh9Otg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o+7TUp2M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o+7TUp2M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::e; helo=mail-pz2-x0e.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0e.google.com (mail-pz2-x0e.google.com [IPv6:2607:f8b0:4864:3b::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htGc92gtSz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 06:43:20 +1000 (AEST)
Received: by mail-pz2-x0e.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so792491a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790541799; x=1791146599; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YfUIOw0LZDaV+qpARbEy58798D+e2vA00v6oms+VU5w=;
        b=o+7TUp2MJ37wDh/gemd5Q2J3Smo6yNj+XOdf75uDZSfCsux2aOGaOpXnUqnqWb/8Lh
         atGlSFhKc4DcTpgfmcwpFRrpoVT6uPkD18+wTW1oUWIt4hecH2myUT1XdQ8UDDBB3SIc
         oWYyYBdsKbSh/2ATG2aRmvX0AvY7dHXA9SDxF/+sqIhckEvhrioho/mToaBf158BLsTL
         v6jSeZXDwHT8Q5TL8sI20R+yyrt7F0ozVF/bBoSXbmPyee+CNF+1tcvqTLDWfgrT9VJi
         ap8fYJlg8trc1dQKlp2l0oBsi/pEoZizwZaWRoqPNnZs5HqqIe7rQ9xtOoedTNAuP5nU
         6nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790541799; x=1791146599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfUIOw0LZDaV+qpARbEy58798D+e2vA00v6oms+VU5w=;
        b=1LgnJ88Hk4EV5hzdGxMcGcijLqgDFXTWjZlzHhTdyiCHzI6/4RKiJvk9zH6JCtT2Uq
         fQKPwZryQ22hQbxR8vtIoYtRzuUEb55CguGIVOUkMZIw6choOvdMJ75nERkCGZjFnN0G
         t/SY61a8K3o9SG0JiJ2T1bL8yI1M8SVuw5L1zDnPlr4FMl+/v6MmJoNYHWkyJvtJ4DA1
         0vy/3BWhWLEr68HxJtpd7EZOxy7iJozSNJXrc/OwKnph9rpEyXSMV1VvajVQAR8O2rNw
         beUs0quO7x6P4PhrSF/NyoWVFcyPWR0mgFNSUhzIzaCGFPX5DtrlTJ/WDaIUFpqK2wxb
         jJkg==
X-Forwarded-Encrypted: i=1; AKwUvBx1CA6zhc8VQvtOj5TKgLkOkPcVs8VWx9xaClpGuiE/5oKPyCNS3zq6MqdG8pf0+OK2+jYtDmsWavNpy6M=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ1Pf7m6/9XKwzmgLXMcLXqOY5ugtDdpPyG+4D509K48c8lVgHo
	i3ZMnBH/seCXE9pUZh36QCPZgfNF8CXSdBSJyU18TM9NPka3ub0huGsC
X-Gm-Gg: AYBFou0wuGFAaVZtHrJN/hR97usU/v9DV909w6/7EHviNm0o/oV4IPixDyHOu14o6hX
	Qa79AFkFwsGYd4bi84yV4eIG0o56Kt6ERQWwFSb54Kwl00Ed4N+52Js+f4nU8Ui7fj2SWxGVy+u
	B38yDHuxGa0AVafkYxRut74F4wMxXGUIAZTUoDWl0QZGZoxGQIX/VwLVM1/N7eF/CA1dEGbkSZ9
	NKtcznYM5XVkQT153bO4XUVgJSmbQ3fBTwhnuNVF6lnpY5+hiPF/Uzlzhb5p8gIvHXfiBeWXKuX
	OHsQ0z3QadOfVhJSEcAAt/yO6xyT6t8X+IsxtIEongw6Fg73cDwDCEUgrh8+Sca5E1cRfyaPvR4
	/T88bINWxG+gBAl7cc5DzetDHWnFr8N+T7oApfFMAuMohBlLMNy4fnsmR/njcQLZLKReQQkWE4Q
	bL8ZvXdNcXCraZ/eIZofD5CEda2B7rueB52xRZoV24HBx6IJySy3MHrkcqZvpDlZZNoV13iLLIK
	shmdwzYq7W+tqDyNUnqC3BsF9eOG1R0u5LXuGYv3JDm3RbSHMdTI8HMUQ3CCCPQkVwL/wS7PWQk
	Rg37jvQfIGYrFJFkOdtW6siLFxcelpmZ60xjEz+5dIYjWydF
X-Received: by 2002:a17:90a:d44e:b0:3a0:bfa4:b966 with SMTP id 98e67ed59e1d1-3a0bfa4e2c5mr5503688a91.61.1790541799021;
        Sun, 27 Sep 2026 13:43:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm23288711a91.14.2026.09.27.13.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:43:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Timur Tabi <timur@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC UART DRIVER),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH v2] serial: ucc_uart: Use platform IRQ helper
Date: Sun, 27 Sep 2026 13:43:17 -0700
Message-ID: <20260927204317.21546-1-rosenp@gmail.com>
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

Avoid calling irq_dispose_mapping() by letting the platform_device
machinery handle it. Also enable possibility of handling -EPROBE_DEFER
and other errors. Handle before any allocation or anything to avoid
dealing with gotos.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: move platform_get_irq() earlier.
 drivers/tty/serial/ucc_uart.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 6b7dcbbacd13..96e3c9534de7 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -26,7 +26,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/dma-mapping.h>
 
 #include <soc/fsl/qe/ucc_slow.h>
@@ -1238,8 +1237,13 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	struct uart_qe_port *qe_port = NULL;
 	struct resource res;
 	u32 val;
+	int irq;
 	int ret;
 
+	irq = platform_get_irq(ofdev, 0);
+	if (irq < 0)
+		return irq;
+
 	/*
 	 * Determine if we need Soft-UART mode
 	 */
@@ -1338,13 +1342,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 		goto out_free;
 	}
 
-	qe_port->port.irq = irq_of_parse_and_map(np, 0);
-	if (qe_port->port.irq == 0) {
-		dev_err(&ofdev->dev, "could not map IRQ for UCC%u\n",
-		       qe_port->ucc_num + 1);
-		ret = -EINVAL;
-		goto out_free;
-	}
+	qe_port->port.irq = irq;
 
 	/*
 	 * Newer device trees have an "fsl,qe" compatible property for the QE
-- 
2.55.0


