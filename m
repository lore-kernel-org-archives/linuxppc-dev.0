Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77740C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:41:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269F52085A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269F52085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4wf6mBjzDqJ2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:41:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3b05W9MzDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:41:00 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McHQA-1gU8G81aX6-00chnU; Thu, 14 Mar 2019 23:35:00 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/45] drivers: tty: serial: serial_ks8695: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:00 +0100
Message-Id: <1552602855-26086-31-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:RqmNHQG6GlZCyxEPs4T/D+FeHKdpMqllZFhLAoxsdJ5FPoo1fK3
 oJcg8qSRtX/GrS1AQsMUQ0WKpU9Quss9wS8FvyXaAbtDBWHMtXOnotDfmnX7+ginoYsPnTq
 vru5F/NsJawa/bbk17tAvdhbrQGbKFC44LzRg/WnWeT42AYueLN4HL85mh8HgFsoUUVyyUy
 /Lop32066rj15fzOr+vvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iYYhYOU2jNU=:gC2qumkDGXHYVc8/oeDa5k
 d/qaFn5PS2nr/YecnM75Tw/Q8F50lUYntszkw4MhmYeA841zPahK04q6fjnK/hzoFBDVuf2PF
 dnoon0JOsP8DgBkBesKgZsm2EUFciGyk3uVFCnYUU4TShSmtlDh93OJGiVhX/IIHzfsipQUtB
 xVfkCxGf2eoWw3ohaPNbixa8hGyKiqN3QcN6fzt0+lSl1GPKKD9uX6LRIiCzWYQOnKRLR5otA
 g3r0b9OzrY02AdKmUFx82DRfNh3XCvHo1mmSQc/ZCtUpPfj4O9oTF4NRg7snuTWayvj1i0RlF
 GNzQ6DgC7Hf5bQ7L9n+2vMQ/m13vQP+6322L0pdvFxC++wJz3VjmjIAJPVebvGVXmqFh1Na/B
 p2GBJGSA/1s3QETbr6ajR+Z8QF1WtgWyFJDosvVX6OyOne74HbHt/sSjFuC5x7u0nGYK+iXrT
 PwSpEqce3hTMQeeSO73RFIIWZ9v1OpYrvNhcKfNF6jbebNYwMmIxBpmAYDJVzLo9+Zl5p35HT
 aaTzlW28CJgRcRjajcek2FpHchICbBumJ3CotesXIyze1qHRq72VcwL/9yiF5dvIR2LoTDQz6
 965JRVpNZiqMbsTJXL6hR+czTOuh3ImnWR4TZ+PNnHfAQ4WG/CDZY58sfSf08iDIF17phOFsv
 1GwRf8ifHQlhADHS73QCuDfamphRYWR/Tohoj3isSWSQpJ/YzqzncIGQsc9tHqyORPjw7Bw0d
 qXIrzar3i7a4CHV+4h3GVDtEq5B5HGjRAbLTJ2fdT6o9Ogj6KcmovljyVZkirmj6CjB2Q5p5Q
 5vl3c4GWzntMlWxoU2CpSGP/7AfznTtmcaX8THqpgPGrzOjARozwLurKPWRF9KXf1gsfYBS6J
 vMdQjINAbHHnhKFqCg36m8CnqhgbwSR8N4lA6pHhIFhvtdAxroVOjF0hIldGnhxTZAekz38Ga
 4JdaFqyBzBQ==
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
---
 drivers/tty/serial/serial_ks8695.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index b461d79..f901eea 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -482,7 +482,7 @@ static const char *ks8695uart_type(struct uart_port *port)
  */
 static void ks8695uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -490,7 +490,9 @@ static void ks8695uart_release_port(struct uart_port *port)
  */
 static int ks8695uart_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, UART_PORT_SIZE,
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       UART_PORT_SIZE,
 			"serial_ks8695") != NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

