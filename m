Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF7DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:56:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2D321873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2D321873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L3xB20XGzDqP7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:56:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3ST0N6GzDqP2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:18 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8xwu-1h9ULI3npG-0068zi; Thu, 14 Mar 2019 23:34:39 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/45] drivers: tty: serial: 8250_uniphier: use
 devm_ioremap_resource()
Date: Thu, 14 Mar 2019 23:33:37 +0100
Message-Id: <1552602855-26086-8-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:HcULVpvjlPvPuUEkGombDx6Lq0TzXgQINZcbt9v0F4IVw3gvfDU
 ue5jWD4gA8wP1LsZ1ucMXRfehaO85dVyZr4F+33vEb/+OE8H5eHMGwes+HogG5qug9JrO8J
 7oabaolb7Wozqlw9bGe/y7tClhrPNMmFUx/bGTknMrKxLOQyDBqevKo6OkgNPmcIwooD2n9
 pp/LAHbGltK7rNTIffR5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4uPRC96/ixw=:MVIF+epBtx1bRwzaXem0UT
 ZjVpUy+qBWEVewbWf6tEZyqn8SuuO3a+V/jPrPOu/iQS0nuZ0509ATVN+iIBW3U3kCanvh8av
 Quo4grx9tQzJ3G0g3tgWvM5k0XnvlkZnRNJNY7T20C/l9ICnhM9FXYnNs+bKNefKxQ4Amlzqm
 NqFKewDr71+dbTBm8YtoSjAHfepFA8gn8bQvlo7pYeHz5glc8GdPIgyT2S5CfGnoAV3ZtLcKB
 YzCBA9v/AdXGcNpoUgIApdqb2Np8GOIz051SjR7raVwPWLpPnF9WXcoGcUXHMdvZ9EqULthsq
 HadKjLE+6KJ4PymgsJYSK1kDXBZnhQmDx7Ugm12lDXaehNQyq3abOwDUAyRsmsiSmLXNWA1z4
 YY5v1QZ/tyBxJEko8MCjbeteZMzHCzryHzfjWH/6+X932muk3bfGFejAIWcUZpYy/rIDPOWVo
 Gv+snZCm+zNSlLEk61q+xVFIQnTAvNoxHCGsC02+JcAjF6cIsvRwGdqsYgaeSf1us0uXHyZmE
 lQTTUCjdhuv0zreVE/Xak6OdKMZ7r4BF2stYLwH+BEuVwpc+3+cQKJToo8nGAF4RF94QrSOa1
 OIRV/e0vybyVH+ToU9oNm2lE/njB2kcCusqeCy2ybJmdXBGZyBi5N0mXJ1cRAZX3va5V+e80W
 Ap+F3nrbULbPZ2uI1OoQpSz4mDHvzpb1Stbw7mvxNW5W9rSE9OeFSSJTgSnDzsBIJPtWdaeu6
 8uDDvt+uabZO6SKvQpcU+te6p4hwJRe/JhTbNg==
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
Cc: linux-arm-msm@vger.kernel.org, yamada.masahiro@socionext.com,
 macro@linux-mips.org, jacmet@sunsite.dk, festevam@gmail.com,
 stefan.wahren@i2se.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 andy.gross@linaro.org, tklauser@distanz.ch, david.brown@linaro.org,
 rjui@broadcom.com, s.hauer@pengutronix.de, slemieux.tyco@gmail.com,
 linuxppc-dev@lists.ozlabs.org, vz@mleia.com, matthias.bgg@gmail.com,
 andriy.shevchenko@linux.intel.com, baohua@kernel.org, sbranden@broadcom.com,
 eric@anholt.net, richard.genoud@gmail.com, gregkh@linuxfoundation.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 164ba13..9c1244e 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -171,7 +171,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	membase = devm_ioremap(dev, regs->start, resource_size(regs));
+	membase = devm_ioremap_resource(dev, regs);
 	if (!membase)
 		return -ENOMEM;
 
-- 
1.9.1

