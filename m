Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12E5C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:34:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE7F2070D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE7F2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4n90kMBzDqR0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:34:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zs3kzmzDqPM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:53 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McYP5-1gUPEz1VCn-00cyuf; Thu, 14 Mar 2019 23:35:04 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/45] drivers: tty: serial: sb1250-duart: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:04 +0100
Message-Id: <1552602855-26086-35-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:GivYaYpI5CFgJ/Y6XyM0cFoodaogwjyFq9nJQTf5KB4miOPPElm
 TG7RnYiBDHHcGmQFX1YrCsFTVufVxUO2YXer2tyeeaFh1RQG/tiGlTQMuXcK926eQPH9QfT
 3bwHlNMp71kzHH3byvVqe08VFHmfl+1E2yRQY0rVg87iUp3J1p2cFhTfKh6Uaz5iQrssU6Z
 UWLr47C8sq0+M/4O7eceQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6rYOWhFvTbA=:BHrecLoKxasNHH/J/nSJFB
 d5Na64qG32en4sm9W2tpPtRz0bFisiR1kEcOzVcJilT/sKuUhWc0JihpGZylaFn9YfGyumTN1
 UP6YvQ2H/IFJys4UVXuiGHAwFYqt7FoGQezDRmIICmydl3tyocjlUvuFMQ5F9TcEEx0ov3tEa
 tvykPKvkizYRYbLLmP60/SiW8CzvUParNWZR0DuhB2p1Z0Yw+hE8hopfv2P+P/ucIxtLI1dt2
 HIWaBVuxELmO14b9hOXw1XEkeFWo8txQdTCWDWDmsJLkd091c9AQP1t3O5J+B5TS0whiQEJDK
 QihiFgbYvicHmvuNM9SYXljx8o3h6eRXM1n4+Mf3w5uoxdtxKJRzQ0YhW4K6N8rAab739DSC9
 itywmzyl/m1T8aooE0gNpVBJzmIyHT0S+fuh6DeHPuIIfUZp+Pu/afS7UyfWxo06LVfRwBbkZ
 RYk+t0ljroY6j+9jakrBcTqkMw8OIWWxfGKs8glZxQbNr+iGQuU3LpLryMphe6j3FU77v0fHa
 OJ7GtJaqMgo4vMY8M7yCfi7zDotemh7IUV74Q60RtvdeagVmdJmFSaXwOW9FXB9rJlqTML7YJ
 Ldn9/G1C7mRdVP2EyRX7M8NoTiy2ql2cbdvPnbdJRtHznsNqD9B7bm4RAYOwMHfPFKs2Iqtp8
 HD7TNZA5f+fcNdthImKOeQzCPg6/32GpiSeG5z/v8bLxOVjmoH+8FGYpndWBCmRMnlQ77QVZs
 1uLeaCp8RNa2C5b9CerFb5aBHPwoq1IGGjw8kQ==
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
 drivers/tty/serial/sb1250-duart.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 655961c..e77eef6 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -651,14 +651,18 @@ static void sbd_release_port(struct uart_port *uport)
 	struct sbd_port *sport = to_sport(uport);
 	struct sbd_duart *duart = sport->duart;
 
-	iounmap(sport->memctrl);
+	devm_iounmap(uport->dev, sport->memctrl);
 	sport->memctrl = NULL;
-	iounmap(uport->membase);
+	devm_iounmap(uport->dev, uport->membase);
 	uport->membase = NULL;
 
 	if(refcount_dec_and_test(&duart->map_guard))
-		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
-	release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+		devm_release_mem_region(uport->dev,
+					duart->mapctrl,
+					DUART_CHANREG_SPACING);
+	devm_release_mem_region(uport->dev,
+				uport->mapbase,
+				DUART_CHANREG_SPACING);
 }
 
 static int sbd_map_port(struct uart_port *uport)
@@ -667,19 +671,21 @@ static int sbd_map_port(struct uart_port *uport)
 	struct sbd_duart *duart = sport->duart;
 
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 DUART_CHANREG_SPACING);
+		uport->membase = devm_ioremap_nocache(uport->dev,
+						      uport->mapbase,
+						      DUART_CHANREG_SPACING);
 	if (!uport->membase) {
 		dev_err(uport->dev, "Cannot map MMIO (base)\n");
 		return -ENOMEM;
 	}
 
 	if (!sport->memctrl)
-		sport->memctrl = ioremap_nocache(duart->mapctrl,
-						 DUART_CHANREG_SPACING);
+		sport->memctrl = devm_ioremap_nocache(uport->dev,
+						      duart->mapctrl,
+						      DUART_CHANREG_SPACING);
 	if (!sport->memctrl) {
 		dev_err(uport->dev, "Cannot map MMIO (ctrl)\n");
-		iounmap(uport->membase);
+		devm_iounmap(uport->dev, uport->membase);
 		uport->membase = NULL;
 		return -ENOMEM;
 	}
@@ -693,15 +699,18 @@ static int sbd_request_port(struct uart_port *uport)
 	struct sbd_duart *duart = to_sport(uport)->duart;
 	int ret = 0;
 
-	if (!request_mem_region(uport->mapbase, DUART_CHANREG_SPACING,
+	if (!devm_request_mem_region(uport->dev,
+				uport->mapbase, DUART_CHANREG_SPACING,
 				"sb1250-duart")) {
 		printk(err);
 		return -EBUSY;
 	}
 	refcount_inc(&duart->map_guard);
 	if (refcount_read(&duart->map_guard) == 1) {
-		if (!request_mem_region(duart->mapctrl, DUART_CHANREG_SPACING,
-					"sb1250-duart")) {
+		if (!devm_request_mem_region(uport->dev,
+					     duart->mapctrl,
+					     DUART_CHANREG_SPACING,
+					     "sb1250-duart")) {
 			refcount_dec(&duart->map_guard);
 			printk(err);
 			ret = -EBUSY;
@@ -711,12 +720,15 @@ static int sbd_request_port(struct uart_port *uport)
 		ret = sbd_map_port(uport);
 		if (ret) {
 			if (refcount_dec_and_test(&duart->map_guard))
-				release_mem_region(duart->mapctrl,
-						   DUART_CHANREG_SPACING);
+				devm_release_mem_region(uport->dev,
+							duart->mapctrl,
+							DUART_CHANREG_SPACING);
 		}
 	}
 	if (ret) {
-		release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+		devm_release_mem_region(uport->dev,
+					uport->mapbase,
+					DUART_CHANREG_SPACING);
 		return ret;
 	}
 	return 0;
-- 
1.9.1

