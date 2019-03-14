Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1988DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:25:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5532184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5532184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4ZP755TzDq7h
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:25:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zj2y4HzDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:44 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Evp-1h9lL217Kh-006Q6t; Thu, 14 Mar 2019 23:34:51 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/45] drivers: tty: serial: msm_serial: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:33:50 +0100
Message-Id: <1552602855-26086-21-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:diJhcXtKr0D9/1hkZLjn+AYb9Hm7J40LLWi5x1os7vmD7rQjq8n
 3bxGMqvIElvCGM73BifRMbUwOFvxrGZEifs0Z3hFJKocT1wm1CRFsh3vC0w7MgHsbmqeLn1
 l5L4Nn633+AouAwf6GZGNXuKFqbJNOmzN6VqXSDgBASKzGng88Sndkk4Wn/BUROPz9gt8QY
 9eAP7TVtiyekp/lSOR46g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iawuQuwQIRo=:e6K7OOLFG4nK53sbjSm8wJ
 VjTIGy/p5A0pgoaLJVP2iggJZotsGZFqaZL/pUQhoEpLKxyVILzyfMSl6i7j9aCLKrhMq7owb
 yF48MC697GHpAEJ4nlt6ZWaEwokQOKW3wh/YZ0U4ZQs4tm2NRsxwwxsU/FRjULB3PBx/VHc/h
 z+mXM+TNIq6bUfxwZs+Qnw5MreJiUyqkZ7wKA9GO03DO3LVZKtqjjZgrg8Ci5xNZo39TCh6NZ
 EJV9N/an4WtP/Wp6zkAJaE0/DKc1DwL3cyk0183ja4C8SpGcJkH4GEnX6ssvButyCLrZ9Kj+C
 TEypqjJlFW13oFbgeSGVE4iPoBUSj7colXEEqG0L93Nu/IfUc/Q17sOokcCt9mIUlz6CIHyik
 Ht0TnvX5nZ1KlwYVIBn7CTxt78vh+icgLc4Qwj1ay6A4ioaicXI2gDpCrtKOu0kA0YF2TlIXh
 gHFIHwEj1f/LO9yJkVj+hvvhJZ/zs98ibbo6+b/RcNFbY0d+La81Zu66jcO11DcySjkeIQg1Q
 1reYXaHIHGw6TwrFUjpPenO3r+gJBIoC3jxtOxerWBHMp6EyHv/IofSJv8aX0vVF5R+Ag/HEy
 KIoUqP0qRtcdSMpQMSRkTpvtdoAP5bx5aNepRoTWGdzazZrO3PsmeosbYHI3eQOR8iGRkfitf
 b09ddbZmbbjozzrwMx4d3uFVhaUEvuMEXQuWWhgkA/6WwnpTrc2aNKP3nvNffXcKSSAsPHnhl
 Y3BXraZpZ8aZ+iPD67KduoyWySQcc2J8XxFf5A==
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
 drivers/tty/serial/msm_serial.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 1090960..e8e0c87 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1324,8 +1324,8 @@ static void msm_release_port(struct uart_port *port)
 		return;
 	size = resource_size(uart_resource);
 
-	release_mem_region(port->mapbase, size);
-	iounmap(port->membase);
+	devm_release_mem_region(port->dev, port->mapbase, size);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 }
 
@@ -1342,10 +1342,13 @@ static int msm_request_port(struct uart_port *port)
 
 	size = resource_size(uart_resource);
 
-	if (!request_mem_region(port->mapbase, size, "msm_serial"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     size,
+				     "msm_serial"))
 		return -EBUSY;
 
-	port->membase = ioremap(port->mapbase, size);
+	port->membase = ioremap(port->dev, port->mapbase, size);
 	if (!port->membase) {
 		ret = -EBUSY;
 		goto fail_release_port;
@@ -1354,7 +1357,7 @@ static int msm_request_port(struct uart_port *port)
 	return 0;
 
 fail_release_port:
-	release_mem_region(port->mapbase, size);
+	devm_release_mem_region(port->dev, port->mapbase, size);
 	return ret;
 }
 
-- 
1.9.1

