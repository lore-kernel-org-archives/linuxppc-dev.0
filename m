Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A63CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:06:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D05421874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D05421874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4846gzxzDqQK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:06:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Sj1LZdzDqNs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:32 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mleo0-1gdVfA0sFe-00inf4; Thu, 14 Mar 2019 23:35:10 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 40/45] drivers: tty: serial: mpc52xx_uart: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:10 +0100
Message-Id: <1552602855-26086-41-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:c1rt79CARMfMM9EBJpf2Yu57RYWt58bo9ABQPOFK1jRMIOMpF1c
 oERWiyR8NT2Hs6fiUeQh+ZK8EWSU8jOM0bvCWsYu8SH3F0GWyIQenc2T0xWMBp5MB1YMnvT
 9cynd8W3QrXWT9wBlQFnMjW4d7BXcM2YtTfRKGBDbumX8QmF7o8cHizhL+OwOn+w5qfe2Ht
 cW5yG5F00Ulas+z5PWyXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F/NcajlvdU0=:SR2u22OvyWH/qkqQz/MLuF
 IcOzVV/NpdhleuU+i+zgwL7Qod6fUaBYm3pwqKfWLa2p1BABwDKabcIRBnXqcCF8WVx4Ap+JW
 MG4Oy/y0FbDnMNV4+mrGaF7OfjlPJ5Wo8efmVNoNzOHfsxj4ZTzoc+jspuasnSKuWXlfVYfZ5
 6AHSfiDuu2SfyJQAvvCNssOlwiI4RJ4ZMS5Pj2tlSQlzzH6WR1zU+SKYOIJDCF+VMnKrTfk2M
 62quOX228RiyMKg03cIWJKomzvJx6U0lKyAN/yhqBf8JSawYATbTh5Rjnw3lv3lsa7OnHV3is
 Gx/IHqpM2x5EIB+QKq10Wp7jZ8gQQDOEvLikVh22hynFBhr2MY0Qe5whkDqVgzI6xBLlqX5SA
 8HyfI5jVRyAbDKZ8sATvP8XN2xjaYMppci0+A7LIAIG5rELg12w85FTROOttJNNWbbGcWiv4+
 VLn8uyKtNNq17qBuKm+Vfh0j3NT/6l8Wv62NjUYvDfi5wre1CUbYpu+pgpDihnLIWidUMnKam
 5jf/TZSINDlxz/3kYz+w4W+qEjA0gIh0SeaRJKYa33HnzYV3C+BE1GN2w5yzZQh+cscErdStw
 7YCjIp65cCCpMouqxQT3qvytLgZlb9ryk5IVJnraits+8HqvO4aK86YxxbTtUekZaVTZ6+y7s
 PfhGtCEhaHWM8M7taRvwUUTrcCTDcjYUqAEKsLwkC1HmCXRYKpZVJ9DDaNKy1wV4KevKG4W+8
 XPboeXfkX2Baj/uT+CZxFBF2GzItZj2FLsnJlA==
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
 drivers/tty/serial/mpc52xx_uart.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3a75ee0..3e74e44 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1276,11 +1276,13 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 
 	/* remapped by us ? */
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
+	devm_release_mem_region(port->dev,
+				port->mapbase,
+				sizeof(struct mpc52xx_psc));
 }
 
 static int
@@ -1289,13 +1291,14 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 	int err;
 
 	if (port->flags & UPF_IOREMAP) /* Need to remap ? */
-		port->membase = ioremap(port->mapbase,
+		port->membase = devm_ioremap(port->dev, port->mapbase,
 					sizeof(struct mpc52xx_psc));
 
 	if (!port->membase)
 		return -EINVAL;
 
-	err = request_mem_region(port->mapbase, sizeof(struct mpc52xx_psc),
+	err = devm_request_mem_region(port->mapbase,
+			sizeof(struct mpc52xx_psc),
 			"mpc52xx_psc_uart") != NULL ? 0 : -EBUSY;
 
 	if (err)
@@ -1310,10 +1313,12 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 	return 0;
 
 out_mapregion:
-	release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
+	devm_release_mem_region(port->dev,
+				port->mapbase,
+				sizeof(struct mpc52xx_psc));
 out_membase:
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 	return err;
@@ -1653,7 +1658,9 @@ static u8 mpc5125_psc_get_mr1(struct uart_port *port)
 	port->uartclk = uartclk;
 	port->ops	= &mpc52xx_uart_ops;
 	port->mapbase = res.start;
-	port->membase = ioremap(res.start, sizeof(struct mpc52xx_psc));
+	port->membase = devm_ioremap(port->dev,
+				     res.start,
+				     sizeof(struct mpc52xx_psc));
 	port->irq = irq_of_parse_and_map(np, 0);
 
 	if (port->membase == NULL)
-- 
1.9.1

