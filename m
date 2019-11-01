Return-Path: <SRS0=PnYa=YZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15DCA9ECF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 14:35:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BAF2085B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 14:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FgkhkzeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BAF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 474PqJ3SFmzF72r
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Nov 2019 01:35:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::243;
 helo=mail-lj1-x243.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="FgkhkzeS"; dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 474MKs5hX1zF5DR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2019 23:42:57 +1100 (AEDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so10086827ljh.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Nov 2019 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
 b=FgkhkzeSYJafzm+DXrl6r0ta0raYRc/ZnjHF6yCQHxFbbGNUxEdzoS/j/aXd3Z2EAO
 hw9z52EZvMA2GL3c0mAU2KtYNwS9SYbSqE/jeozwpGumHKa2VCr+wpc1rEJNszK7u+I7
 0ZPLO2ccA2UHvIcStPP44EBdQttMJjlSayBbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
 b=tl8kpVKCRiEqbjpLoB6V2LscZXTPOCVR4o7o95D51+6hNXSlSc2+QlbAmSxRU/tO/c
 C2bN2g9rsruYBTq0mDKnBwEYfLo01/A58kUf8Wu7+TgosPTefuZuK2oNFwjrUND+A37x
 0m/FSLKFJ8ZjdJ2QMixZVdbFI5oW89WT49InkRmyKvkRAbOlCN+Hydd8RSthSBdc5MIm
 o836I/ZQyprSrda326iMvj+fPGgAcPItv0WDk0J8MUEpwTfketPNIewmL6j3uk+LPHSX
 IWT2EEyGB0EKGCCp8dJWYiv8XgELA1Vj4jz38DWBGydXjKUxKXSCEoFDFN/p45oxYpbD
 FaOw==
X-Gm-Message-State: APjAAAUODKUrCyiw/QaaVsXqGsdtkr7kIRt+K5AB/3VBm8yflJrM46FB
 JJQHK8fdF5ldAuqEEYFlrgnHKw==
X-Google-Smtp-Source: APXvYqwEgK3pWHNhLdwW3stHSxRWQSbXwYpIh6GddHwwHetrW/PUmKwb0NC0I7oqmSb92E/no6nwnw==
X-Received: by 2002:a2e:819a:: with SMTP id e26mr4744325ljg.26.1572612172961; 
 Fri, 01 Nov 2019 05:42:52 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 05:42:52 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 31/36] serial: ucc_uart: stub out soft_uart_init for
 !CONFIG_PPC32
Date: Fri,  1 Nov 2019 13:42:05 +0100
Message-Id: <20191101124210.14510-32-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Soft UART hack is only needed for some PPC-based SOCs. To allow
building this driver for non-PPC, guard soft_uart_init() and its
helpers by CONFIG_PPC32, and use a no-op soft_uart_init() otherwise.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index f286e91714cb..313697842e24 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -33,7 +33,10 @@
 
 #include <linux/firmware.h>
 #include <soc/fsl/cpm.h>
-#include <asm/reg.h>
+
+#ifdef CONFIG_PPC32
+#include <asm/reg.h> /* mfspr, SPRN_SVR */
+#endif
 
 /*
  * The GUMR flag for Soft UART.  This would normally be defined in qe.h,
@@ -1096,6 +1099,8 @@ static const struct uart_ops qe_uart_pops = {
 	.verify_port    = qe_uart_verify_port,
 };
 
+
+#ifdef CONFIG_PPC32
 /*
  * Obtain the SOC model number and revision level
  *
@@ -1238,6 +1243,16 @@ static int soft_uart_init(struct platform_device *ofdev)
 	return 0;
 }
 
+#else /* !CONFIG_PPC32 */
+
+static int soft_uart_init(struct platform_device *ofdev)
+{
+	return 0;
+}
+
+#endif
+
+
 static int ucc_uart_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-- 
2.23.0

