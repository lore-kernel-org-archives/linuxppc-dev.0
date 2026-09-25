Return-Path: <linuxppc-dev+bounces-28210-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BE0C9832A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:25:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrzdh0bwYz2yNH;
	Sat, 26 Sep 2026 04:25:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790360712;
	cv=none; b=VJksn/2EyPgREbnhi5T/kHFcDlQytgiU0XEDWxU99+Umf0Mg3/qkdpCHVtdRE4QDfsWQVChZZZ0ZaM4teXjoUg2++RVvsPSSTlHla5UeM8m0LnXdHJONk+g1ddCOjY1oVfkvQHyXC6dxFWOBFglja0GwdzvuwDCjXGPSbKTeyP7iyY6KLO5e0F1b2Jm+pIczV3Ld3Cjo8F9BRi6EThF5Wt7C6O7W8YLF0x14s+nkCqXBMGXdnL3lVZXBgyboYmTis1HNXAdtIs++4QOkwnfUACDovLCFQywOVbVwXs3WM/5yFMOdSnguYfwb4ctYbFY+cpkvi4FfUEv+yE93kMUlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790360712; c=relaxed/relaxed;
	bh=GWLCx0r8AlMgp4yLMAlnbb/AEeR6IQzmFOzYO3/wf50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gU0AccDEh7H9ZoKLpgEGwzmLzkS2b4lSw9NWchL5a/pAsqzd/znzOW/YnQDDJ1L00nAKiFi+YbNW+SPGv3jCUvnkC1wiw2bNmUMOOFjV6Tr5cG+iUMduxNp8LYS+sSHUBTShgYEa+5vQ/5r04tdZD5MR/dWHvwA6tk8AcaGxryZGX0nMf3VR276qeWymihLqdjSmznwkUXePrMSYXWOyJFPpDNGiMUoSwLY57mRmygXEeW7Zes1cBedRAsawNq48RfLvmpOxj8w0DNaqlphsqYcl0hwDmCJrysR0EWvG5NGZa3Af/N0nxzl3cu7mNfkkbNnUprbsR1kKY1lvm8gFyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OuGGtV7y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OuGGtV7y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrzdf1mJhz2yMm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:25:09 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so819229a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360707; x=1790965507; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWLCx0r8AlMgp4yLMAlnbb/AEeR6IQzmFOzYO3/wf50=;
        b=OuGGtV7yLiIGCpZ3q05ZF+x/bnculZk9fW1vqmgvy4BhqrGID5SwFTybXH/r2/C/gc
         Jyerw/ZMa6bCEk57bX9UaWGvpsWuz9GQplhSZFoDALdjcCyOb9q/4cxja43KTx93WLNG
         1B1Bw5Ig3HrP7klvqGXvE5J4FxrB9vkXnVUEaXqWpFuEB7nYtHJYaj/OzZA6hHIexPkj
         6NVTHmT0yALYMDQIL+yWa1M39FL2/h411zJlWyZ8gsoKzGXjzvo6U1F6JNTcBXhywwfP
         p0sB1snEFq0M7Mx/P72KwpDV25yxNKhrFRop+5X/9zeleiZ8EwVbJ+WF3G/bgb1Wy8wC
         Q0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360707; x=1790965507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWLCx0r8AlMgp4yLMAlnbb/AEeR6IQzmFOzYO3/wf50=;
        b=LuInZ+arE+sbxKLgEQcbCuoq6OBFHV27hVH2pif6DKHgG1Fx/LMIC8h8emduxLOWk9
         ATB5URX9H38aYh2rl03tfdIRJCUDuG2+enU4XNbHAFWZ7BNeSpX0cRStj7kwStuAG9ne
         FcRfjxpo4StrDTImsDSWvMtFq/feicroh/6xj3LpuPnAWJV1bl+U/0V0rn7toJk2AHkA
         kiorihQa+jTjtXWcjemto55j7DPuniVxuTNAvZdQPCKqjnt3io/kCtxS6tzOhtnlqld0
         CyJxboA61swNQKPQ5gxoai3YLo6gYZmKEjJSwEdo8GcIm4bPBa1GzQ1cOZyU0zWqB8oI
         4Gaw==
X-Forwarded-Encrypted: i=1; AKwUvBy1lnJ3r4WtI3nRes9ZQ4nWYBD/gWvJYoMrg7fIQ4G+LWTL3MRYLn9nIgtNZlnr+4RT3rxv1E51n0jTpCY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lF/R5idrU969KaOQ/KtoS/+LE9N1kh2PTCYypDe2oga15gMWJP
	fDPGd7lLULJqdNKabmFTQyyu4gKWxtdhcYV2K0gwZoJioRBg9tIz3l/T
X-Gm-Gg: AYBFou0jjq5ddich1K50Xu4YY9VUzwrA0TKCHhPrKPD1wbDlmTTKeUr3qX64oCB9K1a
	OgyVSBjuR+cffL6uTfcBCxui9M75CbdNlTxAw/fqTIGz3s4HWyxT3AgBbvFtWpGfEzKr+jLyPY+
	LsyNquWUtTB3bQW0JiuZ+NrsCVOtNsEbUtpKM2RpALRfegFes8N3Dj/bYYWyusLnH3Mp9IhWsy8
	zEa4Vd4bQBABT7pWYS6QCuLSV0tkIZyVqjZh1jLdu5JI0mI+FcbkjcePqnKNujSSL9umt/Mdiaa
	IZm3SkH0aDGEDpD2dXdtGV5kBtyQsLs/gg0V0vUas49C5wKNCBSlLFitPZrwCe1r7EqYgzpY0Rm
	+9VBds6RDILeypo3gvzZ0EBdKcgy/kZ2AV2HLZ1upXpOa/e0wkysPGSH4VkxMnBesVTKjjFM9pX
	5uJEOIZSgy96rnthvuN33I+POVniK2kPdhuXCr4+xrGMtUJIEuaoaUPOkPZrYSGraNk1Fmealrj
	b2js1Vq/Zm/TwkWnNC62skUH5Mt4T/0M6mLWAZFaIwdqIw1fCq/5fsQfyPp+de0H8bkYp4hF3kn
	eWK6zdypw7pM2gqZibgJDXS0hc1fUBcENBrjuXsffXwgaFak
X-Received: by 2002:a17:90b:384c:b0:3a0:c8e6:ab23 with SMTP id 98e67ed59e1d1-3a0c8e6b96bmr1504783a91.54.1790360706898;
        Fri, 25 Sep 2026 11:25:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efaeb3sm5693240a91.2.2026.09.25.11.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:25:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Timur Tabi <timur@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC UART DRIVER),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH] serial: ucc_uart: Use platform IRQ helper
Date: Fri, 25 Sep 2026 11:25:04 -0700
Message-ID: <20260925182504.54976-1-rosenp@gmail.com>
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
 drivers/tty/serial/ucc_uart.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 6b7dcbbacd13..c3c83a59dcce 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1238,6 +1238,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	struct uart_qe_port *qe_port = NULL;
 	struct resource res;
 	u32 val;
+	int irq;
 	int ret;
 
 	/*
@@ -1247,6 +1248,10 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	if (ret)
 		return ret;
 
+	irq = platform_get_irq(ofdev, 0);
+	if (irq < 0)
+		return irq;
+
 	qe_port = kzalloc_obj(struct uart_qe_port);
 	if (!qe_port) {
 		dev_err(&ofdev->dev, "can't allocate QE port structure\n");
@@ -1338,13 +1343,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
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


