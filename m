Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E382C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:42:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AA52087C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AA52087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4yQ0XDhzDq5j
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:42:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3b13wW4zDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:41:00 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MkYsS-1gcPjP14hy-00m5Ry; Thu, 14 Mar 2019 23:35:09 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/45] drivers: tty: serial: efm32-uart: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:09 +0100
Message-Id: <1552602855-26086-40-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:GkEQ3PQL3k2QaLzZb8lNbjPatbvNHO/zBKPO1LUYlKxBlECFjkC
 1vsTglZV0lWeahMAUf50F7oNoUUwsSFbBBV1FGMu0c3n8OSp4NmUTpqXtMLVfydUgsEz4wg
 GksBta3MGsrDnCqyVXtCndFYjYUMxJv9E2WGw9Yjj7w10fReNqQJDKoqluav3RfRBRZ70Kb
 27SyFQKMFvypFdAa2zOFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u3vXrAGV98s=:/II60tlxxJDQnk3vN/B+lJ
 rh5xuphlhBqdnjdrYJDM4OxpPdCeo1HY2te3DUu7tqz2NdDrpnSgY4v79mohwd+kq0iFm1hj3
 WmLLnbF4GsCwI/q+e8lZFdNVWzv45PSXsr1aW8/aBagN0FfFQLtOIOl2nxGLmLPYJHHTmDYvG
 MRJdruM5xJ47r+us2II/yuZ25J5eoXG6LOhFbslNBU+Q6U9q0wrnJy5cbnpr3FSRGc2N7G4aH
 sn+iTR25wakTDJwoA/OB5Ke/NeE90/Pz6VM9IC4Tu7lkwTz6HZBilSoqjvse4PfHM2iJK2mSn
 jVYZD7lk9eQUpss5/A3WxR+ynBrAnS90vfZ7ga7RKm7kFyJOSRzRzJ2AGe4ZtweWH+95JBXYP
 Mk71Z1wlaas2dRnkz7B2EHubCf0NoAKulNknSDZIX+l5w+qiPEemG1xOv9X3eGqGNPr4NDC1Y
 hlqh1qWDpsm9nLg7Cs0TB3YtXO+mqOwlSxwUTE/RPs0y4U0sadmt/ac/M1VkIZ/UaIAhegxfN
 N6eHSlvbcR+lwPlbcwZtbTThSMWKf4yzHd2DLTNQqEaSG7J4T+BCn7TGuSv2yVD/EezzFujX0
 a/kQ8qowiwdOVfXs6DxBNtr4oZHbiEnoRKGKOZfJM78YbHEv0GaLsvy3zF68YBZUoCS/i6NpQ
 5mhumsNk4sLDr3Ebu5swDG8uzm4tFDJKeoBtmGZlvhUuK539aw4NMsoTtSqbAOg2oP7LqncHN
 gSnUJLD0Tis60xRrnRVwt9S1lssCiI5t6eSTWw==
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

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/efm32-uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index d6b5e54..a79cadc 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -437,7 +437,7 @@ static void efm32_uart_release_port(struct uart_port *port)
 
 	clk_unprepare(efm_port->clk);
 	clk_put(efm_port->clk);
-	iounmap(port->membase);
+	devm_iounmap(port->dev, port->membase);
 }
 
 static int efm32_uart_request_port(struct uart_port *port)
@@ -445,7 +445,7 @@ static int efm32_uart_request_port(struct uart_port *port)
 	struct efm32_uart_port *efm_port = to_efm_port(port);
 	int ret;
 
-	port->membase = ioremap(port->mapbase, 60);
+	port->membase = devm_ioremap(port->dev, port->mapbase, 60);
 	if (!efm_port->port.membase) {
 		ret = -ENOMEM;
 		efm_debug(efm_port, "failed to remap\n");
@@ -464,7 +464,7 @@ static int efm32_uart_request_port(struct uart_port *port)
 		clk_put(efm_port->clk);
 err_clk_get:
 
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 err_ioremap:
 		return ret;
 	}
-- 
1.9.1

